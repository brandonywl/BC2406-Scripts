# Exercise 4.1

# Q4.1: Records Data format is the most common data format (but not the only) for Analytics work. why?

# Records data format allows us to quickly and easily compare across observations as well as variables to do analysis.
# Records data format also allows us to quickly identify which inputs are null or invalid as opposed to transactional
# Records data format also likely follows how the data was input into the system.

# Q4.2: What is the usefulness of transactions data format? How is this different from Records data format?

# Transactions Data Format allows us to see how certain items are purchased together as well as keep track of who bought them.
# This format is not the same as a records data format which would have the items as one-hot encoded variables.
# Instead, the transactions data format only keeps track of what items is tied to the ID and not what is not purchased.
# It is good to see behavioural patterns as to whether buying one item would lead to the increased likelihood of buying another item.


# Q4.3: What is the difference between Nominal vs Ordinal? Why is this distinction important?

# Nominal implies that there is no order between categories. E.g. STATES ("NY", "NJ", "OL") and would probably be sorted by quantity
# Ordinal implies that there is an order between categories. E.g. YEAR (1, 2, 3, 4), SIZE ("S", "M", "L")
# The distinction allows for better presentation of results and an easier understanding of it.

# Q4.4: Integers (aka whole numbers) may be treated as either Continuous or Categorical, depending on purpose. 
#       Provide an example for each situation. [Explain in your own words.]

# Integers could be utilised as a Continous Variable to represent the price of an item, or the age of an individual.
# In the example of age, if we are using age of an individual to predict the spending habits of an individual ($ spent per month)
# The Age(Integer) could be used as a continuous variable if we understand the relationship between age and spending habits 
# to be a linear one. E.g. a unit increase in age would result in an increase in spending per month of $32.
# The Age could also be used as a categorical variable if we believe that each category would have a different spending habit
# E.g. 13 (Sec 1) may be low due to low pocket money, 14 (Sec 2) may be slightly higher, 15(Sec 3) may be highest
# while 16 (Sec 4) may be lower than 15 due to lack of time to spend the money.


#### LAWSUIT ####

setwd("C:\\Users\\Brandon PC\\OneDrive - Nanyang Technological University\\NTU Notes\\Biz\\BC2406 Analytics I Visual & Predictive Techniques\\Unit 4 - Data Structures and Visualization");

library(data.table)
lawsuit.dt <- fread("Lawsuit.csv")


# Exploratory Analysis
lawsuit.dt
summary(lawsuit.dt)

# Observe correlation of variables in the dataset through pairplot
pairs(lawsuit.dt)
# Pairplot seems to imply that all values are continuous

# Retrieve type for each variable
sapply(lawsuit.dt, class)

# Following the Dataset understanding from "Lawsuit Documentation.pdf"
# Dept = Categorical(Ordinal)
# Gender = Categorical(Nominal)
# Clin = Categorical (Nominal)
# Cert = Categorical (Nominal)
# Prate = Numeric Continuous
# Exper = Integer (Continous)
# Rank = Categorical (Ordinal)
# Sal94 = Integer Continuous
# Sal95 = Integer Continous

lawsuit.dt$Dept <- factor(lawsuit.dt$Dept, ordered = T, levels = c(1,2,3,4,5,6))
lawsuit.dt$Gender <- factor(lawsuit.dt$Gender)
lawsuit.dt$Clin <- factor(lawsuit.dt$Clin)
lawsuit.dt$Cert <- factor(lawsuit.dt$Cert)
# No need to clean Prate
# No need to clean Exper
lawsuit.dt$Rank <- factor(lawsuit.dt$Rank, ordered = T, levels = c(1,2,3))
# Clean Sal94 and Sal95 on further inspection

# Observe changes are saved
sapply(lawsuit.dt, class)
# Reobserve pairplot for general observations
pairs(lawsuit.dt)

# A. As an Analytics consultant for the female doctors , produce (a) summary table s , and /or (b)
# charts that show discrimination exists. [More than one correct answer
library(ggplot2)
install.packages("plyr")
library(plyr)

### Salary increment discrimination ###

discrimination.fem <- ggplot(data = lawsuit.dt, aes(Sal94))
discrimination.fem + geom_histogram(binwidth = 10000) + facet_grid(.~Gender)

# So we observe that there is a difference in the distribution of the Income, hence we do a boxplot to observe the
# value of the difference as well as the extent.

# Deduce median and 3rd and 1st quartile to plot on the boxplot

med.Sal94 <- ddply(lawsuit.dt, .(Gender), summarise, med = median(Sal94))
uQuantile.Sal94 <- ddply(lawsuit.dt, .(Gender), summarise, UQ = quantile(Sal94, 0.75))
lQuantile.Sal94 <- ddply(lawsuit.dt, .(Gender), summarise, LQ = quantile(Sal94, 0.25))

medText.Sal94 <- geom_text(data = med.Sal94, aes(x = Gender, y = med, label = med, size = 3, vjust = -0.5))
uQuantileText.Sal94 <- geom_text(data = uQuantile.Sal94, aes(x = Gender, y = UQ, label = UQ, size = 3, vjust = -0.5))
lQuantileText.Sal94 <- geom_text(data = lQuantile.Sal94, aes(x = Gender, y = LQ, label = LQ, size = 3, vjust = -0.5))


discrimination.box.fem.incr.94 <- ggplot(data = lawsuit.dt, aes(Gender, Sal94))
discrimination.box.fem.incr.94 + geom_boxplot() + medText.Sal94 + uQuantileText.Sal94 + lQuantileText.Sal94

# We observe that the median is significantly different. Furthermore, the greatest outlier for a female professor is significantly lower than a male.
# Let's observe this for Salary increment after 94

med.Sal95 <- ddply(lawsuit.dt, .(Gender), summarise, med = median(Sal95))
uQuantile.Sal95 <- ddply(lawsuit.dt, .(Gender), summarise, UQ = quantile(Sal95, 0.75))
lQuantile.Sal95 <- ddply(lawsuit.dt, .(Gender), summarise, LQ = quantile(Sal95, 0.25))

medText.Sal95 <- geom_text(data = med.Sal95, aes(x = Gender, y = med, label = med, size = 3, vjust = -0.5))
uQuantileText.Sal95 <- geom_text(data = uQuantile.Sal95, aes(x = Gender, y = UQ, label = UQ, size = 3, vjust = -0.5))
lQuantileText.Sal95 <- geom_text(data = lQuantile.Sal95, aes(x = Gender, y = LQ, label = LQ, size = 3, vjust = -0.5))

discrimination.box.fem.incr.95 <- ggplot(data = lawsuit.dt, aes(Gender, Sal95))
discrimination.box.fem.incr.95 + geom_boxplot() + medText.Sal95 + uQuantileText.Sal95 + lQuantileText.Sal95

# Difference in Median increment
med.Sal95$med - med.Sal94$med
# Males got > 5000 more than females at the average level as increment

uQuantile.Sal95$UQ - uQuantile.Sal94$UQ
# Even worse at upper quartiles. Nearly 14k less in increment

# So we prove that there is discrimination at salary increment

### Promotion Discrimination ###
ggplot(lawsuit.dt, aes(Rank)) + geom_bar() + facet_grid(.~Gender)
# Heavily skewed distribution from female to male. Clearly showing promotion discrimination


#### College Analyst #####

