# REMOVING DUPLICATES

library(dplyr)
library(tidyr)

melb_clean <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")


# Remove full duplicate rows

melb_unique <- melb_clean %>%
               distinct()



# Remove duplicates based on Address

melb_unique_address <- melb_clean %>%
                       distinct(Address, .keep_all = TRUE)



# Arrange by Suburb (ascending) and Price (descending)

melb_arranged <- melb_clean %>%
                 arrange(Suburb, desc(Price))
