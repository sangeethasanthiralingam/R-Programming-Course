# Module 2: Experimental Design and Statistical Modeling
# File: 24_Experimental_Design_Modeling.R

# =============================================================================
# EXPERIMENTAL DESIGN AND STATISTICAL MODELING
# =============================================================================

# This lesson covers experimental design principles and advanced statistical modeling
# techniques essential for applied statistics and research

# =============================================================================
# 1. LOADING REQUIRED LIBRARIES
# =============================================================================

# Install required packages if not already installed
# install.packages(c("DoE.base", "agricolae", "car", "emmeans", "lme4", "nlme"))

library(DoE.base)
library(agricolae)
library(car)
library(emmeans)
library(lme4)
library(nlme)

# =============================================================================
# 2. EXPERIMENTAL DESIGN PRINCIPLES
# =============================================================================

# Create experimental design data
set.seed(123)

# Completely Randomized Design (CRD)
crd_data <- data.frame(
  treatment = rep(c("Control", "Treatment A", "Treatment B", "Treatment C"), each = 10),
  response = c(rnorm(10, mean = 50, sd = 5),    # Control
               rnorm(10, mean = 55, sd = 5),    # Treatment A
               rnorm(10, mean = 60, sd = 5),    # Treatment B
               rnorm(10, mean = 58, sd = 5))    # Treatment C
)

print("CRD Data Sample:")
print(head(crd_data))

# Randomized Complete Block Design (RCBD)
rcbd_data <- data.frame(
  block = rep(1:4, each = 4),
  treatment = rep(c("Control", "Treatment A", "Treatment B", "Treatment C"), 4),
  response = c(rnorm(16, mean = 50, sd = 5))
)

# Add block effects
rcbd_data$response <- rcbd_data$response + rcbd_data$block * 2

print("RCBD Data Sample:")
print(head(rcbd_data))

# =============================================================================
# 3. ANALYSIS OF VARIANCE (ANOVA)
# =============================================================================

# One-way ANOVA
one_way_anova <- aov(response ~ treatment, data = crd_data)
print("One-way ANOVA Results:")
print(summary(one_way_anova))

# Two-way ANOVA
two_way_anova <- aov(response ~ treatment + block, data = rcbd_data)
print("Two-way ANOVA Results:")
print(summary(two_way_anova))

# ANOVA with interaction
interaction_anova <- aov(response ~ treatment * block, data = rcbd_data)
print("ANOVA with Interaction:")
print(summary(interaction_anova))

# =============================================================================
# 4. POST-HOC TESTS
# =============================================================================

# Tukey's HSD test
tukey_result <- TukeyHSD(one_way_anova)
print("Tukey's HSD Results:")
print(tukey_result)

# Bonferroni correction
pairwise_t_test <- pairwise.t.test(crd_data$response, crd_data$treatment, 
                                   p.adjust.method = "bonferroni")
print("Pairwise t-tests with Bonferroni correction:")
print(pairwise_t_test)

# =============================================================================
# 5. FACTORIAL DESIGNS
# =============================================================================

# 2^3 Factorial Design
factorial_data <- expand.grid(
  factor_A = c("Low", "High"),
  factor_B = c("Low", "High"),
  factor_C = c("Low", "High")
)

# Add response variable
factorial_data$response <- rnorm(8, mean = 50, sd = 5)

# Add main effects and interactions
factorial_data$response <- factorial_data$response + 
  ifelse(factorial_data$factor_A == "High", 5, 0) +
  ifelse(factorial_data$factor_B == "High", 3, 0) +
  ifelse(factorial_data$factor_C == "High", 2, 0) +
  ifelse(factorial_data$factor_A == "High" & factorial_data$factor_B == "High", 2, 0)

print("Factorial Design Data:")
print(factorial_data)

# Factorial ANOVA
factorial_anova <- aov(response ~ factor_A * factor_B * factor_C, data = factorial_data)
print("Factorial ANOVA Results:")
print(summary(factorial_anova))

# =============================================================================
# 6. RESPONSE SURFACE METHODOLOGY
# =============================================================================

# Central Composite Design (CCD)
ccd_data <- data.frame(
  x1 = c(-1, 1, -1, 1, -1.414, 1.414, 0, 0, 0, 0, 0),
  x2 = c(-1, -1, 1, 1, 0, 0, -1.414, 1.414, 0, 0, 0),
  response = rnorm(11, mean = 50, sd = 5)
)

# Add quadratic effects
ccd_data$response <- ccd_data$response + 
  ccd_data$x1^2 * 2 + 
  ccd_data$x2^2 * 1.5 + 
  ccd_data$x1 * ccd_data$x2 * 0.5

print("CCD Data:")
print(ccd_data)

# Response Surface Model
rsm_model <- lm(response ~ x1 + x2 + I(x1^2) + I(x2^2) + x1:x2, data = ccd_data)
print("Response Surface Model:")
print(summary(rsm_model))

# =============================================================================
# 7. MIXED EFFECTS MODELS
# =============================================================================

# Create nested data
nested_data <- data.frame(
  subject = rep(1:20, each = 3),
  condition = rep(c("A", "B", "C"), 20),
  response = rnorm(60, mean = 50, sd = 10)
)

# Add subject random effects
nested_data$response <- nested_data$response + rep(rnorm(20, 0, 5), each = 3)

print("Nested Data Sample:")
print(head(nested_data))

# Mixed effects model
mixed_model <- lmer(response ~ condition + (1|subject), data = nested_data)
print("Mixed Effects Model:")
print(summary(mixed_model))

# =============================================================================
# 8. GENERALIZED LINEAR MIXED MODELS (GLMM)
# =============================================================================

# Create binary response data
glmm_data <- data.frame(
  subject = rep(1:20, each = 5),
  time = rep(1:5, 20),
  treatment = rep(sample(c("Control", "Treatment"), 20, replace = TRUE), each = 5),
  success = rbinom(100, 1, 0.5)
)

# Add treatment effect
glmm_data$success <- ifelse(glmm_data$treatment == "Treatment", 
                           rbinom(100, 1, 0.7), rbinom(100, 1, 0.3))

# GLMM with binomial family
glmm_model <- glmer(success ~ treatment + time + (1|subject), 
                   data = glmm_data, family = binomial)
print("GLMM Results:")
print(summary(glmm_model))

# =============================================================================
# 9. NONLINEAR MODELS
# =============================================================================

# Create nonlinear data
nonlinear_data <- data.frame(
  x = seq(0, 10, length.out = 50),
  y = 10 * exp(-0.5 * seq(0, 10, length.out = 50)) + rnorm(50, 0, 0.5)
)

print("Nonlinear Data Sample:")
print(head(nonlinear_data))

# Nonlinear model
nonlinear_model <- nls(y ~ a * exp(-b * x), 
                       data = nonlinear_data, 
                       start = list(a = 10, b = 0.5))
print("Nonlinear Model Results:")
print(summary(nonlinear_model))

# =============================================================================
# 10. MODEL SELECTION AND VALIDATION
# =============================================================================

# Create dataset for model selection
model_data <- data.frame(
  y = rnorm(100, mean = 50, sd = 10),
  x1 = rnorm(100),
  x2 = rnorm(100),
  x3 = rnorm(100),
  x4 = rnorm(100),
  x5 = rnorm(100)
)

# Add some relationships
model_data$y <- model_data$y + model_data$x1 * 2 + model_data$x2 * 1.5

# Stepwise model selection
full_model <- lm(y ~ x1 + x2 + x3 + x4 + x5, data = model_data)
step_model <- step(full_model, direction = "both")
print("Stepwise Model Selection:")
print(summary(step_model))

# Cross-validation
library(caret)
cv_model <- train(y ~ x1 + x2 + x3 + x4 + x5, 
                  data = model_data, 
                  method = "lm", 
                  trControl = trainControl(method = "cv", number = 10))
print("Cross-validation Results:")
print(cv_model)

# =============================================================================
# 11. POWER ANALYSIS AND SAMPLE SIZE
# =============================================================================

# Power analysis for t-test
power_t_test <- power.t.test(n = 30, delta = 5, sd = 10, sig.level = 0.05)
print("Power Analysis for t-test:")
print(power_t_test)

# Sample size calculation
sample_size <- power.t.test(power = 0.8, delta = 5, sd = 10, sig.level = 0.05)
print("Required Sample Size:")
print(sample_size)

# Power analysis for ANOVA
power_anova <- power.anova.test(groups = 4, n = 10, between.var = 25, within.var = 100)
print("Power Analysis for ANOVA:")
print(power_anova)

# =============================================================================
# 12. META-ANALYSIS
# =============================================================================

# Install and load metafor
# install.packages("metafor")
library(metafor)

# Create meta-analysis data
meta_data <- data.frame(
  study = paste("Study", 1:10),
  effect_size = rnorm(10, mean = 0.5, sd = 0.3),
  se = runif(10, 0.1, 0.5),
  n = sample(20:100, 10, replace = TRUE)
)

# Meta-analysis
meta_model <- rma(effect_size, se, data = meta_data)
print("Meta-analysis Results:")
print(meta_model)

# Forest plot
forest(meta_model)

# =============================================================================
# 13. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Design a randomized controlled trial and analyze the results
# Exercise 2: Perform factorial ANOVA and interpret interactions
# Exercise 3: Build a mixed effects model for repeated measures data
# Exercise 4: Conduct power analysis for your study design
# Exercise 5: Perform meta-analysis on multiple studies

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1: RCT Analysis
rct_analysis <- aov(response ~ treatment, data = crd_data)
print("RCT Analysis:")
print(summary(rct_analysis))

# Solution 2: Factorial Interpretation
factorial_summary <- summary(factorial_anova)
print("Factorial ANOVA Summary:")
print(factorial_summary)

# Solution 3: Mixed Effects
mixed_summary <- summary(mixed_model)
print("Mixed Effects Summary:")
print(mixed_summary)

# Solution 4: Power Analysis
power_result <- power.t.test(n = 25, delta = 3, sd = 8, sig.level = 0.05)
print("Power Analysis Result:")
print(power_result)

# Solution 5: Meta-analysis
meta_summary <- summary(meta_model)
print("Meta-analysis Summary:")
print(meta_summary)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Randomization reduces bias and confounding
# 2. Blocking controls for known sources of variation
# 3. Factorial designs efficiently study multiple factors
# 4. Mixed effects models handle correlated data
# 5. Model selection balances fit and complexity
# 6. Cross-validation provides unbiased performance estimates
# 7. Power analysis ensures adequate sample sizes
# 8. Meta-analysis combines evidence from multiple studies
# 9. Always validate model assumptions
# 10. Consider practical significance, not just statistical significance
# 11. Document your design and analysis decisions
# 12. Use appropriate statistical software for complex designs

# This completes experimental design and statistical modeling for applied statistics!
