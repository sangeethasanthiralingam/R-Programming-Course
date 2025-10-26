library(readxl)

data <- read_excel("D:/BIT/Semi 2/Descriptive_Statistics_Practice.xlsx")

# Frequency table
table(data$Gender)

# Proportion table
prop.table(table(data$Gender))

# Cumulative frequency
cumsum(table(data$Gender))

# Mean, Median
mean(data$English, na.rm = TRUE)
median(data$Math, na.rm = TRUE)

# Mode function (Fixed)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Mode of Math
getmode(data$Math)

# Range
range_value <- max(data$Math, na.rm = TRUE) - min(data$Math, na.rm = TRUE)
range_value

# Min and Max together
range(data$Math)

# Variance & Standard Deviation
var(data$Math, na.rm = TRUE)
sd(data$Math, na.rm = TRUE)

# Quartiles
quantile(data$Math, c(0.25, 0.5, 0.75), na.rm = TRUE)
IQR(data$Math, na.rm = TRUE)

# Deciles (10%, 20%, ... 90%)
quantile(data$Math, probs = seq(0.1, 0.9, by = 0.1), na.rm = TRUE)

# Summary statistics
summary(data$Math)

# Group-wise Mean & SD by Gender
tapply(data$Math, data$Gender, mean, na.rm = TRUE)
tapply(data$Math, data$Gender, sd, na.rm = TRUE)
