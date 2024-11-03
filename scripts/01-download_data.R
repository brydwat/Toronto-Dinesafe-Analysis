# Download data
# 11/3/2024
# Bryce Watson
# Downloaded from: https://open.toronto.ca/dataset/dinesafe/

library(opendatatoronto)
library(dplyr)

# get package
dinesafe_package <- show_package("b6b4f3fb-2e2c-47e7-931d-b87d22806948")

# get all resources for this package
dinesafe <- list_package_resources("b6b4f3fb-2e2c-47e7-931d-b87d22806948") |>
  filter(name ==
         "Dinesafe.csv") |>
  get_resource()

# Write raw data to drive
write_csv(
  x = dinesafe,
  file = "data/raw_data/Dinesafe.csv"
)
