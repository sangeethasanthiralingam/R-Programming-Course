# Module 5: Final Comprehensive Project
# File: 22_Final_Project.R

# =============================================================================
# FINAL COMPREHENSIVE R PROJECT
# =============================================================================

# This is your final project that combines all the skills you've learned
# Project: Healthcare Data Analysis and Predictive Modeling

# =============================================================================
# 1. PROJECT OVERVIEW
# =============================================================================

# Project: Healthcare Patient Analysis and Risk Prediction
# Objective: Analyze patient data to identify risk factors and predict health outcomes
# Skills Demonstrated: Data manipulation, visualization, statistical analysis, modeling

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
library(caret)
library(randomForest)
library(VIM)

# =============================================================================
# 3. DATA GENERATION AND LOADING
# =============================================================================

# Set seed for reproducibility
set.seed(98765)

# Generate comprehensive healthcare dataset
n_patients <- 2000
n_visits <- 8000

# Patient demographics
patients <- data.frame(
  patient_id = 1:n_patients,
  age = sample(18:80, n_patients, replace = TRUE),
  gender = sample(c("Male", "Female"), n_patients, replace = TRUE),
  race = sample(c("White", "Black", "Hispanic", "Asian", "Other"), n_patients, replace = TRUE),
  bmi = rnorm(n_patients, mean = 25, sd = 5),
  blood_pressure_systolic = rnorm(n_patients, mean = 120, sd = 15),
  blood_pressure_diastolic = rnorm(n_patients, mean = 80, sd = 10),
  cholesterol = rnorm(n_patients, mean = 200, sd = 40),
  diabetes = sample(c("Yes", "No"), n_patients, replace = TRUE, prob = c(0.2, 0.8)),
  hypertension = sample(c("Yes", "No"), n_patients, replace = TRUE, prob = c(0.3, 0.7)),
  smoking_status = sample(c("Never", "Former", "Current"), n_patients, replace = TRUE, prob = c(0.5, 0.3, 0.2)),
  family_history_heart_disease = sample(c("Yes", "No"), n_patients, replace = TRUE, prob = c(0.4, 0.6))
)

# Add realistic correlations
patients$bmi <- pmax(15, pmin(50, patients$bmi))  # BMI between 15-50
patients$blood_pressure_systolic <- pmax(90, pmin(200, patients$blood_pressure_systolic))
patients$blood_pressure_diastolic <- pmax(60, pmin(120, patients$blood_pressure_diastolic))
patients$cholesterol <- pmax(100, pmin(400, patients$cholesterol))

# Higher BMI correlates with higher blood pressure
patients$blood_pressure_systolic <- patients$blood_pressure_systolic + (patients$bmi - 25) * 0.5
patients$blood_pressure_diastolic <- patients$blood_pressure_diastolic + (patients$bmi - 25) * 0.3

# Generate visit data
visits <- data.frame(
  visit_id = 1:n_visits,
  patient_id = sample(1:n_patients, n_visits, replace = TRUE),
  visit_date = sample(seq(as.Date("2020-01-01"), as.Date("2023-12-31"), by = "day"), n_visits, replace = TRUE),
  visit_type = sample(c("Routine", "Emergency", "Follow-up", "Specialist"), n_visits, replace = TRUE),
  diagnosis = sample(c("Hypertension", "Diabetes", "Heart Disease", "Respiratory", "Other"), n_visits, replace = TRUE),
  treatment_cost = runif(n_visits, 100, 2000),
  length_of_stay = sample(1:14, n_visits, replace = TRUE),
  readmission_risk = runif(n_visits, 0, 1)
)

# Add some realistic patterns
# Emergency visits have higher costs
visits$treatment_cost <- ifelse(visits$visit_type == "Emergency", 
                               visits$treatment_cost * 1.5, visits$treatment_cost)

# Heart disease patients have higher readmission risk
visits$readmission_risk <- ifelse(visits$diagnosis == "Heart Disease", 
                                 visits$readmission_risk * 1.3, visits$readmission_risk)

# Calculate patient risk scores
patient_risk <- patients %>%
  mutate(
    risk_score = (age - 18) * 0.1 + 
                 (bmi - 25) * 0.2 + 
                 (blood_pressure_systolic - 120) * 0.05 +
                 (cholesterol - 200) * 0.01 +
                 ifelse(diabetes == "Yes", 2, 0) +
                 ifelse(hypertension == "Yes", 1.5, 0) +
                 ifelse(smoking_status == "Current", 1, 0) +
                 ifelse(family_history_heart_disease == "Yes", 0.5, 0)
  )

print("Healthcare Data Overview:")
print(paste("Patients:", nrow(patients)))
print(paste("Visits:", nrow(visits)))

# =============================================================================
# 4. DATA EXPLORATION AND CLEANING
# =============================================================================

# Check for missing values
print("Missing Values Check:")
print(paste("Patients missing values:", sum(is.na(patients))))
print(paste("Visits missing values:", sum(is.na(visits))))

# Basic statistics
print("Patient Data Summary:")
print(summary(patients))

print("Visit Data Summary:")
print(summary(visits))

# =============================================================================
# 5. PATIENT DEMOGRAPHICS ANALYSIS
# =============================================================================

# Age distribution
age_distribution <- patients %>%
  group_by(age_group = cut(age, breaks = c(0, 30, 50, 70, 100), labels = c("18-30", "31-50", "51-70", "71+"))) %>%
  summarise(count = n())

print("Age Distribution:")
print(age_distribution)

# Gender distribution
gender_distribution <- table(patients$gender)
print("Gender Distribution:")
print(gender_distribution)

# Risk factors analysis
risk_factors <- patients %>%
  summarise(
    diabetes_rate = mean(diabetes == "Yes") * 100,
    hypertension_rate = mean(hypertension == "Yes") * 100,
    smoking_rate = mean(smoking_status == "Current") * 100,
    family_history_rate = mean(family_history_heart_disease == "Yes") * 100
  )

print("Risk Factors Prevalence:")
print(risk_factors)

# =============================================================================
# 6. VISIT PATTERN ANALYSIS
# =============================================================================

# Visit frequency by patient
visit_frequency <- visits %>%
  group_by(patient_id) %>%
  summarise(
    total_visits = n(),
    total_cost = sum(treatment_cost),
    avg_cost_per_visit = mean(treatment_cost),
    avg_length_of_stay = mean(length_of_stay),
    avg_readmission_risk = mean(readmission_risk)
  ) %>%
  left_join(patient_risk, by = "patient_id")

print("Visit Frequency Analysis:")
print(head(visit_frequency))

# Monthly visit trends
monthly_visits <- visits %>%
  mutate(month = month(visit_date)) %>%
  group_by(month) %>%
  summarise(
    total_visits = n(),
    total_cost = sum(treatment_cost),
    avg_cost = mean(treatment_cost),
    emergency_visits = sum(visit_type == "Emergency")
  )

print("Monthly Visit Trends:")
print(monthly_visits)

# =============================================================================
# 7. RISK ANALYSIS
# =============================================================================

# High-risk patients
high_risk_patients <- patient_risk %>%
  filter(risk_score > quantile(risk_score, 0.8)) %>%
  arrange(desc(risk_score))

print("High-Risk Patients (Top 10):")
print(head(high_risk_patients, 10))

# Risk factors correlation
risk_correlation <- patient_risk %>%
  select(age, bmi, blood_pressure_systolic, blood_pressure_diastolic, 
         cholesterol, risk_score) %>%
  cor(use = "complete.obs")

print("Risk Factors Correlation Matrix:")
print(risk_correlation)

# =============================================================================
# 8. VISUALIZATIONS
# =============================================================================

# Age distribution
age_plot <- ggplot(patients, aes(x = age)) +
  geom_histogram(bins = 20, fill = "lightblue", color = "black") +
  labs(title = "Patient Age Distribution",
       x = "Age",
       y = "Number of Patients") +
  theme_minimal()

print(age_plot)

# BMI distribution by gender
bmi_plot <- ggplot(patients, aes(x = bmi, fill = gender)) +
  geom_histogram(alpha = 0.7, bins = 20) +
  labs(title = "BMI Distribution by Gender",
       x = "BMI",
       y = "Number of Patients",
       fill = "Gender") +
  theme_minimal()

print(bmi_plot)

# Blood pressure scatter plot
bp_plot <- ggplot(patients, aes(x = blood_pressure_systolic, y = blood_pressure_diastolic, color = gender)) +
  geom_point(alpha = 0.6) +
  labs(title = "Blood Pressure Distribution",
       x = "Systolic BP",
       y = "Diastolic BP",
       color = "Gender") +
  theme_minimal()

print(bp_plot)

# Risk score distribution
risk_plot <- ggplot(patient_risk, aes(x = risk_score)) +
  geom_histogram(bins = 20, fill = "lightcoral", color = "black") +
  labs(title = "Patient Risk Score Distribution",
       x = "Risk Score",
       y = "Number of Patients") +
  theme_minimal()

print(risk_plot)

# Monthly visit trends
monthly_plot <- ggplot(monthly_visits, aes(x = month, y = total_visits)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Monthly Visit Trends",
       x = "Month",
       y = "Total Visits") +
  theme_minimal()

print(monthly_plot)

# Visit type distribution
visit_type_plot <- ggplot(visits, aes(x = visit_type, fill = visit_type)) +
  geom_bar() +
  labs(title = "Visit Type Distribution",
       x = "Visit Type",
       y = "Number of Visits") +
  theme_minimal() +
  theme(legend.position = "none")

print(visit_type_plot)

# =============================================================================
# 9. PREDICTIVE MODELING
# =============================================================================

# Prepare data for modeling
model_data <- visit_frequency %>%
  select(patient_id, total_visits, total_cost, avg_readmission_risk, 
         age, bmi, blood_pressure_systolic, cholesterol, 
         diabetes, hypertension, smoking_status, family_history_heart_disease) %>%
  mutate(
    diabetes = as.factor(diabetes),
    hypertension = as.factor(hypertension),
    smoking_status = as.factor(smoking_status),
    family_history_heart_disease = as.factor(family_history_heart_disease)
  )

# Remove missing values
model_data <- na.omit(model_data)

# Split data for training and testing
set.seed(123)
train_indices <- createDataPartition(model_data$avg_readmission_risk, p = 0.7, list = FALSE)
train_data <- model_data[train_indices, ]
test_data <- model_data[-train_indices, ]

# Train random forest model
rf_model <- randomForest(avg_readmission_risk ~ age + bmi + blood_pressure_systolic + 
                         cholesterol + diabetes + hypertension + smoking_status + 
                         family_history_heart_disease,
                         data = train_data, ntree = 100)

# Make predictions
predictions <- predict(rf_model, test_data)

# Calculate model performance
rmse <- sqrt(mean((test_data$avg_readmission_risk - predictions)^2))
mae <- mean(abs(test_data$avg_readmission_risk - predictions))

print("Model Performance:")
print(paste("RMSE:", round(rmse, 3)))
print(paste("MAE:", round(mae, 3)))

# Feature importance
feature_importance <- importance(rf_model)
print("Feature Importance:")
print(feature_importance)

# =============================================================================
# 10. INSIGHTS AND RECOMMENDATIONS
# =============================================================================

print("KEY INSIGHTS:")
print("1. Patient Demographics:")
print(paste("   - Average age:", round(mean(patients$age), 1)))
print(paste("   - Average BMI:", round(mean(patients$bmi), 1)))
print(paste("   - Diabetes rate:", round(risk_factors$diabetes_rate, 1), "%"))

print("2. Visit Patterns:")
print(paste("   - Average visits per patient:", round(mean(visit_frequency$total_visits), 1)))
print(paste("   - Average cost per visit:", round(mean(visit_frequency$avg_cost_per_visit), 2)))

print("3. Risk Factors:")
print(paste("   - High-risk patients:", round(nrow(high_risk_patients) / nrow(patients) * 100, 1), "%"))
print(paste("   - Average risk score:", round(mean(patient_risk$risk_score), 2)))

print("RECOMMENDATIONS:")
print("1. Focus on high-risk patients for preventive care")
print("2. Implement targeted interventions for patients with multiple risk factors")
print("3. Develop programs to reduce emergency visits")
print("4. Create personalized care plans based on risk scores")
print("5. Monitor patients with high readmission risk more closely")

# =============================================================================
# 11. EXPORT RESULTS
# =============================================================================

# Save key results
write_csv(patient_risk, "patient_risk_analysis.csv")
write_csv(visit_frequency, "visit_frequency_analysis.csv")
write_csv(monthly_visits, "monthly_visits.csv")
write_csv(high_risk_patients, "high_risk_patients.csv")

print("Analysis complete! Results saved to CSV files.")

# =============================================================================
# 12. PROJECT SUMMARY
# =============================================================================

print("PROJECT SUMMARY:")
print("This comprehensive healthcare analysis project demonstrates:")
print("1. Data generation and manipulation")
print("2. Exploratory data analysis")
print("3. Statistical analysis and visualization")
print("4. Predictive modeling")
print("5. Business insights and recommendations")
print("6. Data export and reporting")

print("Skills demonstrated:")
print("- Data manipulation with dplyr")
print("- Data visualization with ggplot2")
print("- Statistical analysis")
print("- Machine learning with randomForest")
print("- Data export and reporting")
print("- Professional data analysis workflow")

# =============================================================================
# CONGRATULATIONS!
# =============================================================================

print("CONGRATULATIONS!")
print("You have successfully completed the comprehensive R programming course!")
print("You now have the skills to:")
print("- Manipulate and analyze data")
print("- Create professional visualizations")
print("- Perform statistical analysis")
print("- Build predictive models")
print("- Generate business insights")
print("- Present findings effectively")

print("Keep practicing and exploring new R packages and techniques!")
print("Happy coding! 🚀")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Always start with data exploration and cleaning
# 2. Use appropriate visualizations for your data
# 3. Look for patterns and correlations
# 4. Apply statistical methods appropriately
# 5. Build models that are interpretable and actionable
# 6. Always validate your findings
# 7. Provide clear, actionable recommendations
# 8. Document your analysis process
# 9. Export results for further use
# 10. Continuously learn and improve your skills

# This completes your R programming journey! 🎉
