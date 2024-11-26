#### Preamble ####
# Purpose: Simulate an analysis dataset for children's book ratings
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Install the 'tidyverse' library

#### Workspace setup ####
library(tidyverse)

#### Simulation ####
# Set seed for reproducibility
set.seed(823)

# Number of rows in the dataset
n <- 1000

# Generate cover types
covers <- sample(c("Hardcover", "Paperback"), n, replace = TRUE)

# Generate number of pages (between 20 to 800)
pages <- round(runif(n, min = 20, max = 800))

# Generate original publish year (between 1900 and 2023)
original_publish_year <- sample(1900:2023, n, replace = TRUE)

# Generate ratings (between 1 and 5, with decimal precision)
rating <- round(runif(n, min = 1, max = 5), 2)

# Create dataframe
data <- data.frame(covers, pages, original_publish_year, rating)

# View the first few rows of the dataset
head(data)

# Save the dataset to a CSV file
write_parquet(data, "data/analysis_data/simulate_data.parquet")


