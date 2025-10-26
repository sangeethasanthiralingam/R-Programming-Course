# Module 1: R Introduction and Getting Started
# File: 01_R_Introduction.R

# =============================================================================
# WELCOME TO R PROGRAMMING!
# =============================================================================

# R is a powerful programming language for statistical computing and graphics
# This file will teach you the absolute basics of R

# =============================================================================
# 1. UNDERSTANDING R AND RSTUDIO
# =============================================================================

# R is the programming language
# RStudio is the IDE (Integrated Development Environment) that makes R easier to use

# In RStudio, you'll see 4 panels:
# - Source (top-left): Where you write your code
# - Console (bottom-left): Where R executes commands and shows results
# - Environment (top-right): Shows your variables and data
# - Files/Plots/Help (bottom-right): File browser, plots, and help

# =============================================================================
# 2. YOUR FIRST R COMMANDS
# =============================================================================

# Let's start with the classic "Hello World"
print("Hello, World!")

# You can also just type text without print()
"Hello, R!"

# =============================================================================
# 3. BASIC CALCULATIONS
# =============================================================================

# R can be used as a calculator
2 + 3
10 - 4
6 * 7
15 / 3
2^3  # Exponentiation (2 to the power of 3)

# More complex calculations
(2 + 3) * 4
sqrt(16)  # Square root
abs(-5)   # Absolute value

# =============================================================================
# 4. WORKING WITH VARIABLES
# =============================================================================

# Assign values to variables using <- or =
x <- 10
y = 20

# Use variables in calculations
x + y
x * y

# Variables can store different types of data
name <- "Alice"
age <- 25
is_student <- TRUE

# =============================================================================
# 5. GETTING HELP IN R
# =============================================================================

# To get help on any function, use ? or help()
?print
help(mean)

# To search for help, use ??
??plotting

# =============================================================================
# 6. WORKING DIRECTORY
# =============================================================================

# Check your current working directory
getwd()

# Set a new working directory (change this to your folder path)
# setwd("D:/BIT/2nd semi/practice")

# List files in your working directory
list.files()

# =============================================================================
# 7. BASIC DATA TYPES IN R
# =============================================================================

# Numeric (numbers)
num_var <- 42
class(num_var)

# Character (text)
char_var <- "Hello"
class(char_var)

# Logical (TRUE/FALSE)
logical_var <- TRUE
class(logical_var)

# =============================================================================
# 8. CREATING VECTORS (BASIC)
# =============================================================================

# Create a vector of numbers
numbers <- c(1, 2, 3, 4, 5)
numbers

# Create a vector of text
fruits <- c("apple", "banana", "orange")
fruits

# Create a vector of logical values
flags <- c(TRUE, FALSE, TRUE)
flags

# =============================================================================
# 9. BASIC VECTOR OPERATIONS
# =============================================================================

# Add two vectors
vec1 <- c(1, 2, 3)
vec2 <- c(4, 5, 6)
vec1 + vec2

# Multiply by a scalar
vec1 * 2

# Get the length of a vector
length(vec1)

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create variables for your name, age, and favorite number
# Then print them

# Exercise 2: Calculate the area of a circle with radius 5
# Formula: area = π * r^2

# Exercise 3: Create a vector of your top 5 favorite movies
# Then print the length of this vector

# Exercise 4: Create two vectors of numbers and add them together

# =============================================================================
# SOLUTIONS (Try exercises first, then check here!)
# =============================================================================

# Solution 1:
my_name <- "Your Name"
my_age <- 25
favorite_number <- 7
print(my_name)
print(my_age)
print(favorite_number)

# Solution 2:
radius <- 5
area <- pi * radius^2
print(area)

# Solution 3:
favorite_movies <- c("Movie 1", "Movie 2", "Movie 3", "Movie 4", "Movie 5")
length(favorite_movies)

# Solution 4:
vector_a <- c(10, 20, 30)
vector_b <- c(5, 15, 25)
result <- vector_a + vector_b
print(result)

# =============================================================================
# GLOSSARY AND DEFINITIONS
# =============================================================================

# R: A programming language and environment for statistical computing and graphics
# RStudio: An integrated development environment (IDE) for R
# Console: The area where R commands are executed and results are displayed
# Variable: A named storage location that holds data
# Assignment: The process of storing a value in a variable using <- or =
# Vector: A collection of data elements of the same type
# Data Type: The classification of data (numeric, character, logical, etc.)
# Function: A reusable block of code that performs a specific task
# Argument: Input values passed to a function
# Working Directory: The folder where R looks for files and saves output
# Package: A collection of R functions, data, and documentation
# Library: A collection of packages loaded into R's memory

# =============================================================================
# COMMON R OPERATORS
# =============================================================================

# Arithmetic Operators:
# + (addition), - (subtraction), * (multiplication), / (division)
# ^ or ** (exponentiation), %% (modulo), %/% (integer division)

# Comparison Operators:
# == (equal to), != (not equal to), < (less than), > (greater than)
# <= (less than or equal), >= (greater than or equal)

# Logical Operators:
# & (AND), | (OR), ! (NOT), && (short-circuit AND), || (short-circuit OR)

# Assignment Operators:
# <- (preferred), = (alternative), -> (right to left)

# =============================================================================
# ESSENTIAL R FUNCTIONS FOR BEGINNERS
# =============================================================================

# Mathematical Functions:
# sqrt(x) - square root
# abs(x) - absolute value
# round(x, digits) - round to specified decimal places
# ceiling(x) - round up to next integer
# floor(x) - round down to previous integer
# log(x) - natural logarithm
# log10(x) - base-10 logarithm
# exp(x) - exponential function
# sin(x), cos(x), tan(x) - trigonometric functions

# Statistical Functions:
# mean(x) - average
# median(x) - middle value
# sd(x) - standard deviation
# var(x) - variance
# min(x) - minimum value
# max(x) - maximum value
# sum(x) - sum of all values
# length(x) - number of elements

# Data Manipulation Functions:
# c() - combine values into a vector
# seq() - create sequences
# rep() - repeat values
# sort() - sort values
# unique() - remove duplicates
# which() - find positions of TRUE values

# =============================================================================
# TROUBLESHOOTING COMMON ERRORS
# =============================================================================

# Error: "object 'x' not found"
# Solution: Make sure the variable is defined before using it
# Example: x <- 5 (define first)

# Error: "unexpected symbol"
# Solution: Check for missing commas, parentheses, or quotes
# Example: c(1, 2, 3) not c(1 2 3)

# Error: "non-numeric argument to binary operator"
# Solution: Make sure you're using numeric values for math operations
# Example: Use as.numeric() to convert text to numbers

# Error: "replacement has length zero"
# Solution: Check if your vector is empty before assigning values
# Example: Use length() to check vector size

# =============================================================================
# CODING BEST PRACTICES
# =============================================================================

# 1. Use meaningful variable names
# Good: student_age, test_score
# Bad: x, y, temp

# 2. Use <- for assignment (not =)
# Good: x <- 5
# Bad: x = 5

# 3. Add comments to explain your code
# Good: # Calculate the average score
# Bad: # math stuff

# 4. Use consistent indentation
# Good: if (condition) {
#         do_something()
#       }
# Bad: if (condition) {
# do_something()
# }

# 5. Test your code frequently
# Run small pieces to make sure they work

# =============================================================================
# ADDITIONAL PRACTICE EXERCISES
# =============================================================================

# Exercise 5: Create variables for a student's information:
# - Name (character)
# - Age (numeric)
# - GPA (numeric)
# - Is enrolled (logical)
# Then print a summary of the student

# Exercise 6: Calculate the area and perimeter of a rectangle
# with length 8 and width 5

# Exercise 7: Create a vector of your favorite numbers (at least 5)
# Then calculate the mean, median, and sum

# Exercise 8: Use the help system to learn about the sum() function
# Then use it to add numbers from 1 to 10

# =============================================================================
# SOLUTIONS TO ADDITIONAL EXERCISES
# =============================================================================

# Solution 5:
student_name <- "Alex Johnson"
student_age <- 20
student_gpa <- 3.7
is_enrolled <- TRUE

cat("Student Summary:\n")
cat("Name:", student_name, "\n")
cat("Age:", student_age, "\n")
cat("GPA:", student_gpa, "\n")
cat("Enrolled:", is_enrolled, "\n")

# Solution 6:
length <- 8
width <- 5
area <- length * width
perimeter <- 2 * (length + width)
cat("Rectangle with length", length, "and width", width, "\n")
cat("Area:", area, "\n")
cat("Perimeter:", perimeter, "\n")

# Solution 7:
favorite_numbers <- c(7, 14, 21, 28, 35)
cat("Favorite numbers:", favorite_numbers, "\n")
cat("Mean:", mean(favorite_numbers), "\n")
cat("Median:", median(favorite_numbers), "\n")
cat("Sum:", sum(favorite_numbers), "\n")

# Solution 8:
# ?sum  # This opens help for sum function
numbers_1_to_10 <- 1:10
total_sum <- sum(numbers_1_to_10)
cat("Sum of numbers 1 to 10:", total_sum, "\n")

# =============================================================================
# REAL-WORLD APPLICATIONS
# =============================================================================

# R is used in many fields:
# - Data Science: Analyzing large datasets
# - Finance: Risk modeling and portfolio management
# - Healthcare: Clinical trials and medical research
# - Marketing: Customer segmentation and A/B testing
# - Sports: Performance analytics
# - Education: Student performance analysis
# - Government: Policy analysis and reporting

# Example: Simple grade calculator
test_scores <- c(85, 92, 78, 96, 88)
average_score <- mean(test_scores)
cat("Test scores:", test_scores, "\n")
cat("Average score:", round(average_score, 2), "\n")

if (average_score >= 90) {
  cat("Grade: A\n")
} else if (average_score >= 80) {
  cat("Grade: B\n")
} else if (average_score >= 70) {
  cat("Grade: C\n")
} else {
  cat("Grade: F\n")
}

# =============================================================================
# CONGRATULATIONS!
# =============================================================================

# You've completed your first R lesson!
# Key takeaways:
# 1. R can be used as a calculator
# 2. Variables store data using <- or =
# 3. Vectors are collections of data
# 4. R has different data types (numeric, character, logical)
# 5. Use ? to get help on functions
# 6. Always use meaningful variable names
# 7. Test your code frequently
# 8. R is used in many real-world applications

# Next: Move to 02_Variables_DataTypes.R for more detailed learning!
