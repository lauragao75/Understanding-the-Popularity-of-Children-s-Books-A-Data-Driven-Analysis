#### Preamble ####
# Purpose: Extensive tests for the simulated children's book ratings data using the 'pointblank' package
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Run 00-simulate_data.R

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(pointblank)

#### Load Data ####
simulated_data <- read_parquet("data/analysis_data/simulate_data.parquet")

#### Define Tests Using Pointblank ####
agent <- create_agent(tbl = simulated_data, actions = action_levels(warn_at = 0.01, stop_at = 0.05)) %>%
  col_vals_not_null(vars(covers, pages, original_publish_year, rating)) %>%
  col_vals_in_set(vars(covers), set = c("Hardcover", "Paperback", "Board Book", "Kindle Edition")) %>%
  col_vals_between(vars(pages), 20, 800) %>%
  col_vals_between(vars(original_publish_year), 1900, 2023) %>%
  col_vals_between(vars(rating), 1, 5)

# Interrogate the data
agent <- agent %>% interrogate()

# Print summary of validation results
agent

# Print whether all tests passed
if (all(agent$validation_set$warn == 0 & agent$validation_set$stop == 0)) {
  print("All validation checks passed.")
} else {
  print("Some validation checks failed.")
}
