# Filtering and cleaning
# 11/8/2024
# Bryce Watson
# Filter and export dataset for mapping. 

# Load libraries
library(tidyverse)

# Initial filtering - selecting key vectors, removing rows with no inspection, updating no entry on severity to "NA".
dinesafe_data <- read.csv("data/raw_data/Dinesafe.csv") |>
  select(Establishment.ID, Inspection.ID, Establishment.Name, Severity, Latitude, Longitude) |>
  filter(!is.na(Inspection.ID)) |> 
  mutate(Severity = if_else(Severity == "", "NA", Severity)) |>
  group_by(Inspection.ID)

# Secondary cleaning - changing severity codes to shorthand
dinesafe_data$Severity <- recode(dinesafe_data$Severity,
                                 "NA - Not Applicable" = "NA",
                                 "M - Minor" = "M",
                                 "S - Significant" = "S",
                                 "C - Crucial" = "C")

# Rank severity codes for factoring, N/A, Minor, Significant, Crucial
severity_rank <- c("NA", "M", "S", "C")

# Filter to keep only the highest severity from each establishment - 
# another alternative is to count total codes per establishment, but 
# will be done in another script.
dinesafe_data <- dinesafe_data %>%
  mutate(Severity = factor(Severity, levels = severity_rank, ordered = TRUE)) %>%
  group_by(Inspection.ID) %>%
  slice_max(Severity, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  group_by(Establishment.ID) %>%
  slice_max(Severity, n = 1, with_ties = FALSE) %>%
  ungroup()

# Save data for later analysis
write.csv(dinesafe_data, "data/analysis_data/dinesafe_filtered.csv")
