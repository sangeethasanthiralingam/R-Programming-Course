# Module 2: Statistical Tests
# File: 09_Statistical_Tests.R

# =============================================================================
# STATISTICAL TESTS IN R
# =============================================================================

# This lesson covers common statistical tests for hypothesis testing
# including t-tests, chi-square tests, and ANOVA

# =============================================================================
# 1. SETTING UP SAMPLE DATA
# =============================================================================

# Create sample datasets for different tests
set.seed(123)

# Dataset 1: Two groups for t-test
group1 <- rnorm(30, mean = 100, sd = 15)  # Control group
group2 <- rnorm(30, mean = 110, sd = 15)  # Treatment group

# Dataset 2: Categorical data for chi-square test
treatment_data <- data.frame(
  treatment = rep(c("Drug A", "Drug B", "Placebo"), each = 50),
  outcome = c(rep(c("Improved", "No Change"), c(35, 15)),
           rep(c("Improved", "No Change"), c(40, 10)),
           rep(c("Improved", "No Change"), c(20, 30))
)

# Dataset 3: Multiple groups for ANOVA
anova_data <- data.frame(
  group = rep(c("Group1", "Group2", "Group3"), each = 25),
  score = c(rnorm(25, mean = 75, sd = 10),
           rnorm(25, mean = 80, sd = 10),
           rnorm(25, mean = 85, sd = 10))
)

# =============================================================================
# 2. ONE-SAMPLE T-TEST
# =============================================================================

# Test if sample mean is different from population mean
# H0: μ = 100, H1: μ ≠ 100

one_sample_test <- t.test(group1, mu = 100)
print("One-Sample T-Test:")
print(one_sample_test)

# Extract key information
cat("Test Statistic:", one_sample_test$statistic, "\n")
cat("P-value:", one_sample_test$p.value, "\n")
cat("Confidence Interval:", one_sample_test$conf.int, "\n")

# =============================================================================
# 3. TWO-SAMPLE T-TEST (INDEPENDENT SAMPLES)
# =============================================================================

# Test if two groups have different means
# H0: μ1 = μ2, H1: μ1 ≠ μ2

# Equal variances assumed
two_sample_test <- t.test(group1, group2, var.equal = TRUE)
print("Two-Sample T-Test (Equal Variances):")
print(two_sample_test)

# Unequal variances (Welch's t-test)
welch_test <- t.test(group1, group2, var.equal = FALSE)
print("Welch's T-Test (Unequal Variances):")
print(welch_test)

# =============================================================================
# 4. PAIRED T-TEST
# =============================================================================

# Test if there's a difference between paired observations
# Example: before and after measurements
before <- rnorm(20, mean = 50, sd = 10)
after <- before + rnorm(20, mean = 5, sd = 3)  # After is higher on average

paired_test <- t.test(before, after, paired = TRUE)
print("Paired T-Test:")
print(paired_test)

# =============================================================================
# 5. CHI-SQUARE TEST OF INDEPENDENCE
# =============================================================================

# Test if two categorical variables are independent
# H0: Variables are independent, H1: Variables are dependent

# Create contingency table
contingency_table <- table(treatment_data$treatment, treatment_data$outcome)
print("Contingency Table:")
print(contingency_table)

# Chi-square test
chi_square_test <- chisq.test(contingency_table)
print("Chi-Square Test of Independence:")
print(chi_square_test)

# Expected frequencies
print("Expected Frequencies:")
print(chi_square_test$expected)

# =============================================================================
# 6. CHI-SQUARE GOODNESS OF FIT TEST
# =============================================================================

# Test if observed frequencies match expected frequencies
# Example: Test if dice is fair
observed <- c(12, 8, 15, 10, 9, 6)  # Observed frequencies for each face
expected <- rep(10, 6)  # Expected frequency for each face (60/6 = 10)

goodness_of_fit <- chisq.test(observed, p = rep(1/6, 6))
print("Chi-Square Goodness of Fit Test:")
print(goodness_of_fit)

# =============================================================================
# 7. ONE-WAY ANOVA
# =============================================================================

# Test if means of three or more groups are equal
# H0: μ1 = μ2 = μ3, H1: At least one mean is different

# Perform ANOVA
anova_result <- aov(score ~ group, data = anova_data)
print("One-Way ANOVA:")
print(summary(anova_result))

# Extract F-statistic and p-value
f_statistic <- summary(anova_result)[[1]][["F value"]][1]
p_value <- summary(anova_result)[[1]][["Pr(>F)"]][1]

cat("F-statistic:", f_statistic, "\n")
cat("P-value:", p_value, "\n")

# =============================================================================
# 8. POST-HOC TESTS (Tukey's HSD)
# =============================================================================

# If ANOVA is significant, perform post-hoc tests
if (p_value < 0.05) {
  tukey_result <- TukeyHSD(anova_result)
  print("Tukey's HSD Post-Hoc Test:")
  print(tukey_result)
}

# =============================================================================
# 9. CORRELATION TESTS
# =============================================================================

# Create correlated data
x <- rnorm(50, mean = 100, sd = 15)
y <- 0.7 * x + rnorm(50, mean = 0, sd = 10)

# Pearson correlation test
correlation_test <- cor.test(x, y, method = "pearson")
print("Pearson Correlation Test:")
print(correlation_test)

# Spearman correlation test (non-parametric)
spearman_test <- cor.test(x, y, method = "spearman")
print("Spearman Correlation Test:")
print(spearman_test)

# =============================================================================
# 10. NON-PARAMETRIC TESTS
# =============================================================================

# Wilcoxon Rank-Sum Test (Mann-Whitney U)
# Non-parametric alternative to two-sample t-test
wilcoxon_test <- wilcox.test(group1, group2)
print("Wilcoxon Rank-Sum Test:")
print(wilcoxon_test)

# Kruskal-Wallis Test
# Non-parametric alternative to one-way ANOVA
kruskal_test <- kruskal.test(score ~ group, data = anova_data)
print("Kruskal-Wallis Test:")
print(kruskal_test)

# =============================================================================
# 11. EFFECT SIZE CALCULATIONS
# =============================================================================

# Cohen's d for t-tests
cohens_d <- function(x, y) {
  n1 <- length(x)
  n2 <- length(y)
  pooled_sd <- sqrt(((n1 - 1) * var(x) + (n2 - 1) * var(y)) / (n1 + n2 - 2))
  return((mean(x) - mean(y)) / pooled_sd)
}

d_effect <- cohens_d(group1, group2)
cat("Cohen's d:", round(d_effect, 3), "\n")

# Cramér's V for chi-square test
cramers_v <- function(chi_square, n, min_dim) {
  return(sqrt(chi_square / (n * (min_dim - 1))))
}

chi_square_value <- chi_square_test$statistic
n_total <- sum(contingency_table)
min_dim <- min(nrow(contingency_table), ncol(contingency_table))
cramers_v_value <- cramers_v(chi_square_value, n_total, min_dim)

cat("Cramér's V:", round(cramers_v_value, 3), "\n")

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Perform a one-sample t-test to test if the mean
# of a sample is significantly different from 50

# Exercise 2: Create two groups of data and perform a two-sample t-test
# to compare their means

# Exercise 3: Create a contingency table with two categorical variables
# and perform a chi-square test of independence

# Exercise 4: Create three groups of data and perform a one-way ANOVA
# followed by post-hoc tests if significant

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
sample_data <- rnorm(30, mean = 52, sd = 8)
one_sample_exercise <- t.test(sample_data, mu = 50)
print("Exercise 1 - One-Sample T-Test:")
print(one_sample_exercise)

# Solution 2:
group_a <- rnorm(25, mean = 75, sd = 10)
group_b <- rnorm(25, mean = 80, sd = 10)
two_sample_exercise <- t.test(group_a, group_b)
print("Exercise 2 - Two-Sample T-Test:")
print(two_sample_exercise)

# Solution 3:
exercise_data <- data.frame(
  gender = rep(c("Male", "Female"), each = 50),
  preference = c(rep(c("Option A", "Option B"), c(30, 20)),
           rep(c("Option A", "Option B"), c(25, 25))
)
exercise_table <- table(exercise_data$gender, exercise_data$preference)
chi_square_exercise <- chisq.test(exercise_table)
print("Exercise 3 - Chi-Square Test:")
print(chi_square_exercise)

# Solution 4:
exercise_anova_data <- data.frame(
  group = rep(c("A", "B", "C"), each = 20),
  value = c(rnorm(20, mean = 70, sd = 8),
           rnorm(20, mean = 75, sd = 8),
           rnorm(20, mean = 80, sd = 8))
)
exercise_anova <- aov(value ~ group, data = exercise_anova_data)
print("Exercise 4 - One-Way ANOVA:")
print(summary(exercise_anova))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. t.test() for comparing means
# 2. chisq.test() for testing independence and goodness of fit
# 3. aov() for one-way ANOVA
# 4. TukeyHSD() for post-hoc tests
# 5. cor.test() for correlation tests
# 6. wilcox.test() and kruskal.test() for non-parametric tests
# 7. Always check assumptions before performing tests
# 8. Report effect sizes along with p-values
# 9. Use appropriate multiple comparison corrections
# 10. Interpret results in context of your research question

# Next: Move to 10_Correlation_Regression.R to learn about relationships!
