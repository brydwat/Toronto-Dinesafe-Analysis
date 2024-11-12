# Analysis and mapping
# 11/11/2024
# Bryce Watson
# Data analysis and plotting.

# Load libraries
library(tidyverse)
library(ggmap)
library(plotly)

# Load data
dinesafe <- read.csv("data/analysis_data/dinesafe_filtered.csv", row.names = 1)

# Initial map

### Map Tile
bbox <- c(left = -79.6393, bottom = 43.5810, right = -79.1169, top = 43.8555)

register_stadiamaps(key = "aa163ab0-fe06-4ed0-9a4e-deb449f3e9a9", write = TRUE)

toronto_stamen_map <- get_stadiamap(bbox, zoom = 12, maptype = "stamen_toner_lite")

ggmap(toronto_stamen_map)

### Simulated restaurants plotted

code_map <- ggmap(toronto_stamen_map, extent = "normal", maprange = FALSE) +
  geom_point(data=dinesafe,
             aes(x = Longitude, y = Latitude, colour = Severity,
                 text = Establishment.Name),
             alpha = .3,
             size = 1) +
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

code_map

ggplotly(code_map, tooltip = c("text", "colour"))
