# Module 2: Advanced Statistical Concepts
# File: 23_Advanced_Statistical_Concepts.R

# =============================================================================
# ADVANCED STATISTICAL CONCEPTS FOR APPLIED STATISTICS
# =============================================================================

# This lesson covers advanced statistical concepts essential for applied statistics
# including multivariate analysis, time series, survival analysis, and more

# =============================================================================
# 1. LOADING REQUIRED LIBRARIES
# =============================================================================

# Install required packages if not already installed
# install.packages(c("MASS", "car", "psych", "survival", "forecast", "cluster", "factoextra"))

library(MASS)
library(car)
library(psych)
library(survival)
library(forecast)
library(cluster)
library(factoextra)

# =============================================================================
# 2. MULTIVARIATE ANALYSIS
# =============================================================================

# Create multivariate dataset
set.seed(123)
n <- 200

multivariate_data <- data.frame(
  id = 1:n,
  height = rnorm(n, mean = 170, sd = 10),
  weight = rnorm(n, mean = 70, sd = 15),
  age = sample(20:60, n, replace = TRUE),
  income = rnorm(n, mean = 50000, sd = 15000),
  education_years = sample(12:20, n, replace = TRUE),
  satisfaction = sample(1:10, n, replace = TRUE),
  stress_level = sample(1:10, n, replace = TRUE)
)

# Add correlations
multivariate_data$weight <- multivariate_data$weight + (multivariate_data$height - 170) * 0.5
multivariate_data$income <- multivariate_data$income + multivariate_data$education_years * 2000
multivariate_data$satisfaction <- multivariate_data$satisfaction - multivariate_data$stress_level * 0.3

print("Multivariate Data Sample:")
print(head(multivariate_data))

# Principal Component Analysis (PCA)
pca_data <- multivariate_data[, c("height", "weight", "age", "income", "education_years", "satisfaction", "stress_level")]
pca_result <- prcomp(pca_data, scale = TRUE)

print("PCA Results:")
print(summary(pca_result))

# PCA Scree Plot
scree_plot <- fviz_eig(pca_result, addlabels = TRUE)
print(scree_plot)

# Factor Analysis
factor_data <- multivariate_data[, c("height", "weight", "age", "income", "education_years", "satisfaction", "stress_level")]
factor_result <- factanal(factor_data, factors = 3, rotation = "varimax")

print("Factor Analysis Results:")
print(factor_result)

# =============================================================================
# 3. CLUSTER ANALYSIS
# =============================================================================

# K-means clustering
cluster_data <- multivariate_data[, c("height", "weight", "age", "income")]
cluster_data_scaled <- scale(cluster_data)

# Determine optimal number of clusters
wss <- sapply(1:10, function(k) kmeans(cluster_data_scaled, k, nstart = 10)$tot.withinss)
plot(1:10, wss, type = "b", xlab = "Number of Clusters", ylab = "Within-cluster Sum of Squares")

# Perform K-means clustering
kmeans_result <- kmeans(cluster_data_scaled, centers = 3, nstart = 10)
multivariate_data$cluster <- kmeans_result$cluster

print("Cluster Centers:")
print(kmeans_result$centers)

# Hierarchical clustering
dist_matrix <- dist(cluster_data_scaled)
hclust_result <- hclust(dist_matrix, method = "ward.D2")
plot(hclust_result)

# =============================================================================
# 4. DISCRIMINANT ANALYSIS
# =============================================================================

# Linear Discriminant Analysis (LDA)
lda_data <- multivariate_data[, c("height", "weight", "age", "income", "cluster")]
lda_result <- lda(cluster ~ height + weight + age + income, data = lda_data)

print("LDA Results:")
print(lda_result)

# Quadratic Discriminant Analysis (QDA)
qda_result <- qda(cluster ~ height + weight + age + income, data = lda_data)

print("QDA Results:")
print(qda_result)

# =============================================================================
# 5. MANOVA (Multivariate Analysis of Variance)
# =============================================================================

# Create groups for MANOVA
multivariate_data$group <- sample(c("A", "B", "C"), n, replace = TRUE)

# MANOVA
manova_result <- manova(cbind(height, weight, age, income) ~ group, data = multivariate_data)
print("MANOVA Results:")
print(summary(manova_result))

# =============================================================================
# 6. TIME SERIES ANALYSIS
# =============================================================================

# Create time series data
time_series_data <- data.frame(
  date = seq(as.Date("2020-01-01"), as.Date("2023-12-31"), by = "month"),
  value = cumsum(rnorm(48, mean = 100, sd = 20)) + 
          sin(seq(0, 4*pi, length.out = 48)) * 50 +  # Seasonal component
          seq(1, 48) * 2  # Trend component
)

# Convert to time series object
ts_data <- ts(time_series_data$value, start = c(2020, 1), frequency = 12)

# Time series decomposition
decomposition <- decompose(ts_data)
plot(decomposition)

# ARIMA model
arima_model <- auto.arima(ts_data)
print("ARIMA Model:")
print(arima_model)

# Forecast
forecast_result <- forecast(arima_model, h = 12)
plot(forecast_result)

# =============================================================================
# 7. SURVIVAL ANALYSIS
# =============================================================================

# Create survival data
survival_data <- data.frame(
  id = 1:100,
  time = rexp(100, rate = 0.1),
  event = sample(c(0, 1), 100, replace = TRUE, prob = c(0.3, 0.7)),
  treatment = sample(c("A", "B"), 100, replace = TRUE),
  age = sample(30:70, 100, replace = TRUE)
)

# Kaplan-Meier survival curves
km_fit <- survfit(Surv(time, event) ~ treatment, data = survival_data)
print("Kaplan-Meier Results:")
print(summary(km_fit))

# Plot survival curves
plot(km_fit, col = c("red", "blue"), xlab = "Time", ylab = "Survival Probability")
legend("topright", legend = c("Treatment A", "Treatment B"), col = c("red", "blue"), lty = 1)

# Cox Proportional Hazards Model
cox_model <- coxph(Surv(time, event) ~ treatment + age, data = survival_data)
print("Cox Model Results:")
print(summary(cox_model))

# =============================================================================
# 8. GENERALIZED LINEAR MODELS (GLM)
# =============================================================================

# Logistic Regression
logistic_data <- data.frame(
  outcome = sample(c(0, 1), 100, replace = TRUE),
  predictor1 = rnorm(100),
  predictor2 = rnorm(100),
  predictor3 = rnorm(100)
)

# Add some relationship
logistic_data$outcome <- ifelse(logistic_data$predictor1 + logistic_data$predictor2 > 0, 
                               rbinom(100, 1, 0.7), rbinom(100, 1, 0.3))

logistic_model <- glm(outcome ~ predictor1 + predictor2 + predictor3, 
                     data = logistic_data, family = binomial)
print("Logistic Regression Results:")
print(summary(logistic_model))

# Poisson Regression
poisson_data <- data.frame(
  count = rpois(100, lambda = 5),
  predictor1 = rnorm(100),
  predictor2 = rnorm(100)
)

poisson_model <- glm(count ~ predictor1 + predictor2, 
                    data = poisson_data, family = poisson)
print("Poisson Regression Results:")
print(summary(poisson_model))

# =============================================================================
# 9. MIXED EFFECTS MODELS
# =============================================================================

# Install and load lme4
# install.packages("lme4")
library(lme4)

# Create longitudinal data
longitudinal_data <- data.frame(
  id = rep(1:20, each = 5),
  time = rep(1:5, 20),
  outcome = rnorm(100, mean = 50, sd = 10),
  treatment = rep(sample(c("A", "B"), 20, replace = TRUE), each = 5),
  covariate = rnorm(100)
)

# Add some structure
longitudinal_data$outcome <- longitudinal_data$outcome + 
                            longitudinal_data$time * 2 +
                            ifelse(longitudinal_data$treatment == "A", 5, 0)

# Mixed effects model
mixed_model <- lmer(outcome ~ time + treatment + covariate + (1|id), 
                    data = longitudinal_data)
print("Mixed Effects Model Results:")
print(summary(mixed_model))

# =============================================================================
# 10. BAYESIAN STATISTICS
# =============================================================================

# Install and load rstanarm
# install.packages("rstanarm")
library(rstanarm)

# Bayesian linear regression
bayesian_data <- data.frame(
  y = rnorm(50, mean = 10, sd = 2),
  x1 = rnorm(50),
  x2 = rnorm(50)
)

bayesian_model <- stan_glm(y ~ x1 + x2, data = bayesian_data, 
                          prior = normal(0, 1), prior_intercept = normal(0, 1))
print("Bayesian Model Results:")
print(summary(bayesian_model))

# =============================================================================
# 11. BOOTSTRAP AND RESAMPLING METHODS
# =============================================================================

# Bootstrap confidence intervals
bootstrap_function <- function(data, n_bootstrap = 1000) {
  n <- length(data)
  bootstrap_means <- replicate(n_bootstrap, {
    sample_data <- sample(data, n, replace = TRUE)
    mean(sample_data)
  })
  return(bootstrap_means)
}

# Example with sample data
sample_data <- rnorm(100, mean = 50, sd = 10)
bootstrap_means <- bootstrap_function(sample_data)

# Bootstrap confidence interval
bootstrap_ci <- quantile(bootstrap_means, c(0.025, 0.975))
print("Bootstrap 95% Confidence Interval:")
print(bootstrap_ci)

# =============================================================================
# 12. EFFECT SIZES AND POWER ANALYSIS
# =============================================================================

# Cohen's d calculation
cohens_d <- function(x, y) {
  n1 <- length(x)
  n2 <- length(y)
  pooled_sd <- sqrt(((n1 - 1) * var(x) + (n2 - 1) * var(y)) / (n1 + n2 - 2))
  return((mean(x) - mean(y)) / pooled_sd)
}

# Power analysis
power_analysis <- function(n, effect_size, alpha = 0.05) {
  power <- 1 - pnorm(qnorm(alpha/2) - effect_size * sqrt(n/2))
  return(power)
}

# Example
group1 <- rnorm(30, mean = 100, sd = 15)
group2 <- rnorm(30, mean = 110, sd = 15)
effect_size <- cohens_d(group1, group2)
power <- power_analysis(30, effect_size)

print(paste("Effect size (Cohen's d):", round(effect_size, 3)))
print(paste("Statistical power:", round(power, 3)))

# =============================================================================
# 13. MULTIPLE COMPARISON CORRECTIONS
# =============================================================================

# Bonferroni correction
p_values <- c(0.01, 0.03, 0.05, 0.08, 0.12)
bonferroni_corrected <- p.adjust(p_values, method = "bonferroni")
print("Bonferroni corrected p-values:")
print(bonferroni_corrected)

# False Discovery Rate (FDR)
fdr_corrected <- p.adjust(p_values, method = "fdr")
print("FDR corrected p-values:")
print(fdr_corrected)

# =============================================================================
# 14. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Perform PCA on a dataset and interpret the results
# Exercise 2: Conduct cluster analysis and determine optimal number of clusters
# Exercise 3: Fit a time series model and make forecasts
# Exercise 4: Perform survival analysis and compare groups
# Exercise 5: Build a mixed effects model for longitudinal data

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1: PCA Interpretation
pca_importance <- summary(pca_result)$importance
print("PCA Importance:")
print(pca_importance)

# Solution 2: Optimal Clusters
optimal_clusters <- which.min(wss)
print(paste("Optimal number of clusters:", optimal_clusters))

# Solution 3: Time Series Forecast
forecast_values <- forecast_result$mean
print("Forecast values:")
print(forecast_values)

# Solution 4: Survival Analysis
survival_summary <- summary(km_fit)
print("Survival Analysis Summary:")
print(survival_summary)

# Solution 5: Mixed Effects
random_effects <- ranef(mixed_model)
print("Random Effects:")
print(random_effects)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. PCA reduces dimensionality while preserving variance
# 2. Cluster analysis groups similar observations
# 3. MANOVA tests multiple dependent variables simultaneously
# 4. Time series analysis handles temporal dependencies
# 5. Survival analysis models time-to-event data
# 6. GLMs extend linear models to non-normal distributions
# 7. Mixed effects models handle correlated data
# 8. Bayesian methods incorporate prior knowledge
# 9. Bootstrap provides robust confidence intervals
# 10. Effect sizes quantify practical significance
# 11. Multiple comparison corrections control Type I error
# 12. Always validate assumptions and interpret results carefully

# This completes the advanced statistical concepts for applied statistics!
