# Module 4: Date and Time
# File: 18_Date_Time.R

# =============================================================================
# WORKING WITH DATES AND TIMES IN R
# =============================================================================

# This lesson covers handling dates, times, and time series data
# using R's built-in date/time functions and the lubridate package

# =============================================================================
# 1. LOADING REQUIRED LIBRARIES
# =============================================================================

# Install and load lubridate if not already installed
# install.packages("lubridate")
library(lubridate)

# =============================================================================
# 2. CREATING DATE AND TIME OBJECTS
# =============================================================================

# Current date and time
current_date <- Sys.Date()
current_time <- Sys.time()

print("Current date:", current_date)
print("Current time:", current_time)

# Create dates from strings
date1 <- as.Date("2023-12-25")
date2 <- as.Date("25/12/2023", format = "%d/%m/%Y")
date3 <- as.Date("Dec 25, 2023", format = "%b %d, %Y")

print("Date 1:", date1)
print("Date 2:", date2)
print("Date 3:", date3)

# Create POSIXct objects (date-time)
datetime1 <- as.POSIXct("2023-12-25 14:30:00")
datetime2 <- as.POSIXct("25/12/2023 14:30", format = "%d/%m/%Y %H:%M")

print("DateTime 1:", datetime1)
print("DateTime 2:", datetime2)

# =============================================================================
# 3. USING LUBRIDATE FOR DATE CREATION
# =============================================================================

# Create dates with lubridate
lubridate_date1 <- ymd("2023-12-25")
lubridate_date2 <- dmy("25/12/2023")
lubridate_date3 <- mdy("Dec 25, 2023")

print("Lubridate Date 1:", lubridate_date1)
print("Lubridate Date 2:", lubridate_date2)
print("Lubridate Date 3:", lubridate_date3)

# Create date-time objects
lubridate_datetime1 <- ymd_hms("2023-12-25 14:30:00")
lubridate_datetime2 <- dmy_hm("25/12/2023 14:30")

print("Lubridate DateTime 1:", lubridate_datetime1)
print("Lubridate DateTime 2:", lubridate_datetime2)

# =============================================================================
# 4. EXTRACTING DATE COMPONENTS
# =============================================================================

# Extract components from date
sample_date <- as.Date("2023-12-25")
year_val <- year(sample_date)
month_val <- month(sample_date)
day_val <- day(sample_date)
weekday_val <- weekdays(sample_date)
month_name_val <- month.name[month_val]

print("Year:", year_val)
print("Month:", month_val)
print("Day:", day_val)
print("Weekday:", weekday_val)
print("Month name:", month_name_val)

# Extract components from date-time
sample_datetime <- as.POSIXct("2023-12-25 14:30:45")
hour_val <- hour(sample_datetime)
minute_val <- minute(sample_datetime)
second_val <- second(sample_datetime)

print("Hour:", hour_val)
print("Minute:", minute_val)
print("Second:", second_val)

# =============================================================================
# 5. DATE ARITHMETIC
# =============================================================================

# Add/subtract days
date_plus_7 <- sample_date + 7
date_minus_7 <- sample_date - 7

print("Date + 7 days:", date_plus_7)
print("Date - 7 days:", date_minus_7)

# Add/subtract months and years
date_plus_month <- sample_date + months(1)
date_plus_year <- sample_date + years(1)

print("Date + 1 month:", date_plus_month)
print("Date + 1 year:", date_plus_year)

# Calculate difference between dates
date1 <- as.Date("2023-01-01")
date2 <- as.Date("2023-12-31")
date_diff <- date2 - date1
date_diff_days <- as.numeric(date_diff)

print("Date difference:", date_diff)
print("Date difference in days:", date_diff_days)

# =============================================================================
# 6. DATE FORMATTING
# =============================================================================

# Format dates
formatted_date1 <- format(sample_date, "%Y-%m-%d")
formatted_date2 <- format(sample_date, "%B %d, %Y")
formatted_date3 <- format(sample_date, "%d/%m/%Y")
formatted_date4 <- format(sample_date, "%A, %B %d, %Y")

print("Format 1:", formatted_date1)
print("Format 2:", formatted_date2)
print("Format 3:", formatted_date3)
print("Format 4:", formatted_date4)

# Format date-time
formatted_datetime1 <- format(sample_datetime, "%Y-%m-%d %H:%M:%S")
formatted_datetime2 <- format(sample_datetime, "%B %d, %Y at %I:%M %p")

print("DateTime Format 1:", formatted_datetime1)
print("DateTime Format 2:", formatted_datetime2)

# =============================================================================
# 7. WORKING WITH TIME ZONES
# =============================================================================

# Create date-time with timezone
datetime_tz <- as.POSIXct("2023-12-25 14:30:00", tz = "UTC")
print("DateTime UTC:", datetime_tz)

# Convert timezone
datetime_est <- with_tz(datetime_tz, "America/New_York")
datetime_pst <- with_tz(datetime_tz, "America/Los_Angeles")

print("DateTime EST:", datetime_est)
print("DateTime PST:", datetime_pst)

# =============================================================================
# 8. DATE SEQUENCES
# =============================================================================

# Create date sequences
date_seq_daily <- seq(from = as.Date("2023-01-01"), to = as.Date("2023-01-10"), by = "day")
date_seq_weekly <- seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "week")
date_seq_monthly <- seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "month")

print("Daily sequence:", date_seq_daily)
print("Weekly sequence:", date_seq_weekly)
print("Monthly sequence:", date_seq_monthly)

# =============================================================================
# 9. WORKING WITH TIME SERIES DATA
# =============================================================================

# Create sample time series data
dates <- seq(from = as.Date("2023-01-01"), to = as.Date("2023-12-31"), by = "month")
values <- rnorm(12, mean = 100, sd = 20)

time_series_data <- data.frame(
  date = dates,
  value = values
)

print("Time series data:")
print(time_series_data)

# =============================================================================
# 10. DATE FILTERING AND SUBSETTING
# =============================================================================

# Filter data by date range
start_date <- as.Date("2023-06-01")
end_date <- as.Date("2023-12-31")

filtered_data <- time_series_data[time_series_data$date >= start_date & 
                                 time_series_data$date <= end_date, ]

print("Filtered data:")
print(filtered_data)

# Filter by specific months
summer_data <- time_series_data[month(time_series_data$date) %in% c(6, 7, 8), ]
print("Summer data:")
print(summer_data)

# Filter by specific year
year_2023_data <- time_series_data[year(time_series_data$date) == 2023, ]
print("2023 data:")
print(year_2023_data)

# =============================================================================
# 11. PRACTICAL EXAMPLES
# =============================================================================

# Example 1: Calculate age
calculate_age <- function(birth_date, current_date = Sys.Date()) {
  age <- as.numeric(current_date - birth_date) / 365.25
  return(floor(age))
}

birth_dates <- c("1990-01-15", "1985-06-20", "1992-12-10")
ages <- sapply(birth_dates, function(x) calculate_age(as.Date(x)))
print("Ages:", ages)

# Example 2: Find business days
is_business_day <- function(date) {
  weekday <- weekdays(date)
  return(!weekday %in% c("Saturday", "Sunday"))
}

sample_dates <- seq(from = as.Date("2023-12-01"), to = as.Date("2023-12-10"), by = "day")
business_days <- sample_dates[is_business_day(sample_dates)]
print("Business days:", business_days)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a function that takes a date and returns
# the number of days until the next birthday

# Exercise 2: Create a function that calculates the number of
# business days between two dates

# Exercise 3: Create a function that formats a date in
# a user-friendly way

# Exercise 4: Create a function that finds all dates in a
# given year that fall on a specific day of the week

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
days_until_birthday <- function(birth_date, current_date = Sys.Date()) {
  # Get current year
  current_year <- year(current_date)
  
  # Create birthday for current year
  birthday_this_year <- as.Date(paste(current_year, month(birth_date), day(birth_date), sep = "-"))
  
  # If birthday has passed, use next year
  if (birthday_this_year < current_date) {
    birthday_this_year <- as.Date(paste(current_year + 1, month(birth_date), day(birth_date), sep = "-"))
  }
  
  return(as.numeric(birthday_this_year - current_date))
}

birthday <- as.Date("1990-06-15")
days_until <- days_until_birthday(birthday)
print(paste("Days until birthday:", days_until))

# Solution 2:
business_days_between <- function(start_date, end_date) {
  all_dates <- seq(from = start_date, to = end_date, by = "day")
  business_days <- all_dates[is_business_day(all_dates)]
  return(length(business_days))
}

start <- as.Date("2023-12-01")
end <- as.Date("2023-12-31")
business_days_count <- business_days_between(start, end)
print(paste("Business days between dates:", business_days_count))

# Solution 3:
format_date_friendly <- function(date) {
  return(format(date, "%A, %B %d, %Y"))
}

friendly_date <- format_date_friendly(as.Date("2023-12-25"))
print("Friendly date:", friendly_date)

# Solution 4:
dates_on_weekday <- function(year, weekday_name) {
  start_date <- as.Date(paste(year, "01-01", sep = "-"))
  end_date <- as.Date(paste(year, "12-31", sep = "-"))
  all_dates <- seq(from = start_date, to = end_date, by = "day")
  return(all_dates[weekdays(all_dates) == weekday_name])
}

mondays_2023 <- dates_on_weekday(2023, "Monday")
print("Mondays in 2023:", length(mondays_2023))

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use as.Date() for dates, as.POSIXct() for date-time
# 2. Use lubridate functions for easier date manipulation
# 3. Use year(), month(), day() to extract components
# 4. Use format() to format dates for display
# 5. Use seq() to create date sequences
# 6. Use with_tz() for timezone conversions
# 7. Date arithmetic works with + and - operators
# 8. Use weekdays() to get day names
# 9. Always consider timezones when working with date-time
# 10. Use appropriate date formats for your data source

# Next: Move to 19_Packages_Libraries.R to learn about R packages!
