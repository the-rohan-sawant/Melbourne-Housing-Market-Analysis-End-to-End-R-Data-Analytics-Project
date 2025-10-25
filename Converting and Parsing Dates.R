# CONVERTING AND PARSING DATES

library(dplyr)
library(lubridate)

melb_clean <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")


melb_clean$Date <- parse_date_time(melb_clean$Date, orders = c("d/m/Y"))


# Extract year, month, and day

melb_clean$Year <- year(melb_clean$Date)
melb_clean$Month <- month(melb_clean$Date)
melb_clean$Day <- day(melb_clean$Date)



# Days since sale (using today's date)

melb_clean$Days_Since_Sale <- as.numeric(Sys.Date() - melb_clean$Date)



# Filter data for sales in 2017

sales_2017 <- melb_clean %>%
  filter(year(Date) == 2017)