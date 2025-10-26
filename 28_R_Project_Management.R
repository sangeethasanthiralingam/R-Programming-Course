# Module 9: R Project Management and Workflow
# File: 28_R_Project_Management.R

# =============================================================================
# R PROJECT MANAGEMENT AND WORKFLOW
# =============================================================================

# This lesson covers best practices for managing R projects, organizing code,
# and creating reproducible workflows

# =============================================================================
# 1. PROJECT STRUCTURE AND ORGANIZATION
# =============================================================================

# Recommended project structure:
# my_project/
# ├── data/
# │   ├── raw/           # Original, unmodified data
# │   ├── processed/     # Cleaned and processed data
# │   └── external/      # External data sources
# ├── code/
# │   ├── 01_data_import.R
# │   ├── 02_data_cleaning.R
# │   ├── 03_analysis.R
# │   └── 04_visualization.R
# ├── output/
# │   ├── figures/       # Plots and visualizations
# │   ├── tables/        # Summary tables
# │   └── reports/       # Generated reports
# ├── docs/              # Documentation
# ├── tests/             # Unit tests
# ├── .gitignore         # Git ignore file
# ├── README.md          # Project description
# └── my_project.Rproj   # RStudio project file

# Create project structure function
create_project_structure <- function(project_name) {
  # Create main directories
  dirs <- c(
    file.path(project_name, "data", "raw"),
    file.path(project_name, "data", "processed"),
    file.path(project_name, "data", "external"),
    file.path(project_name, "code"),
    file.path(project_name, "output", "figures"),
    file.path(project_name, "output", "tables"),
    file.path(project_name, "output", "reports"),
    file.path(project_name, "docs"),
    file.path(project_name, "tests")
  )
  
  # Create directories
  for (dir in dirs) {
    dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  }
  
  # Create .gitignore file
  gitignore_content <- c(
    "# R",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    "*.Rproj",
    "*.Rproj.user",
    "",
    "# Data files",
    "data/raw/*.csv",
    "data/raw/*.xlsx",
    "data/raw/*.json",
    "",
    "# Output files",
    "output/figures/*.png",
    "output/figures/*.pdf",
    "output/tables/*.csv",
    "output/reports/*.html",
    "",
    "# Temporary files",
    "*.tmp",
    "*.temp"
  )
  
  writeLines(gitignore_content, file.path(project_name, ".gitignore"))
  
  # Create README.md
  readme_content <- paste0(
    "# ", project_name, "\n\n",
    "## Description\n",
    "Brief description of the project.\n\n",
    "## Project Structure\n",
    "```\n",
    "my_project/\n",
    "├── data/           # Data files\n",
    "├── code/          # R scripts\n",
    "├── output/        # Generated outputs\n",
    "├── docs/          # Documentation\n",
    "└── tests/         # Unit tests\n",
    "```\n\n",
    "## Getting Started\n",
    "1. Clone the repository\n",
    "2. Open the RStudio project file\n",
    "3. Install required packages\n",
    "4. Run the analysis scripts\n\n",
    "## Requirements\n",
    "- R version 4.0 or higher\n",
    "- Required packages listed in requirements.txt\n\n",
    "## Author\n",
    "Your Name\n"
  )
  
  writeLines(readme_content, file.path(project_name, "README.md"))
  
  cat("Project structure created for:", project_name, "\n")
}

# Create a sample project
# create_project_structure("sample_analysis")

# =============================================================================
# 2. PACKAGE MANAGEMENT AND DEPENDENCIES
# =============================================================================

# Create requirements file
create_requirements_file <- function(packages, filename = "requirements.txt") {
  requirements_content <- c(
    "# R Package Requirements",
    "# Install with: install.packages(c(\"package1\", \"package2\", ...))",
    "",
    "# Data manipulation",
    "dplyr",
    "tidyr",
    "readr",
    "readxl",
    "",
    "# Visualization",
    "ggplot2",
    "plotly",
    "",
    "# Statistical analysis",
    "stats",
    "broom",
    "",
    "# Machine learning",
    "caret",
    "randomForest",
    "",
    "# Reporting",
    "rmarkdown",
    "knitr",
    "",
    "# Other utilities",
    "stringr",
    "lubridate",
    "janitor"
  )
  
  writeLines(requirements_content, filename)
  cat("Requirements file created:", filename, "\n")
}

# Install packages from requirements
install_requirements <- function(requirements_file = "requirements.txt") {
  if (!file.exists(requirements_file)) {
    stop("Requirements file not found:", requirements_file)
  }
  
  # Read requirements
  requirements <- readLines(requirements_file)
  
  # Filter out comments and empty lines
  packages <- requirements[!grepl("^#", requirements) & requirements != ""]
  
  # Install packages
  for (package in packages) {
    if (!require(package, character.only = TRUE, quietly = TRUE)) {
      install.packages(package)
      library(package, character.only = TRUE)
    }
  }
  
  cat("All required packages installed successfully\n")
}

# Create requirements file
# create_requirements_file()

# =============================================================================
# 3. DATA MANAGEMENT AND VERSION CONTROL
# =============================================================================

# Data versioning function
version_data <- function(data, version = NULL) {
  if (is.null(version)) {
    version <- format(Sys.time(), "%Y%m%d_%H%M%S")
  }
  
  # Create versioned filename
  filename <- paste0("data_v", version, ".rds")
  
  # Save data
  saveRDS(data, filename)
  
  # Log the version
  log_entry <- paste0(
    Sys.time(), " - Data version ", version, " saved as ", filename, "\n"
  )
  
  # Append to log file
  write(log_entry, file = "data_version_log.txt", append = TRUE)
  
  cat("Data versioned:", filename, "\n")
}

# Load versioned data
load_versioned_data <- function(version) {
  filename <- paste0("data_v", version, ".rds")
  
  if (!file.exists(filename)) {
    stop("Versioned data file not found:", filename)
  }
  
  data <- readRDS(filename)
  cat("Loaded data version:", version, "\n")
  return(data)
}

# =============================================================================
# 4. CONFIGURATION MANAGEMENT
# =============================================================================

# Configuration file management
create_config <- function(config_file = "config.R") {
  config_content <- c(
    "# Project Configuration",
    "",
    "# Data paths",
    "DATA_PATH <- \"data/\"",
    "RAW_DATA_PATH <- \"data/raw/\"",
    "PROCESSED_DATA_PATH <- \"data/processed/\"",
    "",
    "# Output paths",
    "OUTPUT_PATH <- \"output/\"",
    "FIGURES_PATH <- \"output/figures/\"",
    "TABLES_PATH <- \"output/tables/\"",
    "",
    "# Analysis parameters",
    "SIGNIFICANCE_LEVEL <- 0.05",
    "CONFIDENCE_LEVEL <- 0.95",
    "RANDOM_SEED <- 123",
    "",
    "# File formats",
    "FIGURE_FORMAT <- \"png\"",
    "FIGURE_DPI <- 300",
    "FIGURE_WIDTH <- 10",
    "FIGURE_HEIGHT <- 6",
    "",
    "# Colors",
    "PRIMARY_COLOR <- \"#2E86AB\"",
    "SECONDARY_COLOR <- \"#A23B72\"",
    "SUCCESS_COLOR <- \"#F18F01\"",
    "WARNING_COLOR <- \"#C73E1D\""
  )
  
  writeLines(config_content, config_file)
  cat("Configuration file created:", config_file, "\n")
}

# Load configuration
load_config <- function(config_file = "config.R") {
  if (!file.exists(config_file)) {
    stop("Configuration file not found:", config_file)
  }
  
  source(config_file)
  cat("Configuration loaded from:", config_file, "\n")
}

# =============================================================================
# 5. WORKFLOW AUTOMATION
# =============================================================================

# Master analysis script
master_analysis <- function() {
  # Set working directory
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
  # Load configuration
  load_config()
  
  # Set random seed
  set.seed(RANDOM_SEED)
  
  # Create output directories
  dir.create(FIGURES_PATH, showWarnings = FALSE)
  dir.create(TABLES_PATH, showWarnings = FALSE)
  
  # Run analysis steps
  cat("Starting analysis workflow...\n")
  
  # Step 1: Data import
  cat("Step 1: Importing data...\n")
  source("code/01_data_import.R")
  
  # Step 2: Data cleaning
  cat("Step 2: Cleaning data...\n")
  source("code/02_data_cleaning.R")
  
  # Step 3: Analysis
  cat("Step 3: Running analysis...\n")
  source("code/03_analysis.R")
  
  # Step 4: Visualization
  cat("Step 4: Creating visualizations...\n")
  source("code/04_visualization.R")
  
  # Step 5: Generate report
  cat("Step 5: Generating report...\n")
  rmarkdown::render("docs/report.Rmd", 
                   output_dir = "output/reports/",
                   output_file = paste0("report_", format(Sys.time(), "%Y%m%d"), ".html"))
  
  cat("Analysis workflow completed successfully!\n")
}

# =============================================================================
# 6. QUALITY ASSURANCE AND TESTING
# =============================================================================

# Data quality checks
data_quality_check <- function(data) {
  cat("Running data quality checks...\n")
  
  # Check for missing values
  missing_summary <- sapply(data, function(x) sum(is.na(x)))
  cat("Missing values by column:\n")
  print(missing_summary)
  
  # Check for duplicates
  duplicates <- sum(duplicated(data))
  cat("Number of duplicate rows:", duplicates, "\n")
  
  # Check data types
  data_types <- sapply(data, class)
  cat("Data types:\n")
  print(data_types)
  
  # Check for outliers (numeric columns only)
  numeric_cols <- sapply(data, is.numeric)
  if (any(numeric_cols)) {
    cat("Outlier detection (IQR method):\n")
    for (col in names(data)[numeric_cols]) {
      Q1 <- quantile(data[[col]], 0.25, na.rm = TRUE)
      Q3 <- quantile(data[[col]], 0.75, na.rm = TRUE)
      IQR <- Q3 - Q1
      lower_bound <- Q1 - 1.5 * IQR
      upper_bound <- Q3 + 1.5 * IQR
      
      outliers <- sum(data[[col]] < lower_bound | data[[col]] > upper_bound, na.rm = TRUE)
      cat(col, ":", outliers, "outliers\n")
    }
  }
  
  cat("Data quality check completed.\n")
}

# =============================================================================
# 7. DOCUMENTATION AND REPORTING
# =============================================================================

# Generate analysis summary
generate_summary <- function(data, output_file = "analysis_summary.txt") {
  summary_content <- c(
    paste("Analysis Summary - Generated on:", Sys.time()),
    "",
    "Data Overview:",
    paste("- Number of rows:", nrow(data)),
    paste("- Number of columns:", ncol(data)),
    paste("- Data size:", format(object.size(data), units = "MB")),
    "",
    "Column Information:",
    ""
  )
  
  # Add column details
  for (col in names(data)) {
    col_info <- c(
      paste("Column:", col),
      paste("- Type:", class(data[[col]])),
      paste("- Missing values:", sum(is.na(data[[col]]))),
      paste("- Unique values:", length(unique(data[[col]]))),
      ""
    )
    summary_content <- c(summary_content, col_info)
  }
  
  # Write summary
  writeLines(summary_content, output_file)
  cat("Analysis summary saved to:", output_file, "\n")
}

# =============================================================================
# 8. PERFORMANCE MONITORING
# =============================================================================

# Performance monitoring function
monitor_performance <- function(expr, description = "Operation") {
  start_time <- Sys.time()
  result <- expr
  end_time <- Sys.time()
  
  duration <- end_time - start_time
  
  cat(description, "completed in:", round(duration, 2), "seconds\n")
  
  # Log performance
  log_entry <- paste0(
    Sys.time(), " - ", description, " - Duration: ", round(duration, 2), " seconds\n"
  )
  
  write(log_entry, file = "performance_log.txt", append = TRUE)
  
  return(result)
}

# Memory usage monitoring
monitor_memory <- function() {
  memory_info <- gc()
  cat("Memory usage:\n")
  print(memory_info)
  
  # Log memory usage
  log_entry <- paste0(
    Sys.time(), " - Memory usage - Used: ", 
    round(sum(memory_info[, "used"]), 2), " MB\n"
  )
  
  write(log_entry, file = "memory_log.txt", append = TRUE)
}

# =============================================================================
# 9. ERROR HANDLING AND LOGGING
# =============================================================================

# Logging function
log_message <- function(message, level = "INFO", log_file = "analysis.log") {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  log_entry <- paste0(timestamp, " [", level, "] ", message, "\n")
  
  write(log_entry, file = log_file, append = TRUE)
  cat(log_entry)
}

# Error handling wrapper
safe_execute <- function(expr, description = "Operation") {
  tryCatch({
    log_message(paste("Starting:", description))
    result <- expr
    log_message(paste("Completed:", description))
    return(result)
  }, error = function(e) {
    log_message(paste("Error in", description, ":", e$message), "ERROR")
    return(NULL)
  })
}

# =============================================================================
# 10. COLLABORATION AND SHARING
# =============================================================================

# Create project package
create_project_package <- function(project_name) {
  # Create package structure
  create_project_structure(project_name)
  
  # Create package files
  package_files <- c(
    "DESCRIPTION",
    "NAMESPACE",
    "R/package_functions.R",
    "man/package_functions.Rd",
    "tests/testthat/test-package_functions.R"
  )
  
  for (file in package_files) {
    file_path <- file.path(project_name, file)
    dir.create(dirname(file_path), recursive = TRUE, showWarnings = FALSE)
    
    if (file == "DESCRIPTION") {
      content <- paste0(
        "Package: ", project_name, "\n",
        "Title: ", project_name, " Package\n",
        "Version: 0.1.0\n",
        "Author: Your Name\n",
        "Description: A package for data analysis\n",
        "License: MIT\n",
        "Depends: R (>= 3.5.0)\n",
        "Imports: dplyr, ggplot2\n"
      )
    } else if (file == "NAMESPACE") {
      content <- "export(analyze_data)\nimport(dplyr)\nimport(ggplot2)\n"
    } else {
      content <- paste0("# ", file, "\n# Add your code here\n")
    }
    
    writeLines(content, file_path)
  }
  
  cat("Project package created:", project_name, "\n")
}

# =============================================================================
# 11. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create a complete project structure for a data analysis project
# including all necessary directories and files

# Exercise 2: Write a function that manages data versions and allows
# loading specific versions

# Exercise 3: Create a configuration system that allows easy modification
# of analysis parameters

# Exercise 4: Implement a logging system that tracks all operations
# and errors in your analysis

# =============================================================================
# SOLUTIONS TO EXERCISES
# =============================================================================

# Solution 1: Complete project structure
create_complete_project <- function(project_name) {
  # Create main structure
  create_project_structure(project_name)
  
  # Create additional files
  additional_files <- c(
    "code/01_data_import.R",
    "code/02_data_cleaning.R",
    "code/03_analysis.R",
    "code/04_visualization.R",
    "docs/report.Rmd",
    "tests/test_analysis.R",
    "config.R",
    "requirements.txt"
  )
  
  for (file in additional_files) {
    file_path <- file.path(project_name, file)
    dir.create(dirname(file_path), recursive = TRUE, showWarnings = FALSE)
    
    if (file == "code/01_data_import.R") {
      content <- c(
        "# Data Import Script",
        "",
        "# Load required packages",
        "library(readr)",
        "library(readxl)",
        "",
        "# Import data",
        "data <- read_csv(\"data/raw/data.csv\")",
        "",
        "# Save imported data",
        "saveRDS(data, \"data/processed/imported_data.rds\")"
      )
    } else if (file == "code/02_data_cleaning.R") {
      content <- c(
        "# Data Cleaning Script",
        "",
        "# Load required packages",
        "library(dplyr)",
        "library(janitor)",
        "",
        "# Load data",
        "data <- readRDS(\"data/processed/imported_data.rds\")",
        "",
        "# Clean data",
        "cleaned_data <- data %>%",
        "  clean_names() %>%",
        "  filter(!is.na(important_column)) %>%",
        "  mutate(new_column = old_column * 2)",
        "",
        "# Save cleaned data",
        "saveRDS(cleaned_data, \"data/processed/cleaned_data.rds\")"
      )
    } else if (file == "code/03_analysis.R") {
      content <- c(
        "# Analysis Script",
        "",
        "# Load required packages",
        "library(dplyr)",
        "library(broom)",
        "",
        "# Load data",
        "data <- readRDS(\"data/processed/cleaned_data.rds\")",
        "",
        "# Perform analysis",
        "analysis_results <- data %>%",
        "  group_by(category) %>%",
        "  summarise(",
        "    mean_value = mean(value),",
        "    sd_value = sd(value)",
        "  )",
        "",
        "# Save results",
        "saveRDS(analysis_results, \"output/tables/analysis_results.rds\")"
      )
    } else if (file == "code/04_visualization.R") {
      content <- c(
        "# Visualization Script",
        "",
        "# Load required packages",
        "library(ggplot2)",
        "",
        "# Load data",
        "data <- readRDS(\"data/processed/cleaned_data.rds\")",
        "",
        "# Create plots",
        "plot <- ggplot(data, aes(x = x, y = y)) +",
        "  geom_point() +",
        "  geom_smooth(method = \"lm\") +",
        "  labs(title = \"Analysis Results\")",
        "",
        "# Save plot",
        "ggsave(\"output/figures/analysis_plot.png\", plot, width = 10, height = 6)"
      )
    } else if (file == "docs/report.Rmd") {
      content <- c(
        "---",
        "title: \"Analysis Report\"",
        "author: \"Your Name\"",
        "date: \"`r Sys.Date()`\"",
        "output: html_document",
        "---",
        "",
        "```{r setup, include=FALSE}",
        "knitr::opts_chunk$set(echo = TRUE)",
        "```",
        "",
        "# Analysis Report",
        "",
        "This report presents the results of our data analysis.",
        "",
        "## Data Overview",
        "",
        "```{r data-overview}",
        "data <- readRDS(\"data/processed/cleaned_data.rds\")",
        "summary(data)",
        "```",
        "",
        "## Results",
        "",
        "```{r results}",
        "results <- readRDS(\"output/tables/analysis_results.rds\")",
        "knitr::kable(results)",
        "```"
      )
    } else {
      content <- paste0("# ", file, "\n# Add your content here\n")
    }
    
    writeLines(content, file_path)
  }
  
  cat("Complete project structure created:", project_name, "\n")
}

# Test the function
# create_complete_project("my_analysis_project")

# Solution 2: Data version management
data_version_manager <- function() {
  # Create version manager
  manager <- list(
    versions = character(0),
    current_version = NULL,
    
    # Add new version
    add_version = function(data, version = NULL) {
      if (is.null(version)) {
        version <- format(Sys.time(), "%Y%m%d_%H%M%S")
      }
      
      filename <- paste0("data_v", version, ".rds")
      saveRDS(data, filename)
      
      self$versions <<- c(self$versions, version)
      self$current_version <<- version
      
      cat("Data version", version, "saved\n")
      return(version)
    },
    
    # Load version
    load_version = function(version) {
      if (!version %in% self$versions) {
        stop("Version not found:", version)
      }
      
      filename <- paste0("data_v", version, ".rds")
      data <- readRDS(filename)
      self$current_version <<- version
      
      cat("Loaded data version:", version, "\n")
      return(data)
    },
    
    # List versions
    list_versions = function() {
      cat("Available versions:\n")
      for (v in self$versions) {
        cat("-", v, "\n")
      }
    },
    
    # Get current version
    get_current_version = function() {
      return(self$current_version)
    }
  )
  
  return(manager)
}

# Test the version manager
# vm <- data_version_manager()
# vm$add_version(mtcars, "v1")
# vm$add_version(mtcars, "v2")
# vm$list_versions()

# Solution 3: Configuration system
configuration_system <- function() {
  config <- list(
    # Default configuration
    defaults = list(
      data_path = "data/",
      output_path = "output/",
      significance_level = 0.05,
      random_seed = 123,
      figure_format = "png",
      figure_dpi = 300
    ),
    
    # Current configuration
    current = list(),
    
    # Load configuration
    load = function(config_file = "config.R") {
      if (file.exists(config_file)) {
        source(config_file, local = TRUE)
        self$current <<- as.list(environment())
        cat("Configuration loaded from:", config_file, "\n")
      } else {
        cat("Configuration file not found, using defaults\n")
        self$current <<- self$defaults
      }
    },
    
    # Get configuration value
    get = function(key) {
      if (key %in% names(self$current)) {
        return(self$current[[key]])
      } else if (key %in% names(self$defaults)) {
        return(self$defaults[[key]])
      } else {
        stop("Configuration key not found:", key)
      }
    },
    
    # Set configuration value
    set = function(key, value) {
      self$current[[key]] <<- value
      cat("Configuration updated:", key, "=", value, "\n")
    },
    
    # Save configuration
    save = function(config_file = "config.R") {
      config_content <- c(
        "# Configuration File",
        "# Generated on:", Sys.time(),
        ""
      )
      
      for (key in names(self$current)) {
        value <- self$current[[key]]
        if (is.character(value)) {
          config_content <- c(config_content, paste0(key, " <- \"", value, "\""))
        } else {
          config_content <- c(config_content, paste0(key, " <- ", value))
        }
      }
      
      writeLines(config_content, config_file)
      cat("Configuration saved to:", config_file, "\n")
    }
  )
  
  return(config)
}

# Test the configuration system
# config <- configuration_system()
# config$load()
# config$set("significance_level", 0.01)
# config$save()

# Solution 4: Logging system
logging_system <- function() {
  logger <- list(
    log_file = "analysis.log",
    log_levels = c("DEBUG", "INFO", "WARNING", "ERROR"),
    current_level = "INFO",
    
    # Log message
    log = function(message, level = "INFO") {
      if (level %in% self$log_levels) {
        timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
        log_entry <- paste0(timestamp, " [", level, "] ", message, "\n")
        
        write(log_entry, file = self$log_file, append = TRUE)
        cat(log_entry)
      }
    },
    
    # Set log level
    set_level = function(level) {
      if (level %in% self$log_levels) {
        self$current_level <<- level
        cat("Log level set to:", level, "\n")
      } else {
        stop("Invalid log level:", level)
      }
    },
    
    # Log with current level
    info = function(message) {
      self$log(message, "INFO")
    },
    
    warning = function(message) {
      self$log(message, "WARNING")
    },
    
    error = function(message) {
      self$log(message, "ERROR")
    },
    
    debug = function(message) {
      self$log(message, "DEBUG")
    }
  )
  
  return(logger)
}

# Test the logging system
# logger <- logging_system()
# logger$info("Analysis started")
# logger$warning("Missing data detected")
# logger$error("Analysis failed")

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. Organize your project with a clear structure
# 2. Use version control for all your code
# 3. Manage dependencies with requirements files
# 4. Create configuration files for easy parameter changes
# 5. Implement data versioning for reproducibility
# 6. Use logging to track your analysis progress
# 7. Monitor performance and memory usage
# 8. Create comprehensive documentation
# 9. Implement quality assurance checks
# 10. Use automation for repetitive tasks
# 11. Plan for collaboration and sharing
# 12. Test your code thoroughly
# 13. Keep your project organized and clean
# 14. Document your workflow and decisions
# 15. Continuously improve your project management

# Next: Apply these project management practices to your R projects!
