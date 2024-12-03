#### Preamble ####
# Purpose: Simple linear regression model for children's book ratings
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Run 03-clean_data.R, and install the 'rstanarm' library

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read the data and create model ####
# Read the cleaned analysis dataset
analysis_data <- read_parquet("data/analysis_data/clean_books_data.parquet")

# Fit Bayesian hierarchical linear model
data_model <- stan_glm(
  rating ~ cover + pages_range + publish_period,
  data = analysis_data,
  family = gaussian(),
  prior = normal(0, 2.5),
  prior_intercept = normal(0, 2.5),
  chains = 4,
  iter = 2000,
  seed = 123
)

#### Save model ####
saveRDS(
  data_model,
  file = "models/model.rds"
)
