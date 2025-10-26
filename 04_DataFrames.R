# Module 1: Data Frames
# File: 04_DataFrames.R

# =============================================================================
# WORKING WITH DATA FRAMES IN R
# =============================================================================

# Data frames are like tables with rows and columns
# Each column can have different data types
# This is the most common way to store data in R

# =============================================================================
# 1. CREATING DATA FRAMES
# =============================================================================

# Create data frame from vectors
name <- c("Alice", "Bob", "Charlie", "Diana")
age <- c(25, 30, 35, 28)
salary <- c(50000, 60000, 70000, 55000)
department <- c("IT", "HR", "IT", "Finance")

# Create the data frame
employees <- data.frame(name, age, salary, department)
print(employees)

# Create data frame directly
students <- data.frame(
  student_id = c(1, 2, 3, 4),
  name = c("John", "Jane", "Mike", "Sarah"),
  grade = c("A", "B", "A", "C"),
  gpa = c(3.8, 3.2, 3.9, 2.8)
)
print(students)

# =============================================================================
# 2. ACCESSING DATA FRAME ELEMENTS
# =============================================================================

# Access columns by name
employees$name
employees$age
employees$salary

# Access columns by position
employees[, 1]  # First column
employees[, 2]  # Second column
employees[, c(1, 3)]  # First and third columns

# Access rows
employees[1, ]  # First row
employees[2, ]  # Second row
employees[1:2, ]  # First two rows

# Access specific cells
employees[1, 2]  # Row 1, Column 2
employees[2, "name"]  # Row 2, Column "name"

# =============================================================================
# 3. DATA FRAME FUNCTIONS
# =============================================================================

# Basic information about the data frame
nrow(employees)      # Number of rows
ncol(employees)      # Number of columns
dim(employees)       # Dimensions
names(employees)     # Column names
str(employees)       # Structure
summary(employees)   # Summary statistics

# View the data frame
View(employees)      # Opens in a new tab (in RStudio)
head(employees)      # First 6 rows
tail(employees)      # Last 6 rows

# =============================================================================
# 4. ADDING AND REMOVING COLUMNS
# =============================================================================

# Add a new column
employees$bonus <- c(5000, 6000, 7000, 5500)
print(employees)

# Add column using different method
employees$total_salary <- employees$salary + employees$bonus

# Remove a column
employees$bonus <- NULL
# Or: employees <- employees[, -5]  # Remove 5th column

# =============================================================================
# 5. FILTERING DATA FRAMES
# =============================================================================

# Filter by condition
high_salary <- employees[employees$salary > 55000, ]
print(high_salary)

# Filter by multiple conditions
it_employees <- employees[employees$department == "IT", ]
young_it <- employees[employees$department == "IT" & employees$age < 30, ]

# Using subset() function
subset(employees, salary > 55000)
subset(employees, department == "IT" & age < 30)

# =============================================================================
# 6. SORTING DATA FRAMES
# =============================================================================

# Sort by a column
sorted_by_salary <- employees[order(employees$salary), ]
sorted_by_age_desc <- employees[order(employees$age, decreasing = TRUE), ]

# Sort by multiple columns
sorted_multi <- employees[order(employees$department, employees$salary), ]

# =============================================================================
# 7. WORKING WITH MISSING DATA
# =============================================================================

# Create data frame with missing values
data_with_na <- data.frame(
  id = c(1, 2, 3, 4),
  value1 = c(10, NA, 30, 40),
  value2 = c(NA, 20, 30, NA)
)
print(data_with_na)

# Check for missing values
is.na(data_with_na)
sum(is.na(data_with_na))  # Total number of missing values
colSums(is.na(data_with_na))  # Missing values per column

# Remove rows with missing values
complete_data <- na.omit(data_with_na)

# Replace missing values
data_with_na$value1[is.na(data_with_na$value1)] <- 0
data_with_na$value2[is.na(data_with_na$value2)] <- mean(data_with_na$value2, na.rm = TRUE)

# =============================================================================
# 8. COMBINING DATA FRAMES
# =============================================================================

# Create two data frames
df1 <- data.frame(id = c(1, 2, 3), name = c("A", "B", "C"))
df2 <- data.frame(id = c(4, 5, 6), name = c("D", "E", "F"))

# Combine vertically (add rows)
combined_df <- rbind(df1, df2)

# Combine horizontally (add columns)
df3 <- data.frame(age = c(25, 30, 35))
df4 <- data.frame(name = c("Alice", "Bob", "Charlie"), age = c(25, 30, 35))
combined_df2 <- cbind(df1, df3)

# Merge data frames
df5 <- data.frame(id = c(1, 2, 3), salary = c(50000, 60000, 70000))
merged_df <- merge(df1, df5, by = "id")

# =============================================================================
# 9. APPLYING FUNCTIONS TO DATA FRAMES
# =============================================================================

# Apply function to each column
apply(employees[, c("age", "salary")], 2, mean)

# Apply function to each row
apply(employees[, c("age", "salary")], 1, sum)

# Using sapply for columns
sapply(employees[, c("age", "salary")], mean)

# Using lapply for lists
lapply(employees[, c("age", "salary")], summary)

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a data frame with information about 5 cars:
# - make (character): "Toyota", "Honda", "Ford", "BMW", "Audi"
# - model (character): "Camry", "Civic", "Focus", "X3", "A4"
# - year (numeric): 2020, 2021, 2019, 2022, 2020
# - price (numeric): 25000, 22000, 18000, 45000, 40000

# Exercise 2: From your car data frame:
# - Find cars with price > 30000
# - Sort by year (newest first)
# - Calculate the average price

# Exercise 3: Add a new column "age" that calculates the car's age
# (current year - year)

# Exercise 4: Create a summary table showing:
# - Number of cars by make
# - Average price by make

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
cars <- data.frame(
  make = c("Toyota", "Honda", "Ford", "BMW", "Audi"),
  model = c("Camry", "Civic", "Focus", "X3", "A4"),
  year = c(2020, 2021, 2019, 2022, 2020),
  price = c(25000, 22000, 18000, 45000, 40000)
)
print(cars)

# Solution 2:
expensive_cars <- cars[cars$price > 30000, ]
sorted_cars <- cars[order(cars$year, decreasing = TRUE), ]
avg_price <- mean(cars$price)

# Solution 3:
current_year <- 2024
cars$age <- current_year - cars$year
print(cars)

# Solution 4:
table(cars$make)
tapply(cars$price, cars$make, mean)

# =============================================================================
# GLOSSARY AND DEFINITIONS
# =============================================================================

# Data Frame: A table-like structure with rows and columns, where each column can have different data types
# Row: A horizontal record containing values for all variables
# Column: A vertical field containing values for one variable
# Variable: A column in a data frame representing a characteristic or measurement
# Observation: A row in a data frame representing one unit of analysis
# Index: Position identifier for rows or columns
# Subset: A portion of a data frame selected by rows, columns, or conditions
# Filter: Process of selecting rows based on conditions
# Sort: Arranging rows in a specific order
# Merge: Combining two data frames based on common variables
# Join: Database-style operation to combine data frames
# Pivot: Reshaping data from long to wide format or vice versa
# Aggregation: Summarizing data by groups

# =============================================================================
# DATA FRAME CREATION FUNCTIONS
# =============================================================================

# data.frame() - create data frame from vectors
# as.data.frame() - convert other objects to data frame
# read.csv() - read CSV file into data frame
# read.table() - read text file into data frame
# read_excel() - read Excel file into data frame
# data.table() - create data table (from data.table package)
# tibble() - create tibble (from tibble package)

# =============================================================================
# DATA FRAME MANIPULATION FUNCTIONS
# =============================================================================

# Accessing: $, [, [[, subset()
# Filtering: subset(), filter() (dplyr)
# Sorting: order(), arrange() (dplyr)
# Adding: cbind(), rbind(), merge()
# Removing: subset(), select() (dplyr)
# Renaming: names(), colnames(), rename() (dplyr)
# Reshaping: reshape(), pivot_longer(), pivot_wider() (tidyr)
# Grouping: group_by() (dplyr)
# Summarizing: aggregate(), summarise() (dplyr)

# =============================================================================
# DATA FRAME ANALYSIS FUNCTIONS
# =============================================================================

# Structure: str(), head(), tail(), View()
# Summary: summary(), describe() (psych)
# Dimensions: nrow(), ncol(), dim()
# Names: names(), colnames(), rownames()
# Types: sapply(), class(), typeof()
# Missing: is.na(), complete.cases(), na.omit()
# Duplicates: duplicated(), unique()

# =============================================================================
# TROUBLESHOOTING COMMON ERRORS
# =============================================================================

# Error: "undefined columns selected"
# Solution: Check column names and spelling
# Example: Use names(df) to see available columns

# Error: "replacement has length zero"
# Solution: Ensure replacement values have correct length
# Example: Use rep() for repeated values

# Error: "arguments imply differing number of rows"
# Solution: Check that all vectors have the same length
# Example: Use length() to verify vector sizes

# Error: "non-numeric argument to binary operator"
# Solution: Check data types before operations
# Example: Use as.numeric() to convert text to numbers

# =============================================================================
# PERFORMANCE OPTIMIZATION
# =============================================================================

# 1. Use data.table for large datasets
# 2. Use dplyr for complex operations
# 3. Avoid loops when possible
# 4. Use appropriate data types
# 5. Consider memory usage for large datasets

# =============================================================================
# ADDITIONAL PRACTICE EXERCISES
# =============================================================================

# Exercise 5: Create a data frame analysis function that:
# - Takes a data frame
# - Returns summary statistics for each column
# - Handles different data types appropriately

# Exercise 6: Create a data cleaning function that:
# - Takes a data frame
# - Removes duplicates and missing values
# - Standardizes text data
# - Returns cleaned data frame

# Exercise 7: Create a data comparison function that:
# - Takes two data frames
# - Compares their structure and content
# - Returns a comparison report

# Exercise 8: Create a data export function that:
# - Takes a data frame
# - Exports it in multiple formats (CSV, Excel, JSON)
# - Handles errors gracefully

# =============================================================================
# SOLUTIONS TO ADDITIONAL EXERCISES
# =============================================================================

# Solution 5:
dataframe_analyzer <- function(df) {
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }
  
  analysis <- list()
  
  for (col in names(df)) {
    col_data <- df[[col]]
    
    if (is.numeric(col_data)) {
      analysis[[col]] <- list(
        type = "numeric",
        count = length(col_data),
        missing = sum(is.na(col_data)),
        mean = mean(col_data, na.rm = TRUE),
        median = median(col_data, na.rm = TRUE),
        sd = sd(col_data, na.rm = TRUE),
        min = min(col_data, na.rm = TRUE),
        max = max(col_data, na.rm = TRUE),
        unique_values = length(unique(col_data))
      )
    } else if (is.character(col_data)) {
      analysis[[col]] <- list(
        type = "character",
        count = length(col_data),
        missing = sum(is.na(col_data)),
        unique_values = length(unique(col_data)),
        most_common = names(sort(table(col_data), decreasing = TRUE))[1],
        avg_length = mean(nchar(col_data), na.rm = TRUE)
      )
    } else if (is.logical(col_data)) {
      analysis[[col]] <- list(
        type = "logical",
        count = length(col_data),
        missing = sum(is.na(col_data)),
        true_count = sum(col_data, na.rm = TRUE),
        false_count = sum(!col_data, na.rm = TRUE)
      )
    } else {
      analysis[[col]] <- list(
        type = class(col_data),
        count = length(col_data),
        missing = sum(is.na(col_data))
      )
    }
  }
  
  return(analysis)
}

# Test the function
test_df <- data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 30, 35, 28),
  salary = c(50000, 60000, 70000, 55000),
  is_manager = c(FALSE, TRUE, FALSE, TRUE),
  department = c("IT", "HR", "IT", "Finance")
)

analysis <- dataframe_analyzer(test_df)
cat("Data Frame Analysis:\n")
print(analysis)

# Solution 6:
data_cleaner <- function(df) {
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }
  
  # Create a copy to avoid modifying original
  cleaned_df <- df
  
  # Remove duplicates
  cleaned_df <- unique(cleaned_df)
  
  # Standardize text columns
  for (col in names(cleaned_df)) {
    if (is.character(cleaned_df[[col]])) {
      # Convert to lowercase and trim whitespace
      cleaned_df[[col]] <- trimws(tolower(cleaned_df[[col]]))
    }
  }
  
  # Handle missing values in numeric columns
  for (col in names(cleaned_df)) {
    if (is.numeric(cleaned_df[[col]])) {
      # Replace missing values with median
      cleaned_df[[col]][is.na(cleaned_df[[col]])] <- median(cleaned_df[[col]], na.rm = TRUE)
    }
  }
  
  # Remove rows with all missing values
  cleaned_df <- cleaned_df[rowSums(is.na(cleaned_df)) < ncol(cleaned_df), ]
  
  return(cleaned_df)
}

# Test the function
messy_df <- data.frame(
  name = c("Alice", "BOB", "Charlie", "DIANA", "Alice"),
  age = c(25, 30, NA, 28, 25),
  salary = c(50000, 60000, 70000, NA, 50000),
  department = c("IT", "HR", "IT", "Finance", "IT")
)

cleaned <- data_cleaner(messy_df)
cat("Original data frame:\n")
print(messy_df)
cat("\nCleaned data frame:\n")
print(cleaned)

# Solution 7:
dataframe_comparator <- function(df1, df2) {
  if (!is.data.frame(df1) || !is.data.frame(df2)) {
    stop("Both inputs must be data frames")
  }
  
  comparison <- list()
  
  # Compare dimensions
  comparison$dimensions <- list(
    df1 = dim(df1),
    df2 = dim(df2),
    same_dimensions = identical(dim(df1), dim(df2))
  )
  
  # Compare column names
  comparison$column_names <- list(
    df1 = names(df1),
    df2 = names(df2),
    same_names = identical(names(df1), names(df2)),
    common_names = intersect(names(df1), names(df2)),
    df1_only = setdiff(names(df1), names(df2)),
    df2_only = setdiff(names(df2), names(df1))
  )
  
  # Compare data types
  comparison$data_types <- list(
    df1 = sapply(df1, class),
    df2 = sapply(df2, class),
    same_types = identical(sapply(df1, class), sapply(df2, class))
  )
  
  # Compare content (if same structure)
  if (comparison$dimensions$same_dimensions && comparison$column_names$same_names) {
    comparison$content <- list(
      identical_content = identical(df1, df2),
      differences = sum(df1 != df2, na.rm = TRUE)
    )
  }
  
  return(comparison)
}

# Test the function
df1 <- data.frame(a = 1:3, b = c("x", "y", "z"))
df2 <- data.frame(a = 1:3, b = c("x", "y", "z"))
df3 <- data.frame(a = 1:3, c = c("x", "y", "z"))

comparison1 <- dataframe_comparator(df1, df2)
comparison2 <- dataframe_comparator(df1, df3)

cat("Comparison 1 (identical):\n")
print(comparison1)
cat("\nComparison 2 (different):\n")
print(comparison2)

# Solution 8:
data_exporter <- function(df, filename_prefix) {
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }
  
  if (missing(filename_prefix)) {
    filename_prefix <- "exported_data"
  }
  
  export_results <- list()
  
  # Export to CSV
  tryCatch({
    csv_file <- paste0(filename_prefix, ".csv")
    write.csv(df, csv_file, row.names = FALSE)
    export_results$csv <- paste("Successfully exported to", csv_file)
  }, error = function(e) {
    export_results$csv <- paste("CSV export failed:", e$message)
  })
  
  # Export to Excel (if openxlsx is available)
  tryCatch({
    if (requireNamespace("openxlsx", quietly = TRUE)) {
      excel_file <- paste0(filename_prefix, ".xlsx")
      openxlsx::write.xlsx(df, excel_file, rowNames = FALSE)
      export_results$excel <- paste("Successfully exported to", excel_file)
    } else {
      export_results$excel <- "Excel export skipped: openxlsx package not available"
    }
  }, error = function(e) {
    export_results$excel <- paste("Excel export failed:", e$message)
  })
  
  # Export to JSON (if jsonlite is available)
  tryCatch({
    if (requireNamespace("jsonlite", quietly = TRUE)) {
      json_file <- paste0(filename_prefix, ".json")
      jsonlite::write_json(df, json_file)
      export_results$json <- paste("Successfully exported to", json_file)
    } else {
      export_results$json <- "JSON export skipped: jsonlite package not available"
    }
  }, error = function(e) {
    export_results$json <- paste("JSON export failed:", e$message)
  })
  
  return(export_results)
}

# Test the function
export_results <- data_exporter(test_df, "test_export")
cat("Export Results:\n")
print(export_results)

# =============================================================================
# REAL-WORLD APPLICATIONS
# =============================================================================

# Data Frame Applications:
# - Business data (sales, customers, products)
# - Scientific data (experiments, measurements)
# - Survey data (responses, demographics)
# - Financial data (transactions, accounts)
# - Educational data (students, grades, courses)

# Example: Sales analysis
sales_data <- data.frame(
  date = as.Date(c("2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05")),
  product = c("A", "B", "A", "C", "B"),
  quantity = c(10, 5, 15, 8, 12),
  price = c(100, 200, 100, 150, 200),
  region = c("North", "South", "North", "East", "West")
)

# Calculate revenue
sales_data$revenue <- sales_data$quantity * sales_data$price

# Analyze by product
product_summary <- aggregate(revenue ~ product, data = sales_data, FUN = sum)
cat("Product Revenue Summary:\n")
print(product_summary)

# Analyze by region
region_summary <- aggregate(revenue ~ region, data = sales_data, FUN = sum)
cat("\nRegion Revenue Summary:\n")
print(region_summary)

# Find best performing product
best_product <- product_summary[which.max(product_summary$revenue), ]
cat("\nBest Performing Product:\n")
print(best_product)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Data frames store data in rows and columns
# 2. Each column can have different data types
# 3. Use $ to access columns by name
# 4. Use [row, col] to access specific elements
# 5. Use subset() for filtering
# 6. Use order() for sorting
# 7. Handle missing values with is.na() and na.omit()
# 8. Combine data frames with rbind(), cbind(), or merge()
# 9. Always validate data before analysis
# 10. Use appropriate functions for different operations

# Next: Move to 05_Functions.R to learn about creating functions!
