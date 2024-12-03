#### Preamble ####
# Purpose: Simulate an analysis dataset for children's book ratings
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Install the 'tidyverse' library

#### Simulation ####
# Set seed for reproducibility
set.seed(823)

# Number of rows in the dataset
n <- 1000

# Generate cover type values
# Simulate a higher likelihood for hardcover books being published in more recent periods
cover <- sample(c("Hardcover", "Paperback"), n, replace = TRUE, prob = c(0.6, 0.4))

# Generate page counts (categorized)
# Assume that hardcover books tend to have more pages compared to paperbacks
pages <- ifelse(cover == "Hardcover", 
                sample(c("150-299", "300-499", "500 and above"), n, replace = TRUE, prob = c(0.4, 0.4, 0.2)),
                sample(c("Under 50", "50-149", "150-299"), n, replace = TRUE, prob = c(0.3, 0.5, 0.2)))

# Generate publication year categories
# Assume newer publications are more likely to have hardcover format
publish_period <- ifelse(cover == "Hardcover", 
                         sample(c("1980-1999", "2000 and after"), n, replace = TRUE, prob = c(0.3, 0.7)),
                         sample(c("Before 1950", "1950-1979", "1980-1999"), n, replace = TRUE, prob = c(0.2, 0.4, 0.4)))

# Generate ratings (between 0 and 5)
# Assume books with more pages or newer publications tend to have higher ratings
rating <- round(runif(n, min = 0, max = 5), 1)
# Adjust ratings based on cover type, page count, and publication period
rating <- ifelse(cover == "Hardcover", rating + 0.5, rating)
rating <- ifelse(pages %in% c("300-499", "500 and above"), rating + 0.3, rating)
rating <- ifelse(publish_period == "2000 and after", rating + 0.2, rating)
# Cap ratings at 5
rating <- pmin(rating, 5)

# Create dataframe
# Combine all variables into a single dataframe
data <- data.frame(cover, pages, publish_period, rating)

head(data)
# Save the dataset to a CSV file
write_parquet(data, "data/analysis_data/simulate_data.parquet")


