# Module 2: Correlation and Regression
# File: 10_Correlation_Regression.R

# =============================================================================
# CORRELATION AND REGRESSION ANALYSIS IN R
# =============================================================================

# This lesson covers correlation analysis and linear regression
# to understand relationships between variables

# =============================================================================
# 1. CREATING SAMPLE DATA
# =============================================================================

# Create sample dataset with correlated variables
set.seed(123)

# Generate correlated data
n <- 100
x1 <- rnorm(n, mean = 50, sd = 10)  # Independent variable 1
x2 <- rnorm(n, mean = 30, sd = 8)   # Independent variable 2
x3 <- rnorm(n, mean = 40, sd = 12)  # Independent variable 3

# Create dependent variable with some correlation
y <- 2 * x1 + 1.5 * x2 - 0.8 * x3 + rnorm(n, mean = 0, sd = 5)

# Create data frame
regression_data <- data.frame(
  y = y,
  x1 = x1,
  x2 = x2,
  x3 = x3,
  category = sample(c("A", "B", "C"), n, replace = TRUE)
)

print(head(regression_data))

# =============================================================================
# 2. CORRELATION ANALYSIS
# =============================================================================

# Calculate correlation matrix
correlation_matrix <- cor(regression_data[, c("y", "x1", "x2", "x3")])
print("Correlation Matrix:")
print(round(correlation_matrix, 3))

# Individual correlation tests
cor_test_y_x1 <- cor.test(regression_data$y, regression_data$x1)
print("Correlation Test (y vs x1):")
print(cor_test_y_x1)

cor_test_y_x2 <- cor.test(regression_data$y, regression_data$x2)
print("Correlation Test (y vs x2):")
print(cor_test_y_x2)

# Spearman correlation (non-parametric)
spearman_cor <- cor.test(regression_data$y, regression_data$x1, method = "spearman")
print("Spearman Correlation Test:")
print(spearman_cor)

# =============================================================================
# 3. SIMPLE LINEAR REGRESSION
# =============================================================================

# Simple linear regression: y ~ x1
simple_model <- lm(y ~ x1, data = regression_data)
print("Simple Linear Regression (y ~ x1):")
print(summary(simple_model))

# Extract key information
cat("R-squared:", summary(simple_model)$r.squared, "\n")
cat("Adjusted R-squared:", summary(simple_model)$adj.r.squared, "\n")
cat("F-statistic:", summary(simple_model)$fstatistic[1], "\n")
cat("P-value:", pf(summary(simple_model)$fstatistic[1], 
                   summary(simple_model)$fstatistic[2], 
                   summary(simple_model)$fstatistic[3], 
                   lower.tail = FALSE), "\n")

# =============================================================================
# 4. MULTIPLE LINEAR REGRESSION
# =============================================================================

# Multiple linear regression: y ~ x1 + x2 + x3
multiple_model <- lm(y ~ x1 + x2 + x3, data = regression_data)
print("Multiple Linear Regression (y ~ x1 + x2 + x3):")
print(summary(multiple_model))

# Extract coefficients
coefficients <- coef(multiple_model)
cat("Intercept:", round(coefficients[1], 3), "\n")
cat("x1 coefficient:", round(coefficients[2], 3), "\n")
cat("x2 coefficient:", round(coefficients[3], 3), "\n")
cat("x3 coefficient:", round(coefficients[4], 3), "\n")

# =============================================================================
# 5. REGRESSION DIAGNOSTICS
# =============================================================================

# Residuals
residuals <- residuals(multiple_model)
fitted_values <- fitted(multiple_model)

# Plot residuals vs fitted values
plot(fitted_values, residuals, 
     main = "Residuals vs Fitted Values",
     xlab = "Fitted Values", 
     ylab = "Residuals")
abline(h = 0, col = "red")

# Q-Q plot for normality
qqnorm(residuals)
qqline(residuals, col = "red")

# Histogram of residuals
hist(residuals, main = "Histogram of Residuals", xlab = "Residuals")

# =============================================================================
# 6. MODEL SELECTION
# =============================================================================

# Compare different models
model1 <- lm(y ~ x1, data = regression_data)
model2 <- lm(y ~ x1 + x2, data = regression_data)
model3 <- lm(y ~ x1 + x2 + x3, data = regression_data)

# AIC and BIC for model comparison
aic_values <- c(AIC(model1), AIC(model2), AIC(model3))
bic_values <- c(BIC(model1), BIC(model2), BIC(model3))

cat("AIC values:", round(aic_values, 2), "\n")
cat("BIC values:", round(bic_values, 2), "\n")

# Stepwise regression
step_model <- step(multiple_model, direction = "both")
print("Stepwise Regression:")
print(summary(step_model))

# =============================================================================
# 7. PREDICTION AND CONFIDENCE INTERVALS
# =============================================================================

# Create new data for prediction
new_data <- data.frame(
  x1 = c(55, 60, 65),
  x2 = c(35, 40, 45),
  x3 = c(45, 50, 55)
)

# Predictions
predictions <- predict(multiple_model, newdata = new_data)
print("Predictions:")
print(round(predictions, 2))

# Confidence intervals
conf_intervals <- predict(multiple_model, newdata = new_data, interval = "confidence")
print("Confidence Intervals:")
print(round(conf_intervals, 2))

# Prediction intervals
pred_intervals <- predict(multiple_model, newdata = new_data, interval = "prediction")
print("Prediction Intervals:")
print(round(pred_intervals, 2))

# =============================================================================
# 8. INTERACTION TERMS
# =============================================================================

# Model with interaction term
interaction_model <- lm(y ~ x1 + x2 + x1:x2, data = regression_data)
print("Model with Interaction Term:")
print(summary(interaction_model))

# =============================================================================
# 9. CATEGORICAL VARIABLES IN REGRESSION
# =============================================================================

# Model with categorical variable
categorical_model <- lm(y ~ x1 + x2 + category, data = regression_data)
print("Model with Categorical Variable:")
print(summary(categorical_model))

# =============================================================================
# 10. NON-LINEAR REGRESSION
# =============================================================================

# Create non-linear data
x_nonlinear <- seq(0, 10, length.out = 50)
y_nonlinear <- 2 * x_nonlinear^2 + 3 * x_nonlinear + 5 + rnorm(50, 0, 5)

# Polynomial regression
poly_model <- lm(y_nonlinear ~ poly(x_nonlinear, degree = 2))
print("Polynomial Regression:")
print(summary(poly_model))

# =============================================================================
# 11. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a dataset with two variables and perform
# correlation analysis

# Exercise 2: Fit a simple linear regression model and interpret
# the results

# Exercise 3: Create a multiple regression model with at least
# three predictors and compare it with simpler models

# Exercise 4: Use your regression model to make predictions
# for new data points

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
exercise_data <- data.frame(
  hours_studied = rnorm(50, mean = 20, sd = 5),
  test_score = rnorm(50, mean = 75, sd = 10)
)
exercise_data$test_score <- exercise_data$test_score + 0.5 * exercise_data$hours_studied

correlation_exercise <- cor.test(exercise_data$hours_studied, exercise_data$test_score)
print("Exercise 1 - Correlation Analysis:")
print(correlation_exercise)

# Solution 2:
simple_regression <- lm(test_score ~ hours_studied, data = exercise_data)
print("Exercise 2 - Simple Linear Regression:")
print(summary(simple_regression))

# Solution 3:
exercise_data$sleep_hours <- rnorm(50, mean = 8, sd = 1)
exercise_data$test_score <- exercise_data$test_score + 2 * exercise_data$sleep_hours

multiple_regression <- lm(test_score ~ hours_studied + sleep_hours, data = exercise_data)
print("Exercise 3 - Multiple Linear Regression:")
print(summary(multiple_regression))

# Solution 4:
new_student_data <- data.frame(
  hours_studied = c(25, 30, 35),
  sleep_hours = c(8, 7, 9)
)

predictions_exercise <- predict(multiple_regression, newdata = new_student_data)
print("Exercise 4 - Predictions:")
print(round(predictions_exercise, 2))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use cor() for correlation matrix, cor.test() for significance tests
# 2. lm() function fits linear regression models
# 3. summary() provides detailed regression output
# 4. Check residuals for model assumptions
# 5. Use AIC/BIC for model comparison
# 6. predict() function makes predictions
# 7. Include interaction terms when appropriate
# 8. Handle categorical variables properly
# 9. Consider polynomial terms for non-linear relationships
# 10. Always validate model assumptions

# Next: Move to Module 3 - Data Visualization!
# Start with 11_Base_Plotting.R
