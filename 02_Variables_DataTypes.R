# Module 1: Variables and Data Types
# File: 02_Variables_DataTypes.R

# =============================================================================
# VARIABLES AND DATA TYPES IN R
# =============================================================================

# In this lesson, you'll learn about:
# 1. Different ways to assign variables
# 2. All data types in R
# 3. How to check and convert data types
# 4. Working with different data structures

# =============================================================================
# 1. VARIABLE ASSIGNMENT
# =============================================================================

# Three ways to assign variables in R:
# Method 1: Using <- (most common and recommended)
name <- "John"

# Method 2: Using = (works but less preferred)
age = 25

# Method 3: Using -> (right to left assignment)
30 -> height

# Print the variables
print(name)
print(age)
print(height)

# =============================================================================
# 2. BASIC DATA TYPES IN R
# =============================================================================

# NUMERIC - for numbers (integers and decimals)
numeric_var <- 42
decimal_var <- 3.14
negative_var <- -10

# Check the type
class(numeric_var)
typeof(numeric_var)

# INTEGER - for whole numbers only
integer_var <- 42L  # The L makes it an integer
class(integer_var)

# CHARACTER - for text (strings)
char_var <- "Hello World"
char_var2 <- 'Single quotes also work'
class(char_var)

# LOGICAL - for TRUE/FALSE values
logical_true <- TRUE
logical_false <- FALSE
class(logical_true)

# COMPLEX - for complex numbers
complex_var <- 3 + 4i
class(complex_var)

# =============================================================================
# 3. CHECKING DATA TYPES
# =============================================================================

# Check if a variable is of a specific type
is.numeric(numeric_var)
is.character(char_var)
is.logical(logical_true)

# Check the class and type
class(numeric_var)
typeof(numeric_var)

# =============================================================================
# 4. CONVERTING DATA TYPES
# =============================================================================

# Convert numeric to character
num_to_char <- as.character(42)
class(num_to_char)

# Convert character to numeric
char_to_num <- as.numeric("42")
class(char_to_num)

# Convert to logical
num_to_logical <- as.logical(1)  # 1 becomes TRUE, 0 becomes FALSE
char_to_logical <- as.logical("TRUE")

# Convert to integer
num_to_int <- as.integer(3.14)

# =============================================================================
# 5. SPECIAL VALUES IN R
# =============================================================================

# NA - Not Available (missing data)
missing_value <- NA
is.na(missing_value)

# NULL - empty object
empty_object <- NULL
is.null(empty_object)

# NaN - Not a Number
not_a_number <- 0/0
is.nan(not_a_number)

# Inf - Infinity
infinity <- 1/0
is.infinite(infinity)

# =============================================================================
# 6. WORKING WITH CHARACTERS
# =============================================================================

# String concatenation
first_name <- "John"
last_name <- "Doe"
full_name <- paste(first_name, last_name)
full_name

# Paste with separator
full_name_sep <- paste(first_name, last_name, sep = "_")

# Paste multiple elements
paste("A", "B", "C", sep = "-")

# String length
nchar(full_name)

# Substring
substr(full_name, 1, 4)

# =============================================================================
# 7. LOGICAL OPERATIONS
# =============================================================================

# Basic logical operators
a <- TRUE
b <- FALSE

# AND operator
a & b

# OR operator
a | b

# NOT operator
!a

# Comparison operators
x <- 10
y <- 5

x > y   # Greater than
x < y   # Less than
x >= y  # Greater than or equal
x <= y  # Less than or equal
x == y  # Equal to
x != y  # Not equal to

# =============================================================================
# 8. WORKING WITH NUMBERS
# =============================================================================

# Mathematical functions
num <- 16.7

round(num)      # Round to nearest integer
floor(num)      # Round down
ceiling(num)    # Round up
abs(-5)         # Absolute value
sqrt(16)        # Square root
log(10)         # Natural logarithm
log10(100)      # Base-10 logarithm
exp(1)          # e raised to power

# =============================================================================
# 9. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create variables for:
# - Your name (character)
# - Your age (numeric)
# - Whether you like R (logical)
# Then check their data types

# Exercise 2: Convert the number 25 to:
# - Character
# - Logical
# - Integer
# Check the types after each conversion

# Exercise 3: Create two character variables with your first and last name
# Use paste() to combine them with a space

# Exercise 4: Use logical operators to check if:
# - 10 is greater than 5 AND less than 15
# - 20 is greater than 25 OR less than 30

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
my_name <- "Alice"
my_age <- 25
like_r <- TRUE
class(my_name)
class(my_age)
class(like_r)

# Solution 2:
number <- 25
as_char <- as.character(number)
as_logical <- as.logical(number)
as_int <- as.integer(number)
class(as_char)
class(as_logical)
class(as_int)

# Solution 3:
first <- "John"
last <- "Smith"
full <- paste(first, last)
print(full)

# Solution 4:
condition1 <- 10 > 5 & 10 < 15
condition2 <- 20 > 25 | 20 < 30
print(condition1)
print(condition2)

# =============================================================================
# GLOSSARY AND DEFINITIONS
# =============================================================================

# Data Type: The classification of data that determines what operations can be performed
# Numeric: Numbers including integers and decimals (e.g., 42, 3.14)
# Integer: Whole numbers only (e.g., 42L)
# Character: Text data enclosed in quotes (e.g., "Hello", 'World')
# Logical: Boolean values TRUE or FALSE
# Complex: Complex numbers with real and imaginary parts (e.g., 3+4i)
# Raw: Binary data
# Factor: Categorical data with predefined levels
# NA: Not Available - represents missing data
# NULL: Empty object with no length
# NaN: Not a Number - result of invalid mathematical operations
# Inf: Infinity - result of operations like 1/0

# =============================================================================
# DATA TYPE CONVERSION FUNCTIONS
# =============================================================================

# as.numeric() - convert to numeric
# as.integer() - convert to integer
# as.character() - convert to character
# as.logical() - convert to logical
# as.factor() - convert to factor
# as.Date() - convert to date
# as.POSIXct() - convert to date-time

# =============================================================================
# STRING MANIPULATION FUNCTIONS
# =============================================================================

# paste() - combine strings
# paste0() - combine strings without separator
# substr() - extract substring
# nchar() - count characters
# toupper() - convert to uppercase
# tolower() - convert to lowercase
# trimws() - remove whitespace
# gsub() - find and replace text
# strsplit() - split string into parts
# grep() - search for pattern
# grepl() - search for pattern (returns logical)

# =============================================================================
# LOGICAL OPERATIONS AND FUNCTIONS
# =============================================================================

# & (AND) - both conditions must be TRUE
# | (OR) - at least one condition must be TRUE
# ! (NOT) - reverses logical value
# && (short-circuit AND) - stops at first FALSE
# || (short-circuit OR) - stops at first TRUE
# all() - returns TRUE if all elements are TRUE
# any() - returns TRUE if any element is TRUE
# which() - returns positions of TRUE values
# ifelse() - vectorized if-else

# =============================================================================
# TROUBLESHOOTING COMMON ERRORS
# =============================================================================

# Error: "non-numeric argument to binary operator"
# Solution: Check data types before performing operations
# Example: as.numeric("42") before math operations

# Error: "invalid factor level, NA generated"
# Solution: Check factor levels or convert to character first
# Example: as.character(factor_var)

# Error: "replacement has length zero"
# Solution: Ensure the replacement value has the correct length
# Example: Use rep() to create repeated values

# Error: "object of type 'closure' is not subsettable"
# Solution: Don't use function names as variable names
# Example: Avoid naming variables 'mean', 'sum', etc.

# =============================================================================
# PERFORMANCE TIPS
# =============================================================================

# 1. Use appropriate data types for your data
# 2. Avoid unnecessary conversions
# 3. Use vectorized operations instead of loops
# 4. Pre-allocate vectors when possible
# 5. Use factors for categorical data with many levels

# =============================================================================
# ADDITIONAL PRACTICE EXERCISES
# =============================================================================

# Exercise 5: Create a data type conversion function that:
# - Takes any input
# - Returns the most appropriate data type
# - Handles errors gracefully

# Exercise 6: Create a text processing function that:
# - Takes a sentence
# - Counts words, characters, and vowels
# - Returns a summary

# Exercise 7: Create a logical function that:
# - Takes two vectors
# - Returns TRUE if they have the same elements (order doesn't matter)
# - Handles different lengths

# Exercise 8: Create a data validation function that:
# - Takes a vector
# - Checks for missing values, outliers, and data type consistency
# - Returns a validation report

# =============================================================================
# SOLUTIONS TO ADDITIONAL EXERCISES
# =============================================================================

# Solution 5:
smart_convert <- function(x) {
  if (is.numeric(x)) {
    if (all(x == as.integer(x))) {
      return(as.integer(x))
    } else {
      return(as.numeric(x))
    }
  } else if (is.character(x)) {
    # Try to convert to numeric if possible
    numeric_version <- suppressWarnings(as.numeric(x))
    if (!any(is.na(numeric_version))) {
      return(numeric_version)
    } else {
      return(as.character(x))
    }
  } else if (is.logical(x)) {
    return(as.logical(x))
  } else {
    return(x)
  }
}

# Test the function
test_data <- c("1", "2", "3", "4", "5")
converted <- smart_convert(test_data)
cat("Original:", test_data, "\n")
cat("Converted:", converted, "\n")
cat("Type:", class(converted), "\n")

# Solution 6:
text_analyzer <- function(sentence) {
  # Count characters
  char_count <- nchar(sentence)
  
  # Count words
  words <- strsplit(sentence, " ")[[1]]
  word_count <- length(words)
  
  # Count vowels
  vowels <- c("a", "e", "i", "o", "u", "A", "E", "I", "O", "U")
  vowel_count <- sum(grepl(paste(vowels, collapse = "|"), strsplit(sentence, "")[[1]]))
  
  # Return summary
  return(list(
    characters = char_count,
    words = word_count,
    vowels = vowel_count,
    sentence = sentence
  ))
}

# Test the function
result <- text_analyzer("Hello World! This is a test sentence.")
cat("Text Analysis:\n")
cat("Characters:", result$characters, "\n")
cat("Words:", result$words, "\n")
cat("Vowels:", result$vowels, "\n")

# Solution 7:
same_elements <- function(vec1, vec2) {
  # Handle different lengths
  if (length(vec1) != length(vec2)) {
    return(FALSE)
  }
  
  # Sort and compare
  return(all(sort(vec1) == sort(vec2)))
}

# Test the function
vec1 <- c(1, 2, 3, 4, 5)
vec2 <- c(5, 4, 3, 2, 1)
vec3 <- c(1, 2, 3, 4, 6)

cat("Same elements test:\n")
cat("vec1 and vec2:", same_elements(vec1, vec2), "\n")
cat("vec1 and vec3:", same_elements(vec1, vec3), "\n")

# Solution 8:
data_validator <- function(data) {
  report <- list()
  
  # Check data type
  report$data_type <- class(data)
  
  # Check for missing values
  report$missing_count <- sum(is.na(data))
  report$missing_percentage <- (report$missing_count / length(data)) * 100
  
  # Check for outliers (if numeric)
  if (is.numeric(data)) {
    Q1 <- quantile(data, 0.25, na.rm = TRUE)
    Q3 <- quantile(data, 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    
    outliers <- data < lower_bound | data > upper_bound
    report$outlier_count <- sum(outliers, na.rm = TRUE)
  }
  
  # Check data consistency
  report$unique_values <- length(unique(data))
  report$total_values <- length(data)
  
  return(report)
}

# Test the function
test_vector <- c(1, 2, 3, NA, 5, 100, 7, 8, 9, 10)
validation_report <- data_validator(test_vector)
cat("Data Validation Report:\n")
print(validation_report)

# =============================================================================
# REAL-WORLD APPLICATIONS
# =============================================================================

# Data Type Applications:
# - Numeric: Financial calculations, measurements, scores
# - Character: Names, addresses, descriptions
# - Logical: Flags, conditions, binary decisions
# - Factor: Categories, groups, classifications
# - Date: Timestamps, schedules, time series

# Example: Employee database
employee_data <- data.frame(
  name = c("John Doe", "Jane Smith", "Bob Johnson"),
  age = c(25, 30, 35),
  salary = c(50000, 60000, 70000),
  department = factor(c("IT", "HR", "IT")),
  is_manager = c(FALSE, TRUE, FALSE),
  hire_date = as.Date(c("2020-01-15", "2019-03-22", "2021-06-10"))
)

# Data type analysis
cat("Employee Data Types:\n")
sapply(employee_data, class)

# Data validation
cat("\nData Validation:\n")
for (col in names(employee_data)) {
  cat(col, ":", class(employee_data[[col]]), "\n")
  if (is.numeric(employee_data[[col]])) {
    cat("  Range:", range(employee_data[[col]], na.rm = TRUE), "\n")
  }
  if (is.character(employee_data[[col]])) {
    cat("  Length:", nchar(employee_data[[col]]), "\n")
  }
}

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use <- for variable assignment (preferred over =)
# 2. R has 6 basic data types: numeric, integer, character, logical, complex, raw
# 3. Use class() and typeof() to check data types
# 4. Use as.*() functions to convert between types
# 5. Special values: NA (missing), NULL (empty), NaN (not a number), Inf (infinity)
# 6. Logical operators: & (AND), | (OR), ! (NOT)
# 7. Comparison operators: >, <, >=, <=, ==, !=
# 8. Always validate data types before operations
# 9. Use appropriate data types for better performance
# 10. Handle missing values appropriately

# Next: Move to 03_Vectors_Matrices.R to learn about vectors and matrices!
