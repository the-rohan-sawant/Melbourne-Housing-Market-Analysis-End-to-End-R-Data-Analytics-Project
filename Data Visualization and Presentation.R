# DATA VISUALIZATION AND PRESENTATION

library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)

# Load the Melbourne housing data set from the specified CSV file

melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")


# Convert the 'Date' column from character to Date format (day/month/year)

melb_data$Date <- parse_date_time(melb_data$Date, orders = c("d/m/Y"))


# Extract the year from the 'Date' column and create a new 'Year' column

melb_data$Year <- year(melb_data$Date)




# 1. Box Plot: Price by Property Type
               
               ggplot(melb_data, aes(x = Type, y = Price)) +
               geom_boxplot(fill = "lightblue", color = "darkblue") +
               labs(title = "Price by Property Type", x = "Property Type", y = "Price") +
               theme_minimal() +
               theme(axis.text.x = element_text(angle = 45, hjust = 1))



# 2. Scatter Plot: Rooms vs Price by Property Type
              ggplot(melb_data, aes(x = Rooms, y = Price, color = Type)) +
              geom_point(alpha = 0.6) +
              labs(title = "Rooms vs Price by Property Type", x = "Number of Rooms", y = "Price") +
              theme_light()



# 3. Histogram: Price Distribution
              ggplot(melb_data, aes(x = Price)) +
              geom_histogram(binwidth = 50000, fill = "steelblue", color = "white") +
              labs(title = "Price Distribution", x = "Price", y = "Count") +
              scale_x_continuous(labels = scales::comma) +
              theme_bw()




# 4. Bar Chart: Average Price by Number of Rooms
avg_by_rooms <- melb_data %>%
                group_by(Rooms) %>%
                summarise(Avg_Price = mean(Price, na.rm = TRUE), .groups = "drop")
                ggplot(avg_by_rooms, aes(x = factor(Rooms), y = Avg_Price)) +
                       geom_col(fill = "orange") +
                       geom_text(aes(label = scales::comma(round(Avg_Price, 0))), vjust = -0.3, size = 2.35) +
                       scale_y_continuous(labels = scales::comma) +
                       labs(title = "Average Price by Number of Rooms", x = "Number of Rooms", y = "Average Price") +
                       theme_classic()



# 5. Line Chart: Average Price Trend Over Years
avg_by_year <- melb_data %>%
               group_by(Year) %>%
               summarise(Avg_Price = mean(Price, na.rm = TRUE), .groups = "drop")
               ggplot(avg_by_year, aes(x = Year, y = Avg_Price)) +
               geom_line(size = 1, color = "darkgreen") +
               geom_point(size = 2, color = "darkred") +
               labs(title = "Average Price Trend Over Years", x = "Year", y = "Average Price") +
               scale_y_continuous(labels = scales::comma) +
               theme_minimal()