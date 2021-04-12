#Alex Monaghan
#Professor Davis
#ATSA
#9 April 2021

#Exercise 2.1

install.packages("Metrics")
library("Metrics")
# Applied Time Series Analysis
# Exercise 2.1
# author: Tyler W. Davis, William & Mary
# created: 2021-03-26
# updated: 2021-03-26
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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## READ THE DATA
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Only looking at the first five CSVs
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

# Create function for reproducibility; this method needs run on each dataset

# ************************************************************************
# Name:     find_duplicates
# Inputs:   R data.frame with columns
#           * "nodeid", "parent", "voltage", "humid", "humtemp", "adc0"
#           * "adc1",   "adc2",   "adc3",    "adc4",  "adc5",    "adc6"
#           * "date" <- must be POSIXct object (others can be anything)
#           * "dup"  <- must be integer (0: original; 1: duplicate)
# Returns:  R data.frame (edited)
# Features: Assigns 1 to rows that are found to be duplicates based on
#           Algorithm 1 above.
# Ref:      https://doi.org/10.3390/jsan3040297
# ************************************************************************
find_duplicates <- function(my.df) {
  # Define the experimental delta, seconds
  kbd <- (15 - 2)*60
  
  # Get length of time series
  n <- length(my.df$result_time)
  
  # Define columns for checking duplicates (i.e., everything but time)
  check.cols <- c("nodeid", "parent", "voltage", "humid", "humtemp", "adc0", 
                  "adc1",   "adc2",   "adc3",    "adc4",  "adc5",    "adc6")
  
  for (i in 1:(n-1)) {
    for (j in (i+1):(n-1)) {
      # Check the time delta
      dt <- difftime(my.df$date[j], my.df$date[i], units = "secs")
      if (dt < kbd) {
        # We are in the search region; check for matching content;
        # the 'all' function is TRUE if all columns match
        d.mat <- all(my.df[i, check.cols] == my.df[j, check.cols])
        if (d.mat) {
          # In the search region w/ matching data; mark at duplicate
          my.df[j, "dup"] <- 1
        }
      } else {
        # We are passed the search region
        break
      }
    }
  }
  return(my.df)
}

s2003 <- find_duplicates(s2003) # Found 435 duplicates
s2015 <- find_duplicates(s2015) # Found 285 duplicates
s2025 <- find_duplicates(s2025) # Found 350 duplicates
s2045 <- find_duplicates(s2045) # Found 422 duplicates
s2055 <- find_duplicates(s2055) # Found 308 duplicates
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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## CREATE SINGLE DATAFRAME WITH ALL OBSERVATIONS SORTED BY TIME
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Create a helper function for merging a list of dataframes

# ************************************************************************
# Name:     merge_all
# Inputs:   list, list of data frames to aggregate by rows
# Returns:  R data.frame
# Features: Merges and sorts a list of data frames; rather than merge
#           just two data frames at a time.
# Ref:      https://www.r-bloggers.com/2011/01/merging-multiple-data-frames-in-r/
# ************************************************************************
merge_list <- function(listofdf){
  Reduce(
    function(x, y) merge(x, y, all=TRUE), listofdf)
}

# Merge all data.frames together
orig.df <- merge_list(list(s2003, s2015, s2025, s2045, s2055))
nodup.df <- merge_list(list(s2003.df, s2015.df, s2025.df, s2045.df, s2055.df))

# Sort by time
orig.df <- orig.df[order(orig.df$date), ]
nodup.df <- nodup.df[order(nodup.df$date), ]

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## AGGREGATE BY TIME STEP
## (work in progress)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TODO: turn this into a function

agg <- function(t.step, data){
  # Define the time step for aggregation
  t.step <- 15*60  # 15-minutes in seconds
  
  # Grab the first instance of time and roll back to the earliest whole hour
  #  * note: I don't know a method to find the earliest whole 15-minute
  #    so this will have to do
  t1 <- trunc(orig.df$date[1], "hour")
  
  # Grab the last time
  tn <- tail(orig.df, 1)$date
  
  # Grab total number of rows
  n <- length(orig.df$result_time)
  
  # Initialize a new empty dataframe for storing ensemble means
  ensemble.df <- orig.df[1==2, ]
  ensemble.df <- subset(ensemble.df, select = -result_time)  # remove this column
  
  # Initial the current time with the first time
  curr.t <- t1
  
  # The following is just an outline; needs to be completed.
  
  while (curr.t < tn) {
    next.t <- curr.t + t.step
    tmp.df <- orig.df[orig.df$date >= curr.t & orig.df$date < next.t, ]
    
    tmp.df <- tmp.df[tmp.df$adc0 >= 500 & tmp.df$adc0 <= 1000, ]
    tmp.df <- tmp.df[tmp.df$adc1 >= 250 & tmp.df$adc1 <= 1000, ]
    tmp.df <- tmp.df[tmp.df$adc2 >= 250 & tmp.df$adc2 <= 1000, ]
    
    if (is.nan(mean(tmp.df$adc0))) {
      adc0 <- 0
    }
    else {
      adc0 <- mean(tmp.df$adc0)
    }
    if (is.nan(mean(tmp.df$adc1))) {
      adc1 <- 0
    }
    else {
      adc1 <- mean(tmp.df$adc1)
    }
    if (is.nan(mean(tmp.df$adc2))) {
      adc2 <- 0
    }
    else {
      adc2 <- mean(tmp.df$adc2)
    }
    tmp <- data.frame(adc0, adc1, adc2, curr.t)
    names(tmp) <- c("adc0", "adc1", "adc2", "time")
    ensemble.df <- rbind(ensemble.df, tmp)
    
    # Update time
    curr.t <- curr.t + t.step
  }
  return(ensemble.df)
}
calcSwp <- function(data){  
  # '''
  # Input: dataframe column of adc0 values
  # Output: vector of converted soil water potential values
  # ''' 
  
  a <- 0.000048
  b <- 0.0846
  c <- 39.45
  
  output <- list()
  
  for (i in 1:length(data)){
    if (data[i] < 591 | data[i] > 841){
      output[[i]] = 0
    } 
    else 
    {
      output[[i]] = -1.0*exp( (a * data[i] * data[i]) - (b * data[i]) + c )
    }
  }
  
  return(unlist(output))
  
}


# Calculate soil moisture function

calc.Vwc <- function(data){
  # '''
  # Input: dataframe column of adc1 or adc2 values
  # Output: vector of converted soil moisture values
  # ''' 
  
  a = 0.00119
  b = 0.401
  
  output <- list()
  
  for (i in 1:length(data)){
    if (data[i] < 337 | data[i] > 841){
      output[[i]] <- 0
    }
    else
    {
      output[[i]] <- a * data[i] - b
    }
  }
  
  return(unlist(output))
  
}

agg15m <- agg(t.step = 15, orig.df)
agg60m <- agg(t.step = 60, orig.df)
agg12h <- agg(t.step = 12*60, orig.df)
agg24h <- agg(t.step = 24*60, orig.df)

agg15m_nd <- agg(t.step = 15, nodup.df)
agg60m_nd <- agg(t.step = 60, nodup.df)
agg12h_nd <- agg(t.step = 12*60, nodup.df)
agg24h_nd <- agg(t.step = 24*60, nodup.df)

agg_15m$adc0 <- calcSwp(agg_15m$adc0)
agg_15m$adc1 <- calcVwc(agg_15m$adc1)
agg_15m$adc2  <- calcVwc(agg_15m$adc2)

agg60m$adc0 <- calcSwp(agg60m$adc0)
agg60m$adc1 <- calcVwc(agg60m$adc1)
agg60m$adc2 <- calcVwc(agg60m$adc2)

agg12h$adc0 <- calcSwp(agg12h$adc0)
agg12h$adc1 <- calcVwc(agg12h$adc1)
agg12h$adc2 <- calcVwc(agg12h$adc2)

agg24h$adc0  <- calcSwp(agg24h$adc0)
agg24h$adc1  <- calcVwc(agg24h$adc1)
agg24hf$adc2  <- calcVwc(agg24h$adc2)

agg15m_nd$adc0 <- calcSwp(agg15m_nd$adc0)
agg15m_nd$adc1 <- calcVwc(agg15m_nd$adc1)
agg15m_nd$adc2  <- calcVwc(agg15m_nd$adc2)

agg60m_nd$adc0 <- calcSwp(agg60m_nd$adc0)
agg60m_nd$adc1 <- calcVwc(agg60m_nd$adc1)
agg60m_nd$adc2 <- calcVwc(agg60m_nd$adc2)

agg12h_nd$adc0 <- calcSwp(agg12h_nd$adc0)
agg12h_nd$adc1 <- calcVwc(agg12h_nd$adc1)
agg12h_nd$adc2 <- calcVwc(agg12h_nd$adc2)

agg24h_nd$adc0 <- calcSwp(agg24h_nd$adc0)
agg24h_nd$adc1 <- calcVwc(agg24h_nd$adc1)
agg24h_nd$adc2 <- calcVwc(agg24h_nd$adc2)

fifteen_cor <- cor(agg15m[1:3], agg15m_nd[1:3], method='pearson')
sixtyMin_cor <- cor(agg60m[1:3], agg24h_nd[1:3], method = 'pearson')
twelveHr_cor <- cor(agg12h[1:3], agg12h_nd[1:3], method = 'pearson')
day_cor <- cor(agg24h[1:3], agg24h_nd[1:3], method = 'pearson')

fifteen_sq <- (fifteen_cor)^2
sixtyMin_sq <- (sixtyMin_cor)^2
twelveHr_sq <- (twelveHr_cor)^2
day_sq <- (day_cor)^2

fifteen_rmse.adc0 <- rmse(agg15m$adc0, agg15m_nd$adc0)
fifteen_rmse.adc1 <- rmse(agg15m$adc1, agg15m_nd$adc1)
fifteen_rmse.adc2 <- rmse(agg15m$adc2, agg15m_nd$adc2)

sixtyMin_rmse.adc0 <- rmse(agg60m$adc0, agg60m_nd$adc0)
sixtyMin_rmse.adc1 <- rmse(agg60m$adc1, agg60m_nd$adc1)
sixtyMin_rmse.adc2 <- rmse(agg60m$adc2, agg60m_nd$adc2)

twelveHr_rsme.adc0 <- rmse(agg12h$adc0, agg12h_nd$adc0)
twelveHr_rsme.adc1 <- rmse(agg12h$adc1, agg12h_nd$adc1)
rtwelveHr_rsme.adc2 <- rmse(agg12h$adc2, agg12h_nd$adc2)

day_rsme.adc0 <- rmse(agg24h$adc0, agg24h_nd$adc0)
day_rsme.adc1 <- rmse(agg24h$adc1, agg24h_nd$adc1)
day_rsme.adc2 <- rmse(agg24h$adc2, agg24h_nd$adc2)

plot(agg15m$adc0, agg15m_np$adc0,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "15-Minute Aggregation: ADC0")

plot(agg60m$adc0, agg60m_np$adc0,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "60 Minute Aggregation: ADC0")

plot(agg12h$adc0, agg12h_np$adc0,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "12 Hour Aggregation: ADC0")

plot(agg24h$adc0, agg24h_np$adc0,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "24 Hour Aggregation: ADC0")

plot(agg15m$adc1, agg15m_np$adc1,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "15-Minute Aggregation: ADC1")

plot(agg60m$adc1, agg60m_np$adc1,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "60 Minute Aggregation: ADC1")

plot(agg12h$adc1, agg12h_np$adc1,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "12 Hour Aggregation: ADC1")

plot(agg24h$adc1, agg24h_np$adc1,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "24 Hour Aggregation: ADC1")

plot(agg15m$adc2, agg15m_np$adc2,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "15-Minute Aggregation: ADC2")

plot(agg60m$adc2, agg60m_np$adc2,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "60 Minute Aggregation: ADC2")

plot(agg12h$adc2, agg12h_np$adc2,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "12 Hour Aggregation: ADC2")

plot(agg24h$adc2, agg24h_np$adc2,type = 'p',
     xlab = "Soil Water Potency (Original)", 
     ylab = "Soil Water Potency (Duplicates Removed)",
     main = "24 Hour Aggregation: ADC2")

