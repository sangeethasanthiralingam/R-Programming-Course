# Module 4: Lists and Apply Functions
# File: 16_Lists_Apply_Functions.R

# =============================================================================
# WORKING WITH LISTS AND APPLY FUNCTIONS IN R
# =============================================================================

# Lists are flexible data structures that can hold different types of data
# Apply functions provide efficient ways to apply operations across data

# =============================================================================
# 1. CREATING LISTS
# =============================================================================

# Basic list creation
basic_list <- list(1, "hello", TRUE, 3.14)
print(basic_list)

# Named list
named_list <- list(
  name = "Alice",
  age = 25,
  scores = c(85, 92, 78),
  is_student = TRUE
)
print(named_list)

# List with different data types
mixed_list <- list(
  numbers = c(1, 2, 3, 4, 5),
  text = c("apple", "banana", "orange"),
  matrix = matrix(1:9, nrow = 3),
  data_frame = data.frame(x = 1:3, y = 4:6)
)
print(mixed_list)

# =============================================================================
# 2. ACCESSING LIST ELEMENTS
# =============================================================================

# Access by position
print(basic_list[[1]])  # First element
print(basic_list[[2]])  # Second element

# Access by name
print(named_list$name)
print(named_list$age)
print(named_list[["scores"]])

# Access multiple elements
print(named_list[c("name", "age")])

# =============================================================================
# 3. MODIFYING LISTS
# =============================================================================

# Add new elements
named_list$city <- "New York"
named_list$hobbies <- c("reading", "swimming", "cooking")
print(named_list)

# Modify existing elements
named_list$age <- 26
print(named_list$age)

# Remove elements
named_list$is_student <- NULL
print(named_list)

# =============================================================================
# 4. LIST FUNCTIONS
# =============================================================================

# Check list structure
str(named_list)

# Get list length
length(named_list)

# Get names
names(named_list)

# Check if element exists
"name" %in% names(named_list)
"salary" %in% names(named_list)

# =============================================================================
# 5. APPLY FUNCTIONS FAMILY
# =============================================================================

# Create sample data
matrix_data <- matrix(1:12, nrow = 3, ncol = 4)
print(matrix_data)

# apply() - apply function to margins of array
row_sums <- apply(matrix_data, 1, sum)  # Sum by rows
col_sums <- apply(matrix_data, 2, sum)  # Sum by columns
row_means <- apply(matrix_data, 1, mean)  # Mean by rows
col_means <- apply(matrix_data, 2, mean)  # Mean by columns

print("Row sums:", row_sums)
print("Column sums:", col_sums)
print("Row means:", row_means)
print("Column means:", col_means)

# =============================================================================
# 6. LAPPLY FUNCTION
# =============================================================================

# Create list of vectors
list_of_vectors <- list(
  a = c(1, 2, 3, 4, 5),
  b = c(10, 20, 30, 40, 50),
  c = c(100, 200, 300, 400, 500)
)

# Apply function to each element
sums <- lapply(list_of_vectors, sum)
means <- lapply(list_of_vectors, mean)
lengths <- lapply(list_of_vectors, length)

print("Sums:", sums)
print("Means:", means)
print("Lengths:", lengths)

# =============================================================================
# 7. SAPPLY FUNCTION
# =============================================================================

# sapply returns simplified output
sums_simple <- sapply(list_of_vectors, sum)
means_simple <- sapply(list_of_vectors, mean)

print("Sums (simplified):", sums_simple)
print("Means (simplified):", means_simple)

# =============================================================================
# 8. VAPPLY FUNCTION
# =============================================================================

# vapply specifies output type
sums_vector <- vapply(list_of_vectors, sum, FUN.VALUE = numeric(1))
means_vector <- vapply(list_of_vectors, mean, FUN.VALUE = numeric(1))

print("Sums (vector):", sums_vector)
print("Means (vector):", means_vector)

# =============================================================================
# 9. MAPPLY FUNCTION
# =============================================================================

# mapply applies function to multiple arguments
numbers1 <- c(1, 2, 3, 4, 5)
numbers2 <- c(10, 20, 30, 40, 50)

# Add corresponding elements
sums_mapply <- mapply(sum, numbers1, numbers2)
print("Sums (mapply):", sums_mapply)

# Custom function with mapply
multiply_add <- function(x, y, z) {
  return(x * y + z)
}

result <- mapply(multiply_add, c(1, 2, 3), c(4, 5, 6), c(7, 8, 9))
print("Multiply and add:", result)

# =============================================================================
# 10. TAPPLY FUNCTION
# =============================================================================

# Create sample data frame
tapply_data <- data.frame(
  group = c("A", "A", "B", "B", "C", "C"),
  value = c(10, 15, 20, 25, 30, 35)
)

# Apply function by group
group_sums <- tapply(tapply_data$value, tapply_data$group, sum)
group_means <- tapply(tapply_data$value, tapply_data$group, mean)
group_counts <- tapply(tapply_data$value, tapply_data$group, length)

print("Group sums:", group_sums)
print("Group means:", group_means)
print("Group counts:", group_counts)

# =============================================================================
# 11. PRACTICAL EXAMPLES
# =============================================================================

# Example 1: Processing multiple datasets
datasets <- list(
  dataset1 = data.frame(x = 1:5, y = 6:10),
  dataset2 = data.frame(x = 11:15, y = 16:20),
  dataset3 = data.frame(x = 21:25, y = 26:30)
)

# Calculate summary statistics for each dataset
summaries <- lapply(datasets, function(df) {
  list(
    nrow = nrow(df),
    ncol = ncol(df),
    mean_x = mean(df$x),
    mean_y = mean(df$y)
  )
})

print("Dataset summaries:")
print(summaries)

# Example 2: Custom function with apply
calculate_stats <- function(x) {
  return(c(
    mean = mean(x),
    median = median(x),
    sd = sd(x),
    min = min(x),
    max = max(x)
  ))
}

# Apply to matrix rows
matrix_stats <- apply(matrix_data, 1, calculate_stats)
print("Matrix row statistics:")
print(matrix_stats)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a list containing information about 3 people
# (name, age, city) and access their information

# Exercise 2: Use lapply to calculate the mean of each vector
# in a list of numeric vectors

# Exercise 3: Use tapply to calculate the sum of values
# grouped by category

# Exercise 4: Create a function that takes a list of data frames
# and returns the number of rows in each

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
people_list <- list(
  person1 = list(name = "Alice", age = 25, city = "New York"),
  person2 = list(name = "Bob", age = 30, city = "London"),
  person3 = list(name = "Charlie", age = 35, city = "Paris")
)

print("Person 1 name:", people_list$person1$name)
print("Person 2 age:", people_list$person2$age)
print("Person 3 city:", people_list$person3$city)

# Solution 2:
numeric_vectors <- list(
  vec1 = c(1, 2, 3, 4, 5),
  vec2 = c(10, 20, 30, 40, 50),
  vec3 = c(100, 200, 300, 400, 500)
)

means <- lapply(numeric_vectors, mean)
print("Means:", means)

# Solution 3:
exercise_data <- data.frame(
  category = c("A", "A", "B", "B", "C", "C"),
  value = c(5, 10, 15, 20, 25, 30)
)

category_sums <- tapply(exercise_data$value, exercise_data$category, sum)
print("Category sums:", category_sums)

# Solution 4:
count_rows <- function(df) {
  return(nrow(df))
}

data_frames <- list(
  df1 = data.frame(x = 1:3, y = 4:6),
  df2 = data.frame(x = 1:5, y = 6:10),
  df3 = data.frame(x = 1:2, y = 3:4)
)

row_counts <- lapply(data_frames, count_rows)
print("Row counts:", row_counts)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Lists can hold different data types
# 2. Use $ or [[]] to access list elements
# 3. apply() works on arrays (matrices, arrays)
# 4. lapply() applies function to list elements
# 5. sapply() simplifies output when possible
# 6. vapply() specifies output type
# 7. mapply() applies function to multiple arguments
# 8. tapply() applies function by group
# 9. Apply functions are often faster than loops
# 10. Use appropriate apply function for your data structure

# Next: Move to 17_String_Manipulation.R to learn about working with text!
