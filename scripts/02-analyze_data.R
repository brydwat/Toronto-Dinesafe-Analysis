# Filtering and exploratory data analysis script
# 11/8/2024
# Bryce Watson
# Filter and export dataset for mapping. Exploratory data analysis

# Load libraries
library(tidyverse)

dinesafe_data <- read.csv("data/raw_data/Dinesafe.csv") |>
  select(Establishment.ID, Inspection.ID, Establishment.Name, Severity, Latitude, Longitude)




dinesafe_data$Severity <- recode(dinesafe_data$Severity,
                                 "NA - Not Applicable" = "",
                                 "M - Minor" = "M",
                                 "S - Significant" = "S",
                                 "C - Crucial" = "C")

# WIP
for (i in dinesafe_real$Establishment.ID) {
  severity_compare <- dinesafe_real$Severity
  cat("Severity:", severity_compare, "\n")
  #print(severity_compare)
  
  while (count <= 3) {
    cat("  Inner loop count:", count, "\n")
    count <- count + 1
  }
}