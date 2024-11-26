#### Preamble ####
# Purpose: Simple linear regression model for children's book ratings
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Run 01-clean_data.R

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Read the data and create model ####
# Read the cleaned analysis dataset
analysis_data <- read_parquet("data/analysis_data/clean_books_data.parquet")

# Fit a simple linear regression model
simple_model <-
  lm(
    rating ~ covers + pages_range + publish_period,
    data = analysis_data
  )

#### Save model ####
saveRDS(
  simple_model,
  file = "models/simple_model.rds"
)
