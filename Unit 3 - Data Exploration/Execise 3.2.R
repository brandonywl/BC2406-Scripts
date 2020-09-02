# Set up defaults
library(data.table)
setwd("C:\\Users\\Brandon PC\\OneDrive - Nanyang Technological University\\NTU Notes\\Biz\\BC2406 Analytics I Visual & Predictive Techniques\\Unit 3 - Data Exploration")

data1.dt <- fread("flights14.csv")[,!"year"]
data1.dt

# If else to set major delay
data1.dt[, major_delay:= ifelse((arr_delay + dep_delay) >= 60, 1, 0)]

# Create a new column where all major_delay = 0, then apply major_delay = 1 when arr_delay + dep_delay > 60
data1.dt <- data1.dt[, major_delay:=0][(arr_delay + dep_delay) >= 60, major_delay:=1]
summary(data1.dt)
# Verification
data1.dt[,sum((arr_delay + dep_delay) >= 60), keyby=.(major_delay)]

# Ordered number of major delays
data1.dt[major_delay == 1, .N, by = .(origin, dest, carrier)][order(-N)]


# data1.dt[,]
# data1.dt[,sum(arr_delay, dep_delay), by=.(origin, dest, carrier)][order(-V1)]

temp.data1.dt <- data1.dt[, `:=`(arr_delay = ifelse(arr_delay > 0, arr_delay, 0), dep_delay = ifelse(dep_delay > 0, dep_delay, 0))]

delay.data1.dt <- temp.data1.dt[, arr_delay + dep_delay, by= .(origin,dest,carrier)][order(-V1)]
delay.data1.dt[1:10,]

