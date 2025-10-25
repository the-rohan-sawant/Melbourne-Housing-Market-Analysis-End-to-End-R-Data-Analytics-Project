# READING AND WRITING FILES


 
# Read data set

melb_data <- read.csv("C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data.csv")



# View structure and summary

head(melb_data)

str(melb_data)

summary(melb_data)



# Save data set to a new file

write.csv(melb_data, "C:/Rohan/R-Programming-for-Data-Analysts-main/Datasets/melb_data_output.csv", row.names = FALSE)
