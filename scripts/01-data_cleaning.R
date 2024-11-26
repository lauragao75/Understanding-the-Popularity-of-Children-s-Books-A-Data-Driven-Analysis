#### Preamble ####
# Purpose: Cleans the simulated children's book ratings dataset
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: Install the 'tidyverse' and 'arrow' libraries

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Load and clean data ####
# Read the simulated data
books <- read.csv("data/analysis_data/simulate_data.csv")

# Select relevant columns
books_clean <- books %>%
  select(covers, pages, original_publish_year, rating) %>%
  filter(!is.na(pages), !is.na(rating), rating <= 5, rating >= 0) %>% # Ensure rating is between 0 and 5
  filter(covers %in% c("Hardcover", "Paperback")) %>% # Filter to include only Hardcover and Paperback for easier analysis
  mutate(
    # Create page range categories
    pages_range = case_when(
      pages < 50 ~ "Under 50",
      pages >= 50 & pages < 150 ~ "50-149",
      pages >= 150 & pages < 300 ~ "150-299",
      pages >= 300 & pages < 500 ~ "300-499",
      pages >= 500 ~ "500 and above",
      TRUE ~ as.character(pages)
    ),
    # Create publication year categories
    publish_period = case_when(
      original_publish_year < 1950 ~ "Before 1950",
      original_publish_year >= 1950 & original_publish_year < 1980 ~ "1950-1979",
      original_publish_year >= 1980 & original_publish_year < 2000 ~ "1980-1999",
      original_publish_year >= 2000 ~ "2000 and after",
      TRUE ~ as.character(original_publish_year)
    )
  ) %>%
  # Select final columns
  select(covers, pages_range, publish_period, rating)

#### Save the cleaned data ####
write_parquet(books_clean, "data/analysis_data/clean_books_data.parquet")

