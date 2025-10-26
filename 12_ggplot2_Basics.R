# Module 3: ggplot2 Basics
# File: 12_ggplot2_Basics.R

# =============================================================================
# INTRODUCTION TO GGPLOT2
# =============================================================================

# ggplot2 is a powerful and flexible plotting system for R
# This lesson covers the basics of creating beautiful plots with ggplot2

# =============================================================================
# 1. INSTALLING AND LOADING GGPLOT2
# =============================================================================

# Install ggplot2 if not already installed
# install.packages("ggplot2")

# Load the library
library(ggplot2)

# =============================================================================
# 2. CREATING SAMPLE DATA
# =============================================================================

# Create sample datasets for plotting
set.seed(123)

# Basic dataset
basic_data <- data.frame(
  x = 1:20,
  y = 2 * (1:20) + rnorm(20, mean = 0, sd = 5),
  category = sample(c("A", "B", "C"), 20, replace = TRUE),
  value = rnorm(20, mean = 50, sd = 15)
)

# Time series dataset
time_data <- data.frame(
  date = seq(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "month"),
  sales = cumsum(rnorm(12, mean = 100, sd = 20)),
  region = rep(c("North", "South", "East", "West"), 3)
)

# Categorical dataset
categorical_data <- data.frame(
  product = rep(c("Product A", "Product B", "Product C"), each = 10),
  sales = c(rnorm(10, mean = 100, sd = 20),
           rnorm(10, mean = 120, sd = 25),
           rnorm(10, mean = 80, sd = 15)),
  quarter = rep(c("Q1", "Q2", "Q3", "Q4"), each = 7.5)
)

print(head(basic_data))

# =============================================================================
# 3. BASIC GGPLOT2 SYNTAX
# =============================================================================

# Basic ggplot2 syntax:
# ggplot(data, aes(x = x_var, y = y_var)) + geom_function()

# Basic scatter plot
basic_plot <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_point()

print(basic_plot)

# =============================================================================
# 4. SCATTER PLOTS
# =============================================================================

# Scatter plot with customization
scatter_plot <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_point(size = 3, color = "blue", alpha = 0.7) +
  labs(title = "Scatter Plot",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(scatter_plot)

# Scatter plot with different colors for categories
scatter_categorical <- ggplot(basic_data, aes(x = x, y = y, color = category)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Scatter Plot by Category",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(scatter_categorical)

# =============================================================================
# 5. LINE PLOTS
# =============================================================================

# Basic line plot
line_plot <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Line Plot",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(line_plot)

# Line plot with points
line_point_plot <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Line Plot with Points",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(line_point_plot)

# =============================================================================
# 6. BAR PLOTS
# =============================================================================

# Basic bar plot
bar_plot <- ggplot(basic_data, aes(x = category)) +
  geom_bar() +
  labs(title = "Bar Plot",
       x = "Category",
       y = "Count") +
  theme_minimal()

print(bar_plot)

# Bar plot with custom colors
bar_colored <- ggplot(basic_data, aes(x = category, fill = category)) +
  geom_bar() +
  labs(title = "Bar Plot with Colors",
       x = "Category",
       y = "Count") +
  theme_minimal() +
  scale_fill_manual(values = c("A" = "red", "B" = "green", "C" = "blue"))

print(bar_colored)

# =============================================================================
# 7. HISTOGRAMS
# =============================================================================

# Basic histogram
histogram_plot <- ggplot(basic_data, aes(x = value)) +
  geom_histogram(bins = 10, fill = "lightblue", color = "black") +
  labs(title = "Histogram",
       x = "Values",
       y = "Frequency") +
  theme_minimal()

print(histogram_plot)

# Histogram with density curve
histogram_density <- ggplot(basic_data, aes(x = value)) +
  geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", color = "black") +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram with Density Curve",
       x = "Values",
       y = "Density") +
  theme_minimal()

print(histogram_density)

# =============================================================================
# 8. BOX PLOTS
# =============================================================================

# Basic box plot
box_plot <- ggplot(basic_data, aes(x = category, y = value)) +
  geom_boxplot() +
  labs(title = "Box Plot",
       x = "Category",
       y = "Values") +
  theme_minimal()

print(box_plot)

# Box plot with custom colors
box_colored <- ggplot(basic_data, aes(x = category, y = value, fill = category)) +
  geom_boxplot() +
  labs(title = "Box Plot with Colors",
       x = "Category",
       y = "Values") +
  theme_minimal() +
  scale_fill_manual(values = c("A" = "lightcoral", "B" = "lightgreen", "C" = "lightblue"))

print(box_colored)

# =============================================================================
# 9. FACETING
# =============================================================================

# Facet by category
facet_plot <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~category) +
  labs(title = "Faceted Scatter Plot",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(facet_plot)

# Facet by category with different scales
facet_free <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~category, scales = "free") +
  labs(title = "Faceted Plot with Free Scales",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(facet_free)

# =============================================================================
# 10. CUSTOMIZING THEMES
# =============================================================================

# Custom theme
custom_plot <- ggplot(basic_data, aes(x = x, y = y, color = category)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Customized Plot",
       x = "X Values",
       y = "Y Values") +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10),
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_line(color = "grey95")
  )

print(custom_plot)

# =============================================================================
# 11. SAVING PLOTS
# =============================================================================

# Save plot as PNG
ggsave("my_ggplot.png", plot = custom_plot, width = 10, height = 6, dpi = 300)

# Save plot as PDF
ggsave("my_ggplot.pdf", plot = custom_plot, width = 10, height = 6)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a scatter plot with different colors
# for different categories and add a trend line

# Exercise 2: Create a bar plot showing the count of each category
# with custom colors

# Exercise 3: Create a box plot comparing values across categories
# with a custom theme

# Exercise 4: Create a faceted plot showing the relationship
# between x and y for each category

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
exercise_plot1 <- ggplot(basic_data, aes(x = x, y = y, color = category)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Exercise 1 - Scatter Plot with Trend Line",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(exercise_plot1)

# Solution 2:
exercise_plot2 <- ggplot(basic_data, aes(x = category, fill = category)) +
  geom_bar() +
  labs(title = "Exercise 2 - Bar Plot with Custom Colors",
       x = "Category",
       y = "Count") +
  theme_minimal() +
  scale_fill_manual(values = c("A" = "coral", "B" = "forestgreen", "C" = "dodgerblue"))

print(exercise_plot2)

# Solution 3:
exercise_plot3 <- ggplot(basic_data, aes(x = category, y = value, fill = category)) +
  geom_boxplot() +
  labs(title = "Exercise 3 - Box Plot with Custom Theme",
       x = "Category",
       y = "Values") +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "grey90")
  ) +
  scale_fill_manual(values = c("A" = "lightcoral", "B" = "lightgreen", "C" = "lightblue"))

print(exercise_plot3)

# Solution 4:
exercise_plot4 <- ggplot(basic_data, aes(x = x, y = y)) +
  geom_point(size = 2, alpha = 0.7) +
  facet_wrap(~category) +
  labs(title = "Exercise 4 - Faceted Plot",
       x = "X Values",
       y = "Y Values") +
  theme_minimal()

print(exercise_plot4)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. ggplot2 uses a layered approach to building plots
# 2. Start with ggplot() and add layers with +
# 3. Use aes() to map variables to aesthetics
# 4. Different geom functions create different plot types
# 5. Use labs() to add titles and labels
# 6. Use theme functions to customize appearance
# 7. Use facet_wrap() or facet_grid() for faceting
# 8. Use ggsave() to save plots
# 9. Always specify data and aesthetics in ggplot()
# 10. Build plots layer by layer for maximum flexibility

# Next: Move to 13_Advanced_Visualizations.R to learn about advanced plotting!
