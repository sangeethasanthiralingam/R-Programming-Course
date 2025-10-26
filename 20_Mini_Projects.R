# Module 5: Mini Projects
# File: 20_Mini_Projects.R

# =============================================================================
# MINI PROJECTS TO PRACTICE R SKILLS
# =============================================================================

# This file contains small projects that combine multiple R concepts
# to help you practice and reinforce your learning

# =============================================================================
# PROJECT 1: STUDENT GRADE ANALYZER
# =============================================================================

# Create sample student data
set.seed(123)
student_data <- data.frame(
  student_id = 1:50,
  name = paste("Student", 1:50),
  math_score = rnorm(50, mean = 75, sd = 15),
  science_score = rnorm(50, mean = 80, sd = 12),
  english_score = rnorm(50, mean = 70, sd = 18),
  attendance = sample(80:100, 50, replace = TRUE),
  study_hours = sample(5:25, 50, replace = TRUE)
)

# Add some correlations
student_data$math_score <- student_data$math_score + student_data$study_hours * 0.5
student_data$science_score <- student_data$science_score + student_data$study_hours * 0.3
student_data$english_score <- student_data$english_score + student_data$study_hours * 0.2

# Calculate average score
student_data$average_score <- (student_data$math_score + student_data$science_score + student_data$english_score) / 3

# Assign letter grades
student_data$letter_grade <- ifelse(student_data$average_score >= 90, "A",
                                   ifelse(student_data$average_score >= 80, "B",
                                         ifelse(student_data$average_score >= 70, "C",
                                               ifelse(student_data$average_score >= 60, "D", "F"))))

print("Student Data Sample:")
print(head(student_data))

# Analyze the data
library(ggplot2)
library(dplyr)

# Grade distribution
grade_distribution <- table(student_data$letter_grade)
print("Grade Distribution:")
print(grade_distribution)

# Create visualizations
# Grade distribution bar plot
grade_plot <- ggplot(student_data, aes(x = letter_grade, fill = letter_grade)) +
  geom_bar() +
  labs(title = "Grade Distribution",
       x = "Letter Grade",
       y = "Number of Students") +
  theme_minimal() +
  theme(legend.position = "none")

print(grade_plot)

# Study hours vs average score
study_plot <- ggplot(student_data, aes(x = study_hours, y = average_score)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Study Hours vs Average Score",
       x = "Study Hours per Week",
       y = "Average Score") +
  theme_minimal()

print(study_plot)

# =============================================================================
# PROJECT 2: SALES DATA ANALYZER
# =============================================================================

# Create sample sales data
set.seed(456)
sales_data <- data.frame(
  date = seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "day"),
  product = sample(c("Product A", "Product B", "Product C", "Product D"), 365, replace = TRUE),
  sales_amount = rnorm(365, mean = 1000, sd = 300),
  units_sold = sample(1:50, 365, replace = TRUE),
  region = sample(c("North", "South", "East", "West"), 365, replace = TRUE)
)

# Add some seasonality
sales_data$sales_amount <- sales_data$sales_amount + 
  ifelse(month(sales_data$date) %in% c(11, 12), 200, 0) +  # Holiday season
  ifelse(month(sales_data$date) %in% c(6, 7, 8), 100, 0)  # Summer season

# Calculate daily revenue
sales_data$daily_revenue <- sales_data$sales_amount * sales_data$units_sold

print("Sales Data Sample:")
print(head(sales_data))

# Monthly sales summary
monthly_sales <- sales_data %>%
  mutate(month = month(date)) %>%
  group_by(month) %>%
  summarise(
    total_revenue = sum(daily_revenue),
    avg_daily_sales = mean(sales_amount),
    total_units = sum(units_sold)
  )

print("Monthly Sales Summary:")
print(monthly_sales)

# Create visualizations
# Monthly revenue trend
monthly_plot <- ggplot(monthly_sales, aes(x = month, y = total_revenue)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Monthly Revenue Trend",
       x = "Month",
       y = "Total Revenue") +
  theme_minimal()

print(monthly_plot)

# Product performance
product_performance <- sales_data %>%
  group_by(product) %>%
  summarise(
    total_revenue = sum(daily_revenue),
    avg_sales = mean(sales_amount),
    total_units = sum(units_sold)
  ) %>%
  arrange(desc(total_revenue))

print("Product Performance:")
print(product_performance)

# Product performance bar plot
product_plot <- ggplot(product_performance, aes(x = product, y = total_revenue, fill = product)) +
  geom_bar(stat = "identity") +
  labs(title = "Product Performance by Revenue",
       x = "Product",
       y = "Total Revenue") +
  theme_minimal() +
  theme(legend.position = "none")

print(product_plot)

# =============================================================================
# PROJECT 3: WEATHER DATA ANALYZER
# =============================================================================

# Create sample weather data
set.seed(789)
weather_data <- data.frame(
  date = seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "day"),
  temperature = rnorm(365, mean = 20, sd = 10),
  humidity = rnorm(365, mean = 60, sd = 15),
  pressure = rnorm(365, mean = 1013, sd = 20),
  wind_speed = rnorm(365, mean = 10, sd = 5),
  precipitation = rpois(365, lambda = 2)
)

# Add seasonality to temperature
weather_data$temperature <- weather_data$temperature + 
  ifelse(month(weather_data$date) %in% c(12, 1, 2), -5,  # Winter
         ifelse(month(weather_data$date) %in% c(6, 7, 8), 5, 0))  # Summer

# Add weather conditions
weather_data$condition <- ifelse(weather_data$precipitation > 5, "Rainy",
                               ifelse(weather_data$temperature > 25, "Hot",
                                     ifelse(weather_data$temperature < 5, "Cold", "Mild")))

print("Weather Data Sample:")
print(head(weather_data))

# Analyze weather patterns
# Monthly temperature analysis
monthly_weather <- weather_data %>%
  mutate(month = month(date)) %>%
  group_by(month) %>%
  summarise(
    avg_temp = mean(temperature),
    avg_humidity = mean(humidity),
    avg_pressure = mean(pressure),
    total_precipitation = sum(precipitation)
  )

print("Monthly Weather Summary:")
print(monthly_weather)

# Create visualizations
# Temperature trend
temp_plot <- ggplot(weather_data, aes(x = date, y = temperature)) +
  geom_line(color = "red", alpha = 0.7) +
  geom_smooth(method = "loess", se = FALSE, color = "blue") +
  labs(title = "Temperature Trend Over Time",
       x = "Date",
       y = "Temperature (°C)") +
  theme_minimal()

print(temp_plot)

# Weather condition distribution
condition_dist <- table(weather_data$condition)
print("Weather Condition Distribution:")
print(condition_dist)

# Weather condition pie chart
condition_data <- data.frame(
  condition = names(condition_dist),
  count = as.numeric(condition_dist)
)

condition_plot <- ggplot(condition_data, aes(x = "", y = count, fill = condition)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Weather Condition Distribution",
       fill = "Condition") +
  theme_void()

print(condition_plot)

# =============================================================================
# PROJECT 4: CUSTOMER SEGMENTATION
# =============================================================================

# Create sample customer data
set.seed(101112)
customer_data <- data.frame(
  customer_id = 1:200,
  age = sample(18:65, 200, replace = TRUE),
  income = rnorm(200, mean = 50000, sd = 20000),
  spending = rnorm(200, mean = 2000, sd = 800),
  visits = sample(1:20, 200, replace = TRUE),
  satisfaction = sample(1:10, 200, replace = TRUE)
)

# Add some correlations
customer_data$spending <- customer_data$spending + customer_data$income * 0.02
customer_data$spending <- customer_data$spending + customer_data$satisfaction * 100

# Create customer segments
customer_data$segment <- ifelse(customer_data$spending > 2500 & customer_data$visits > 10, "High Value",
                               ifelse(customer_data$spending > 1500 & customer_data$visits > 5, "Medium Value",
                                     ifelse(customer_data$spending > 1000, "Low Value", "Potential")))

print("Customer Data Sample:")
print(head(customer_data))

# Analyze customer segments
segment_analysis <- customer_data %>%
  group_by(segment) %>%
  summarise(
    count = n(),
    avg_age = mean(age),
    avg_income = mean(income),
    avg_spending = mean(spending),
    avg_visits = mean(visits),
    avg_satisfaction = mean(satisfaction)
  )

print("Customer Segment Analysis:")
print(segment_analysis)

# Create visualizations
# Spending by segment
spending_plot <- ggplot(customer_data, aes(x = segment, y = spending, fill = segment)) +
  geom_boxplot() +
  labs(title = "Spending Distribution by Segment",
       x = "Customer Segment",
       y = "Spending Amount") +
  theme_minimal() +
  theme(legend.position = "none")

print(spending_plot)

# Customer scatter plot
scatter_plot <- ggplot(customer_data, aes(x = income, y = spending, color = segment)) +
  geom_point(alpha = 0.7) +
  labs(title = "Income vs Spending by Segment",
       x = "Income",
       y = "Spending",
       color = "Segment") +
  theme_minimal()

print(scatter_plot)

# =============================================================================
# PROJECT 5: STOCK PRICE SIMULATOR
# =============================================================================

# Create sample stock data
set.seed(131415)
stock_data <- data.frame(
  date = seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "day"),
  price = 100  # Starting price
)

# Simulate stock price movement
for (i in 2:nrow(stock_data)) {
  # Random walk with drift
  change <- rnorm(1, mean = 0.001, sd = 0.02)
  stock_data$price[i] <- stock_data$price[i-1] * (1 + change)
}

# Calculate daily returns
stock_data$daily_return <- c(0, diff(stock_data$price) / stock_data$price[-nrow(stock_data)])

# Add some volatility
stock_data$volatility <- rollapply(stock_data$daily_return, width = 30, FUN = sd, fill = NA)

print("Stock Data Sample:")
print(head(stock_data))

# Analyze stock performance
# Monthly performance
monthly_stock <- stock_data %>%
  mutate(month = month(date)) %>%
  group_by(month) %>%
  summarise(
    avg_price = mean(price),
    avg_return = mean(daily_return, na.rm = TRUE),
    volatility = mean(volatility, na.rm = TRUE)
  )

print("Monthly Stock Performance:")
print(monthly_stock)

# Create visualizations
# Stock price trend
price_plot <- ggplot(stock_data, aes(x = date, y = price)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Stock Price Trend",
       x = "Date",
       y = "Price") +
  theme_minimal()

print(price_plot)

# Daily returns histogram
returns_plot <- ggplot(stock_data, aes(x = daily_return)) +
  geom_histogram(bins = 30, fill = "lightblue", color = "black") +
  labs(title = "Daily Returns Distribution",
       x = "Daily Return",
       y = "Frequency") +
  theme_minimal()

print(returns_plot)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Mini projects help integrate multiple R concepts
# 2. Always start with data exploration and cleaning
# 3. Use appropriate visualizations for your data
# 4. Combine different R packages for comprehensive analysis
# 5. Practice with real-world scenarios
# 6. Document your analysis process
# 7. Test your code with different datasets
# 8. Consider edge cases and data quality issues
# 9. Use functions to make your code reusable
# 10. Always validate your results

# Next: Move to 21_Data_Analysis_Project.R for a comprehensive project!
