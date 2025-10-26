# Module 3: Interactive Plots
# File: 14_Interactive_Plots.R

# =============================================================================
# CREATING INTERACTIVE PLOTS IN R
# =============================================================================

# This lesson covers creating interactive visualizations using
# plotly, leaflet, and other interactive plotting libraries

# =============================================================================
# 1. LOADING REQUIRED LIBRARIES
# =============================================================================

# Install required packages if not already installed
# install.packages(c("plotly", "leaflet", "DT", "shiny", "highcharter"))

library(plotly)
library(leaflet)
library(DT)
library(shiny)
library(highcharter)

# =============================================================================
# 2. CREATING SAMPLE DATA
# =============================================================================

set.seed(123)

# Create sample dataset
interactive_data <- data.frame(
  id = 1:50,
  name = paste("Person", 1:50),
  age = sample(18:65, 50, replace = TRUE),
  income = rnorm(50, mean = 50000, sd = 15000),
  education = sample(c("High School", "Bachelor's", "Master's", "PhD"), 50, replace = TRUE),
  department = sample(c("IT", "HR", "Finance", "Marketing", "Sales"), 50, replace = TRUE),
  performance = rnorm(50, mean = 75, sd = 15),
  satisfaction = sample(1:10, 50, replace = TRUE),
  latitude = runif(50, 40.7, 40.8),
  longitude = runif(50, -74.0, -73.9)
)

# Add some correlations
interactive_data$income <- interactive_data$income + interactive_data$age * 500
interactive_data$performance <- interactive_data$performance + interactive_data$satisfaction * 2

print(head(interactive_data))

# =============================================================================
# 3. INTERACTIVE SCATTER PLOTS WITH PLOTLY
# =============================================================================

# Basic interactive scatter plot
interactive_scatter <- plot_ly(interactive_data, 
                             x = ~age, 
                             y = ~income,
                             type = "scatter",
                             mode = "markers",
                             text = ~paste("Name:", name, "<br>Age:", age, "<br>Income:", income),
                             hoverinfo = "text") %>%
  layout(title = "Interactive Scatter Plot: Age vs Income",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Income"))

print(interactive_scatter)

# Scatter plot with color coding
interactive_scatter_color <- plot_ly(interactive_data, 
                                   x = ~age, 
                                   y = ~income,
                                   color = ~department,
                                   type = "scatter",
                                   mode = "markers",
                                   text = ~paste("Name:", name, "<br>Department:", department),
                                   hoverinfo = "text") %>%
  layout(title = "Interactive Scatter Plot by Department",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Income"))

print(interactive_scatter_color)

# =============================================================================
# 4. INTERACTIVE LINE PLOTS
# =============================================================================

# Create time series data
time_data <- data.frame(
  date = seq(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "month"),
  sales = cumsum(rnorm(12, mean = 100, sd = 20)),
  profit = cumsum(rnorm(12, mean = 50, sd = 15))
)

# Interactive line plot
interactive_line <- plot_ly(time_data, x = ~date) %>%
  add_trace(y = ~sales, name = "Sales", type = "scatter", mode = "lines+markers") %>%
  add_trace(y = ~profit, name = "Profit", type = "scatter", mode = "lines+markers") %>%
  layout(title = "Interactive Time Series Plot",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Value"))

print(interactive_line)

# =============================================================================
# 5. INTERACTIVE BAR PLOTS
# =============================================================================

# Create summary data
summary_data <- interactive_data %>%
  group_by(department) %>%
  summarise(
    avg_income = mean(income),
    avg_performance = mean(performance),
    count = n()
  )

# Interactive bar plot
interactive_bar <- plot_ly(summary_data, 
                          x = ~department, 
                          y = ~avg_income,
                          type = "bar",
                          text = ~paste("Department:", department, "<br>Avg Income:", round(avg_income, 2)),
                          hoverinfo = "text") %>%
  layout(title = "Interactive Bar Plot: Average Income by Department",
         xaxis = list(title = "Department"),
         yaxis = list(title = "Average Income"))

print(interactive_bar)

# =============================================================================
# 6. INTERACTIVE BOX PLOTS
# =============================================================================

# Interactive box plot
interactive_box <- plot_ly(interactive_data, 
                          x = ~department, 
                          y = ~income,
                          type = "box",
                          color = ~department) %>%
  layout(title = "Interactive Box Plot: Income by Department",
         xaxis = list(title = "Department"),
         yaxis = list(title = "Income"))

print(interactive_box)

# =============================================================================
# 7. INTERACTIVE HISTOGRAMS
# =============================================================================

# Interactive histogram
interactive_hist <- plot_ly(interactive_data, 
                           x = ~income,
                           type = "histogram",
                           nbinsx = 20) %>%
  layout(title = "Interactive Histogram: Income Distribution",
         xaxis = list(title = "Income"),
         yaxis = list(title = "Frequency"))

print(interactive_hist)

# =============================================================================
# 8. INTERACTIVE MAPS WITH LEAFLET
# =============================================================================

# Create interactive map
interactive_map <- leaflet(interactive_data) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = ~income/5000,
    popup = ~paste("Name:", name, "<br>Income:", income, "<br>Department:", department),
    color = ~ifelse(department == "IT", "red", 
                   ifelse(department == "HR", "blue",
                         ifelse(department == "Finance", "green",
                               ifelse(department == "Marketing", "orange", "purple"))))
  ) %>%
  addLegend("bottomright", 
            colors = c("red", "blue", "green", "orange", "purple"),
            labels = c("IT", "HR", "Finance", "Marketing", "Sales"),
            title = "Departments")

print(interactive_map)

# =============================================================================
# 9. INTERACTIVE TABLES WITH DT
# =============================================================================

# Create interactive data table
interactive_table <- datatable(interactive_data,
                              options = list(
                                pageLength = 10,
                                scrollX = TRUE,
                                dom = 'Bfrtip',
                                buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
                              ),
                              extensions = 'Buttons',
                              filter = 'top',
                              rownames = FALSE)

print(interactive_table)

# =============================================================================
# 10. INTERACTIVE DASHBOARD WITH SHINY
# =============================================================================

# Create a simple Shiny app
ui <- fluidPage(
  titlePanel("Interactive Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput("department", "Select Department:",
                  choices = unique(interactive_data$department),
                  selected = "IT"),
      sliderInput("age_range", "Age Range:",
                  min = min(interactive_data$age),
                  max = max(interactive_data$age),
                  value = c(min(interactive_data$age), max(interactive_data$age)))
    ),
    mainPanel(
      plotlyOutput("scatter_plot"),
      plotlyOutput("histogram")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    interactive_data %>%
      filter(department == input$department,
             age >= input$age_range[1],
             age <= input$age_range[2])
  })
  
  output$scatter_plot <- renderPlotly({
    plot_ly(filtered_data(), 
            x = ~age, 
            y = ~income,
            type = "scatter",
            mode = "markers") %>%
      layout(title = "Age vs Income",
             xaxis = list(title = "Age"),
             yaxis = list(title = "Income"))
  })
  
  output$histogram <- renderPlotly({
    plot_ly(filtered_data(), 
            x = ~income,
            type = "histogram") %>%
      layout(title = "Income Distribution",
             xaxis = list(title = "Income"),
             yaxis = list(title = "Frequency"))
  })
}

# Run the Shiny app
# shinyApp(ui = ui, server = server)

# =============================================================================
# 11. INTERACTIVE CHARTS WITH HIGHCHARTER
# =============================================================================

# Interactive chart with highcharter
interactive_chart <- highchart() %>%
  hc_chart(type = "scatter") %>%
  hc_add_series(data = interactive_data, 
                hcaes(x = age, y = income, group = department)) %>%
  hc_title(text = "Interactive Chart with Highcharter") %>%
  hc_xAxis(title = list(text = "Age")) %>%
  hc_yAxis(title = list(text = "Income")) %>%
  hc_tooltip(pointFormat = "Age: {point.x}<br>Income: {point.y}")

print(interactive_chart)

# =============================================================================
# 12. PRACTICE EXERCISES
# =============================================================================

# Exercise 1: Create an interactive scatter plot with plotly
# showing the relationship between age and income, colored by department

# Exercise 2: Create an interactive map showing the locations
# of your data points with popup information

# Exercise 3: Create an interactive data table with filtering
# and export options

# Exercise 4: Create a simple Shiny app with at least two
# interactive plots

# =============================================================================
# SOLUTIONS
# =============================================================================

# Solution 1:
exercise_scatter <- plot_ly(interactive_data, 
                           x = ~age, 
                           y = ~income,
                           color = ~department,
                           type = "scatter",
                           mode = "markers",
                           text = ~paste("Name:", name, "<br>Department:", department),
                           hoverinfo = "text") %>%
  layout(title = "Exercise 1 - Interactive Scatter Plot",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Income"))

print(exercise_scatter)

# Solution 2:
exercise_map <- leaflet(interactive_data) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = 5,
    popup = ~paste("Name:", name, "<br>Age:", age, "<br>Income:", income),
    color = "red"
  ) %>%
  addLegend("bottomright", 
            colors = "red",
            labels = "Data Points",
            title = "Legend")

print(exercise_map)

# Solution 3:
exercise_table <- datatable(interactive_data,
                           options = list(
                             pageLength = 5,
                             scrollX = TRUE,
                             dom = 'Bfrtip',
                             buttons = c('copy', 'csv', 'excel')
                           ),
                           extensions = 'Buttons',
                           filter = 'top')

print(exercise_table)

# Solution 4:
exercise_ui <- fluidPage(
  titlePanel("Exercise 4 - Simple Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput("education", "Select Education:",
                  choices = unique(interactive_data$education),
                  selected = "Bachelor's")
    ),
    mainPanel(
      plotlyOutput("box_plot"),
      plotlyOutput("bar_plot")
    )
  )
)

exercise_server <- function(input, output) {
  filtered_data <- reactive({
    interactive_data %>%
      filter(education == input$education)
  })
  
  output$box_plot <- renderPlotly({
    plot_ly(filtered_data(), 
            x = ~department, 
            y = ~income,
            type = "box") %>%
      layout(title = "Income by Department",
             xaxis = list(title = "Department"),
             yaxis = list(title = "Income"))
  })
  
  output$bar_plot <- renderPlotly({
    summary_data <- filtered_data() %>%
      group_by(department) %>%
      summarise(count = n())
    
    plot_ly(summary_data, 
            x = ~department, 
            y = ~count,
            type = "bar") %>%
      layout(title = "Count by Department",
             xaxis = list(title = "Department"),
             yaxis = list(title = "Count"))
  })
}

# Run the Shiny app
# shinyApp(ui = exercise_ui, server = exercise_server)

# =============================================================================
# KEY TAKEAWAYS
# =============================================================================

# 1. plotly creates interactive plots with hover information
# 2. leaflet creates interactive maps with markers and popups
# 3. DT creates interactive data tables with filtering
# 4. Shiny creates interactive web applications
# 5. highcharter provides additional chart types
# 6. Interactive plots enhance data exploration
# 7. Always provide meaningful hover information
# 8. Use appropriate colors and symbols
# 9. Consider your audience when designing interactions
# 10. Test your interactive plots thoroughly

# Next: Move to Module 4 - Advanced R Programming!
# Start with 15_Control_Structures.R
