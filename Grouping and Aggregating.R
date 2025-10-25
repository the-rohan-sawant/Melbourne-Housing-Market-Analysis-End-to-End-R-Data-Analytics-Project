# GROUPING AND AGGREGATING

library(dplyr)

melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")



# Average Price per Suburb

avg_price_by_suburb <- melb_data %>%
                       group_by(Suburb) %>%
                       summarise(Average_Price = mean(Price, na.rm = TRUE))



# Total Properties by Type

total_properties_by_type <- melb_data %>%
                            group_by(Type) %>%
                            summarise(Total_Properties = sum(Propertycount, na.rm = TRUE))



# Median Rooms per Suburb

median_rooms_by_suburb <- melb_data %>%
                          group_by(Suburb) %>%
                          summarise(Median_Rooms = median(Rooms, na.rm = TRUE))