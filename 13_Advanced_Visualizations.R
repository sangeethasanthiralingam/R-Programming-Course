# Module 3: Advanced Visualizations
# File: 13_Advanced_Visualizations.R

# =============================================================================
# ADVANCED VISUALIZATION TECHNIQUES IN R
# =============================================================================

# This lesson covers advanced plotting techniques and specialized plots
# for more sophisticated data visualization

# =============================================================================
# 1. LOADING REQUIRED LIBRARIES
# =============================================================================

library(ggplot2)
library(dplyr)
library(reshape2)

# =============================================================================
# 2. CREATING COMPLEX SAMPLE DATA
# =============================================================================

set.seed(123)

# Create comprehensive dataset
advanced_data <- data.frame(
  id = 1:100,
  age = sample(18:65, 100, replace = TRUE),
  income = rnorm(100, mean = 50000, sd = 15000),
  education = sample(c("High School", "Bachelor's", "Master's", "PhD"), 100, replace = TRUE),
  department = sample(c("IT", "HR", "Finance", "Marketing", "Sales"), 100, replace = TRUE),
  experience = sample(0:20, 100, replace = TRUE),
  performance = rnorm(100, mean = 75, sd = 15),
  satisfaction = sample(1:10, 100, replace = TRUE)
)

# Add some correlations
advanced_data$income <- advanced_data$income + advanced_data$experience * 2000
advanced_data$performance <- advanced_data$performance + advanced_data$satisfaction * 2

print(head(advanced_data))

# =============================================================================
# 3. HEATMAPS
# =============================================================================

# Create correlation matrix
numeric_data <- advanced_data[, c("age", "income", "experience", "performance", "satisfaction")]
correlation_matrix <- cor(numeric_data)

# Convert to long format for ggplot2
correlation_long <- melt(correlation_matrix)

# Create heatmap
heatmap_plot <- ggplot(correlation_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "white", size = 3) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  labs(title = "Correlation Heatmap",
       x = "Variables",
       y = "Variables") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(heatmap_plot)

# =============================================================================
# 4. VIOLIN PLOTS
# =============================================================================

# Violin plot
violin_plot <- ggplot(advanced_data, aes(x = department, y = income, fill = department)) +
  geom_violin() +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(title = "Income Distribution by Department",
       x = "Department",
       y = "Income") +
  theme_minimal() +
  theme(legend.position = "none")

print(violin_plot)

# =============================================================================
# 5. DENSITY PLOTS
# =============================================================================

# Density plot
density_plot <- ggplot(advanced_data, aes(x = income, fill = department)) +
  geom_density(alpha = 0.7) +
  labs(title = "Income Distribution by Department",
       x = "Income",
       y = "Density") +
  theme_minimal() +
  facet_wrap(~department)

print(density_plot)

# =============================================================================
# 6. RIDGE PLOTS
# =============================================================================

# Install and load ggridges if not available
# install.packages("ggridges")
library(ggridges)

# Ridge plot
ridge_plot <- ggplot(advanced_data, aes(x = income, y = department, fill = department)) +
  geom_density_ridges(alpha = 0.7) +
  labs(title = "Income Distribution by Department (Ridge Plot)",
       x = "Income",
       y = "Department") +
  theme_minimal() +
  theme(legend.position = "none")

print(ridge_plot)

# =============================================================================
# 7. BUBBLE PLOTS
# =============================================================================

# Create bubble plot data
bubble_data <- advanced_data %>%
  group_by(department, education) %>%
  summarise(
    avg_income = mean(income),
    avg_performance = mean(performance),
    count = n()
  )

# Bubble plot
bubble_plot <- ggplot(bubble_data, aes(x = department, y = education)) +
  geom_point(aes(size = count, color = avg_income), alpha = 0.7) +
  scale_size_continuous(range = c(3, 15)) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Bubble Plot: Department vs Education",
       x = "Department",
       y = "Education",
       size = "Count",
       color = "Avg Income") +
  theme_minimal()

print(bubble_plot)

# =============================================================================
# 8. STACKED BAR PLOTS
# =============================================================================

# Stacked bar plot
stacked_bar <- ggplot(advanced_data, aes(x = department, fill = education)) +
  geom_bar(position = "stack") +
  labs(title = "Education Distribution by Department",
       x = "Department",
       y = "Count",
       fill = "Education") +
  theme_minimal()

print(stacked_bar)

# Percentage stacked bar plot
percent_stacked_bar <- ggplot(advanced_data, aes(x = department, fill = education)) +
  geom_bar(position = "fill") +
  labs(title = "Education Distribution by Department (Percentage)",
       x = "Department",
       y = "Percentage",
       fill = "Education") +
  theme_minimal()

print(percent_stacked_bar)

# =============================================================================
# 9. MULTI-PANEL PLOTS
# =============================================================================

# Create multiple plots
plot1 <- ggplot(advanced_data, aes(x = age, y = income)) +
  geom_point(alpha = 0.6) +
  labs(title = "Age vs Income", x = "Age", y = "Income") +
  theme_minimal()

plot2 <- ggplot(advanced_data, aes(x = experience, y = performance)) +
  geom_point(alpha = 0.6) +
  labs(title = "Experience vs Performance", x = "Experience", y = "Performance") +
  theme_minimal()

plot3 <- ggplot(advanced_data, aes(x = satisfaction, y = performance)) +
  geom_point(alpha = 0.6) +
  labs(title = "Satisfaction vs Performance", x = "Satisfaction", y = "Performance") +
  theme_minimal()

plot4 <- ggplot(advanced_data, aes(x = department, y = income)) +
  geom_boxplot() +
  labs(title = "Income by Department", x = "Department", y = "Income") +
  theme_minimal()

# Combine plots using gridExtra
# install.packages("gridExtra")
library(gridExtra)

combined_plot <- grid.arrange(plot1, plot2, plot3, plot4, ncol = 2)
print(combined_plot)

# =============================================================================
# 10. INTERACTIVE PLOTS
# =============================================================================

# Install and load plotly for interactive plots
# install.packages("plotly")
library(plotly)

# Create interactive scatter plot
interactive_plot <- plot_ly(advanced_data, 
                           x = ~age, 
                           y = ~income,
                           color = ~department,
                           size = ~performance,
                           text = ~paste("ID:", id, "<br>Experience:", experience),
                           hoverinfo = "text") %>%
  add_markers() %>%
  layout(title = "Interactive Scatter Plot",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Income"))

print(interactive_plot)

# =============================================================================
# 11. CUSTOM ANNOTATIONS
# =============================================================================

# Create plot with custom annotations
annotated_plot <- ggplot(advanced_data, aes(x = age, y = income)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  annotate("text", x = 30, y = 80000, 
           label = "Positive Correlation", 
           color = "red", size = 4) +
  annotate("rect", xmin = 20, xmax = 30, ymin = 70000, ymax = 90000,
           alpha = 0.2, fill = "yellow") +
  labs(title = "Age vs Income with Annotations",
       x = "Age",
       y = "Income") +
  theme_minimal()

print(annotated_plot)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a heatmap showing the relationship between
# different numeric variables in your dataset

# Exercise 2: Create a violin plot comparing income distribution
# across different education levels

# Exercise 3: Create a bubble plot where the size represents
# the count and color represents the average performance

# Exercise 4: Create a multi-panel plot showing different
# relationships in your data

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
exercise_data <- advanced_data[, c("age", "income", "experience", "performance", "satisfaction")]
exercise_cor <- cor(exercise_data)
exercise_cor_long <- melt(exercise_cor)

exercise_heatmap <- ggplot(exercise_cor_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "white", size = 3) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  labs(title = "Exercise 1 - Correlation Heatmap") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(exercise_heatmap)

# Solution 2:
exercise_violin <- ggplot(advanced_data, aes(x = education, y = income, fill = education)) +
  geom_violin() +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(title = "Exercise 2 - Income Distribution by Education",
       x = "Education",
       y = "Income") +
  theme_minimal() +
  theme(legend.position = "none")

print(exercise_violin)

# Solution 3:
exercise_bubble_data <- advanced_data %>%
  group_by(department, education) %>%
  summarise(
    avg_performance = mean(performance),
    count = n()
  )

exercise_bubble <- ggplot(exercise_bubble_data, aes(x = department, y = education)) +
  geom_point(aes(size = count, color = avg_performance), alpha = 0.7) +
  scale_size_continuous(range = c(3, 15)) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Exercise 3 - Bubble Plot",
       x = "Department",
       y = "Education",
       size = "Count",
       color = "Avg Performance") +
  theme_minimal()

print(exercise_bubble)

# Solution 4:
exercise_plot1 <- ggplot(advanced_data, aes(x = age, y = income)) +
  geom_point(alpha = 0.6) +
  labs(title = "Age vs Income", x = "Age", y = "Income") +
  theme_minimal()

exercise_plot2 <- ggplot(advanced_data, aes(x = experience, y = performance)) +
  geom_point(alpha = 0.6) +
  labs(title = "Experience vs Performance", x = "Experience", y = "Performance") +
  theme_minimal()

exercise_combined <- grid.arrange(exercise_plot1, exercise_plot2, ncol = 2)
print(exercise_combined)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Heatmaps are great for showing correlations and patterns
# 2. Violin plots show distribution shape better than box plots
# 3. Ridge plots are excellent for comparing distributions
# 4. Bubble plots can show three dimensions of data
# 5. Stacked bar plots show composition and proportions
# 6. Multi-panel plots help compare multiple relationships
# 7. Interactive plots enhance data exploration
# 8. Custom annotations can highlight important insights
# 9. Always choose the right plot type for your data
# 10. Consider your audience when designing visualizations

# Next: Move to 14_Interactive_Plots.R to learn about interactive visualizations!
