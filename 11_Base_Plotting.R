# Module 3: Base Plotting
# File: 11_Base_Plotting.R

# =============================================================================
# BASIC PLOTTING WITH BASE R
# =============================================================================

# Base R provides powerful plotting functions
# This lesson covers the fundamental plotting functions in R

# =============================================================================
# 1. CREATING SAMPLE DATA
# =============================================================================

# Create sample datasets for plotting
set.seed(123)

# Numeric data
x <- 1:20
y <- 2 * x + rnorm(20, mean = 0, sd = 5)
z <- rnorm(20, mean = 50, sd = 10)

# Categorical data
categories <- sample(c("A", "B", "C"), 20, replace = TRUE)
values <- rnorm(20, mean = 75, sd = 15)

# Time series data
time <- seq(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "month")
sales <- cumsum(rnorm(12, mean = 100, sd = 20))

# =============================================================================
# 2. SCATTER PLOTS
# =============================================================================

# Basic scatter plot
plot(x, y, main = "Basic Scatter Plot", xlab = "X Values", ylab = "Y Values")

# Scatter plot with different symbols and colors
plot(x, y, 
     main = "Scatter Plot with Customization",
     xlab = "X Values", 
     ylab = "Y Values",
     pch = 16,  # Filled circles
     col = "blue",
     cex = 1.2)  # Size of points

# Scatter plot with different colors for categories
plot(x, y, 
     main = "Scatter Plot by Category",
     xlab = "X Values", 
     ylab = "Y Values",
     pch = 16,
     col = c("red", "green", "blue")[as.numeric(as.factor(categories))])

# =============================================================================
# 3. LINE PLOTS
# =============================================================================

# Basic line plot
plot(x, y, type = "l", main = "Basic Line Plot")

# Line plot with points
plot(x, y, type = "b", main = "Line Plot with Points")

# Multiple lines on same plot
plot(x, y, type = "l", col = "blue", main = "Multiple Lines")
lines(x, z, col = "red")
legend("topright", legend = c("Y", "Z"), col = c("blue", "red"), lty = 1)

# =============================================================================
# 4. BAR PLOTS
# =============================================================================

# Basic bar plot
barplot(table(categories), main = "Basic Bar Plot")

# Horizontal bar plot
barplot(table(categories), horiz = TRUE, main = "Horizontal Bar Plot")

# Bar plot with custom colors
barplot(table(categories), 
        main = "Bar Plot with Colors",
        col = c("red", "green", "blue"),
        xlab = "Categories",
        ylab = "Frequency")

# =============================================================================
# 5. HISTOGRAMS
# =============================================================================

# Basic histogram
hist(y, main = "Basic Histogram", xlab = "Values")

# Histogram with custom breaks
hist(y, breaks = 10, main = "Histogram with 10 Breaks")

# Histogram with density curve
hist(y, freq = FALSE, main = "Histogram with Density Curve")
lines(density(y), col = "red", lwd = 2)

# =============================================================================
# 6. BOX PLOTS
# =============================================================================

# Basic box plot
boxplot(y, main = "Basic Box Plot")

# Box plot by group
boxplot(values ~ categories, main = "Box Plot by Group")

# Box plot with custom colors
boxplot(values ~ categories, 
        main = "Box Plot with Colors",
        col = c("lightblue", "lightgreen", "lightcoral"))

# =============================================================================
# 7. PIE CHARTS
# =============================================================================

# Basic pie chart
pie(table(categories), main = "Basic Pie Chart")

# Pie chart with custom colors and labels
pie(table(categories), 
    main = "Pie Chart with Custom Colors",
    col = c("red", "green", "blue"),
    labels = c("Category A", "Category B", "Category C"))

# =============================================================================
# 8. PLOTTING PARAMETERS
# =============================================================================

# Set plotting parameters
par(mfrow = c(2, 2))  # 2x2 grid of plots

# Create multiple plots
plot(x, y, main = "Plot 1")
plot(x, z, main = "Plot 2")
hist(y, main = "Plot 3")
boxplot(y, main = "Plot 4")

# Reset plotting parameters
par(mfrow = c(1, 1))

# =============================================================================
# 9. CUSTOMIZING PLOTS
# =============================================================================

# Create a highly customized plot
plot(x, y,
     main = "Customized Plot",
     xlab = "X Values",
     ylab = "Y Values",
     pch = 16,
     col = "darkblue",
     cex = 1.5,
     cex.main = 1.5,
     cex.lab = 1.2,
     cex.axis = 1.1,
     lwd = 2,
     xlim = c(0, 25),
     ylim = c(0, 50))

# Add grid
grid()

# Add text annotation
text(10, 40, "Important Point", col = "red", cex = 1.2)

# Add arrows
arrows(15, 35, 18, 38, col = "red", lwd = 2)

# =============================================================================
# 10. TIME SERIES PLOTS
# =============================================================================

# Basic time series plot
plot(time, sales, type = "l", main = "Sales Over Time")

# Time series with points
plot(time, sales, type = "b", main = "Sales Over Time with Points")

# =============================================================================
# 11. MULTIPLE PLOTS ON SAME GRAPH
# =============================================================================

# Create data for multiple variables
var1 <- rnorm(20, mean = 50, sd = 10)
var2 <- rnorm(20, mean = 60, sd = 15)
var3 <- rnorm(20, mean = 55, sd = 12)

# Plot multiple variables
plot(x, var1, type = "l", col = "blue", ylim = c(20, 80))
lines(x, var2, col = "red")
lines(x, var3, col = "green")
legend("topright", legend = c("Var1", "Var2", "Var3"), 
       col = c("blue", "red", "green"), lty = 1)

# =============================================================================
# 12. SAVING PLOTS
# =============================================================================

# Save plot as PNG
png("my_plot.png", width = 800, height = 600)
plot(x, y, main = "Saved Plot")
dev.off()

# Save plot as PDF
pdf("my_plot.pdf", width = 8, height = 6)
plot(x, y, main = "Saved Plot")
dev.off()

# =============================================================================
# 13. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a scatter plot of two variables with
# different colors for different categories

# Exercise 2: Create a histogram with a density curve overlay

# Exercise 3: Create a box plot comparing three groups

# Exercise 4: Create a time series plot with multiple lines

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
exercise_data <- data.frame(
  x = rnorm(30, mean = 50, sd = 10),
  y = rnorm(30, mean = 60, sd = 15),
  group = sample(c("Group1", "Group2", "Group3"), 30, replace = TRUE)
)

plot(exercise_data$x, exercise_data$y,
     main = "Exercise 1 - Scatter Plot by Group",
     xlab = "X Values",
     ylab = "Y Values",
     pch = 16,
     col = c("red", "green", "blue")[as.numeric(as.factor(exercise_data$group))])

# Solution 2:
hist(exercise_data$y, freq = FALSE, main = "Exercise 2 - Histogram with Density")
lines(density(exercise_data$y), col = "red", lwd = 2)

# Solution 3:
boxplot(exercise_data$y ~ exercise_data$group,
        main = "Exercise 3 - Box Plot by Group",
        col = c("lightblue", "lightgreen", "lightcoral"))

# Solution 4:
time_exercise <- 1:12
value1 <- cumsum(rnorm(12, mean = 10, sd = 5))
value2 <- cumsum(rnorm(12, mean = 8, sd = 3))

plot(time_exercise, value1, type = "l", col = "blue", main = "Exercise 4 - Time Series")
lines(time_exercise, value2, col = "red")
legend("topright", legend = c("Value1", "Value2"), col = c("blue", "red"), lty = 1)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. plot() is the main function for creating plots
# 2. Use type parameter to control plot type ("p", "l", "b", "h", "s")
# 3. Customize with col, pch, cex, main, xlab, ylab
# 4. Use par() to set global plotting parameters
# 5. Add elements with lines(), points(), text(), arrows()
# 6. Use legend() to add legends
# 7. Save plots with png(), pdf(), jpeg(), etc.
# 8. Always add meaningful titles and labels
# 9. Use appropriate colors and symbols
# 10. Consider your audience when choosing plot types

# Next: Move to 12_ggplot2_Basics.R to learn about ggplot2!
