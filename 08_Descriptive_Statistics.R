# Module 2: Descriptive Statistics
# File: 08_Descriptive_Statistics.R

# =============================================================================
# DESCRIPTIVE STATISTICS IN R
# =============================================================================

# Descriptive statistics help us understand and summarize data
# This lesson covers measures of central tendency, dispersion, and distribution

# =============================================================================
# 1. CREATING SAMPLE DATA
# =============================================================================

# Create sample dataset
set.seed(123)  # For reproducible results
sample_data <- data.frame(
  student_id = 1:100,
  math_score = rnorm(100, mean = 75, sd = 10),
  science_score = rnorm(100, mean = 80, sd = 8),
  english_score = rnorm(100, mean = 70, sd = 12),
  gender = sample(c("Male", "Female"), 100, replace = TRUE),
  grade_level = sample(c("9th", "10th", "11th", "12th"), 100, replace = TRUE)
)

# Add some missing values
sample_data$math_score[sample(1:100, 5)] <- NA
sample_data$science_score[sample(1:100, 3)] <- NA

print(head(sample_data))

# =============================================================================
# 2. MEASURES OF CENTRAL TENDENCY
# =============================================================================

# Mean (Average)
mean_math <- mean(sample_data$math_score, na.rm = TRUE)
mean_science <- mean(sample_data$science_score, na.rm = TRUE)
mean_english <- mean(sample_data$english_score, na.rm = TRUE)

print(paste("Mean Math Score:", round(mean_math, 2)))
print(paste("Mean Science Score:", round(mean_science, 2)))
print(paste("Mean English Score:", round(mean_english, 2)))

# Median (Middle value)
median_math <- median(sample_data$math_score, na.rm = TRUE)
median_science <- median(sample_data$science_score, na.rm = TRUE)

print(paste("Median Math Score:", round(median_math, 2)))
print(paste("Median Science Score:", round(median_science, 2)))

# Mode (Most frequent value)
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

mode_gender <- get_mode(sample_data$gender)
mode_grade <- get_mode(sample_data$grade_level)

print(paste("Mode Gender:", mode_gender))
print(paste("Mode Grade:", mode_grade))

# =============================================================================
# 3. MEASURES OF DISPERSION
# =============================================================================

# Range
range_math <- range(sample_data$math_score, na.rm = TRUE)
range_science <- range(sample_data$science_score, na.rm = TRUE)

print(paste("Math Score Range:", range_math[1], "to", range_math[2]))
print(paste("Science Score Range:", range_science[1], "to", range_science[2]))

# Variance
var_math <- var(sample_data$math_score, na.rm = TRUE)
var_science <- var(sample_data$science_score, na.rm = TRUE)

print(paste("Math Score Variance:", round(var_math, 2)))
print(paste("Science Score Variance:", round(var_science, 2)))

# Standard Deviation
sd_math <- sd(sample_data$math_score, na.rm = TRUE)
sd_science <- sd(sample_data$science_score, na.rm = TRUE)

print(paste("Math Score Standard Deviation:", round(sd_math, 2)))
print(paste("Science Score Standard Deviation:", round(sd_science, 2)))

# Coefficient of Variation (CV = SD/Mean)
cv_math <- (sd_math / mean_math) * 100
cv_science <- (sd_science / mean_science) * 100

print(paste("Math Score CV:", round(cv_math, 2), "%"))
print(paste("Science Score CV:", round(cv_science, 2), "%"))

# =============================================================================
# 4. QUARTILES AND PERCENTILES
# =============================================================================

# Quartiles (25%, 50%, 75%)
quartiles_math <- quantile(sample_data$math_score, c(0.25, 0.5, 0.75), na.rm = TRUE)
quartiles_science <- quantile(sample_data$science_score, c(0.25, 0.5, 0.75), na.rm = TRUE)

print("Math Score Quartiles:")
print(quartiles_math)
print("Science Score Quartiles:")
print(quartiles_science)

# Interquartile Range (IQR)
iqr_math <- IQR(sample_data$math_score, na.rm = TRUE)
iqr_science <- IQR(sample_data$science_score, na.rm = TRUE)

print(paste("Math Score IQR:", round(iqr_math, 2)))
print(paste("Science Score IQR:", round(iqr_science, 2)))

# Percentiles
percentiles_math <- quantile(sample_data$math_score, probs = seq(0.1, 0.9, by = 0.1), na.rm = TRUE)
print("Math Score Percentiles:")
print(percentiles_math)

# =============================================================================
# 5. SUMMARY STATISTICS
# =============================================================================

# Complete summary
summary(sample_data$math_score)
summary(sample_data$science_score)

# Custom summary function
custom_summary <- function(x) {
  summary_stats <- list(
    count = length(x),
    missing = sum(is.na(x)),
    mean = mean(x, na.rm = TRUE),
    median = median(x, na.rm = TRUE),
    mode = get_mode(x[!is.na(x)]),
    sd = sd(x, na.rm = TRUE),
    min = min(x, na.rm = TRUE),
    max = max(x, na.rm = TRUE),
    range = max(x, na.rm = TRUE) - min(x, na.rm = TRUE),
    iqr = IQR(x, na.rm = TRUE)
  )
  return(summary_stats)
}

math_summary <- custom_summary(sample_data$math_score)
print("Math Score Summary:")
print(math_summary)

# =============================================================================
# 6. FREQUENCY TABLES
# =============================================================================

# Frequency table for categorical variables
gender_freq <- table(sample_data$gender)
print("Gender Frequency:")
print(gender_freq)

grade_freq <- table(sample_data$grade_level)
print("Grade Level Frequency:")
print(grade_freq)

# Proportion table
gender_prop <- prop.table(gender_freq)
print("Gender Proportions:")
print(gender_prop)

# Cumulative frequency
gender_cumsum <- cumsum(gender_freq)
print("Gender Cumulative Frequency:")
print(gender_cumsum)

# =============================================================================
# 7. GROUPED STATISTICS
# =============================================================================

# Statistics by gender
math_by_gender <- tapply(sample_data$math_score, sample_data$gender, mean, na.rm = TRUE)
science_by_gender <- tapply(sample_data$science_score, sample_data$gender, mean, na.rm = TRUE)

print("Math Score by Gender:")
print(math_by_gender)
print("Science Score by Gender:")
print(science_by_gender)

# Multiple statistics by group
math_stats_by_gender <- tapply(sample_data$math_score, sample_data$gender, function(x) {
  c(mean = mean(x, na.rm = TRUE),
    median = median(x, na.rm = TRUE),
    sd = sd(x, na.rm = TRUE),
    count = length(x[!is.na(x)]))
})

print("Math Statistics by Gender:")
print(math_stats_by_gender)

# =============================================================================
# 8. CROSS-TABULATION
# =============================================================================

# Cross-tabulation of two categorical variables
gender_grade_cross <- table(sample_data$gender, sample_data$grade_level)
print("Gender vs Grade Level Cross-tabulation:")
print(gender_grade_cross)

# Add margins
gender_grade_margins <- addmargins(gender_grade_cross)
print("Gender vs Grade Level with Margins:")
print(gender_grade_margins)

# =============================================================================
# 9. DESCRIPTIVE STATISTICS BY GROUP
# =============================================================================

# Using aggregate function
math_stats_by_grade <- aggregate(math_score ~ grade_level, data = sample_data, 
                               FUN = function(x) c(mean = mean(x, na.rm = TRUE),
                                                 sd = sd(x, na.rm = TRUE),
                                                 count = length(x[!is.na(x)])))

print("Math Score Statistics by Grade Level:")
print(math_stats_by_grade)

# Using dplyr (if available)
# library(dplyr)
# sample_data %>%
#   group_by(grade_level) %>%
#   summarise(
#     mean_math = mean(math_score, na.rm = TRUE),
#     sd_math = sd(math_score, na.rm = TRUE),
#     count = n()
#   )

# =============================================================================
# 10. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Calculate descriptive statistics for all numeric columns
# in the sample_data dataset

# Exercise 2: Create a frequency table for grade_level and calculate
# the percentage distribution

# Exercise 3: Compare math scores between male and female students
# Calculate mean, median, and standard deviation for each group

# Exercise 4: Identify outliers in math_score using the IQR method
# and create a summary of the data with and without outliers

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
numeric_columns <- sapply(sample_data, is.numeric)
numeric_data <- sample_data[numeric_columns]

for (col in names(numeric_data)) {
  cat("\n", col, "Statistics:\n")
  print(custom_summary(numeric_data[[col]]))
}

# Solution 2:
grade_freq <- table(sample_data$grade_level)
grade_prop <- prop.table(grade_freq) * 100
print("Grade Level Distribution (%):")
print(round(grade_prop, 2))

# Solution 3:
math_comparison <- tapply(sample_data$math_score, sample_data$gender, function(x) {
  c(mean = mean(x, na.rm = TRUE),
    median = median(x, na.rm = TRUE),
    sd = sd(x, na.rm = TRUE),
    count = length(x[!is.na(x)]))
})

print("Math Score Comparison by Gender:")
print(math_comparison)

# Solution 4:
# Identify outliers
Q1 <- quantile(sample_data$math_score, 0.25, na.rm = TRUE)
Q3 <- quantile(sample_data$math_score, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

outliers <- sample_data$math_score < lower_bound | sample_data$math_score > upper_bound
outlier_data <- sample_data[outliers, ]

print("Data with outliers:")
print(custom_summary(sample_data$math_score))
print("Data without outliers:")
print(custom_summary(sample_data$math_score[!outliers]))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use mean() for average, median() for middle value, mode for most frequent
# 2. Range shows spread, variance and SD measure dispersion
# 3. Quartiles divide data into quarters, IQR measures middle 50%
# 4. Use na.rm = TRUE to handle missing values
# 5. table() creates frequency tables, prop.table() creates proportions
# 6. tapply() calculates statistics by group
# 7. aggregate() provides grouped summaries
# 8. Always check for outliers and missing values

# Next: Move to 09_Statistical_Tests.R to learn about hypothesis testing!
