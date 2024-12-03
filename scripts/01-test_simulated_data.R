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

#### Tests using pointblank ####
# Create a pointblank agent to validate the dataset
agent <- create_agent(tbl = simulated_data, actions = action_levels(warn_at = 0.01, stop_at = 0.05)) %>%
  # Test 1: Check for missing data
  col_vals_not_null(vars(cover, pages, publish_period, rating)) %>%
  # Test 2: Check that the 'cover' variable has valid values
  col_vals_in_set(columns = vars(cover), set = c("Hardcover", "Paperback")) %>%
  # Test 3: Check that the 'pages' variable has valid values
  col_vals_in_set(columns = vars(pages), set = c("Under 50", "50-149", "150-299", "300-499", "500 and above")) %>%
  # Test 4: Check that the 'publish_period' variable has valid values
  col_vals_in_set(columns = vars(publish_period), set = c("Before 1950", "1950-1979", "1980-1999", "2000 and after")) %>%
  # Test 5: Check that 'rating' is between 0 and 5
  col_vals_between(columns = vars(rating), left = 0, right = 5)

# Interrogate the agent to execute the tests
agent <- interrogate(agent)

# Print summary of test results
agent

# Print whether all tests passed
if (all(!is.na(agent$validation_set$warn) & agent$validation_set$warn == 0 & !is.na(agent$validation_set$stop) & agent$validation_set$stop == 0)) {
  print("All validation checks passed.")
} else {
  print("Some validation checks failed.")
}