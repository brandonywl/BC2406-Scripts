# Q3.1
?cor

# Q3.2 By using "health_ins_cust.csv," draw the following scatter plots of health 
# insurance coverage and income without and with jittered function. Discuss what you can see from the graphs.
setwd("C:\\Users\\Brandon PC\\OneDrive - Nanyang Technological University\\NTU Notes\\Biz\\BC2406 Analytics I Visual & Predictive Techniques\\Unit 3 - Data Exploration")

data1 <- read.csv("health_ins_cust.csv")
summary(data1)

options(scipen=0)

# Non-jittered Y
plot(data1$income, data1$health.ins, main = "Health Insurance Coverage across Income", ylab = "Health Insurance Coverage", xlab = "Income")

# Jittered Y
plot(data1$income, jitter(as.numeric(data1$health.ins)), main = "Health Insurance Coverage across Income", ylab = "Health Insurance Coverage", xlab = "Income")

# From the non-jittered graph, I observe that most people with higher income mostly do have health insurance except for the two outliers.
# From the jittered graph, I observe that this trend extends across the spectrum of the income bracket. Most people do have health insurance, except those that don't largely concentrate
# at low-income levels

# Q3.3 The following graph shows the scatterplot of Age and Income. Here, we do not need to use jitter. Why?

# Here, Y is a continuous variable and has more variation than a categorical Y (0 and 1). We are not interested
# finding out each distinct point, but rather the general relationship between the two relationship.
# Furthermore, jittering Y would cause the value of Y to not be accurate and hence corrupting the data.

