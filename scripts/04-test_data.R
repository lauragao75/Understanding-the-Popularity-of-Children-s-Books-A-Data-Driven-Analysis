#### Preamble ####
# Purpose: Extensive tests for the cleaned children's book ratings data using the 'testthat' and 'pointblank' packages
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Run 03-data_cleaning.R, and install the 'pointblank' library

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(pointblank)

#### Load Data ####
analysis_data <- read_parquet("data/analysis_data/clean_books_data.parquet")

#### Define Tests Using Pointblank ####
agent <- create_agent(tbl = analysis_data, actions = action_levels(warn_at = 0.01, stop_at = 0.05)) %>%
  col_vals_not_null(vars(cover, pages_range, publish_period, rating)) %>%
  col_vals_in_set(vars(cover), set = c("Hardcover", "Paperback")) %>%
  col_vals_in_set(vars(pages_range), set = c("Under 50", "50-149", "150-299", "300-499", "500 and above")) %>%
  col_vals_in_set(vars(publish_period), set = c("Before 1950", "1950-1979", "1980-1999", "2000 and after")) %>%
  col_vals_between(vars(rating), 0, 5)

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
