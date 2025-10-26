# Module 8: R Best Practices and Coding Standards
# File: 27_R_Best_Practices.R

# =============================================================================
# R BEST PRACTICES AND CODING STANDARDS
# =============================================================================

# This lesson covers best practices for writing clean, efficient, and maintainable R code

# =============================================================================
# 1. CODE STYLE AND FORMATTING
# =============================================================================

# Use consistent indentation (2 or 4 spaces)
# Good:
if (condition) {
  do_something()
  do_something_else()
}

# Bad:
if (condition) {
do_something()
do_something_else()
}

# Use meaningful variable names
# Good:
student_age <- 25
average_score <- 85.5
is_enrolled <- TRUE

# Bad:
x <- 25
y <- 85.5
z <- TRUE

# Use descriptive function names
# Good:
calculate_average_grade <- function(grades) {
  return(mean(grades))
}

# Bad:
calc <- function(x) {
  return(mean(x))
}

# =============================================================================
# 2. VARIABLE NAMING CONVENTIONS
# =============================================================================

# Use snake_case for variables and functions
student_name <- "John Doe"
average_grade <- 85.5
is_student_active <- TRUE

# Use descriptive names
# Good:
monthly_sales_revenue <- 50000
customer_satisfaction_score <- 4.5

# Bad:
msr <- 50000
css <- 4.5

# Use consistent naming patterns
# For data frames:
student_data <- data.frame(...)
sales_data <- data.frame(...)
customer_data <- data.frame(...)

# For functions:
calculate_mean <- function(...) { }
calculate_median <- function(...) { }
calculate_standard_deviation <- function(...) { }

# =============================================================================
# 3. FUNCTION DESIGN PRINCIPLES
# =============================================================================

# Single Responsibility Principle
# Each function should do one thing well

# Good: Single responsibility
calculate_mean <- function(x) {
  if (!is.numeric(x)) {
    stop("Input must be numeric")
  }
  return(sum(x) / length(x))
}

# Bad: Multiple responsibilities
calculate_stats <- function(x) {
  mean_val <- mean(x)
  median_val <- median(x)
  sd_val <- sd(x)
  plot(x)
  return(list(mean = mean_val, median = median_val, sd = sd_val))
}

# Use default parameters
# Good:
create_person <- function(name, age = 25, city = "Unknown") {
  list(name = name, age = age, city = city)
}

# Bad:
create_person <- function(name, age, city) {
  list(name = name, age = age, city = city)
}

# Validate inputs
# Good:
safe_divide <- function(x, y) {
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Both inputs must be numeric")
  }
  if (y == 0) {
    stop("Cannot divide by zero")
  }
  return(x / y)
}

# Bad:
unsafe_divide <- function(x, y) {
  return(x / y)
}

# =============================================================================
# 4. ERROR HANDLING AND VALIDATION
# =============================================================================

# Always validate inputs
validate_numeric_input <- function(x) {
  if (!is.numeric(x)) {
    stop("Input must be numeric")
  }
  if (length(x) == 0) {
    stop("Input cannot be empty")
  }
  if (any(is.na(x))) {
    warning("Input contains missing values")
  }
  return(TRUE)
}

# Use tryCatch for error handling
robust_function <- function(x) {
  tryCatch({
    result <- sqrt(x)
    return(result)
  }, error = function(e) {
    cat("Error:", e$message, "\n")
    return(NA)
  }, warning = function(w) {
    cat("Warning:", w$message, "\n")
    return(sqrt(x))
  })
}

# Test the function
test_values <- c(4, -1, 9, "text")
results <- sapply(test_values, robust_function)
print(results)

# =============================================================================
# 5. DOCUMENTATION AND COMMENTS
# =============================================================================

# Use roxygen2 for function documentation
# install.packages("roxygen2")
library(roxygen2)

# Example of well-documented function
#' Calculate the weighted average of a vector
#'
#' This function calculates the weighted average of a numeric vector,
#' where each element is weighted by its position in the vector.
#'
#' @param x A numeric vector
#' @param weights A numeric vector of weights (optional)
#' @return The weighted average as a numeric value
#' @examples
#' calculate_weighted_average(c(1, 2, 3, 4, 5))
#' calculate_weighted_average(c(1, 2, 3, 4, 5), c(0.1, 0.2, 0.3, 0.2, 0.2))
#' @export
calculate_weighted_average <- function(x, weights = NULL) {
  if (!is.numeric(x)) {
    stop("Input must be numeric")
  }
  
  if (is.null(weights)) {
    weights <- seq_along(x)
  }
  
  if (length(weights) != length(x)) {
    stop("Weights must have the same length as input")
  }
  
  return(sum(x * weights) / sum(weights))
}

# Use meaningful comments
# Good:
# Calculate the standard deviation using the population formula
population_sd <- function(x) {
  n <- length(x)
  mean_x <- mean(x)
  variance <- sum((x - mean_x)^2) / n  # Population variance
  return(sqrt(variance))
}

# Bad:
# Calculate sd
sd <- function(x) {
  n <- length(x)
  m <- mean(x)
  v <- sum((x - m)^2) / n
  return(sqrt(v))
}

# =============================================================================
# 6. PERFORMANCE OPTIMIZATION
# =============================================================================

# Use vectorized operations
# Good:
vectorized_sum <- function(x) {
  return(sum(x))
}

# Bad:
loop_sum <- function(x) {
  total <- 0
  for (i in 1:length(x)) {
    total <- total + x[i]
  }
  return(total)
}

# Pre-allocate vectors
# Good:
preallocated_vector <- function(n) {
  result <- numeric(n)
  for (i in 1:n) {
    result[i] <- i^2
  }
  return(result)
}

# Bad:
growing_vector <- function(n) {
  result <- c()
  for (i in 1:n) {
    result <- c(result, i^2)
  }
  return(result)
}

# Use appropriate data types
# Good:
efficient_data <- data.frame(
  id = as.integer(1:1000),
  name = as.character(paste("Person", 1:1000)),
  active = as.logical(rep(c(TRUE, FALSE), 500))
)

# Bad:
inefficient_data <- data.frame(
  id = 1:1000,
  name = paste("Person", 1:1000),
  active = rep(c(TRUE, FALSE), 500)
)

# =============================================================================
# 7. PACKAGE DEVELOPMENT
# =============================================================================

# Create a simple package structure
# install.packages("devtools")
library(devtools)

# Package structure example
# mypackage/
#   ├── DESCRIPTION
#   ├── NAMESPACE
#   ├── R/
#   │   └── functions.R
#   ├── man/
#   │   └── function-documentation.Rd
#   └── tests/
#       └── testthat/
#           └── test-functions.R

# DESCRIPTION file example
# Package: mypackage
# Title: My R Package
# Version: 0.1.0
# Author: Your Name
# Description: A package for data analysis
# License: MIT
# Depends: R (>= 3.5.0)
# Imports: dplyr, ggplot2

# NAMESPACE file example
# export(calculate_mean)
# export(calculate_median)
# import(dplyr)
# import(ggplot2)

# =============================================================================
# 8. TESTING AND QUALITY ASSURANCE
# =============================================================================

# Use testthat for unit testing
# install.packages("testthat")
library(testthat)

# Example test
test_that("calculate_mean works correctly", {
  expect_equal(calculate_mean(c(1, 2, 3, 4, 5)), 3)
  expect_equal(calculate_mean(c(10, 20, 30)), 20)
  expect_error(calculate_mean(c("a", "b", "c")))
})

# Test edge cases
test_that("calculate_mean handles edge cases", {
  expect_equal(calculate_mean(c(5)), 5)
  expect_equal(calculate_mean(c(0, 0, 0)), 0)
  expect_error(calculate_mean(c()))
})

# =============================================================================
# 9. VERSION CONTROL AND COLLABORATION
# =============================================================================

# Use Git for version control
# Initialize repository: git init
# Add files: git add .
# Commit changes: git commit -m "Initial commit"
# Push to remote: git push origin main

# Use meaningful commit messages
# Good:
# "Add function to calculate weighted average"
# "Fix bug in data validation"
# "Update documentation for calculate_mean function"

# Bad:
# "Update"
# "Fix"
# "Changes"

# =============================================================================
# 10. CODE ORGANIZATION
# =============================================================================

# Organize code into logical sections
# 1. Library loading
# 2. Data loading
# 3. Data cleaning
# 4. Analysis
# 5. Visualization
# 6. Results

# Example of well-organized script
# Load libraries
library(dplyr)
library(ggplot2)
library(readr)

# Load data
data <- read_csv("data.csv")

# Clean data
cleaned_data <- data %>%
  filter(!is.na(score)) %>%
  mutate(grade = ifelse(score >= 90, "A",
                       ifelse(score >= 80, "B",
                             ifelse(score >= 70, "C", "F"))))

# Analyze data
summary_stats <- cleaned_data %>%
  group_by(grade) %>%
  summarise(
    count = n(),
    mean_score = mean(score),
    sd_score = sd(score)
  )

# Visualize results
plot <- ggplot(cleaned_data, aes(x = grade, y = score)) +
  geom_boxplot() +
  labs(title = "Score Distribution by Grade")

# =============================================================================
# 11. SECURITY AND PRIVACY
# =============================================================================

# Never hardcode sensitive information
# Bad:
# password <- "secret123"
# api_key <- "abc123xyz"

# Good:
# Use environment variables
# password <- Sys.getenv("DB_PASSWORD")
# api_key <- Sys.getenv("API_KEY")

# Validate user inputs
validate_user_input <- function(input) {
  if (is.null(input) || length(input) == 0) {
    stop("Input cannot be empty")
  }
  if (any(grepl("[<>]", input))) {
    stop("Input contains potentially dangerous characters")
  }
  return(TRUE)
}

# =============================================================================
# 12. MEMORY MANAGEMENT
# =============================================================================

# Remove unused objects
large_object <- rnorm(1000000)
# Use the object
result <- mean(large_object)
# Remove when done
rm(large_object)
gc()  # Force garbage collection

# Use appropriate data structures
# For large datasets, consider data.table
# install.packages("data.table")
library(data.table)

# Convert data frame to data table
dt <- as.data.table(mtcars)
# More memory efficient operations
result <- dt[, .(mean_mpg = mean(mpg)), by = cyl]

# =============================================================================
# 13. DEBUGGING TECHNIQUES
# =============================================================================

# Use browser() for interactive debugging
debug_function <- function(x) {
  browser()  # Pause execution here
  result <- x * 2
  return(result)
}

# Use trace() for function tracing
trace(mean, tracer = function() cat("Calling mean function\n"))

# Use debug() for function debugging
debug(mean)
mean(c(1, 2, 3))
undebug(mean)

# =============================================================================
# 14. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Write a well-documented function that calculates
# the median of a numeric vector with proper error handling

# Exercise 2: Create a function that validates email addresses
# using regular expressions

# Exercise 3: Write a function that safely reads CSV files
# with error handling and validation

# Exercise 4: Create a package structure for a simple
# statistics package

# =============================================================================
# SOLUTIONS TO EXERCISES
# =============================================================================

# Solution 1: Well-documented median function
#' Calculate the median of a numeric vector
#'
#' This function calculates the median value of a numeric vector,
#' handling missing values appropriately.
#'
#' @param x A numeric vector
#' @param na.rm Logical indicating whether to remove missing values
#' @return The median value as a numeric
#' @examples
#' calculate_median(c(1, 2, 3, 4, 5))
#' calculate_median(c(1, 2, 3, 4, 5, NA), na.rm = TRUE)
#' @export
calculate_median <- function(x, na.rm = FALSE) {
  # Validate input
  if (!is.numeric(x)) {
    stop("Input must be numeric")
  }
  
  if (length(x) == 0) {
    stop("Input cannot be empty")
  }
  
  # Handle missing values
  if (na.rm) {
    x <- x[!is.na(x)]
  } else if (any(is.na(x))) {
    return(NA)
  }
  
  # Calculate median
  sorted_x <- sort(x)
  n <- length(sorted_x)
  
  if (n %% 2 == 0) {
    return((sorted_x[n/2] + sorted_x[n/2 + 1]) / 2)
  } else {
    return(sorted_x[(n + 1)/2])
  }
}

# Test the function
test_values <- c(1, 2, 3, 4, 5)
cat("Median of", test_values, ":", calculate_median(test_values), "\n")

# Solution 2: Email validation function
#' Validate email addresses
#'
#' This function validates email addresses using regular expressions.
#'
#' @param email A character vector of email addresses
#' @return A logical vector indicating valid emails
#' @examples
#' validate_email("test@example.com")
#' validate_email(c("test@example.com", "invalid-email"))
#' @export
validate_email <- function(email) {
  if (!is.character(email)) {
    stop("Input must be character")
  }
  
  # Email regex pattern
  pattern <- "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
  
  return(grepl(pattern, email))
}

# Test the function
test_emails <- c("test@example.com", "invalid-email", "user@domain.org")
cat("Email validation results:", validate_email(test_emails), "\n")

# Solution 3: Safe CSV reader
#' Safely read CSV files
#'
#' This function reads CSV files with error handling and validation.
#'
#' @param file_path Path to the CSV file
#' @param ... Additional arguments passed to read.csv
#' @return A data frame or NULL if error occurs
#' @examples
#' safe_read_csv("data.csv")
#' safe_read_csv("data.csv", stringsAsFactors = FALSE)
#' @export
safe_read_csv <- function(file_path, ...) {
  # Validate file path
  if (!is.character(file_path) || length(file_path) != 1) {
    stop("File path must be a single character string")
  }
  
  if (!file.exists(file_path)) {
    stop("File does not exist: ", file_path)
  }
  
  # Try to read the file
  tryCatch({
    data <- read.csv(file_path, ...)
    
    # Validate the data
    if (!is.data.frame(data)) {
      stop("File does not contain valid CSV data")
    }
    
    if (nrow(data) == 0) {
      warning("File contains no data")
    }
    
    return(data)
  }, error = function(e) {
    cat("Error reading file:", e$message, "\n")
    return(NULL)
  })
}

# Test the function
# safe_read_csv("nonexistent.csv")  # Will show error
# safe_read_csv("existing.csv")     # Will read successfully

# Solution 4: Package structure
# Create package directory structure
create_package_structure <- function(package_name) {
  # Create directories
  dir.create(package_name)
  dir.create(file.path(package_name, "R"))
  dir.create(file.path(package_name, "man"))
  dir.create(file.path(package_name, "tests"))
  dir.create(file.path(package_name, "tests", "testthat"))
  
  # Create DESCRIPTION file
  description <- paste0(
    "Package: ", package_name, "\n",
    "Title: ", package_name, " Package\n",
    "Version: 0.1.0\n",
    "Author: Your Name\n",
    "Description: A package for statistical analysis\n",
    "License: MIT\n",
    "Depends: R (>= 3.5.0)\n",
    "Imports: dplyr, ggplot2\n"
  )
  
  writeLines(description, file.path(package_name, "DESCRIPTION"))
  
  # Create NAMESPACE file
  namespace <- paste0(
    "export(calculate_mean)\n",
    "export(calculate_median)\n",
    "import(dplyr)\n",
    "import(ggplot2)\n"
  )
  
  writeLines(namespace, file.path(package_name, "NAMESPACE"))
  
  cat("Package structure created for:", package_name, "\n")
}

# Create package structure
# create_package_structure("mystats")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use consistent code style and formatting
# 2. Choose meaningful variable and function names
# 3. Design functions with single responsibility
# 4. Always validate inputs and handle errors
# 5. Document your code thoroughly
# 6. Optimize for performance when necessary
# 7. Use version control for collaboration
# 8. Organize code into logical sections
# 9. Consider security and privacy implications
# 10. Manage memory efficiently
# 11. Use debugging tools effectively
# 12. Test your code thoroughly
# 13. Follow package development best practices
# 14. Write clean, maintainable code
# 15. Continuously improve your coding skills

# Next: Apply these best practices to your R projects!
