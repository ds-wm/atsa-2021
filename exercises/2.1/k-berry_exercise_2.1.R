# Applied Time Series Analysis
# Exercise 2.1
# author: Kelton Berry
# created: 2021-04-06
#
#
#
# PROBLEM STATEMENT: Create an R script that performs the following analysis. 
# 1. Combine the 12 individual measurements into 2 versions of the data.
#    * original
#    * duplicate free
# 2. Aggregate (using arithmetic means) the two individual time series into 
#    * 15-minute, 60-minute, 12-hour, and 24-hour averages
# 3. Calculate the correlation coefficient (Pearson's R), the coefficient of 
#    determination (r-squared), and root-mean-squared error (RMSE) for each of 
#    the four time aggregations of ADC0, ADC1, and ADC2 (converted to physical 
#    units) comparing the original versus duplicate-free data.
# 4. Create three plots (one for ADC0, ADC1, ADC2) showing the original 
#    time-aggregated data plotted against the duplicate free data. 
#    Include the metrics in the plot.


source('kberryb2_utility.R')
install.packages("Metrics") # run if not already installed!
library("Metrics")
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## READ THE DATA
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Locate urls
s2003.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt"
s2015.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt"
s2025.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt"
s2045.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt"
s2055.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt"
s2065.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt"
s2085.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt"
s2095.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt"
s2103.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt"
s2115.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt"
s2125.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt"
s2135.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt"

# Read in data as CSV
s2003 <- read.csv(s2003.url)
s2015 <- read.csv(s2015.url)
s2025 <- read.csv(s2025.url)
s2045 <- read.csv(s2045.url)
s2055 <- read.csv(s2055.url)
s2065 <- read.csv(s2065.url)
s2085 <- read.csv(s2085.url)
s2095 <- read.csv(s2095.url)
s2103 <- read.csv(s2103.url)
s2115 <- read.csv(s2115.url)
s2125 <- read.csv(s2125.url)
s2135 <- read.csv(s2135.url)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## IDENTIFY DUPLICATES
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Based on the reading, the psuedo code for identifying duplicates within a
# sensor's data file is as follows (NOTE: there are other valid definitions):
# Reference: https://doi.org/10.3390/jsan3040297
#
# Algorithm 1:	Identifies and Removes Duplicate Packets
#   Input:	Packets from the same node ordered by time and marked as valid
#   Output:	Packets marked either as valid or duplicate
#   Begin
#   While pkti = nextValidPacket() do
#     While pkti is valid AND pktj = nextValidPacket() do
#       If |pkti.time - pktj.time| < T - dT then
#         If pkti.content == pktj.content then
#           Mark pktj as a duplicate of pkti
#         End
#       Else
#         Break loop on pktj
#     End
#   End
#   pkti = nextValidPacket()
#   End
#   End
#
# The network has a sampling period, T, of 15 minutes.
# The paper experiments with dt = 2 minutes.
#
# The data files are presorted by the result time; therefore, it is just a
# matter of checking for valid packets and checking its neighbors to see
# if they are duplicates. Let's use battery voltage as our first criteria
#
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Filter for valid measurements
###  * note that the battery level impacts all measurements and we
###    will take care of individual measurements at time of averaging
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003 <- s2003[s2003$voltage >= 2600, ]
s2015 <- s2015[s2015$voltage >= 2600, ]
s2025 <- s2025[s2025$voltage >= 2600, ]
s2045 <- s2045[s2045$voltage >= 2600, ]
s2055 <- s2055[s2055$voltage >= 2600, ]
s2065 <- s2065[s2065$voltage >= 2600, ]
s2085 <- s2085[s2085$voltage >= 2600, ]
s2095 <- s2095[s2095$voltage >= 2600, ]
s2103 <- s2103[s2103$voltage >= 2600, ]
s2115 <- s2115[s2115$voltage >= 2600, ]
s2125 <- s2125[s2125$voltage >= 2600, ]
s2135 <- s2135[s2135$voltage >= 2600, ]

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Add duplicate marker column (0: valid; 1: duplicate)
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003$dup <- 0
s2015$dup <- 0
s2025$dup <- 0
s2045$dup <- 0
s2055$dup <- 0
s2065$dup <- 0
s2085$dup <- 0
s2095$dup <- 0
s2103$dup <- 0
s2115$dup <- 0
s2125$dup <- 0
s2135$dup <- 0

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Add time column (this method uses POSIXct for dates/times)
### and allows to check for time differences between rows in seconds
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003$date <- as.POSIXct(s2003$result_time)
s2015$date <- as.POSIXct(s2015$result_time)
s2025$date <- as.POSIXct(s2025$result_time)
s2045$date <- as.POSIXct(s2045$result_time)
s2055$date <- as.POSIXct(s2055$result_time)
s2065$date <- as.POSIXct(s2065$result_time)
s2085$date <- as.POSIXct(s2085$result_time)
s2095$date <- as.POSIXct(s2095$result_time)
s2103$date <- as.POSIXct(s2103$result_time)
s2115$date <- as.POSIXct(s2115$result_time)
s2125$date <- as.POSIXct(s2125$result_time)
s2135$date <- as.POSIXct(s2135$result_time)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Mark the duplicates
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003 <- find_duplicates(s2003)
s2003 <- find_duplicates(s2003) 
s2015 <- find_duplicates(s2015)
s2025 <- find_duplicates(s2025)
s2045 <- find_duplicates(s2045)
s2055 <- find_duplicates(s2055) 
s2065 <- find_duplicates(s2065) 
s2085 <- find_duplicates(s2085) 
s2095 <- find_duplicates(s2095) 
s2103 <- find_duplicates(s2103) 
s2115 <- find_duplicates(s2115)
s2125 <- find_duplicates(s2125)
s2135 <- find_duplicates(s2135)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## CREATE DUPLICATE-FREE COPIES
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003.df <- s2003[s2003$dup == 0, ]
s2015.df <- s2015[s2015$dup == 0, ]
s2025.df <- s2025[s2025$dup == 0, ]
s2045.df <- s2045[s2045$dup == 0, ]
s2055.df <- s2055[s2055$dup == 0, ]
s2065.df <- s2065[s2065$dup == 0, ]
s2085.df <- s2085[s2085$dup == 0, ]
s2095.df <- s2095[s2095$dup == 0, ]
s2103.df <- s2103[s2103$dup == 0, ]
s2115.df <- s2115[s2115$dup == 0, ]
s2125.df <- s2125[s2125$dup == 0, ]
s2135.df <- s2135[s2135$dup == 0, ]

# Merge all data.frames together
orig.df <- merge_list(list(s2003, s2015, s2025, s2045, s2055, s2065, s2085, s2095, s2103, s2115, s2125, s2135))
nodup.df <- merge_list(list(s2003.df, s2015.df, s2025.df, s2045.df, s2055.df, s2065.df, s2085.df, s2095.df, s2103.df, s2115.df, s2125.df, s2135.df))


# Sort by time
orig.df <- orig.df[order(orig.df$date), ]
nodup.df <- nodup.df[order(nodup.df$date), ]



## USe the agg_time to find intervsl of agregrate dat
# First ususing the df with duplicates
#Note: must be patient, takes an extraordrinary time to run
agg_fifteen <- agg_time(t.step = 15, orig.df)
agg_hour <- agg_time(t.step = 60, orig.df)
agg_half <- agg_time(t.step = 12*60, orig.df)
agg_day <- agg_time(t.step = 24*60, orig.df)

#Second using the df with no duplicates
agg_fifteen_nd <- agg_time(t.step = 15, nodup.df)
agg_hour_nd <- agg_time(t.step = 60, nodup.df)
agg_half_nd <- agg_time(t.step = 12*60, nodup.df)
agg_day_nd <- agg_time(t.step = 24*60, nodup.df)



## Convert aggregate values to via the calcSwp and calcVwc function

# First using the df with duplicates

agg_fifteen$adc0 <- calcSwp(agg_fifteen$adc0)
agg_fifteen$adc1 <- calcVwc(agg_fifteen$adc1)
agg_fifteen$adc2  <- calcVwc(agg_fifteen$adc2)

agg_hour$adc0 <- calcSwp(agg_hour$adc0)
agg_hour$adc1 <- calcVwc(agg_hour$adc1)
agg_hour$adc2 <- calcVwc(agg_hour$adc2)

agg_half$adc0 <- calcSwp(agg_half$adc0)
agg_half$adc1 <- calcVwc(agg_half$adc1)
agg_half$adc2 <- calcVwc(agg_half$adc2)

agg_day$adc0  <- calcSwp(agg_day$adc0)
agg_day$adc1  <- calcVwc(agg_day$adc1)
agg_dayf$adc2  <- calcVwc(agg_day$adc2)


# Now with no duplicates

agg_fifteen_nd$adc0 <- calcSwp(agg_fifteen_nd$adc0)
agg_fifteen_nd$adc1 <- calcVwc(agg_fifteen_nd$adc1)
agg_fifteen_nd$adc2  <- calcVwc(agg_fifteen_nd$adc2)

agg_hour_nd$adc0 <- calcSwp(agg_hour_nd$adc0)
agg_hour_nd$adc1 <- calcVwc(agg_hour_nd$adc1)
agg_hour_nd$adc2 <- calcVwc(agg_hour_nd$adc2)

agg_half_nd$adc0 <- calcSwp(agg_half_nd$adc0)
agg_half_nd$adc1 <- calcVwc(agg_half_nd$adc1)
agg_half_nd$adc2 <- calcVwc(agg_half_nd$adc2)

agg_day_nd$adc0 <- calcSwp(agg_day_nd$adc0)
agg_day_nd$adc1 <- calcVwc(agg_day_nd$adc1)
agg_day_nd$adc2 <- calcVwc(agg_day_nd$adc2)

#Get correlation coefficient, or Persons C


fifteen_cor <- cor(agg_fifteen[1:3], agg_fifteen_nd[1:3], method='pearson')
hour_cor <- cor(agg_hour[1:3], agg_day_nd[1:3], method = 'pearson')
half_cor <- cor(agg_half[1:3], agg_half_nd[1:3], method = 'pearson')
day_cor <- cor(agg_day[1:3], agg_day_nd[1:3], method = 'pearson')

# Get R-squared

fifteen_squared <- (fifteen_cor)^2
hour_squared <- (hour_cor)^2
half_squared <- (half_cor)^2
day_squared <- (day_cor)^2

#Get root-mean-squared error (RMSE)

fifteen_rmse.adc0 <- rmse(agg_fifteen$adc0, agg_fifteen_nd$adc0)
fifteen_rmse.adc1 <- rmse(agg_fifteen$adc1, agg_fifteen_nd$adc1)
fifteen_rmse.adc2 <- rmse(agg_fifteen$adc2, agg_fifteen_nd$adc2)

hour_rmse.adc0 <- rmse(agg_hour$adc0, agg_hour_nd$adc0)
hour_rmse.adc1 <- rmse(agg_hour$adc1, agg_hour_nd$adc1)
hour_rmse.adc2 <- rmse(agg_hour$adc2, agg_hour_nd$adc2)

half_rsme.adc0 <- rmse(agg_half$adc0, agg_half_nd$adc0)
half_rsme.adc1 <- rmse(agg_half$adc1, agg_half_nd$adc1)
rhalf_rsme.adc2 <- rmse(agg_half$adc2, agg_half_nd$adc2)

day_rsme.adc0 <- rmse(agg_day$adc0, agg_day_nd$adc0)
day_rsme.adc1 <- rmse(agg_day$adc1, agg_day_nd$adc1)
day_rsme.adc2 <- rmse(agg_day$adc2, agg_day_nd$adc2)


#Plotting ADC0

# ADC0
plot(agg_fifteen$adc0, agg_fifteen_np$adc0,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "15-Minute Aggregation: ADC0")

plot(agg_hour$adc0, agg_hour_np$adc0,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "Hour Aggregation: ADC0")

plot(agg_half$adc0, agg_half_np$adc0,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "12 Hour Aggregation: ADC0")

plot(agg_day$adc0, agg_day_np$adc0,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "24 Hour Aggregation: ADC0")

#ADC1


plot(agg_fifteen$adc1, agg_fifteen_np$adc1,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "15-Minute Aggregation: ADC1")

plot(agg_hour$adc1, agg_hour_np$adc1,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "Hour Aggregation: ADC1")

plot(agg_half$adc1, agg_half_np$adc1,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "12 Hour Aggregation: ADC1")

plot(agg_day$adc1, agg_day_np$adc1,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "24 Hour Aggregation: ADC1")

#ADC2

plot(agg_fifteen$adc2, agg_fifteen_np$adc2,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "15-Minute Aggregation: ADC2")

plot(agg_hour$adc2, agg_hour_np$adc2,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "Hour Aggregation: ADC2")

plot(agg_half$adc2, agg_half_np$adc2,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "12 Hour Aggregation: ADC2")

plot(agg_day$adc2, agg_day_np$adc2,type = 'p',
     xlab = "Soil water potent (originial state)", 
     ylab = "Soil water potent (w/ no duplicates)",
     main = "24 Hour Aggregation: ADC2")



















































































































