# Module 7: Advanced R Programming Concepts
# File: 26_Advanced_R_Programming.R

# =============================================================================
# ADVANCED R PROGRAMMING CONCEPTS
# =============================================================================

# This lesson covers advanced R programming concepts including
# object-oriented programming, functional programming, and performance optimization

# =============================================================================
# 1. OBJECT-ORIENTED PROGRAMMING IN R
# =============================================================================

# R has multiple OOP systems: S3, S4, R6, and RC

# S3 Classes (most common)
# Create S3 class
person <- function(name, age, salary) {
  structure(list(name = name, age = age, salary = salary), class = "person")
}

# S3 method
print.person <- function(x, ...) {
  cat("Person:", x$name, "\n")
  cat("Age:", x$age, "\n")
  cat("Salary:", x$salary, "\n")
}

# Create and use S3 object
p1 <- person("John Doe", 30, 50000)
print(p1)

# S4 Classes (more formal)
setClass("Employee",
         slots = list(
           name = "character",
           age = "numeric",
           salary = "numeric",
           department = "character"
         ))

# S4 constructor
setMethod("initialize", "Employee",
          function(.Object, name, age, salary, department) {
            .Object@name <- name
            .Object@age <- age
            .Object@salary <- salary
            .Object@department <- department
            .Object
          })

# Create S4 object
emp1 <- new("Employee", name = "Jane Smith", age = 25, salary = 60000, department = "IT")
print(emp1)

# =============================================================================
# 2. FUNCTIONAL PROGRAMMING CONCEPTS
# =============================================================================

# Higher-order functions
# Functions that take functions as arguments or return functions

# Function that returns a function
create_multiplier <- function(factor) {
  function(x) x * factor
}

# Create specific multipliers
double <- create_multiplier(2)
triple <- create_multiplier(3)

# Use the functions
cat("Double 5:", double(5), "\n")
cat("Triple 5:", triple(5), "\n")

# Function that takes a function as argument
apply_function <- function(data, func) {
  func(data)
}

# Use with different functions
numbers <- 1:10
cat("Sum:", apply_function(numbers, sum), "\n")
cat("Mean:", apply_function(numbers, mean), "\n")
cat("Max:", apply_function(numbers, max), "\n")

# =============================================================================
# 3. CLOSURES AND LEXICAL SCOPING
# =============================================================================

# Closure example
create_counter <- function() {
  count <- 0
  function() {
    count <<- count + 1
    count
  }
}

# Create counter instances
counter1 <- create_counter()
counter2 <- create_counter()

# Use counters
cat("Counter1:", counter1(), "\n")  # 1
cat("Counter1:", counter1(), "\n")  # 2
cat("Counter2:", counter2(), "\n")  # 1
cat("Counter1:", counter1(), "\n")  # 3

# =============================================================================
# 4. MEMOIZATION AND CACHING
# =============================================================================

# Simple memoization
memoize <- function(fun) {
  cache <- new.env()
  function(...) {
    key <- paste(..., collapse = ",")
    if (exists(key, cache)) {
      return(get(key, cache))
    }
    result <- fun(...)
    assign(key, result, cache)
    result
  }
}

# Fibonacci with memoization
fib <- function(n) {
  if (n <= 1) return(n)
  return(fib(n - 1) + fib(n - 2))
}

# Memoized version
fib_memo <- memoize(fib)

# Compare performance
system.time(fib(30))
system.time(fib_memo(30))

# =============================================================================
# 5. ERROR HANDLING AND DEBUGGING
# =============================================================================

# tryCatch for error handling
safe_divide <- function(x, y) {
  tryCatch({
    result <- x / y
    return(result)
  }, error = function(e) {
    cat("Error:", e$message, "\n")
    return(NA)
  }, warning = function(w) {
    cat("Warning:", w$message, "\n")
    return(x / y)
  })
}

# Test error handling
cat("Safe divide 10/2:", safe_divide(10, 2), "\n")
cat("Safe divide 10/0:", safe_divide(10, 0), "\n")

# stopifnot for input validation
validate_input <- function(x) {
  stopifnot(is.numeric(x), length(x) > 0, all(x >= 0))
  return(TRUE)
}

# Test validation
validate_input(c(1, 2, 3))
# validate_input(c(-1, 2, 3))  # This will stop with error

# =============================================================================
# 6. PERFORMANCE OPTIMIZATION
# =============================================================================

# Vectorization vs loops
# Slow loop version
slow_sum <- function(x) {
  total <- 0
  for (i in 1:length(x)) {
    total <- total + x[i]
  }
  return(total)
}

# Fast vectorized version
fast_sum <- function(x) {
  return(sum(x))
}

# Compare performance
large_vector <- rnorm(1000000)
system.time(slow_sum(large_vector))
system.time(fast_sum(large_vector))

# Pre-allocation
# Slow version (growing vector)
slow_grow <- function(n) {
  result <- c()
  for (i in 1:n) {
    result <- c(result, i^2)
  }
  return(result)
}

# Fast version (pre-allocated)
fast_grow <- function(n) {
  result <- numeric(n)
  for (i in 1:n) {
    result[i] <- i^2
  }
  return(result)
}

# Compare performance
system.time(slow_grow(10000))
system.time(fast_grow(10000))

# =============================================================================
# 7. PARALLEL COMPUTING
# =============================================================================

# parallel package for parallel computing
# install.packages("parallel")
library(parallel)

# Detect number of cores
num_cores <- detectCores()
cat("Number of cores:", num_cores, "\n")

# Simple parallel example
parallel_sum <- function(x) {
  # Split data
  chunks <- split(x, cut(seq_along(x), num_cores, labels = FALSE))
  
  # Process in parallel
  results <- mclapply(chunks, sum, mc.cores = num_cores)
  
  # Combine results
  return(sum(unlist(results)))
}

# Compare performance
large_data <- rnorm(1000000)
system.time(sum(large_data))
system.time(parallel_sum(large_data))

# =============================================================================
# 8. METAPROGRAMMING
# =============================================================================

# Non-standard evaluation
# Function that captures expressions
capture_expr <- function(expr) {
  substitute(expr)
}

# Use with expressions
expr1 <- capture_expr(x + y)
expr2 <- capture_expr(mean(data))

cat("Expression 1:", deparse(expr1), "\n")
cat("Expression 2:", deparse(expr2), "\n")

# Function that evaluates expressions
eval_expr <- function(expr, env = parent.frame()) {
  eval(substitute(expr), env)
}

# Use with data
data <- list(x = 1:5, y = 6:10)
result <- eval_expr(x + y, data)
cat("Result:", result, "\n")

# =============================================================================
# 9. ADVANCED DATA STRUCTURES
# =============================================================================

# Environments
# Create environment
my_env <- new.env()
my_env$var1 <- "Hello"
my_env$var2 <- 42

# Access environment variables
cat("var1:", my_env$var1, "\n")
cat("var2:", my_env$var2, "\n")

# Lists with attributes
# Create list with attributes
my_list <- list(a = 1, b = 2, c = 3)
attr(my_list, "description") <- "A sample list"
attr(my_list, "created") <- Sys.time()

# Access attributes
cat("Description:", attr(my_list, "description"), "\n")
cat("Created:", attr(my_list, "created"), "\n")

# =============================================================================
# 10. ADVANCED FUNCTIONAL PROGRAMMING
# =============================================================================

# Function composition
compose <- function(f, g) {
  function(...) f(g(...))
}

# Create composed function
add_one <- function(x) x + 1
multiply_two <- function(x) x * 2

# Compose functions
add_one_then_multiply <- compose(multiply_two, add_one)
cat("Compose result:", add_one_then_multiply(5), "\n")  # (5 + 1) * 2 = 12

# Partial application
partial <- function(f, ...) {
  args <- list(...)
  function(...more_args) {
    do.call(f, c(args, more_args))
  }
}

# Create partial function
multiply_by <- partial(`*`, 3)
cat("Partial result:", multiply_by(4), "\n")  # 3 * 4 = 12

# =============================================================================
# 11. ADVANCED DEBUGGING TECHNIQUES
# =============================================================================

# Debug function
debug_function <- function(x) {
  browser()  # Interactive debugging
  result <- x * 2
  return(result)
}

# Use debugger
# debug_function(5)  # Uncomment to use debugger

# Trace function calls
trace_sum <- function(x) {
  cat("Calling sum with:", length(x), "elements\n")
  result <- sum(x)
  cat("Result:", result, "\n")
  return(result)
}

# Use trace
trace_sum(1:10)

# =============================================================================
# 12. ADVANCED ERROR HANDLING
# =============================================================================

# Custom error classes
custom_error <- function(message) {
  structure(list(message = message), class = c("custom_error", "error"))
}

# Error handler
handle_custom_error <- function(e) {
  if (inherits(e, "custom_error")) {
    cat("Custom error:", e$message, "\n")
  } else {
    cat("Standard error:", e$message, "\n")
  }
}

# Test custom error
tryCatch({
  stop(custom_error("This is a custom error"))
}, error = handle_custom_error)

# =============================================================================
# 13. ADVANCED PERFORMANCE TECHNIQUES
# =============================================================================

# Rcpp for C++ integration
# install.packages("Rcpp")
library(Rcpp)

# Simple Rcpp function
cppFunction('
  double rcpp_sum(NumericVector x) {
    double total = 0;
    for (int i = 0; i < x.size(); i++) {
      total += x[i];
    }
    return total;
  }
')

# Compare performance
test_data <- rnorm(1000000)
system.time(sum(test_data))
system.time(rcpp_sum(test_data))

# =============================================================================
# 14. ADVANCED DATA MANIPULATION
# =============================================================================

# Advanced dplyr operations
# install.packages("dplyr")
library(dplyr)

# Create sample data
advanced_data <- data.frame(
  id = 1:100,
  group = rep(c("A", "B", "C"), length.out = 100),
  value = rnorm(100),
  date = seq(as.Date("2023-01-01"), by = "day", length.out = 100)
)

# Advanced operations
result <- advanced_data %>%
  group_by(group) %>%
  mutate(
    rank = rank(value),
    lag_value = lag(value),
    lead_value = lead(value),
    cumsum_value = cumsum(value)
  ) %>%
  filter(rank <= 5) %>%
  arrange(group, desc(value))

print("Advanced data manipulation result:")
print(head(result))

# =============================================================================
# 15. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create an S3 class for a "Student" with methods for
# calculating GPA and printing student information

# Exercise 2: Implement a memoized function for calculating
# the factorial of a number

# Exercise 3: Create a function that uses parallel processing
# to calculate the mean of multiple vectors

# Exercise 4: Implement error handling for a function that
# divides two numbers and handles division by zero

# =============================================================================
# SOLUTIONS TO EXERCISES
# =============================================================================

# Solution 1: S3 Student class
student <- function(name, grades) {
  structure(list(name = name, grades = grades), class = "student")
}

# Method to calculate GPA
gpa.student <- function(x) {
  mean(x$grades)
}

# Method to print student
print.student <- function(x, ...) {
  cat("Student:", x$name, "\n")
  cat("Grades:", paste(x$grades, collapse = ", "), "\n")
  cat("GPA:", round(gpa(x), 2), "\n")
}

# Create and use student
s1 <- student("Alice", c(85, 90, 88, 92))
print(s1)

# Solution 2: Memoized factorial
factorial_memo <- memoize(function(n) {
  if (n <= 1) return(1)
  return(n * factorial_memo(n - 1))
})

# Test memoized factorial
cat("Factorial of 10:", factorial_memo(10), "\n")

# Solution 3: Parallel mean calculation
parallel_mean <- function(vectors) {
  # Process in parallel
  means <- mclapply(vectors, mean, mc.cores = num_cores)
  return(unlist(means))
}

# Test parallel mean
test_vectors <- list(
  rnorm(1000000),
  rnorm(1000000),
  rnorm(1000000)
)

system.time(parallel_mean(test_vectors))

# Solution 4: Error handling for division
safe_divide <- function(x, y) {
  tryCatch({
    if (y == 0) {
      stop("Division by zero is not allowed")
    }
    return(x / y)
  }, error = function(e) {
    cat("Error:", e$message, "\n")
    return(NA)
  })
}

# Test safe division
cat("Safe divide 10/2:", safe_divide(10, 2), "\n")
cat("Safe divide 10/0:", safe_divide(10, 0), "\n")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. R supports multiple OOP systems (S3, S4, R6, RC)
# 2. Use closures for stateful functions
# 3. Memoization can significantly improve performance
# 4. Always handle errors gracefully
# 5. Vectorization is faster than loops
# 6. Pre-allocate vectors when possible
# 7. Use parallel processing for large computations
# 8. Metaprogramming allows for flexible code
# 9. Use appropriate data structures
# 10. Debugging tools help identify issues
# 11. Rcpp can improve performance for critical code
# 12. Advanced dplyr operations simplify data manipulation
# 13. Always test your code thoroughly
# 14. Document your advanced functions
# 15. Consider performance implications of your code

# Next: Continue exploring advanced R concepts!
