# Module 4: Control Structures
# File: 15_Control_Structures.R

# =============================================================================
# CONTROL STRUCTURES IN R
# =============================================================================

# Control structures allow you to control the flow of your program
# This lesson covers if-else statements, loops, and other control structures

# =============================================================================
# 1. CREATING SAMPLE DATA
# =============================================================================

# Create sample data for examples
set.seed(123)

# Sample vectors
numbers <- c(1, 5, 8, 12, 15, 20, 25, 30)
scores <- c(85, 92, 78, 96, 88, 91, 82, 95)
names <- c("Alice", "Bob", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry")

# Sample data frame
student_data <- data.frame(
  name = names,
  score = scores,
  grade = c("A", "A", "C", "A", "B", "A", "B", "A")
)

print(student_data)

# =============================================================================
# 2. IF-ELSE STATEMENTS
# =============================================================================

# Basic if statement
x <- 10
if (x > 5) {
  print("x is greater than 5")
}

# If-else statement
y <- 3
if (y > 5) {
  print("y is greater than 5")
} else {
  print("y is not greater than 5")
}

# If-else-if statement
z <- 7
if (z < 5) {
  print("z is less than 5")
} else if (z < 10) {
  print("z is between 5 and 10")
} else {
  print("z is 10 or greater")
}

# =============================================================================
# 3. VECTORIZED IF-ELSE
# =============================================================================

# Using ifelse() for vectorized operations
scores <- c(85, 92, 78, 96, 88, 91, 82, 95)
pass_fail <- ifelse(scores >= 80, "Pass", "Fail")
print(pass_fail)

# Multiple conditions with ifelse()
grade_letters <- ifelse(scores >= 90, "A",
                      ifelse(scores >= 80, "B",
                            ifelse(scores >= 70, "C", "F")))
print(grade_letters)

# =============================================================================
# 4. FOR LOOPS
# =============================================================================

# Basic for loop
for (i in 1:5) {
  print(paste("Iteration", i))
}

# For loop with vector
for (name in names) {
  print(paste("Hello,", name))
}

# For loop with data frame
for (i in 1:nrow(student_data)) {
  print(paste(student_data$name[i], "scored", student_data$score[i]))
}

# =============================================================================
# 5. WHILE LOOPS
# =============================================================================

# Basic while loop
counter <- 1
while (counter <= 5) {
  print(paste("Counter:", counter))
  counter <- counter + 1
}

# While loop with condition
number <- 1
while (number < 100) {
  print(number)
  number <- number * 2
}

# =============================================================================
# 6. REPEAT LOOPS
# =============================================================================

# Basic repeat loop with break
counter <- 1
repeat {
  print(paste("Repeat:", counter))
  counter <- counter + 1
  if (counter > 3) {
    break
  }
}

# Repeat loop with next
counter <- 1
repeat {
  if (counter %% 2 == 0) {
    counter <- counter + 1
    next
  }
  print(paste("Odd number:", counter))
  counter <- counter + 1
  if (counter > 10) {
    break
  }
}

# =============================================================================
# 7. NESTED LOOPS
# =============================================================================

# Nested for loops
for (i in 1:3) {
  for (j in 1:3) {
    print(paste("i =", i, ", j =", j))
  }
}

# Nested loops with data
for (i in 1:nrow(student_data)) {
  for (j in 1:ncol(student_data)) {
    print(paste("Row", i, "Column", j, ":", student_data[i, j]))
  }
}

# =============================================================================
# 8. BREAK AND NEXT STATEMENTS
# =============================================================================

# Using break to exit loop early
for (i in 1:10) {
  if (i == 5) {
    break
  }
  print(i)
}

# Using next to skip iteration
for (i in 1:10) {
  if (i %% 2 == 0) {
    next
  }
  print(i)
}

# =============================================================================
# 9. SWITCH STATEMENTS
# =============================================================================

# Basic switch statement
day <- "Monday"
day_type <- switch(day,
                  "Monday" = "Weekday",
                  "Tuesday" = "Weekday",
                  "Wednesday" = "Weekday",
                  "Thursday" = "Weekday",
                  "Friday" = "Weekday",
                  "Saturday" = "Weekend",
                  "Sunday" = "Weekend",
                  "Unknown")
print(day_type)

# Switch with numeric input
month <- 3
month_name <- switch(month,
                     "January", "February", "March", "April",
                     "May", "June", "July", "August",
                     "September", "October", "November", "December")
print(month_name)

# =============================================================================
# 10. PRACTICAL EXAMPLES
# =============================================================================

# Example 1: Grade classification
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
for (score in scores) {
  grade <- classify_grade(score)
  print(paste("Score:", score, "Grade:", grade))
}

# Example 2: Finding prime numbers
is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n <= 3) return(TRUE)
  if (n %% 2 == 0 || n %% 3 == 0) return(FALSE)
  
  i <- 5
  while (i * i <= n) {
    if (n %% i == 0 || n %% (i + 2) == 0) {
      return(FALSE)
    }
    i <- i + 6
  }
  return(TRUE)
}

# Find prime numbers between 1 and 20
primes <- c()
for (i in 1:20) {
  if (is_prime(i)) {
    primes <- c(primes, i)
  }
}
print(paste("Prime numbers between 1 and 20:", paste(primes, collapse = ", ")))

# =============================================================================
# 11. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a function that takes a number and returns
# "Even" or "Odd" using if-else

# Exercise 2: Use a for loop to calculate the sum of numbers
# from 1 to 100

# Exercise 3: Create a while loop that finds the first number
# greater than 1000 that is divisible by 7

# Exercise 4: Use nested loops to create a multiplication table
# for numbers 1 to 5

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
even_odd <- function(number) {
  if (number %% 2 == 0) {
    return("Even")
  } else {
    return("Odd")
  }
}

# Test the function
for (i in 1:10) {
  result <- even_odd(i)
  print(paste(i, "is", result))
}

# Solution 2:
sum_result <- 0
for (i in 1:100) {
  sum_result <- sum_result + i
}
print(paste("Sum of numbers 1 to 100:", sum_result))

# Solution 3:
number <- 1000
while (TRUE) {
  number <- number + 1
  if (number %% 7 == 0) {
    break
  }
}
print(paste("First number > 1000 divisible by 7:", number))

# Solution 4:
for (i in 1:5) {
  for (j in 1:5) {
    result <- i * j
    print(paste(i, "x", j, "=", result))
  }
}

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use if-else for conditional execution
# 2. Use ifelse() for vectorized conditional operations
# 3. Use for loops when you know the number of iterations
# 4. Use while loops when you don't know the number of iterations
# 5. Use repeat loops with break for infinite loops
# 6. Use break to exit loops early
# 7. Use next to skip iterations
# 8. Use switch for multiple condition checking
# 9. Be careful with nested loops - they can be slow
# 10. Consider vectorized operations instead of loops when possible

# Next: Move to 16_Lists_Apply_Functions.R to learn about lists and apply functions!
