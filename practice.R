library(readxl)

data <- read_excel("D:/BIT/Semi 2/Descriptive_Statistics_Practice.xlsx")

table(data.Gender)

table(Gender)
prop.table(tableI(Gender))
cumsum(table((Gender)))
#----Measures of Central Tendency -------
mean(English)