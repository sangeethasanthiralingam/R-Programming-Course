# Module 4: String Manipulation
# File: 17_String_Manipulation.R

# =============================================================================
# STRING MANIPULATION IN R
# =============================================================================

# This lesson covers working with text data, including
# pattern matching, text processing, and string operations

# =============================================================================
# 1. CREATING SAMPLE TEXT DATA
# =============================================================================

# Sample text data
text_data <- c(
  "Hello World",
  "R Programming is fun",
  "Data Science with R",
  "Machine Learning",
  "Statistical Analysis"
)

# Sample data frame with text
text_df <- data.frame(
  id = 1:5,
  name = c("John Smith", "Jane Doe", "Bob Johnson", "Alice Brown", "Charlie Wilson"),
  email = c("john@email.com", "jane@email.com", "bob@email.com", "alice@email.com", "charlie@email.com"),
  phone = c("555-1234", "555-5678", "555-9012", "555-3456", "555-7890"),
  address = c("123 Main St", "456 Oak Ave", "789 Pine Rd", "321 Elm St", "654 Maple Dr")
)

print(text_df)

# =============================================================================
# 2. BASIC STRING OPERATIONS
# =============================================================================

# String length
text_length <- nchar(text_data)
print("Text lengths:", text_length)

# Convert to uppercase
text_upper <- toupper(text_data)
print("Uppercase:", text_upper)

# Convert to lowercase
text_lower <- tolower(text_data)
print("Lowercase:", text_lower)

# Convert to title case
text_title <- tools::toTitleCase(text_data)
print("Title case:", text_title)

# =============================================================================
# 3. STRING CONCATENATION
# =============================================================================

# Using paste()
concatenated <- paste("Hello", "World", "!")
print("Concatenated:", concatenated)

# Using paste0() (no separator)
concatenated_no_sep <- paste0("Hello", "World", "!")
print("Concatenated (no sep):", concatenated_no_sep)

# Concatenate with separator
concatenated_sep <- paste("Hello", "World", "!", sep = "-")
print("Concatenated (sep):", concatenated_sep)

# Concatenate vectors
vector_concat <- paste(text_data, collapse = " | ")
print("Vector concatenated:", vector_concat)

# =============================================================================
# 4. STRING SPLITTING
# =============================================================================

# Split string by space
split_text <- strsplit(text_data, " ")
print("Split text:", split_text)

# Split by specific character
split_by_char <- strsplit(text_df$phone, "-")
print("Split phone:", split_by_char)

# Split and extract specific parts
first_names <- sapply(strsplit(text_df$name, " "), function(x) x[1])
last_names <- sapply(strsplit(text_df$name, " "), function(x) x[2])
print("First names:", first_names)
print("Last names:", last_names)

# =============================================================================
# 5. STRING SUBSTITUTION
# =============================================================================

# Replace first occurrence
replaced_first <- sub("R", "Python", text_data)
print("Replaced first:", replaced_first)

# Replace all occurrences
replaced_all <- gsub("R", "Python", text_data)
print("Replaced all:", replaced_all)

# Replace with pattern
replaced_pattern <- gsub("\\s+", "_", text_data)  # Replace spaces with underscores
print("Replaced pattern:", replaced_pattern)

# =============================================================================
# 6. PATTERN MATCHING
# =============================================================================

# Check if pattern exists
has_pattern <- grepl("R", text_data)
print("Has 'R':", has_pattern)

# Find pattern positions
pattern_positions <- grep("R", text_data)
print("Pattern positions:", pattern_positions)

# Find pattern with value
pattern_values <- grep("R", text_data, value = TRUE)
print("Pattern values:", pattern_values)

# =============================================================================
# 7. REGULAR EXPRESSIONS
# =============================================================================

# Email pattern
email_pattern <- "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
email_matches <- grepl(email_pattern, text_df$email)
print("Valid emails:", email_matches)

# Phone pattern
phone_pattern <- "^\\d{3}-\\d{4}$"
phone_matches <- grepl(phone_pattern, text_df$phone)
print("Valid phones:", phone_matches)

# Extract numbers from text
text_with_numbers <- c("Price: $25.99", "Weight: 150 lbs", "Age: 25 years")
numbers_extracted <- gsub("[^0-9.]", "", text_with_numbers)
print("Extracted numbers:", numbers_extracted)

# =============================================================================
# 8. STRING EXTRACTION
# =============================================================================

# Extract substring
substring_extracted <- substr(text_data, 1, 5)
print("Substring:", substring_extracted)

# Extract with regex
# Extract domain from email
email_domains <- gsub(".*@", "", text_df$email)
print("Email domains:", email_domains)

# Extract username from email
email_usernames <- gsub("@.*", "", text_df$email)
print("Email usernames:", email_usernames)

# =============================================================================
# 9. STRING FORMATTING
# =============================================================================

# Format numbers
numbers <- c(1234.5678, 9876.5432, 555.1234)
formatted_numbers <- sprintf("%.2f", numbers)
print("Formatted numbers:", formatted_numbers)

# Format with padding
padded_numbers <- sprintf("%05d", 1:5)
print("Padded numbers:", padded_numbers)

# Format with different styles
formatted_text <- sprintf("Name: %s, Age: %d, Score: %.1f", 
                         c("Alice", "Bob", "Charlie"), 
                         c(25, 30, 35), 
                         c(85.5, 92.3, 78.9))
print("Formatted text:", formatted_text)

# =============================================================================
# 10. TEXT CLEANING
# =============================================================================

# Sample messy text
messy_text <- c(
  "  Hello World  ",
  "R Programming!!!",
  "Data Science with R...",
  "Machine Learning???",
  "Statistical Analysis   "
)

# Remove leading/trailing whitespace
cleaned_text <- trimws(messy_text)
print("Cleaned text:", cleaned_text)

# Remove punctuation
no_punctuation <- gsub("[[:punct:]]", "", messy_text)
print("No punctuation:", no_punctuation)

# Remove extra spaces
no_extra_spaces <- gsub("\\s+", " ", messy_text)
print("No extra spaces:", no_extra_spaces)

# Remove numbers
no_numbers <- gsub("[0-9]", "", messy_text)
print("No numbers:", no_numbers)

# =============================================================================
# 11. PRACTICAL EXAMPLES
# =============================================================================

# Example 1: Clean and standardize names
clean_names <- function(names) {
  # Convert to title case
  cleaned <- tools::toTitleCase(tolower(names))
  # Remove extra spaces
  cleaned <- gsub("\\s+", " ", cleaned)
  # Trim whitespace
  cleaned <- trimws(cleaned)
  return(cleaned)
}

cleaned_names <- clean_names(text_df$name)
print("Cleaned names:", cleaned_names)

# Example 2: Extract information from text
extract_info <- function(text) {
  # Extract numbers
  numbers <- gsub("[^0-9]", "", text)
  # Extract letters
  letters <- gsub("[^A-Za-z]", "", text)
  # Extract special characters
  special <- gsub("[A-Za-z0-9]", "", text)
  
  return(list(
    numbers = numbers,
    letters = letters,
    special = special
  ))
}

sample_text <- "Hello123World!!!"
extracted <- extract_info(sample_text)
print("Extracted info:", extracted)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a function that takes a list of names
# and returns only the first names

# Exercise 2: Create a function that validates email addresses
# using regular expressions

# Exercise 3: Create a function that cleans text by removing
# punctuation and extra spaces

# Exercise 4: Create a function that extracts all numbers
# from a text string

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
get_first_names <- function(names) {
  first_names <- sapply(strsplit(names, " "), function(x) x[1])
  return(first_names)
}

first_names_result <- get_first_names(text_df$name)
print("First names:", first_names_result)

# Solution 2:
validate_email <- function(email) {
  pattern <- "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
  return(grepl(pattern, email))
}

email_validation <- validate_email(text_df$email)
print("Email validation:", email_validation)

# Solution 3:
clean_text <- function(text) {
  # Remove punctuation
  cleaned <- gsub("[[:punct:]]", "", text)
  # Remove extra spaces
  cleaned <- gsub("\\s+", " ", cleaned)
  # Trim whitespace
  cleaned <- trimws(cleaned)
  return(cleaned)
}

cleaned_text_result <- clean_text(messy_text)
print("Cleaned text:", cleaned_text_result)

# Solution 4:
extract_numbers <- function(text) {
  numbers <- gsub("[^0-9]", "", text)
  return(numbers)
}

numbers_extracted <- extract_numbers(text_with_numbers)
print("Extracted numbers:", numbers_extracted)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Use nchar() for string length
# 2. Use toupper(), tolower(), toTitleCase() for case conversion
# 3. Use paste() and paste0() for concatenation
# 4. Use strsplit() for splitting strings
# 5. Use sub() and gsub() for substitution
# 6. Use grepl() and grep() for pattern matching
# 7. Use substr() for substring extraction
# 8. Use sprintf() for string formatting
# 9. Use trimws() for whitespace removal
# 10. Regular expressions are powerful for pattern matching

# Next: Move to 18_Date_Time.R to learn about working with dates and times!
