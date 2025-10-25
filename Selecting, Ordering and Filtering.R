# SELECTING, ORDERING AND FILTERING DATA

library(dplyr)

melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")


# Selecting specific columns

selected_data <- melb_data %>%
                 select(Suburb, Price, Rooms, Bathroom, Date, Distance, Type)



# Ordering data by Price (descending)
ordered_data <- melb_data %>%
                arrange(desc(Price))



# Filtering properties with Price > 1,000,000
filtered_data <- melb_data %>%
                 filter(Price > 1000000)