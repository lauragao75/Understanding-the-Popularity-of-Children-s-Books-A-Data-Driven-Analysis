# **Understanding the Ratings of Children's Books: A Data-Driven Analysis**

## **Overview**
This repository contains all necessary files for the project *Understanding the Ratings of Children's Books: A Data-Driven Analysis*. The objective of this project is to investigate the factors that impact the popularity and ratings of children's books, such as cover type, page count, and publication period. This repository is intended to provide a foundation for others looking to replicate or build on the analysis presented in the accompanying paper.

## **File Structure**
The repository is organized as follows:

- **data/raw_data**: Contains the original dataset (e.g., `childrens-books.txt`) as obtained from GitHub by Alex Cookson.  
- **data/analysis_data**: Contains the cleaned dataset and the simulated dataset (`clean_books_data.parquet`, `simulate_data.parquet`) used for the main analysis.  
- **models**: Stores the model file (`model.rds`) that was fitted during the analysis.  
- **other**: Contains additional files related to the literature, details about LLM (large language model) chat interactions (`llm/usage.txt`), and sketches used during project ideation (`sketches/graph.jpg`, `sketches/table.jpg`).  
- **paper**: Holds the files related to generating the research paper, including:  
  - `paper.qmd`: Quarto document used to write the paper.  
  - `references.bib`: Bibliography file containing references used in the paper.  
  - `paper.pdf`: The final PDF version of the paper.  
- **scripts**: Stores all R scripts utilized in the project:  
  - `00-simulate_data.R`: Script to generate the simulated dataset.  
  - `01-test_simulated_data.R`: Script to validate and perform data quality checks on the simulated dataset.  
  - `02-download_data.R`: Script to download the raw dataset from GitHub.  
  - `03-data_cleaning.R`: Script to clean and preprocess the downloaded raw dataset.  
  - `04-test_data.R`: Script to test the cleaned dataset for consistency and completeness.  
  - `05-model.R`: Script to fit and evaluate the model based on cleaned datasets.  

## **Statement on LLM Usage**
Parts of the code were written with the assistance of ChatGPT-4.0. Additionally, the abstract, introduction, and parts of the appendix were developed with the help of ChatGPT-4.0, and the entire chat history is documented in `other/llm/usage.txt`.
