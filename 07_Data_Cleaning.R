# Module 2: Data Cleaning and Preprocessing
# File: 07_Data_Cleaning.R

# =============================================================================
# DATA CLEANING AND PREPROCESSING IN R
# =============================================================================

# Data cleaning is crucial for accurate analysis
# This lesson covers identifying and handling common data quality issues

# =============================================================================
# 1. CREATING SAMPLE DATA WITH ISSUES
# =============================================================================

# Create sample data with various data quality issues
messy_data <- data.frame(
  id = c(1, 2, 3, 4, 5, 6),
  name = c("Alice", "bob", "CHARLIE", "diana", "Eve", "frank"),
  age = c(25, 30, 35, 28, NA, 45),
  salary = c(50000, 60000, 70000, 55000, 65000, 80000),
  email = c("alice@email.com", "bob@email.com", "charlie@email.com", 
            "diana@email.com", "eve@email.com", "frank@email.com"),
  department = c("IT", "HR", "IT", "Finance", "IT", "HR"),
  hire_date = c("2020-01-15", "2019-03-22", "2021-06-10", 
                "2020-11-05", "2022-02-14", "2018-09-30"),
  performance = c("Excellent", "Good", "Excellent", "Good", "Excellent", "Good"),
  stringsAsFactors = FALSE
)

print(messy_data)

# =============================================================================
# 2. IDENTIFYING DATA QUALITY ISSUES
# =============================================================================

# Check data structure
str(messy_data)

# Check for missing values
is.na(messy_data)
sum(is.na(messy_data))
colSums(is.na(messy_data))

# Check for duplicates
duplicated(messy_data)
sum(duplicated(messy_data))

# Check data types
sapply(messy_data, class)

# Check for outliers (using IQR method)
check_outliers <- function(data, column) {
  Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  outliers <- data[[column]] < lower_bound | data[[column]] > upper_bound
  return(outliers)
}

# Check for outliers in salary
salary_outliers <- check_outliers(messy_data, "salary")
print(salary_outliers)

# =============================================================================
# 3. HANDLING MISSING VALUES
# =============================================================================

# Create data with missing values
data_with_na <- messy_data
data_with_na$age[2] <- NA
data_with_na$salary[4] <- NA

# Method 1: Remove rows with missing values
data_no_na <- na.omit(data_with_na)
print(data_no_na)

# Method 2: Replace with mean (for numeric columns)
data_mean_impute <- data_with_na
data_mean_impute$age[is.na(data_mean_impute$age)] <- mean(data_mean_impute$age, na.rm = TRUE)
data_mean_impute$salary[is.na(data_mean_impute$salary)] <- mean(data_mean_impute$salary, na.rm = TRUE)

# Method 3: Replace with median
data_median_impute <- data_with_na
data_median_impute$age[is.na(data_median_impute$age)] <- median(data_median_impute$age, na.rm = TRUE)
data_median_impute$salary[is.na(data_median_impute$salary)] <- median(data_median_impute$salary, na.rm = TRUE)

# Method 4: Replace with mode (for categorical columns)
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# =============================================================================
# 4. STANDARDIZING TEXT DATA
# =============================================================================

# Convert to proper case (first letter uppercase)
messy_data$name <- tools::toTitleCase(tolower(messy_data$name))

# Remove extra whitespace
messy_data$name <- trimws(messy_data$name)

# Standardize department names
messy_data$department <- toupper(messy_data$department)

print(messy_data)

# =============================================================================
# 5. HANDLING DUPLICATES
# =============================================================================

# Create data with duplicates
duplicate_data <- rbind(messy_data, messy_data[1:2, ])
print(duplicate_data)

# Remove duplicates
unique_data <- unique(duplicate_data)
print(unique_data)

# Remove duplicates based on specific columns
unique_by_id <- duplicate_data[!duplicated(duplicate_data$id), ]
print(unique_by_id)

# =============================================================================
# 6. DATA TYPE CONVERSIONS
# =============================================================================

# Convert hire_date to proper date format
messy_data$hire_date <- as.Date(messy_data$hire_date)
class(messy_data$hire_date)

# Convert performance to factor
messy_data$performance <- as.factor(messy_data$performance)
class(messy_data$performance)

# Convert salary to numeric (if it was character)
messy_data$salary <- as.numeric(messy_data$salary)

# =============================================================================
# 7. CREATING NEW VARIABLES
# =============================================================================

# Calculate years of experience
current_date <- Sys.Date()
messy_data$years_experience <- as.numeric(current_date - messy_data$hire_date) / 365.25

# Create salary categories
messy_data$salary_category <- ifelse(messy_data$salary < 60000, "Low",
                                    ifelse(messy_data$salary < 70000, "Medium", "High"))

# Create age groups
messy_data$age_group <- ifelse(messy_data$age < 30, "Young",
                              ifelse(messy_data$age < 40, "Middle", "Senior"))

print(messy_data)

# =============================================================================
# 8. FILTERING AND SUBSETTING DATA
# =============================================================================

# Remove rows with missing age
clean_data <- messy_data[!is.na(messy_data$age), ]

# Filter by department
it_employees <- messy_data[messy_data$department == "IT", ]

# Filter by multiple conditions
senior_it <- messy_data[messy_data$department == "IT" & messy_data$age > 30, ]

# =============================================================================
# 9. DATA VALIDATION
# =============================================================================

# Check for valid email format (simple check)
is_valid_email <- function(email) {
  grepl("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", email)
}

messy_data$valid_email <- is_valid_email(messy_data$email)

# Check for reasonable age values
messy_data$reasonable_age <- messy_data$age >= 18 & messy_data$age <= 65

# Check for positive salary
messy_data$positive_salary <- messy_data$salary > 0

print(messy_data)

# =============================================================================
# 10. COMPREHENSIVE DATA CLEANING FUNCTION
# =============================================================================

# Create a comprehensive data cleaning function
clean_data <- function(data) {
  # Remove duplicates
  data <- unique(data)
  
  # Standardize text columns
  text_columns <- sapply(data, is.character)
  for (col in names(data)[text_columns]) {
    data[[col]] <- trimws(tolower(data[[col]]))
  }
  
  # Handle missing values in numeric columns
  numeric_columns <- sapply(data, is.numeric)
  for (col in names(data)[numeric_columns]) {
    if (sum(is.na(data[[col]])) > 0) {
      data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
    }
  }
  
  # Remove rows with all missing values
  data <- data[rowSums(is.na(data)) < ncol(data), ]
  
  return(data)
}

# Test the cleaning function
cleaned_data <- clean_data(messy_data)
print(cleaned_data)

# =============================================================================
# 11. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a data frame with various data quality issues:
# - Inconsistent capitalization
# - Missing values
# - Duplicates
# - Invalid data types
# Then clean the data step by step

# Exercise 2: Create a function that identifies and handles outliers
# in a numeric column

# Exercise 3: Clean a dataset with date columns that have
# different formats

# Exercise 4: Create a data validation report that checks for:
# - Missing values
# - Duplicates
# - Invalid ranges
# - Data type consistency

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
problematic_data <- data.frame(
  name = c("JOHN", "jane", "Bob", "JOHN", "alice"),
  age = c(25, NA, 35, 25, 30),
  score = c("85", "90", "95", "85", "88"),
  grade = c("A", "B", "A", "A", "B")
)

# Clean the data
problematic_data$name <- tools::toTitleCase(tolower(problematic_data$name))
problematic_data$age[is.na(problematic_data$age)] <- median(problematic_data$age, na.rm = TRUE)
problematic_data$score <- as.numeric(problematic_data$score)
problematic_data <- unique(problematic_data)

# Solution 2:
handle_outliers <- function(data, column) {
  Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  
  # Replace outliers with median
  data[[column]][data[[column]] < lower_bound | data[[column]] > upper_bound] <- median(data[[column]], na.rm = TRUE)
  return(data)
}

# Solution 3:
date_data <- data.frame(
  date1 = c("2020-01-15", "15/01/2020", "Jan 15, 2020"),
  date2 = c("2021-06-10", "10/06/2021", "Jun 10, 2021")
)

# Convert to proper date format
date_data$date1 <- as.Date(date_data$date1, format = "%Y-%m-%d")
date_data$date2 <- as.Date(date_data$date2, format = "%d/%m/%Y")

# Solution 4:
validation_report <- function(data) {
  report <- list()
  
  # Missing values
  report$missing_values <- colSums(is.na(data))
  
  # Duplicates
  report$duplicates <- sum(duplicated(data))
  
  # Data types
  report$data_types <- sapply(data, class)
  
  # Numeric column ranges
  numeric_cols <- sapply(data, is.numeric)
  report$numeric_ranges <- sapply(data[numeric_cols], function(x) c(min(x, na.rm = TRUE), max(x, na.rm = TRUE)))
  
  return(report)
}

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Always check for missing values, duplicates, and outliers
# 2. Standardize text data (case, whitespace)
# 3. Convert data types appropriately
# 4. Handle missing values based on context
# 5. Validate data ranges and formats
# 6. Create cleaning functions for reusable processes
# 7. Document your cleaning steps
# 8. Always verify results after cleaning

# Next: Move to 08_Descriptive_Statistics.R to learn about statistical summaries!
