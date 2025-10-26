# Module 1: Vectors and Matrices
# File: 03_Vectors_Matrices.R

# =============================================================================
# WORKING WITH VECTORS AND MATRICES IN R
# =============================================================================

# Vectors are the basic building blocks of R
# Matrices are 2-dimensional arrays
# This lesson covers creating, manipulating, and working with both

# =============================================================================
# 1. CREATING VECTORS
# =============================================================================

# Using c() function (combine)
numbers <- c(1, 2, 3, 4, 5)
fruits <- c("apple", "banana", "orange")
flags <- c(TRUE, FALSE, TRUE)

# Using : operator for sequences
sequence1 <- 1:10
sequence2 <- 10:1
sequence3 <- -5:5

# Using seq() function for more control
seq1 <- seq(from = 1, to = 10, by = 1)
seq2 <- seq(from = 0, to = 1, by = 0.1)
seq3 <- seq(from = 1, to = 20, length.out = 5)

# Using rep() function for repetition
rep1 <- rep(5, times = 3)
rep2 <- rep(c(1, 2), times = 3)
rep3 <- rep(c(1, 2), each = 3)

# =============================================================================
# 2. VECTOR OPERATIONS
# =============================================================================

# Basic arithmetic operations
vec1 <- c(1, 2, 3, 4, 5)
vec2 <- c(6, 7, 8, 9, 10)

# Element-wise operations
vec1 + vec2
vec1 - vec2
vec1 * vec2
vec1 / vec2
vec1^2

# Operations with scalars
vec1 + 10
vec1 * 2
vec1 / 2

# =============================================================================
# 3. ACCESSING VECTOR ELEMENTS
# =============================================================================

# Create a sample vector
scores <- c(85, 92, 78, 96, 88)

# Access by position (indexing starts at 1)
scores[1]        # First element
scores[3]        # Third element
scores[c(1, 3)]  # First and third elements
scores[1:3]      # First three elements

# Access by condition
scores[scores > 90]  # Elements greater than 90
scores[scores == 85] # Elements equal to 85

# =============================================================================
# 4. VECTOR FUNCTIONS
# =============================================================================

# Basic statistics
data <- c(10, 15, 20, 25, 30, 35, 40)

length(data)     # Number of elements
sum(data)        # Sum of all elements
mean(data)       # Average
median(data)     # Median
min(data)        # Minimum value
max(data)        # Maximum value
range(data)      # Min and max
var(data)        # Variance
sd(data)         # Standard deviation

# Sorting
sorted_data <- sort(data)
reverse_sorted <- sort(data, decreasing = TRUE)

# =============================================================================
# 5. CREATING MATRICES
# =============================================================================

# Create matrix from vector
matrix1 <- matrix(1:12, nrow = 3, ncol = 4)
matrix2 <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)

# Create matrix with specific values
matrix3 <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)

# Create matrix with row and column names
matrix4 <- matrix(1:6, nrow = 2, ncol = 3)
rownames(matrix4) <- c("Row1", "Row2")
colnames(matrix4) <- c("Col1", "Col2", "Col3")

# =============================================================================
# 6. MATRIX OPERATIONS
# =============================================================================

# Create sample matrices
mat1 <- matrix(1:4, nrow = 2, ncol = 2)
mat2 <- matrix(5:8, nrow = 2, ncol = 2)

# Element-wise operations
mat1 + mat2
mat1 - mat2
mat1 * mat2  # Element-wise multiplication

# Matrix multiplication
mat1 %*% mat2

# Scalar operations
mat1 * 2
mat1 + 10

# =============================================================================
# 7. ACCESSING MATRIX ELEMENTS
# =============================================================================

# Create a sample matrix
grades <- matrix(c(85, 92, 78, 96, 88, 91), nrow = 2, ncol = 3)
rownames(grades) <- c("Student1", "Student2")
colnames(grades) <- c("Math", "Science", "English")

# Access by row and column
grades[1, 2]        # Row 1, Column 2
grades[1, ]         # All columns of row 1
grades[, 2]         # All rows of column 2
grades[1:2, 2:3]    # Submatrix

# Access by name
grades["Student1", "Math"]
grades["Student1", ]

# =============================================================================
# 8. MATRIX FUNCTIONS
# =============================================================================

# Basic matrix functions
dim(grades)         # Dimensions
nrow(grades)        # Number of rows
ncol(grades)        # Number of columns
t(grades)           # Transpose

# Matrix statistics
rowMeans(grades)    # Mean of each row
colMeans(grades)    # Mean of each column
rowSums(grades)     # Sum of each row
colSums(grades)     # Sum of each column

# =============================================================================
# 9. COMBINING VECTORS AND MATRICES
# =============================================================================

# Combine vectors into matrix
vec1 <- c(1, 2, 3)
vec2 <- c(4, 5, 6)
combined_matrix <- rbind(vec1, vec2)  # Row bind
combined_matrix2 <- cbind(vec1, vec2) # Column bind

# Combine matrices
mat1 <- matrix(1:4, nrow = 2)
mat2 <- matrix(5:8, nrow = 2)
combined <- cbind(mat1, mat2)

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a vector of numbers from 1 to 20
# Then find the mean, median, and standard deviation

# Exercise 2: Create a matrix with 3 rows and 4 columns
# Fill it with numbers from 1 to 12
# Add row names: "Group1", "Group2", "Group3"
# Add column names: "Q1", "Q2", "Q3", "Q4"

# Exercise 3: Create two vectors of the same length
# Perform all basic arithmetic operations on them

# Exercise 4: Create a matrix of test scores (3 students, 4 subjects)
# Calculate the average score for each student
# Calculate the average score for each subject

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
numbers <- 1:20
mean(numbers)
median(numbers)
sd(numbers)

# Solution 2:
my_matrix <- matrix(1:12, nrow = 3, ncol = 4)
rownames(my_matrix) <- c("Group1", "Group2", "Group3")
colnames(my_matrix) <- c("Q1", "Q2", "Q3", "Q4")
print(my_matrix)

# Solution 3:
vec_a <- c(10, 20, 30)
vec_b <- c(5, 15, 25)
vec_a + vec_b
vec_a - vec_b
vec_a * vec_b
vec_a / vec_b

# Solution 4:
scores <- matrix(c(85, 92, 78, 96, 88, 91, 82, 95), nrow = 2, ncol = 4)
rownames(scores) <- c("Student1", "Student2")
colnames(scores) <- c("Math", "Science", "English", "History")
rowMeans(scores)  # Average per student
colMeans(scores)  # Average per subject

# =============================================================================
# GLOSSARY AND DEFINITIONS
# =============================================================================

# Vector: A collection of data elements of the same type arranged in a sequence
# Matrix: A 2-dimensional array with rows and columns
# Array: A multi-dimensional data structure
# Element: Individual values within a vector or matrix
# Index: Position of an element (starts at 1 in R)
# Dimension: The size of a data structure (rows, columns, etc.)
# Subset: A portion of a vector or matrix selected by indices
# Recycling: R's automatic repetition of shorter vectors to match longer ones
# Vectorization: Performing operations on entire vectors at once
# Row: Horizontal arrangement of elements in a matrix
# Column: Vertical arrangement of elements in a matrix
# Transpose: Flipping rows and columns of a matrix
# Diagonal: Elements where row index equals column index

# =============================================================================
# VECTOR CREATION FUNCTIONS
# =============================================================================

# c() - combine values into a vector
# : - create sequences (e.g., 1:10)
# seq() - create sequences with more control
# rep() - repeat values
# vector() - create empty vector of specified type and length
# numeric() - create numeric vector
# character() - create character vector
# logical() - create logical vector
# sample() - random sampling
# runif() - uniform random numbers
# rnorm() - normal random numbers

# =============================================================================
# MATRIX CREATION FUNCTIONS
# =============================================================================

# matrix() - create matrix from vector
# rbind() - combine vectors as rows
# cbind() - combine vectors as columns
# diag() - create diagonal matrix
# array() - create multi-dimensional array
# dim() - get or set dimensions
# nrow() - number of rows
# ncol() - number of columns
# rownames() - get or set row names
# colnames() - get or set column names

# =============================================================================
# VECTOR OPERATIONS AND FUNCTIONS
# =============================================================================

# Arithmetic: +, -, *, /, ^, %%, %/%
# Comparison: ==, !=, <, >, <=, >=
# Logical: &, |, !
# Mathematical: sum(), mean(), median(), sd(), var(), min(), max()
# Sorting: sort(), order(), rank()
# Selection: which(), subset()
# Modification: append(), replace()
# Information: length(), is.na(), any(), all()

# =============================================================================
# MATRIX OPERATIONS AND FUNCTIONS
# =============================================================================

# Element-wise: +, -, *, /
# Matrix multiplication: %*%
# Transpose: t()
# Inverse: solve()
# Determinant: det()
# Eigenvalues: eigen()
# Row/column operations: rowMeans(), colMeans(), rowSums(), colSums()
# Matrix properties: is.matrix(), is.symmetric()

# =============================================================================
# TROUBLESHOOTING COMMON ERRORS
# =============================================================================

# Error: "longer object length is not a multiple of shorter object length"
# Solution: Check vector lengths or use rep() to match lengths
# Example: rep(1, length(vec2)) + vec2

# Error: "non-conformable arrays"
# Solution: Check matrix dimensions for operations
# Example: Ensure matrices have compatible dimensions

# Error: "subscript out of bounds"
# Solution: Check that indices are within valid range
# Example: Use length() to check vector size

# Error: "replacement has length zero"
# Solution: Ensure replacement values have correct length
# Example: Use rep() for repeated values

# =============================================================================
# PERFORMANCE OPTIMIZATION
# =============================================================================

# 1. Pre-allocate vectors and matrices when possible
# 2. Use vectorized operations instead of loops
# 3. Avoid unnecessary copying with <- vs <<-
# 4. Use appropriate data types
# 5. Consider using matrix operations for large datasets

# =============================================================================
# ADDITIONAL PRACTICE EXERCISES
# =============================================================================

# Exercise 5: Create a function that:
# - Takes a vector and a number
# - Returns the vector with the number added to each element
# - Handles different data types

# Exercise 6: Create a matrix multiplication function that:
# - Takes two matrices
# - Returns their product
# - Handles dimension errors gracefully

# Exercise 7: Create a vector analysis function that:
# - Takes a numeric vector
# - Returns statistics (mean, median, mode, range, outliers)
# - Handles missing values

# Exercise 8: Create a matrix manipulation function that:
# - Takes a matrix
# - Returns the matrix with row and column names
# - Adds summary statistics as additional rows/columns

# =============================================================================
# SOLUTIONS TO ADDITIONAL EXERCISES
# =============================================================================

# Solution 5:
add_to_vector <- function(vec, number) {
  if (is.numeric(vec) && is.numeric(number)) {
    return(vec + number)
  } else if (is.character(vec)) {
    return(paste(vec, number, sep = "_"))
  } else if (is.logical(vec)) {
    return(vec | (number != 0))
  } else {
    return(vec)
  }
}

# Test the function
numeric_vec <- c(1, 2, 3, 4, 5)
char_vec <- c("a", "b", "c")
logical_vec <- c(TRUE, FALSE, TRUE)

cat("Numeric vector + 5:", add_to_vector(numeric_vec, 5), "\n")
cat("Character vector + 5:", add_to_vector(char_vec, 5), "\n")
cat("Logical vector + 5:", add_to_vector(logical_vec, 5), "\n")

# Solution 6:
matrix_multiply <- function(mat1, mat2) {
  # Check if inputs are matrices
  if (!is.matrix(mat1) || !is.matrix(mat2)) {
    stop("Both inputs must be matrices")
  }
  
  # Check dimensions
  if (ncol(mat1) != nrow(mat2)) {
    stop("Number of columns in first matrix must equal number of rows in second matrix")
  }
  
  # Perform matrix multiplication
  return(mat1 %*% mat2)
}

# Test the function
mat1 <- matrix(1:6, nrow = 2, ncol = 3)
mat2 <- matrix(7:12, nrow = 3, ncol = 2)

result <- matrix_multiply(mat1, mat2)
cat("Matrix multiplication result:\n")
print(result)

# Solution 7:
vector_analyzer <- function(vec) {
  if (!is.numeric(vec)) {
    stop("Input must be a numeric vector")
  }
  
  # Remove missing values for analysis
  clean_vec <- vec[!is.na(vec)]
  
  if (length(clean_vec) == 0) {
    return(list(error = "No valid numeric values found"))
  }
  
  # Calculate statistics
  stats <- list(
    mean = mean(clean_vec),
    median = median(clean_vec),
    mode = get_mode(clean_vec),
    range = range(clean_vec),
    min = min(clean_vec),
    max = max(clean_vec),
    sd = sd(clean_vec),
    var = var(clean_vec),
    length = length(clean_vec),
    missing = sum(is.na(vec))
  )
  
  # Find outliers using IQR method
  Q1 <- quantile(clean_vec, 0.25)
  Q3 <- quantile(clean_vec, 0.75)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  
  outliers <- clean_vec[clean_vec < lower_bound | clean_vec > upper_bound]
  stats$outliers <- outliers
  stats$outlier_count <- length(outliers)
  
  return(stats)
}

# Helper function for mode
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Test the function
test_vector <- c(1, 2, 3, 4, 5, 100, 7, 8, 9, 10, NA)
analysis <- vector_analyzer(test_vector)
cat("Vector Analysis:\n")
print(analysis)

# Solution 8:
matrix_enhancer <- function(mat) {
  if (!is.matrix(mat)) {
    stop("Input must be a matrix")
  }
  
  # Add row names
  rownames(mat) <- paste("Row", 1:nrow(mat))
  
  # Add column names
  colnames(mat) <- paste("Col", 1:ncol(mat))
  
  # Add summary row
  summary_row <- c(
    mean(mat, na.rm = TRUE),
    median(mat, na.rm = TRUE),
    min(mat, na.rm = TRUE),
    max(mat, na.rm = TRUE)
  )
  
  # Add summary column
  summary_col <- c(
    rowMeans(mat, na.rm = TRUE),
    mean(mat, na.rm = TRUE)
  )
  
  # Create enhanced matrix
  enhanced_mat <- rbind(mat, summary_row)
  enhanced_mat <- cbind(enhanced_mat, summary_col)
  
  # Update names
  rownames(enhanced_mat)[nrow(enhanced_mat)] <- "Summary"
  colnames(enhanced_mat)[ncol(enhanced_mat)] <- "Summary"
  
  return(enhanced_mat)
}

# Test the function
test_matrix <- matrix(1:12, nrow = 3, ncol = 4)
enhanced <- matrix_enhancer(test_matrix)
cat("Enhanced Matrix:\n")
print(enhanced)

# =============================================================================
# REAL-WORLD APPLICATIONS
# =============================================================================

# Vector Applications:
# - Time series data (stock prices, temperature readings)
# - Survey responses (ratings, scores)
# - Measurements (heights, weights, distances)
# - Categorical data (names, categories, labels)

# Matrix Applications:
# - Data tables (spreadsheets, databases)
# - Image data (pixel values)
# - Correlation matrices
# - Distance matrices
# - Transition matrices

# Example: Student grade matrix
student_grades <- matrix(
  c(85, 92, 78, 96, 88, 91, 82, 95, 87, 89, 93, 84),
  nrow = 3, ncol = 4,
  dimnames = list(
    c("Student1", "Student2", "Student3"),
    c("Math", "Science", "English", "History")
  )
)

cat("Student Grades Matrix:\n")
print(student_grades)

# Calculate statistics
cat("\nSubject Averages:\n")
print(colMeans(student_grades))

cat("\nStudent Averages:\n")
print(rowMeans(student_grades))

# Find highest and lowest grades
cat("\nHighest Grade:", max(student_grades), "\n")
cat("Lowest Grade:", min(student_grades), "\n")

# Find students with average > 90
high_achievers <- which(rowMeans(student_grades) > 90)
cat("High Achievers (avg > 90):", rownames(student_grades)[high_achievers], "\n")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Vectors are created with c(), :, seq(), or rep()
# 2. Matrix operations are element-wise unless using %*%
# 3. Indexing starts at 1 (not 0 like some languages)
# 4. Use [] for accessing elements, [row, col] for matrices
# 5. Many functions work on vectors and matrices automatically
# 6. Use rbind() and cbind() to combine vectors/matrices
# 7. Always check dimensions before matrix operations
# 8. Use vectorized operations for better performance
# 9. Handle missing values appropriately
# 10. Use meaningful names for rows and columns

# Next: Move to 04_DataFrames.R to learn about data frames!
