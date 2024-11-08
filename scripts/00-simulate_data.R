# Simulated data script
# 11/3/2024
# Bryce Watson
# Simulate data for analysis from Toronto Dinesafe dataset

# Load libraries
library(tidyverse)
library(ggmap)

# create dataset for 60 restaurants
n_restaurants <- 60

restaurant_names <- paste("Restaurant", seq(1:60))

# Generate random inspection outcomes
set.seed(345)
severity <- sample(c("C", "S", "M", "N"),
                   size = 60, 
                   replace = TRUE,
                   prob = c(0.05, 0.20, 0.55, 0.20)
                   )

# Read in csv lat/long - copied first 60 unique lat/long pairs from Dinesafe dataset
latlong <- read.csv("data/simulated_data/lat_long.csv")
lat <- latlong$Latitude
long <- latlong$Longitude
  
# Create data frame
dinesafe_data <- data.frame(
  restaurant_names, 
  severity,
  lat,
  long
)

write.csv(dinesafe_data, "data/simulated_data/dinesafe_data.csv", row.names = FALSE)
head(dinesafe_data)

# Other potential categories to include: Action,  Amount Fined

# Map Tile
bbox <- c(left = -79.6393, bottom = 43.5810, right = -79.1169, top = 43.8555)

register_stadiamaps(key = "aa163ab0-fe06-4ed0-9a4e-deb449f3e9a9", write = TRUE)

toronto_stamen_map <- get_stadiamap(bbox, zoom = 11, maptype = "stamen_toner_lite")

ggmap(toronto_stamen_map)

# Simulated restaurants plotted

ggmap(toronto_stamen_map, extent = "normal", maprange = FALSE) +
  geom_point(data=dinesafe_data,
             aes(x = long, y = lat, colour = severity),
             alpha = .5) +
  scale_colour_manual(values = c("N" = "gray50", "M" = "gold", "S" = "darkorange", "C" = "firebrick3")) +
  coord_map(
    projection = "mercator",
    xlim = c(attr(map, "bb")$ll.lon, attr(map, "bb")$ur.lon),
    ylim = c(attr(map, "bb")$ll.lat, attr(map, "bb")$ur.lat)
  ) +
  labs(x = "Longitude",
       y = "Latitude") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
  