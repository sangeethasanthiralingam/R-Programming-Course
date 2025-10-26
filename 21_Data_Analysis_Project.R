# Module 5: Comprehensive Data Analysis Project
# File: 21_Data_Analysis_Project.R

# =============================================================================
# COMPREHENSIVE DATA ANALYSIS PROJECT
# =============================================================================

# This project demonstrates a complete data analysis workflow
# from data collection to insights and recommendations

# =============================================================================
# 1. PROJECT OVERVIEW
# =============================================================================

# Project: E-commerce Customer Analysis
# Objective: Analyze customer behavior and identify opportunities for improvement
# Data: Simulated e-commerce dataset with customer transactions

# =============================================================================
# 2. LOADING REQUIRED LIBRARIES
# =============================================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(lubridate)
library(corrplot)
library(gridExtra)

# =============================================================================
# 3. DATA GENERATION AND LOADING
# =============================================================================

# Set seed for reproducibility
set.seed(12345)

# Generate comprehensive e-commerce data
n_customers <- 1000
n_products <- 50
n_transactions <- 5000

# Customer data
customers <- data.frame(
  customer_id = 1:n_customers,
  age = sample(18:65, n_customers, replace = TRUE),
  gender = sample(c("Male", "Female"), n_customers, replace = TRUE),
  income = rnorm(n_customers, mean = 50000, sd = 20000),
  city = sample(c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix"), n_customers, replace = TRUE),
  registration_date = sample(seq(as.Date("2020-01-01"), as.Date("2023-01-01"), by = "day"), n_customers, replace = TRUE)
)

# Product data
products <- data.frame(
  product_id = 1:n_products,
  product_name = paste("Product", 1:n_products),
  category = sample(c("Electronics", "Clothing", "Books", "Home", "Sports"), n_products, replace = TRUE),
  price = runif(n_products, 10, 500),
  cost = runif(n_products, 5, 250)
)

# Transaction data
transactions <- data.frame(
  transaction_id = 1:n_transactions,
  customer_id = sample(1:n_customers, n_transactions, replace = TRUE),
  product_id = sample(1:n_products, n_transactions, replace = TRUE),
  quantity = sample(1:5, n_transactions, replace = TRUE),
  transaction_date = sample(seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"), n_transactions, replace = TRUE)
)

# Add some realistic patterns
# Higher income customers buy more expensive products
transactions$product_id <- ifelse(customers$income[transactions$customer_id] > 60000, 
                                 sample(1:n_products, n_transactions, replace = TRUE, prob = products$price/max(products$price)),
                                 transactions$product_id)

# Calculate transaction values
transactions$unit_price <- products$price[transactions$product_id]
transactions$total_amount <- transactions$quantity * transactions$unit_price

# Add some seasonality
transactions$total_amount <- transactions$total_amount * 
  ifelse(month(transactions$transaction_date) %in% c(11, 12), 1.2, 1)  # Holiday season

print("Data Overview:")
print(paste("Customers:", nrow(customers)))
print(paste("Products:", nrow(products)))
print(paste("Transactions:", nrow(transactions)))

# =============================================================================
# 4. DATA EXPLORATION AND CLEANING
# =============================================================================

# Check for missing values
print("Missing Values Check:")
print(paste("Customers missing values:", sum(is.na(customers))))
print(paste("Products missing values:", sum(is.na(products))))
print(paste("Transactions missing values:", sum(is.na(transactions))))

# Check data types
print("Data Types:")
print(str(customers))
print(str(products))
print(str(transactions))

# Basic statistics
print("Customer Data Summary:")
print(summary(customers))

print("Product Data Summary:")
print(summary(products))

print("Transaction Data Summary:")
print(summary(transactions))

# =============================================================================
# 5. CUSTOMER ANALYSIS
# =============================================================================

# Customer transaction summary
customer_summary <- transactions %>%
  group_by(customer_id) %>%
  summarise(
    total_transactions = n(),
    total_spent = sum(total_amount),
    avg_transaction_value = mean(total_amount),
    first_purchase = min(transaction_date),
    last_purchase = max(transaction_date),
    days_since_last_purchase = as.numeric(Sys.Date() - max(transaction_date))
  ) %>%
  left_join(customers, by = "customer_id")

print("Customer Summary Sample:")
print(head(customer_summary))

# Customer segmentation
customer_summary$segment <- ifelse(customer_summary$total_spent > 2000, "High Value",
                                  ifelse(customer_summary$total_spent > 1000, "Medium Value",
                                        ifelse(customer_summary$total_spent > 500, "Low Value", "Potential")))

# Segment analysis
segment_analysis <- customer_summary %>%
  group_by(segment) %>%
  summarise(
    count = n(),
    percentage = n() / nrow(customer_summary) * 100,
    avg_spent = mean(total_spent),
    avg_transactions = mean(total_transactions),
    avg_age = mean(age),
    avg_income = mean(income)
  )

print("Customer Segment Analysis:")
print(segment_analysis)

# =============================================================================
# 6. PRODUCT ANALYSIS
# =============================================================================

# Product performance
product_performance <- transactions %>%
  group_by(product_id) %>%
  summarise(
    total_sales = sum(total_amount),
    total_quantity = sum(quantity),
    total_transactions = n(),
    avg_price = mean(unit_price),
    profit_margin = mean(unit_price - products$cost[product_id])
  ) %>%
  left_join(products, by = "product_id") %>%
  arrange(desc(total_sales))

print("Top 10 Products by Sales:")
print(head(product_performance, 10))

# Category analysis
category_analysis <- product_performance %>%
  group_by(category) %>%
  summarise(
    total_sales = sum(total_sales),
    total_quantity = sum(total_quantity),
    avg_price = mean(avg_price),
    profit_margin = mean(profit_margin),
    product_count = n()
  ) %>%
  arrange(desc(total_sales))

print("Category Analysis:")
print(category_analysis)

# =============================================================================
# 7. TEMPORAL ANALYSIS
# =============================================================================

# Monthly sales analysis
monthly_sales <- transactions %>%
  mutate(month = month(transaction_date)) %>%
  group_by(month) %>%
  summarise(
    total_sales = sum(total_amount),
    total_transactions = n(),
    avg_transaction_value = mean(total_amount),
    unique_customers = n_distinct(customer_id)
  )

print("Monthly Sales Analysis:")
print(monthly_sales)

# Daily sales pattern
daily_sales <- transactions %>%
  mutate(day_of_week = weekdays(transaction_date)) %>%
  group_by(day_of_week) %>%
  summarise(
    total_sales = sum(total_amount),
    total_transactions = n(),
    avg_transaction_value = mean(total_amount)
  )

print("Daily Sales Pattern:")
print(daily_sales)

# =============================================================================
# 8. VISUALIZATIONS
# =============================================================================

# Customer segment distribution
segment_plot <- ggplot(customer_summary, aes(x = segment, fill = segment)) +
  geom_bar() +
  labs(title = "Customer Segment Distribution",
       x = "Segment",
       y = "Number of Customers") +
  theme_minimal() +
  theme(legend.position = "none")

print(segment_plot)

# Spending by segment
spending_plot <- ggplot(customer_summary, aes(x = segment, y = total_spent, fill = segment)) +
  geom_boxplot() +
  labs(title = "Spending Distribution by Segment",
       x = "Segment",
       y = "Total Spent") +
  theme_minimal() +
  theme(legend.position = "none")

print(spending_plot)

# Monthly sales trend
monthly_plot <- ggplot(monthly_sales, aes(x = month, y = total_sales)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Monthly Sales Trend",
       x = "Month",
       y = "Total Sales") +
  theme_minimal()

print(monthly_plot)

# Product category performance
category_plot <- ggplot(category_analysis, aes(x = reorder(category, total_sales), y = total_sales, fill = category)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Sales by Product Category",
       x = "Category",
       y = "Total Sales") +
  theme_minimal() +
  theme(legend.position = "none")

print(category_plot)

# Customer age vs spending
age_spending_plot <- ggplot(customer_summary, aes(x = age, y = total_spent, color = segment)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Customer Age vs Total Spending",
       x = "Age",
       y = "Total Spent",
       color = "Segment") +
  theme_minimal()

print(age_spending_plot)

# =============================================================================
# 9. CORRELATION ANALYSIS
# =============================================================================

# Customer correlation matrix
customer_corr <- customer_summary %>%
  select(age, income, total_transactions, total_spent, avg_transaction_value) %>%
  cor(use = "complete.obs")

print("Customer Correlation Matrix:")
print(customer_corr)

# Correlation plot
corrplot(customer_corr, method = "color", type = "upper", 
         order = "hclust", tl.cex = 0.8, tl.col = "black")

# =============================================================================
# 10. INSIGHTS AND RECOMMENDATIONS
# =============================================================================

# Key insights
print("KEY INSIGHTS:")
print("1. Customer Segmentation:")
print(paste("   - High Value customers:", round(segment_analysis$percentage[segment_analysis$segment == "High Value"], 1), "%"))
print(paste("   - Medium Value customers:", round(segment_analysis$percentage[segment_analysis$segment == "Medium Value"], 1), "%"))
print(paste("   - Low Value customers:", round(segment_analysis$percentage[segment_analysis$segment == "Low Value"], 1), "%"))

print("2. Product Performance:")
print(paste("   - Top category:", category_analysis$category[1]))
print(paste("   - Average profit margin:", round(mean(product_performance$profit_margin), 2)))

print("3. Temporal Patterns:")
print(paste("   - Best month:", month.name[monthly_sales$month[which.max(monthly_sales$total_sales)]]))
print(paste("   - Best day:", daily_sales$day_of_week[which.max(daily_sales$total_sales)]))

# Recommendations
print("RECOMMENDATIONS:")
print("1. Focus on High Value customers - they represent the highest revenue potential")
print("2. Develop targeted marketing campaigns for Medium Value customers to upgrade them")
print("3. Analyze the top-performing product category for expansion opportunities")
print("4. Implement retention strategies for customers who haven't purchased recently")
print("5. Consider seasonal promotions during peak months")

# =============================================================================
# 11. EXPORT RESULTS
# =============================================================================

# Save key results to CSV files
write_csv(customer_summary, "customer_analysis.csv")
write_csv(product_performance, "product_analysis.csv")
write_csv(monthly_sales, "monthly_sales.csv")
write_csv(segment_analysis, "segment_analysis.csv")

print("Analysis complete! Results saved to CSV files.")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Always start with data exploration and cleaning
# 2. Use multiple analysis approaches (descriptive, exploratory, inferential)
# 3. Create visualizations to support your findings
# 4. Look for patterns and correlations in the data
# 5. Segment your data to find actionable insights
# 6. Consider temporal patterns and seasonality
# 7. Always validate your findings with multiple methods
# 8. Document your analysis process and assumptions
# 9. Provide actionable recommendations based on insights
# 10. Export results for further use and sharing

# Next: Move to 22_Final_Project.R for the comprehensive final project!
