# Module 1: Functions
# File: 05_Functions.R

# =============================================================================
# CREATING AND USING FUNCTIONS IN R
# =============================================================================

# Functions are reusable blocks of code that perform specific tasks
# This lesson covers creating, using, and understanding functions in R

# =============================================================================
# 1. UNDERSTANDING FUNCTIONS
# =============================================================================

# Functions you've already used:
print("Hello")
mean(c(1, 2, 3, 4, 5))
sum(c(10, 20, 30))
sqrt(16)

# Functions have:
# - Name (e.g., mean, sum, sqrt)
# - Arguments/parameters (e.g., the data to work with)
# - Return value (what the function gives back)

# =============================================================================
# 2. CREATING YOUR FIRST FUNCTION
# =============================================================================

# Basic function structure:
# function_name <- function(parameters) {
#   # code to execute
#   return(result)
# }

# Simple function that adds two numbers
add_numbers <- function(x, y) {
  result <- x + y
  return(result)
}

# Use the function
add_numbers(5, 3)
add_numbers(10, 20)

# =============================================================================
# 3. FUNCTIONS WITHOUT RETURN STATEMENT
# =============================================================================

# If no return() is specified, the last expression is returned
multiply <- function(x, y) {
  x * y  # This is automatically returned
}

multiply(4, 5)

# Function that prints and returns
greet <- function(name) {
  message <- paste("Hello,", name)
  print(message)
  return(message)
}

greet("Alice")

# =============================================================================
# 4. FUNCTIONS WITH DEFAULT VALUES
# =============================================================================

# Function with default parameter values
calculate_area <- function(length, width = 1) {
  area <- length * width
  return(area)
}

# Use with both parameters
calculate_area(5, 3)

# Use with default width (square)
calculate_area(5)

# Function with multiple defaults
create_person <- function(name, age = 25, city = "Unknown") {
  person <- list(name = name, age = age, city = city)
  return(person)
}

create_person("John")
create_person("Jane", 30)
create_person("Bob", 35, "New York")

# =============================================================================
# 5. FUNCTIONS WITH MULTIPLE PARAMETERS
# =============================================================================

# Function to calculate statistics
calculate_stats <- function(data) {
  stats <- list(
    mean = mean(data),
    median = median(data),
    min = min(data),
    max = max(data),
    sd = sd(data)
  )
  return(stats)
}

# Test the function
test_data <- c(10, 15, 20, 25, 30)
result <- calculate_stats(test_data)
print(result)

# =============================================================================
# 6. FUNCTIONS WITH CONDITIONAL LOGIC
# =============================================================================

# Function to classify grades
classify_grade <- function(score) {
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 70) {
    return("C")
  } else if (score >= 60) {
    return("D")
  } else {
    return("F")
  }
}

# Test the function
classify_grade(95)
classify_grade(85)
classify_grade(75)
classify_grade(65)
classify_grade(55)

# =============================================================================
# 7. FUNCTIONS WITH LOOPS
# =============================================================================

# Function to find factorial
factorial_func <- function(n) {
  if (n <= 1) {
    return(1)
  } else {
    result <- 1
    for (i in 2:n) {
      result <- result * i
    }
    return(result)
  }
}

factorial_func(5)
factorial_func(3)

# Function to count even numbers
count_even <- function(numbers) {
  count <- 0
  for (num in numbers) {
    if (num %% 2 == 0) {
      count <- count + 1
    }
  }
  return(count)
}

count_even(c(1, 2, 3, 4, 5, 6))

# =============================================================================
# 8. FUNCTIONS THAT WORK WITH DATA FRAMES
# =============================================================================

# Function to summarize a data frame column
summarize_column <- function(data, column_name) {
  column_data <- data[[column_name]]
  summary <- list(
    mean = mean(column_data, na.rm = TRUE),
    median = median(column_data, na.rm = TRUE),
    min = min(column_data, na.rm = TRUE),
    max = max(column_data, na.rm = TRUE),
    count = length(column_data),
    missing = sum(is.na(column_data))
  )
  return(summary)
}

# Create sample data frame
sample_data <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  salary = c(50000, 60000, 70000)
)

# Use the function
summarize_column(sample_data, "age")
summarize_column(sample_data, "salary")

# =============================================================================
# 9. RECURSIVE FUNCTIONS
# =============================================================================

# Function that calls itself
fibonacci <- function(n) {
  if (n <= 1) {
    return(n)
  } else {
    return(fibonacci(n - 1) + fibonacci(n - 2))
  }
}

# Test fibonacci function
fibonacci(0)
fibonacci(1)
fibonacci(5)
fibonacci(10)

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a function called "is_even" that takes a number
# and returns TRUE if it's even, FALSE if it's odd

# Exercise 2: Create a function called "calculate_bmi" that takes
# weight (kg) and height (m) and returns the BMI

# Exercise 3: Create a function called "find_max" that takes a vector
# of numbers and returns the maximum value (don't use max() function)

# Exercise 4: Create a function called "count_words" that takes a
# sentence and returns the number of words

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
is_even <- function(number) {
  return(number %% 2 == 0)
}

is_even(4)
is_even(7)

# Solution 2:
calculate_bmi <- function(weight, height) {
  bmi <- weight / (height^2)
  return(bmi)
}

calculate_bmi(70, 1.75)

# Solution 3:
find_max <- function(numbers) {
  max_value <- numbers[1]
  for (num in numbers) {
    if (num > max_value) {
      max_value <- num
    }
  }
  return(max_value)
}

find_max(c(10, 5, 20, 15, 25))

# Solution 4:
count_words <- function(sentence) {
  words <- strsplit(sentence, " ")[[1]]
  return(length(words))
}

count_words("Hello world this is a test")

# =============================================================================
# GLOSSARY AND DEFINITIONS
# =============================================================================

# Function: A reusable block of code that performs a specific task
# Parameter: A variable in a function definition that receives a value
# Argument: A value passed to a function when it is called
# Return Value: The result that a function produces
# Default Parameter: A parameter with a predefined value
# Optional Parameter: A parameter that doesn't need to be specified
# Required Parameter: A parameter that must be provided
# Function Body: The code inside a function that executes
# Local Variable: A variable defined inside a function
# Global Variable: A variable defined outside any function
# Scope: The context where a variable is accessible
# Recursion: When a function calls itself
# Anonymous Function: A function without a name
# Closure: A function that captures variables from its environment
# Higher-order Function: A function that takes other functions as arguments
# Pure Function: A function with no side effects
# Side Effect: Any change to state outside the function

# =============================================================================
# FUNCTION TYPES
# =============================================================================

# Built-in Functions: Functions that come with R (e.g., mean, sum, length)
# User-defined Functions: Functions created by the user
# Anonymous Functions: Functions defined inline without a name
# Recursive Functions: Functions that call themselves
# Vectorized Functions: Functions that work on entire vectors at once
# Nested Functions: Functions defined inside other functions

# =============================================================================
# FUNCTION DESIGN PATTERNS
# =============================================================================

# Pure Functions: Return output based only on input, no side effects
# Helper Functions: Small functions that support larger functions
# Validation Functions: Check if input meets requirements
# Utility Functions: Perform common tasks
# Factory Functions: Create and return other functions
# Callback Functions: Functions passed as arguments to other functions

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Functions are reusable blocks of code
# 2. Use function() to create functions
# 3. Parameters can have default values
# 4. Functions can return values using return()
# 5. Functions can contain conditional logic and loops
# 6. Functions can work with any data type
# 7. Functions can call themselves (recursion)
# 8. Always test your functions with different inputs
# 9. Use meaningful function names
# 10. Document your functions with comments

# Next: Move to Module 2 - Data Analysis & Statistics!
# Start with 06_Data_Import_Export.R
