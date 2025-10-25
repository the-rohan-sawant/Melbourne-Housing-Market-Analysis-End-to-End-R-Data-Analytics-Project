# DATA CLEANING

library(dplyr)
library(tidyr)

melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")

melb_clean <- melb_data


# Replace missing numeric values with medians

melb_clean$Bedroom2[is.na(melb_clean$Bedroom2)] <- median(melb_clean$Bedroom2, na.rm = TRUE)
melb_clean$Bathroom[is.na(melb_clean$Bathroom)] <- median(melb_clean$Bathroom, na.rm = TRUE)
melb_clean$Distance[is.na(melb_clean$Distance)] <- median(melb_clean$Distance, na.rm = TRUE)



# Trim white spaces and convert to lowercase

melb_clean$Suburb <- tolower(trimws(melb_clean$Suburb))
melb_clean$Type <- tolower(trimws(melb_clean$Type))



# Replace zero or unrealistic prices with median
melb_clean$Price[melb_clean$Price <= 0] <- median(melb_clean$Price, na.rm = TRUE)



# Fill missing categorical/numeric values
melb_clean$Car[is.na(melb_clean$Car)] <- 0
melb_clean$BuildingArea[is.na(melb_clean$BuildingArea)] <- NA
melb_clean$YearBuilt[is.na(melb_clean$YearBuilt)] <- "Unknown"



# Check missing values again
colSums(is.na(melb_clean))

