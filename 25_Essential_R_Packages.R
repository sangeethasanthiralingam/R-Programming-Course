# Module 6: Essential R Packages
# File: 25_Essential_R_Packages.R

# =============================================================================
# ESSENTIAL R PACKAGES FOR DATA ANALYSIS
# =============================================================================

# This lesson covers the most important R packages for data analysis,
# visualization, and statistical computing

# =============================================================================
# 1. PACKAGE MANAGEMENT BASICS
# =============================================================================

# Installing packages
# install.packages("package_name")
# install.packages(c("package1", "package2", "package3"))

# Loading packages
# library(package_name)
# require(package_name)

# Checking if package is installed
# packageVersion("package_name")
# installed.packages()

# Updating packages
# update.packages()

# =============================================================================
# 2. DATA MANIPULATION PACKAGES
# =============================================================================

# dplyr - Data manipulation
# install.packages("dplyr")
library(dplyr)

# Create sample data
set.seed(123)
sample_data <- data.frame(
  id = 1:100,
  name = paste("Person", 1:100),
  age = sample(18:65, 100, replace = TRUE),
  salary = rnorm(100, mean = 50000, sd = 15000),
  department = sample(c("IT", "HR", "Finance", "Marketing"), 100, replace = TRUE),
  experience = sample(0:20, 100, replace = TRUE)
)

# dplyr operations
# Filter rows
it_employees <- sample_data %>% filter(department == "IT")

# Select columns
selected_data <- sample_data %>% select(name, age, salary)

# Arrange (sort) data
sorted_data <- sample_data %>% arrange(desc(salary))

# Mutate (create new columns)
enhanced_data <- sample_data %>% 
  mutate(
    salary_category = ifelse(salary > 60000, "High", "Low"),
    experience_level = ifelse(experience > 10, "Senior", "Junior")
  )

# Group and summarize
department_summary <- sample_data %>% 
  group_by(department) %>% 
  summarise(
    count = n(),
    avg_salary = mean(salary),
    avg_age = mean(age),
    avg_experience = mean(experience)
  )

print("Department Summary:")
print(department_summary)

# =============================================================================
# 3. DATA VISUALIZATION PACKAGES
# =============================================================================

# ggplot2 - Grammar of Graphics
# install.packages("ggplot2")
library(ggplot2)

# Basic ggplot2 plots
# Scatter plot
scatter_plot <- ggplot(sample_data, aes(x = age, y = salary, color = department)) +
  geom_point(alpha = 0.7) +
  labs(title = "Age vs Salary by Department",
       x = "Age",
       y = "Salary") +
  theme_minimal()

print(scatter_plot)

# Bar plot
bar_plot <- ggplot(department_summary, aes(x = department, y = avg_salary, fill = department)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Salary by Department",
       x = "Department",
       y = "Average Salary") +
  theme_minimal() +
  theme(legend.position = "none")

print(bar_plot)

# Box plot
box_plot <- ggplot(sample_data, aes(x = department, y = salary, fill = department)) +
  geom_boxplot() +
  labs(title = "Salary Distribution by Department",
       x = "Department",
       y = "Salary") +
  theme_minimal() +
  theme(legend.position = "none")

print(box_plot)

# =============================================================================
# 4. STATISTICAL ANALYSIS PACKAGES
# =============================================================================

# stats - Built-in statistical functions
# Basic statistical tests
t_test_result <- t.test(sample_data$salary ~ sample_data$department)
print("T-test result:")
print(t_test_result)

# Correlation analysis
correlation_matrix <- cor(sample_data[, c("age", "salary", "experience")])
print("Correlation Matrix:")
print(correlation_matrix)

# Linear regression
regression_model <- lm(salary ~ age + experience, data = sample_data)
print("Regression Model Summary:")
print(summary(regression_model))

# =============================================================================
# 5. DATA IMPORT/EXPORT PACKAGES
# =============================================================================

# readr - Fast data import
# install.packages("readr")
library(readr)

# readxl - Excel file import
# install.packages("readxl")
library(readxl)

# openxlsx - Excel file export
# install.packages("openxlsx")
library(openxlsx)

# jsonlite - JSON data handling
# install.packages("jsonlite")
library(jsonlite)

# Example: Export data to different formats
# CSV
write_csv(sample_data, "sample_data.csv")

# Excel
write.xlsx(sample_data, "sample_data.xlsx")

# JSON
write_json(sample_data, "sample_data.json")

# =============================================================================
# 6. STRING MANIPULATION PACKAGES
# =============================================================================

# stringr - String manipulation
# install.packages("stringr")
library(stringr)

# String operations
sample_text <- c("Hello World", "R Programming", "Data Analysis")

# Extract substrings
first_words <- str_extract(sample_text, "^\\w+")
print("First words:")
print(first_words)

# Replace text
replaced_text <- str_replace(sample_text, " ", "_")
print("Replaced text:")
print(replaced_text)

# Split strings
split_text <- str_split(sample_text, " ")
print("Split text:")
print(split_text)

# =============================================================================
# 7. DATE AND TIME PACKAGES
# =============================================================================

# lubridate - Date and time manipulation
# install.packages("lubridate")
library(lubridate)

# Create date data
dates <- c("2023-01-15", "2023-02-20", "2023-03-25")
parsed_dates <- ymd(dates)

# Extract components
years <- year(parsed_dates)
months <- month(parsed_dates)
days <- day(parsed_dates)

print("Date components:")
print(data.frame(dates, years, months, days))

# =============================================================================
# 8. DATA CLEANING PACKAGES
# =============================================================================

# janitor - Data cleaning
# install.packages("janitor")
library(janitor)

# Clean column names
messy_data <- data.frame(
  "First Name" = c("John", "Jane", "Bob"),
  "Last Name" = c("Doe", "Smith", "Johnson"),
  "Age (Years)" = c(25, 30, 35),
  "Salary ($)" = c(50000, 60000, 70000)
)

# Clean names
clean_data <- messy_data %>% clean_names()
print("Cleaned data:")
print(clean_data)

# =============================================================================
# 9. MACHINE LEARNING PACKAGES
# =============================================================================

# caret - Classification and Regression Training
# install.packages("caret")
library(caret)

# Create sample data for machine learning
ml_data <- data.frame(
  x1 = rnorm(100),
  x2 = rnorm(100),
  x3 = rnorm(100),
  y = rnorm(100)
)

# Split data
train_index <- createDataPartition(ml_data$y, p = 0.7, list = FALSE)
train_data <- ml_data[train_index, ]
test_data <- ml_data[-train_index, ]

# Train model
model <- train(y ~ ., data = train_data, method = "lm")
print("Model Summary:")
print(model)

# =============================================================================
# 10. INTERACTIVE VISUALIZATION PACKAGES
# =============================================================================

# plotly - Interactive plots
# install.packages("plotly")
library(plotly)

# Create interactive plot
interactive_plot <- plot_ly(sample_data, x = ~age, y = ~salary, 
                           color = ~department, type = "scatter", mode = "markers")
print(interactive_plot)

# =============================================================================
# 11. REPORTING PACKAGES
# =============================================================================

# knitr - Dynamic report generation
# install.packages("knitr")
library(knitr)

# rmarkdown - R Markdown
# install.packages("rmarkdown")
library(rmarkdown)

# Create a simple table
kable(department_summary, caption = "Department Summary")

# =============================================================================
# 12. PACKAGE COMBINATION EXAMPLES
# =============================================================================

# Complete data analysis workflow
analysis_workflow <- function(data) {
  # Load required packages
  library(dplyr)
  library(ggplot2)
  library(knitr)
  
  # Data exploration
  cat("Data Overview:\n")
  print(str(data))
  
  # Summary statistics
  cat("\nSummary Statistics:\n")
  print(summary(data))
  
  # Create visualizations
  p1 <- ggplot(data, aes(x = age, y = salary)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(title = "Age vs Salary")
  
  p2 <- ggplot(data, aes(x = department, y = salary)) +
    geom_boxplot() +
    labs(title = "Salary by Department")
  
  # Return results
  return(list(
    plots = list(p1, p2),
    summary = summary(data)
  ))
}

# Run analysis
results <- analysis_workflow(sample_data)

# =============================================================================
# 13. PACKAGE INSTALLATION SCRIPT
# =============================================================================

# Function to install multiple packages
install_packages <- function(packages) {
  for (package in packages) {
    if (!require(package, character.only = TRUE)) {
      install.packages(package)
      library(package, character.only = TRUE)
    }
  }
}

# Essential packages for data analysis
essential_packages <- c(
  "dplyr", "ggplot2", "readr", "readxl", "openxlsx",
  "stringr", "lubridate", "janitor", "caret", "plotly",
  "knitr", "rmarkdown", "tidyr", "purrr", "broom"
)

# Install packages
# install_packages(essential_packages)

# =============================================================================
# 14. PACKAGE DOCUMENTATION AND HELP
# =============================================================================

# Getting help with packages
# ?package_name
# help(package = "package_name")
# vignette("package_name")

# Package documentation
# browseVignettes("dplyr")
# help.start()

# =============================================================================
# 15. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Install and load the following packages:
# - dplyr
# - ggplot2
# - readr
# - stringr

# Exercise 2: Use dplyr to:
# - Filter data where salary > 50000
# - Group by department
# - Calculate average age and salary

# Exercise 3: Use ggplot2 to create:
# - A histogram of salary
# - A scatter plot of age vs salary
# - A bar plot of department counts

# Exercise 4: Use stringr to:
# - Extract the first word from each name
# - Replace spaces with underscores
# - Count the number of characters in each name

# =============================================================================
# SOLUTIONS TO EXERCISES
# =============================================================================

# Solution 1:
# install.packages(c("dplyr", "ggplot2", "readr", "stringr"))
library(dplyr)
library(ggplot2)
library(readr)
library(stringr)

# Solution 2:
filtered_data <- sample_data %>% 
  filter(salary > 50000) %>% 
  group_by(department) %>% 
  summarise(
    avg_age = mean(age),
    avg_salary = mean(salary),
    count = n()
  )

print("Filtered and grouped data:")
print(filtered_data)

# Solution 3:
# Histogram
hist_plot <- ggplot(sample_data, aes(x = salary)) +
  geom_histogram(bins = 20, fill = "lightblue") +
  labs(title = "Salary Distribution")

# Scatter plot
scatter_plot <- ggplot(sample_data, aes(x = age, y = salary)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm") +
  labs(title = "Age vs Salary")

# Bar plot
bar_plot <- ggplot(sample_data, aes(x = department)) +
  geom_bar(fill = "lightgreen") +
  labs(title = "Department Counts")

print(hist_plot)
print(scatter_plot)
print(bar_plot)

# Solution 4:
# Extract first word
first_words <- str_extract(sample_data$name, "^\\w+")

# Replace spaces with underscores
names_underscore <- str_replace(sample_data$name, " ", "_")

# Count characters
char_counts <- str_length(sample_data$name)

print("String operations results:")
print(data.frame(
  original = sample_data$name,
  first_word = first_words,
  underscore = names_underscore,
  char_count = char_counts
))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Always install packages before using them
# 2. Load packages with library() or require()
# 3. Use dplyr for data manipulation
# 4. Use ggplot2 for visualization
# 5. Use readr/readxl for data import
# 6. Use stringr for string manipulation
# 7. Use lubridate for date/time operations
# 8. Use janitor for data cleaning
# 9. Use caret for machine learning
# 10. Use plotly for interactive plots
# 11. Use knitr/rmarkdown for reporting
# 12. Always check package documentation
# 13. Keep packages updated
# 14. Use package combinations for complex workflows
# 15. Practice with real datasets

# Next: Continue with your R learning journey!
