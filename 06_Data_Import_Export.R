# Module 2: Data Import and Export
# File: 06_Data_Import_Export.R

# =============================================================================
# IMPORTING AND EXPORTING DATA IN R
# =============================================================================

# This lesson covers how to read data from various sources
# and save your results to different file formats

# =============================================================================
# 1. SETTING UP YOUR WORKING DIRECTORY
# =============================================================================

# Check current working directory
getwd()

# Set working directory (change this to your folder path)
# setwd("D:/BIT/2nd semi/practice")

# List files in your directory
list.files()

# =============================================================================
# 2. READING CSV FILES
# =============================================================================

# Create sample CSV data first
sample_data <- data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 30, 35, 28),
  salary = c(50000, 60000, 70000, 55000),
  department = c("IT", "HR", "IT", "Finance")
)

# Write CSV file
write.csv(sample_data, "sample_data.csv", row.names = FALSE)

# Read CSV file
data_from_csv <- read.csv("sample_data.csv")
print(data_from_csv)

# Read CSV with different options
data_with_options <- read.csv("sample_data.csv", 
                             stringsAsFactors = FALSE,
                             na.strings = c("", "NA"))

# =============================================================================
# 3. READING EXCEL FILES
# =============================================================================

# Install and load readxl package (if not already installed)
# install.packages("readxl")
library(readxl)

# Create sample Excel data
write.csv(sample_data, "sample_data.xlsx", row.names = FALSE)

# Read Excel file
# data_from_excel <- read_excel("sample_data.xlsx")

# Read specific sheet
# data_sheet2 <- read_excel("sample_data.xlsx", sheet = 2)

# Read specific range
# data_range <- read_excel("sample_data.xlsx", range = "A1:D5")

# =============================================================================
# 4. READING TEXT FILES
# =============================================================================

# Create sample text file
writeLines(c("Name,Age,City", "Alice,25,New York", "Bob,30,London", "Charlie,35,Paris"), "sample_data.txt")

# Read text file
data_from_txt <- read.table("sample_data.txt", header = TRUE, sep = ",")
print(data_from_txt)

# Read with different separators
# Tab-separated: sep = "\t"
# Space-separated: sep = " "
# Semicolon-separated: sep = ";"

# =============================================================================
# 5. READING DATA FROM URL
# =============================================================================

# Read CSV from URL
# url_data <- read.csv("https://example.com/data.csv")

# Read from GitHub
# github_data <- read.csv("https://raw.githubusercontent.com/username/repo/main/data.csv")

# =============================================================================
# 6. EXPORTING DATA
# =============================================================================

# Export to CSV
write.csv(sample_data, "exported_data.csv", row.names = FALSE)

# Export to CSV with different options
write.csv(sample_data, "exported_data_with_quotes.csv", 
          row.names = FALSE, quote = TRUE)

# Export to text file
write.table(sample_data, "exported_data.txt", 
            sep = "\t", row.names = FALSE, quote = FALSE)

# =============================================================================
# 7. WORKING WITH EXCEL FILES (EXPORT)
# =============================================================================

# Install and load openxlsx package
# install.packages("openxlsx")
library(openxlsx)

# Export to Excel
write.xlsx(sample_data, "exported_data.xlsx", rowNames = FALSE)

# Export multiple sheets
# Create multiple data frames
sheet1_data <- sample_data
sheet2_data <- data.frame(
  product = c("A", "B", "C"),
  price = c(100, 200, 300)
)

# Write to Excel with multiple sheets
write.xlsx(list("Employees" = sheet1_data, "Products" = sheet2_data), 
          "multi_sheet_data.xlsx")

# =============================================================================
# 8. HANDLING MISSING DATA DURING IMPORT
# =============================================================================

# Create data with missing values
data_with_missing <- data.frame(
  name = c("Alice", "Bob", "", "Diana"),
  age = c(25, NA, 35, 28),
  salary = c(50000, 60000, NA, 55000)
)

# Write to CSV
write.csv(data_with_missing, "data_with_missing.csv", row.names = FALSE)

# Read with different missing value handling
data_na_strings <- read.csv("data_with_missing.csv", 
                           na.strings = c("", "NA", "N/A"))

# Check for missing values
is.na(data_na_strings)
sum(is.na(data_na_strings))
colSums(is.na(data_na_strings))

# =============================================================================
# 9. READING LARGE FILES
# =============================================================================

# For large files, use these options:
# - nrows: limit number of rows to read
# - skip: skip first n rows
# - colClasses: specify column types

# Read only first 1000 rows
# large_data <- read.csv("large_file.csv", nrows = 1000)

# Skip first 10 rows
# data_skip <- read.csv("file.csv", skip = 10)

# Specify column classes for faster reading
# data_fast <- read.csv("file.csv", 
#                      colClasses = c("character", "numeric", "logical"))

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a data frame with information about 5 books:
# - title, author, year, pages, price
# Save it as a CSV file and then read it back

# Exercise 2: Create two data frames and save them as separate sheets
# in the same Excel file

# Exercise 3: Read a CSV file and handle missing values appropriately

# Exercise 4: Export your data in three different formats:
# CSV, text file, and Excel

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
books <- data.frame(
  title = c("1984", "To Kill a Mockingbird", "Pride and Prejudice", "The Great Gatsby", "Moby Dick"),
  author = c("George Orwell", "Harper Lee", "Jane Austen", "F. Scott Fitzgerald", "Herman Melville"),
  year = c(1949, 1960, 1813, 1925, 1851),
  pages = c(328, 281, 432, 180, 635),
  price = c(12.99, 14.99, 11.99, 13.99, 15.99)
)

write.csv(books, "books.csv", row.names = FALSE)
books_read <- read.csv("books.csv")
print(books_read)

# Solution 2:
fiction_books <- books[1:3, ]
nonfiction_books <- books[4:5, ]

write.xlsx(list("Fiction" = fiction_books, "Nonfiction" = nonfiction_books), 
          "books_by_genre.xlsx")

# Solution 3:
books_with_na <- books
books_with_na$price[3] <- NA
write.csv(books_with_na, "books_with_na.csv", row.names = FALSE)

books_clean <- read.csv("books_with_na.csv", na.strings = c("", "NA"))
print(books_clean)

# Solution 4:
write.csv(books, "books_export.csv", row.names = FALSE)
write.table(books, "books_export.txt", sep = "\t", row.names = FALSE)
write.xlsx(books, "books_export.xlsx", rowNames = FALSE)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use read.csv() for CSV files, read_excel() for Excel files
# 2. Use write.csv() to export to CSV, write.xlsx() for Excel
# 3. Always specify na.strings when reading data
# 4. Use colClasses for faster reading of large files
# 5. Check for missing values after importing
# 6. Use appropriate separators for different file types
# 7. Save your working directory path for easy access

# Next: Move to 07_Data_Cleaning.R to learn about data preprocessing!
