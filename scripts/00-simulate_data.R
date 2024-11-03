# Simulated data script
# 11/3/2024
# Bryce Watson
# Simulate data for analysis from Toronto Dinesafe dataset

# Load libraries
library(tidyverse)

# create dataset for 60 restaurants
n_restaurants <- 60

restaurant_names <- paste("Restaurant", seq(1:60))

# Generate random inspection outcomes
set.seed(345)
severity <- sample(c("C", "S", "M", " "),
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
