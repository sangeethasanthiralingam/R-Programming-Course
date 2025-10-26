# Module 4: Packages and Libraries
# File: 19_Packages_Libraries.R

# =============================================================================
# WORKING WITH R PACKAGES AND LIBRARIES
# =============================================================================

# This lesson covers installing, loading, and managing R packages
# as well as understanding the R package ecosystem

# =============================================================================
# 1. UNDERSTANDING R PACKAGES
# =============================================================================

# R packages are collections of functions, data, and documentation
# They extend R's functionality for specific tasks

# Check installed packages
installed_packages <- installed.packages()
print("Number of installed packages:", nrow(installed_packages))

# List some installed packages
print("Some installed packages:")
print(rownames(installed_packages)[1:10])

# =============================================================================
# 2. INSTALLING PACKAGES
# =============================================================================

# Install packages from CRAN
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("tidyr")

# Install multiple packages at once
# install.packages(c("ggplot2", "dplyr", "tidyr", "readr"))

# Install packages from GitHub
# install.packages("devtools")
# library(devtools)
# install_github("username/package_name")

# Install packages from Bioconductor
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("package_name")

# =============================================================================
# 3. LOADING PACKAGES
# =============================================================================

# Load packages using library()
library(ggplot2)
library(dplyr)

# Check if package is loaded
loaded_packages <- (.packages())
print("Currently loaded packages:")
print(loaded_packages)

# Load package with error handling
if (!require(ggplot2, quietly = TRUE)) {
  install.packages("ggplot2")
  library(ggplot2)
}

# =============================================================================
# 4. ESSENTIAL R PACKAGES
# =============================================================================

# Data manipulation packages
# dplyr - for data manipulation
# tidyr - for data tidying
# readr - for reading data
# readxl - for reading Excel files

# Visualization packages
# ggplot2 - for creating plots
# plotly - for interactive plots
# leaflet - for maps
# highcharter - for charts

# Statistical packages
# stats - built-in statistical functions
# MASS - additional statistical functions
# car - for regression analysis
# psych - for psychological research

# Machine learning packages
# caret - for machine learning
# randomForest - for random forests
# e1071 - for SVM
# nnet - for neural networks

# =============================================================================
# 5. WORKING WITH DPLYR
# =============================================================================

# Create sample data
set.seed(123)
sample_data <- data.frame(
  id = 1:100,
  name = paste("Person", 1:100),
  age = sample(18:65, 100, replace = TRUE),
  income = rnorm(100, mean = 50000, sd = 15000),
  department = sample(c("IT", "HR", "Finance", "Marketing", "Sales"), 100, replace = TRUE),
  performance = rnorm(100, mean = 75, sd = 15)
)

# Load dplyr
library(dplyr)

# Select specific columns
selected_data <- sample_data %>%
  select(name, age, income, department)

print("Selected data:")
print(head(selected_data))

# Filter data
filtered_data <- sample_data %>%
  filter(age > 30, income > 50000)

print("Filtered data:")
print(head(filtered_data))

# Arrange data
arranged_data <- sample_data %>%
  arrange(desc(income))

print("Arranged data:")
print(head(arranged_data))

# Mutate data (create new columns)
mutated_data <- sample_data %>%
  mutate(
    income_category = ifelse(income > 60000, "High", "Low"),
    age_group = ifelse(age < 30, "Young", "Old")
  )

print("Mutated data:")
print(head(mutated_data))

# Summarize data
summary_data <- sample_data %>%
  group_by(department) %>%
  summarise(
    avg_income = mean(income),
    avg_age = mean(age),
    count = n()
  )

print("Summary data:")
print(summary_data)

# =============================================================================
# 6. WORKING WITH GGPLOT2
# =============================================================================

# Load ggplot2
library(ggplot2)

# Create scatter plot
scatter_plot <- ggplot(sample_data, aes(x = age, y = income, color = department)) +
  geom_point(alpha = 0.7) +
  labs(title = "Age vs Income by Department",
       x = "Age",
       y = "Income") +
  theme_minimal()

print(scatter_plot)

# Create bar plot
bar_plot <- ggplot(summary_data, aes(x = department, y = avg_income, fill = department)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Income by Department",
       x = "Department",
       y = "Average Income") +
  theme_minimal() +
  theme(legend.position = "none")

print(bar_plot)

# =============================================================================
# 7. WORKING WITH TIDYR
# =============================================================================

# Load tidyr
library(tidyr)

# Create wide data
wide_data <- data.frame(
  id = 1:5,
  name = c("Alice", "Bob", "Charlie", "Diana", "Eve"),
  math = c(85, 92, 78, 96, 88),
  science = c(90, 85, 92, 88, 95),
  english = c(88, 90, 85, 92, 87)
)

print("Wide data:")
print(wide_data)

# Convert to long format
long_data <- wide_data %>%
  pivot_longer(cols = c(math, science, english),
               names_to = "subject",
               values_to = "score")

print("Long data:")
print(long_data)

# Convert back to wide format
wide_data_again <- long_data %>%
  pivot_wider(names_from = subject,
              values_from = score)

print("Wide data again:")
print(wide_data_again)

# =============================================================================
# 8. WORKING WITH READR
# =============================================================================

# Load readr
library(readr)

# Create sample CSV data
write_csv(sample_data, "sample_data.csv")

# Read CSV file
read_data <- read_csv("sample_data.csv")

print("Read data:")
print(head(read_data))

# Read with specific options
read_data_options <- read_csv("sample_data.csv",
                             col_types = cols(
                               id = col_integer(),
                               name = col_character(),
                               age = col_integer(),
                               income = col_double(),
                               department = col_character(),
                               performance = col_double()
                             ))

print("Read data with options:")
print(head(read_data_options))

# =============================================================================
# 9. PACKAGE MANAGEMENT
# =============================================================================

# Check package version
package_version <- packageVersion("ggplot2")
print("ggplot2 version:", package_version)

# Update packages
# update.packages()

# Check for outdated packages
outdated_packages <- old.packages()
if (!is.null(outdated_packages)) {
  print("Outdated packages:")
  print(outdated_packages)
} else {
  print("All packages are up to date")
}

# Remove packages
# remove.packages("package_name")

# =============================================================================
# 10. CREATING CUSTOM PACKAGES
# =============================================================================

# Create a simple function
calculate_statistics <- function(data) {
  return(list(
    mean = mean(data, na.rm = TRUE),
    median = median(data, na.rm = TRUE),
    sd = sd(data, na.rm = TRUE),
    min = min(data, na.rm = TRUE),
    max = max(data, na.rm = TRUE)
  ))
}

# Test the function
test_data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
stats_result <- calculate_statistics(test_data)
print("Statistics result:")
print(stats_result)

# =============================================================================
# 11. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Install and load the "psych" package
# Then use it to calculate descriptive statistics

# Exercise 2: Use dplyr to filter and summarize data
# from the sample_data data frame

# Exercise 3: Create a ggplot2 visualization
# showing the relationship between two variables

# Exercise 4: Use tidyr to reshape data
# from wide to long format

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
# install.packages("psych")
library(psych)

psych_stats <- describe(sample_data$income)
print("Psych statistics:")
print(psych_stats)

# Solution 2:
dplyr_exercise <- sample_data %>%
  filter(age > 25) %>%
  group_by(department) %>%
  summarise(
    avg_income = mean(income),
    avg_performance = mean(performance),
    count = n()
  ) %>%
  arrange(desc(avg_income))

print("Dplyr exercise result:")
print(dplyr_exercise)

# Solution 3:
ggplot_exercise <- ggplot(sample_data, aes(x = age, y = performance)) +
  geom_point(aes(color = department), alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Age vs Performance by Department",
       x = "Age",
       y = "Performance") +
  theme_minimal()

print(ggplot_exercise)

# Solution 4:
tidyr_exercise <- sample_data %>%
  select(id, name, age, income, performance) %>%
  pivot_longer(cols = c(age, income, performance),
               names_to = "variable",
               values_to = "value")

print("Tidyr exercise result:")
print(head(tidyr_exercise))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use install.packages() to install packages
# 2. Use library() to load packages
# 3. Use require() for conditional loading
# 4. dplyr provides powerful data manipulation functions
# 5. ggplot2 is the standard for creating plots
# 6. tidyr helps with data reshaping
# 7. readr provides fast data reading functions
# 8. Always check package versions and updates
# 9. Use package documentation and vignettes
# 10. Consider package dependencies when installing

# Next: Move to Module 5 - Practice & Projects!
# Start with 20_Mini_Projects.R
