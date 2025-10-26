############################################################
# 🏠 MELBOURNE HOUSING MARKET DASHBOARD — R SHINY
# Author: Rohan Sawant
# Description: Interactive dashboard for the Melbourne
# Housing dataset with filters, summaries, and visualizations.
############################################################

# ==========================================================
# 1️⃣ LOAD LIBRARIES
# ==========================================================

library(shiny)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(tidyr)

# ==========================================================
# 2️⃣ LOAD AND CLEAN DATA
# ==========================================================
melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")

# --- Clean the dataset (same logic as your script)
melb_data$Bedroom2[is.na(melb_data$Bedroom2)] <- median(melb_data$Bedroom2, na.rm = TRUE)
melb_data$Bathroom[is.na(melb_data$Bathroom)] <- median(melb_data$Bathroom, na.rm = TRUE)
melb_data$Distance[is.na(melb_data$Distance)] <- median(melb_data$Distance, na.rm = TRUE)
melb_data$Suburb <- tolower(trimws(melb_data$Suburb))
melb_data$Type <- tolower(trimws(melb_data$Type))
melb_data$Price[melb_data$Price <= 0] <- median(melb_data$Price, na.rm = TRUE)
melb_data$Car[is.na(melb_data$Car)] <- 0
melb_data$YearBuilt[is.na(melb_data$YearBuilt)] <- "Unknown"
melb_data$Date <- parse_date_time(melb_data$Date, orders = c("d/m/Y"))
melb_data$Year <- year(melb_data$Date)
melb_data$Month <- month(melb_data$Date)

# ==========================================================
# 3️⃣ DASHBOARD UI
# ==========================================================
ui <- dashboardPage(
  dashboardHeader(title = "Melbourne Housing Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("home")),
      menuItem("Price Analysis", tabName = "price", icon = icon("chart-line")),
      menuItem("Suburb Insights", tabName = "suburb", icon = icon("city")),
      menuItem("Trends", tabName = "trend", icon = icon("calendar"))
    ),
    # Add filter inputs
    selectInput("suburbInput", "Select Suburb:", 
                choices = sort(unique(melb_data$Suburb)), 
                selected = "richmond"),
    selectInput("typeInput", "Property Type:", 
                choices = unique(melb_data$Type), 
                selected = "h"),
    sliderInput("priceRange", "Price Range (AUD):", 
                min = min(melb_data$Price, na.rm = TRUE),
                max = max(melb_data$Price, na.rm = TRUE),
                value = c(500000, 2000000), step = 50000)
  ),
  
  dashboardBody(
    tabItems(
      # =======================
      # 📊 Overview Tab
      # =======================
      tabItem(tabName = "overview",
              fluidRow(
                valueBoxOutput("totalSales"),
                valueBoxOutput("avgPrice"),
                valueBoxOutput("avgRooms")
              ),
              fluidRow(
                box(width = 12, title = "Dataset Preview", 
                    dataTableOutput("previewTable"))
              )
      ),
      
      # =======================
      # 💰 Price Analysis
      # =======================
      tabItem(tabName = "price",
              fluidRow(
                box(title = "Price Distribution by Type", width = 6, 
                    plotOutput("priceBoxPlot")),
                box(title = "Average Price by Rooms", width = 6, 
                    plotOutput("priceByRooms"))
              ),
              fluidRow(
                box(title = "Price Distribution (Histogram)", width = 12,
                    plotOutput("priceHist"))
              )
      ),
      
      # =======================
      # 🏙️ Suburb Insights
      # =======================
      tabItem(tabName = "suburb",
              fluidRow(
                box(title = "Selected Suburb Summary", width = 4,
                    tableOutput("suburbSummary")),
                box(title = "Price Distribution in Suburb", width = 8,
                    plotOutput("suburbPricePlot"))
              )
      ),
      
      # =======================
      # 📅 Trends
      # =======================
      tabItem(tabName = "trend",
              fluidRow(
                box(title = "Average Price Trend by Year", width = 12,
                    plotOutput("priceTrend"))
              )
      )
    )
  )
)

# ==========================================================
# 4️⃣ SERVER LOGIC
# ==========================================================
server <- function(input, output) {
  
  # Reactive filtered data
  filtered_data <- reactive({
    melb_data %>%
      filter(Suburb == input$suburbInput,
             Type == input$typeInput,
             Price >= input$priceRange[1],
             Price <= input$priceRange[2])
  })
  
  # KPIs
  output$totalSales <- renderValueBox({
    valueBox(format(nrow(filtered_data()), big.mark = ","), 
             subtitle = "Total Properties", 
             icon = icon("home"), color = "purple")
  })
  
  output$avgPrice <- renderValueBox({
    avg_price <- mean(filtered_data()$Price, na.rm = TRUE)
    valueBox(paste0("$", format(round(avg_price), big.mark = ",")), 
             subtitle = "Average Price", 
             icon = icon("dollar-sign"), color = "green")
  })
  
  output$avgRooms <- renderValueBox({
    avg_rooms <- mean(filtered_data()$Rooms, na.rm = TRUE)
    valueBox(round(avg_rooms, 1), 
             subtitle = "Average Rooms", 
             icon = icon("bed"), color = "blue")
  })
  
  # Table Preview
  output$previewTable <- renderDataTable({
    head(filtered_data()[, c("Suburb", "Price", "Rooms", "Type", "Date")], 10)
  })
  
  # Boxplot: Price by Type
  output$priceBoxPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Type, y = Price, fill = Type)) +
      geom_boxplot() +
      labs(title = "Price Distribution by Property Type", 
           x = "Type", y = "Price (AUD)") +
      theme_minimal()
  })
  
  # Histogram
  output$priceHist <- renderPlot({
    ggplot(filtered_data(), aes(x = Price)) +
      geom_histogram(binwidth = 100000, fill = "steelblue", color = "white") +
      scale_x_continuous(labels = comma) +
      labs(title = "Price Distribution", x = "Price (AUD)", y = "Count") +
      theme_light()
  })
  
  # Average price by rooms
  output$priceByRooms <- renderPlot({
    filtered_data() %>%
      group_by(Rooms) %>%
      summarise(AvgPrice = mean(Price, na.rm = TRUE)) %>%
      ggplot(aes(x = factor(Rooms), y = AvgPrice)) +
      geom_col(fill = "orange") +
      geom_text(aes(label = comma(round(AvgPrice))), vjust = -0.3, size = 3) +
      scale_y_continuous(labels = comma) +
      labs(title = "Average Price by Number of Rooms", 
           x = "Rooms", y = "Average Price (AUD)") +
      theme_classic()
  })
  
  # Suburb summary
  output$suburbSummary <- renderTable({
    filtered_data() %>%
      summarise(
        Properties = n(),
        Avg_Price = mean(Price, na.rm = TRUE),
        Median_Price = median(Price, na.rm = TRUE),
        Avg_Rooms = mean(Rooms, na.rm = TRUE)
      )
  })
  
  # Suburb histogram
  output$suburbPricePlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Price)) +
      geom_histogram(binwidth = 100000, fill = "coral", color = "black") +
      labs(title = paste("Price Distribution in", input$suburbInput),
           x = "Price (AUD)", y = "Count") +
      scale_x_continuous(labels = comma) +
      theme_minimal()
  })
  
  # Price trend by year
  output$priceTrend <- renderPlot({
    melb_data %>%
      group_by(Year) %>%
      summarise(Avg_Price = mean(Price, na.rm = TRUE)) %>%
      ggplot(aes(x = Year, y = Avg_Price)) +
      geom_line(color = "darkgreen", size = 1.2) +
      geom_point(color = "red", size = 2) +
      scale_y_continuous(labels = comma) +
      labs(title = "Average Price Trend by Year", 
           x = "Year", y = "Average Price (AUD)") +
      theme_minimal()
  })
}

# ==========================================================
# 5️⃣ RUN THE APP
# ==========================================================
shinyApp(ui, server)
