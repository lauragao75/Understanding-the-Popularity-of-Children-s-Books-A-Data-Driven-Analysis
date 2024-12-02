#### Download Script ####
# Purpose: Download the necessary data for children's book ratings analysis
# Author: Zien Gao
# Date: November 26th 2024
# Contact: lauragao75@gmail.com
# License: MIT

# Define the destination directory if it doesn't exist
dest_dir <- "data/raw_data"
if (!dir.exists(dest_dir)) {
  dir.create(dest_dir, recursive = TRUE)
}

# URL to download the raw data
url <- "https://raw.githubusercontent.com/tacookson/data/master/childrens-book-ratings/childrens-books.txt"

# Download the dataset if it does not exist
if (!file.exists(file.path(dest_dir, "childrens-books.txt"))) {
  download.file(
    url = url,
    destfile = file.path(dest_dir, "childrens-books.txt")
  )
}

