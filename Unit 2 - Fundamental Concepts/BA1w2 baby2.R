# ==========================================================
# Purpose: RScript for Team Challenge in BA1 Week 2 class.
# Author:  Neumann Chew
# DOC:     20-08-2017
#===========================================================

# Set a working directory to store all the related datasets and files for a specific project.
setwd("C:\\Users\\Brandon PC\\OneDrive - Nanyang Technological University\\NTU Notes\\Biz\\BC2406 Analytics I Visual & Predictive Techniques\\Unit 2 - Fundamental Concepts")

# Import a data file and store as R object baby2_data in R.
baby2_data <- read.csv("baby2.csv")

# Utilize a data table
library(data.table)
baby2.dt <- fread('baby2.csv')
baby2.dt[Weight >0 ,]

data <- baby2_data[complete.cases(baby2_data),]

# Calculate the average weight of all babies.
mean(data$Weight)
# 7.788088
mean(baby2_data$Weight, na.rm = T)
# Calculate the std dev of weight of all babies.
sd(data$Weight)
# 1.749672

# Calculate the correlation between age and weight.
cor(data$Age, data$Weight)
# 0.9367088
# use='complete.obs"

# Scatterplot with x-axis = age, y-axis = weight.
plot(data$Age, data$Weight)


# Q: Is there a better and faster way to get summary statistics
#    of all the variables in the dataset, instead of one variable at a time?
summary(data)
sapply(baby2_data, sd, na.rm = T)
