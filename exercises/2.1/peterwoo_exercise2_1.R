# Applied Time Series Analysis
# Exercise 2.1
# author: Peter woo
# created: 2021-04-05
# updated: 2021-05-07

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

install.packages("Metrics")
library("Metrics")

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## READ THE DATA
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s2003.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt"
s2015.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt"
s2025.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt"
s2045.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt"
s2055.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt"
s2065.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt'
s2085.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt'
s2095.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt'
s2103.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt'
s2115.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt'
s2125.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt'
s2135.url <- 'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt'

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
  kbd <- (15 - 2)*60
  
  n <- length(my.df$result_time)
  
  check.cols <- c("nodeid", "parent", "voltage", "humid", "humtemp", "adc0", 
                  "adc1",   "adc2",   "adc3",    "adc4",  "adc5",    "adc6")
  
  for (i in 1:(n-1)) {
    for (j in (i+1):(n-1)) {
      dt <- difftime(my.df$date[j], my.df$date[i], units = "secs")
      if (dt < kbd) {
        d.mat <- all(my.df[i, check.cols] == my.df[j, check.cols])
        if (d.mat) {
          my.df[j, "dup"] <- 1
        }
      } else {
        break
      }
    }
  }
  return(my.df)
}


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
orig.df <- merge_list(list(s2003, s2015, s2025, s2045, s2055, s2065, s2085, s2095, s2103, s2115, s2125, s2135))
nodup.df <- merge_list(list(s2003.df, s2015.df, s2025.df, s2045.df, s2055.df, s2065.df, s2085.df, s2095.df, s2103.df, s2115.df, s2125.df, s2135.df))

# Sort by time
orig.df <- orig.df[order(orig.df$date), ]
nodup.df <- nodup.df[order(nodup.df$date), ]

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## AGGREGATE BY TIME STEP
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

calc_aggregate <- function(data, time){
  # Define the time step for aggregation
  t.step <- time*60  # 15-minutes in seconds
  
  # Grab the first instance of time and roll back to the earliest whole hour
  t1 <- trunc(data$date[1], "hour")
  
  # Grab the last time
  tn <- tail(data, 1)$date
  
  # Grab total number of rows
  n <- length(data$result_time)
  
  # Initialize a new empty dataframe for storing ensemble means
  ensemble.df <- data[1==2, ]
  ensemble.df <- subset(ensemble.df, select = -result_time)  # remove this column
  curr.t <- t1
  
  while (curr.t < tn) {
    next.t <- curr.t + t.step
    next.i <- nrow(ensemble.df) + 1
    
    next.row <- nrow(ensemble.df + 1)
    tmp.df <- data[data$date >= curr.t & orig.df$date < next.t, ]
    
    ensemble.df[next.i, ]$date <- curr.t
    ensemble.df[next.i, ]$adc0 <- mean(tmp.df[tmp.df$adc0 >= 500 & tmp.df$adc0 <= 1000, "adc0"])
    ensemble.df[next.i, ]$adc1 <- mean(tmp.df[tmp.df$adc1 >= 250 & tmp.df$adc1 <= 1000, "adc1"])
    ensemble.df[next.i, ]$adc2 <- mean(tmp.df[tmp.df$adc2 >= 250 & tmp.df$adc2 <= 1000, "adc2"])
    
    curr.t <- curr.t + t.step
  }
  return(ensemble.df)
}

# Aggregate the data with duplicates

# 15 minutes
min15 <- calc_aggregate(orig.df, 15)

# 60 minutes
min60 <- calc_aggregate(orig.df, 60)

# 12 hours
hr12 <- calc_aggregate(orig.df, 12*60)

# 24 hours
hr24 <- calc_aggregate(orig.df, 24*60)

# Now aggregate the data without duplicates

# 15 minutes
min15nd <- calc_aggregate(nodup.df, 15)

# 60 minutes
min60nd <- calc_aggregate(nodup.df, 60)

# 12 hours
hr12nd <- calc_aggregate(nodup.df, 12*60)

# 24 hours
hr24nd <- calc_aggregate(nodup.df, 24*60)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: calcSwp
# Inputs: dataframe with raw soil water potential 
# Returns: list, converted values in kPa
# Featrues: converts raw soil water potential to kPa 
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

calcSwp <- function(data){  
  
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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: calcVwc
# Inputs: dataframe with raw soil water potential 
# Returns: list, converted values in volumetric (m^3/m^3)
# Featrues: converts raw soil water potential to volumetric (m^3/m^3)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

calcVwc <- function(df.col) {
  A = 0.00119
  B = 0.401
  
  result = list()
  
  for (idx in 1:length(df.col)) {
    if (!is.na(df.col[idx])) {
      if (df.col[idx] < 337 | df.col[idx] > 841) {
        result[[idx]] = 0;
      }
      else {
        result[[idx]] = A * df.col[idx] - B
      }
    }
  }
  result = unlist(result)
  return(result)
}

# Replace nan values with 0, then convert the raw values to swp and vwc values

# Original data

# 15 minutes
min15$adc0[is.na(min15$adc0)] <- 0
min15$adc0 <- calcSwp(min15$adc0)
min15$adc1[is.na(min15$adc1)] <- 0
min15$adc1 <- calcVwc(min15$adc1)
min15$adc2[is.na(min15$adc2)] <- 0
min15$adc2 <- calcVwc(min15$adc2)

# 60 minutes
min60$adc0[is.na(min60$adc0)] <- 0
min60$adc0 <- calcSwp(min60$adc0)
min60$adc1[is.na(min60$adc1)] <- 0
min60$adc1 <- calcVwc(min60$adc1)
min60$adc2[is.na(min60$adc2)] <- 0
min60$adc2 <- calcVwc(min60$adc2)

# 12 hours
hr12$adc0[is.na(hr12$adc0)] <- 0
hr12$adc0 <- calcSwp(hr12$adc0)
hr12$adc1[is.na(hr12$adc1)] <- 0
hr12$adc1 <- calcVwc(hr12$adc1)
hr12$adc2[is.na(hr12$adc2)] <- 0
hr12$adc2 <- calcVwc(hr12$adc2)

# 24 hours
hr24$adc0[is.na(hr24$adc0)] <- 0
hr24$adc0 <- calcSwp(hr24$adc0)
hr24$adc1[is.na(hr24$adc1)] <- 0
hr24$adc1 <- calcVwc(hr24$adc1)
hr24$adc2[is.na(hr24$adc2)] <- 0
hr24$adc2 <- calcVwc(hr24$adc2)

# Data with no duplicates 

min15nd$adc0[is.na(min15nd$adc0)] <- 0
min15nd$adc0 <- calcSwp(min15nd$adc0)
min15nd$adc1[is.na(min15nd$adc1)] <- 0
min15nd$adc1 <- calcVwc(min15nd$adc1)
min15nd$adc2[is.na(min15nd$adc2)] <- 0
min15nd$adc2 <- calcVwc(min15nd$adc2)

# 60 minutes
min60nd$adc0[is.na(min60nd$adc0)] <- 0
min60nd$adc0 <- calcSwp(min60nd$adc0)
min60nd$adc1[is.na(min60nd$adc1)] <- 0
min60nd$adc1 <- calcVwc(min60nd$adc1)
min60nd$adc2[is.na(min60nd$adc2)] <- 0
min60nd$adc2 <- calcVwc(min60nd$adc2)

# 12 hours
hr12nd$adc0[is.na(hr12nd$adc0)] <- 0
hr12nd$adc0 <- calcSwp(hr12nd$adc0)
hr12nd$adc1[is.na(hr12nd$adc1)] <- 0
hr12nd$adc1 <- calcVwc(hr12nd$adc1)
hr12nd$adc2[is.na(hr12nd$adc2)] <- 0
hr12nd$adc2 <- calcVwc(hr12nd$adc2)

# 24 hours
hr24nd$adc0[is.na(hr24nd$adc0)] <- 0
hr24nd$adc0 <- calcSwp(hr24nd$adc0)
hr24nd$adc1[is.na(hr24nd$adc1)] <- 0
hr24nd$adc1 <- calcVwc(hr24nd$adc1)
hr24nd$adc2[is.na(hr24nd$adc2)] <- 0
hr24nd$adc2 <- calcVwc(hr24nd$adc2)

################################################################################
# Calculating correlation coefficient, R^2, RMSE

# CORRELATION COEFFICIENT ( PEARSON'S R)

# Correlation coefficient - adc0 
min15.corrc.adc0 <- cor(min15$adc0, min15nd$adc0, method = 'pearson')
min60.corrc.adc0 <- cor(min60$adc0, min60nd$adc0, method = 'pearson')
hr12.corrc.adc0 <- cor(hr12$adc0, hr12nd$adc0, method = 'pearson')
hr24.corrc.adc0 <- cor(hr24$adc0, hr24nd$adc0, method = 'pearson')

# Correlation coefficient - adc1
min15.corrc.adc1 <- cor(min15$adc1, min15nd$adc1, method = 'pearson')
min60.corrc.adc1 <- cor(min60$adc1, min60nd$adc1, method = 'pearson')
hr12.corrc.adc1 <- cor(hr12$adc1, hr12nd$adc1, method = 'pearson')
hr24.corrc.adc1 <- cor(hr24$adc1, hr24nd$adc1, method = 'pearson')

# Correlation coefficient - adc2
min15.corrc.adc2 <- cor(min15$adc2, min15nd$adc2, method = 'pearson')
min60.corrc.adc2 <- cor(min60$adc2, min60nd$adc2, method = 'pearson')
hr12.corrc.adc2 <- cor(hr12$adc2, hr12nd$adc2, method = 'pearson')
hr24.corrc.adc2 <- cor(hr24$adc2, hr24nd$adc2, method = 'pearson')

# R^2

# R^2 - adc0
min15.r2.adc0 <- min15.corrc.adc0^2
min60.r2.adc0 <- min60.corrc.adc0^2
hr12.r2.adc0 <- hr12.corrc.adc0^2
hr24.r2.adc0 <- hr24.corrc.adc0^2

# R^2 - adc1
min15.r2.adc1 <- min15.corrc.adc1^2
min60.r2.adc1 <- min60.corrc.adc1^2
hr12.r2.adc1 <- hr12.corrc.adc1^2
hr24.r2.adc1 <- hr24.corrc.adc1^2

# R^2 - adc2
min15.r2.adc2 <- min15.corrc.adc2^2
min60.r2.adc2 <- min60.corrc.adc2^2
hr12.r2.adc2 <- hr12.corrc.adc2^2
hr24.r2.adc2 <- hr24.corrc.adc2^2

# RMSE 

# RMSE - adc0
min15.rmse.adc0 <- rmse(min15$adc0, min15nd$adc0)
min60.rmse.adc0 <- rmse(min60$adc0, min60nd$adc0)
hr12.rmse.adc0 <- rmse(hr12$adc0, hr12$adc0)
hr24.rmse.adc0 <- rmse(hr24$adc0, hr24$adc0)

# RMSE - adc1
min15.rmse.adc1 <- rmse(min15$adc1, min15nd$adc1)
min60.rmse.adc1 <- rmse(min60$adc1, min60nd$adc1)
hr12.rmse.adc1 <- rmse(hr12$adc1, hr12$adc1)
hr24.rmse.adc1 <- rmse(hr24$adc1, hr24$adc1)

# RMSE - adc2
min15.rmse.adc2 <- rmse(min15$adc2, min15nd$adc2)
min60.rmse.adc2 <- rmse(min60$adc2, min60nd$adc2)
hr12.rmse.adc2 <- rmse(hr12$adc2, hr12$adc2)
hr24.rmse.adc2 <- rmse(hr24$adc2, hr24$adc2)

################################################################################

# Create plots

# adc0 
plot(min15$adc0, min15nd$adc0, main = 'ADC0 for 15-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(min60$adc0, min60nd$adc0, main = 'ADC0 for 60-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr12$adc0, hr12nd$adc0, main = 'ADC0 for 12-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr24$adc0, hr24nd$adc0, main = 'ADC0 for 24-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")

# adc1
plot(min15$adc1, min15nd$adc1, main = 'ADC1 for 15-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(min60$adc1, min60nd$adc1, main = 'ADC1 for 60-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr12$adc1, hr12nd$adc1, main = 'ADC1 for 12-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr24$adc1, hr24nd$adc1, main = 'ADC1 for 24-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")

# adc2
plot(min15$adc2, min15nd$adc2, main = 'ADC2 for 15-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(min60$adc2, min60nd$adc2, main = 'ADC2 for 60-Minute Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr12$adc2, hr12nd$adc2, main = 'ADC2 for 12-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
plot(hr24$adc2, hr24nd$adc2, main = 'ADC2 for 24-Hour Aggregation', xlab = "duplicates included", ylab = "duplicates excluded")
















