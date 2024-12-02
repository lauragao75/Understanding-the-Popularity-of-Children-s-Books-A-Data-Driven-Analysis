#### Load and clean data ####
# Read the simulated data
books <- read_delim("data/raw_data/childrens-books.txt", delim = "\t")

# Select relevant columns
books_clean <- books %>%
  select(all_of(c("cover", "pages", "original_publish_year", "rating"))) %>%
  filter(!is.na(pages), !is.na(rating), rating <= 5, rating >= 0) %>% # Ensure rating is between 0 and 5
  filter(cover %in% c("Hardcover", "Paperback")) %>% # Filter to include only Hardcover and Paperback for easier analysis
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
  filter(!is.na(publish_period)) %>%  # Remove rows with NA in publish_period
  # Select final columns
  select(cover, pages_range, publish_period, rating)

#### Save the cleaned data ####
write_parquet(books_clean, "data/analysis_data/clean_books_data.parquet")
