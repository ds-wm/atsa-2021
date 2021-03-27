# Applied Time Series Analysis
# Exercise 2.2
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
#
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## READ THE DATA
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Only looking at the first five CSVs
s2003.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt"
s2015.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt"
s2025.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt"
s2045.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt"
s2055.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt"

s2003 <- read.csv(s2003.url)
s2015 <- read.csv(s2015.url)
s2025 <- read.csv(s2025.url)
s2045 <- read.csv(s2045.url)
s2055 <- read.csv(s2055.url)

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
# if they are duplicates. Let's use batter voltage as our first criteria
#
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Filter for valid measurements
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
s2003 <- s2003[s2003$voltage >= 2600, ]
s2015 <- s2015[s2015$voltage >= 2600, ]
s2025 <- s2025[s2025$voltage >= 2600, ]
s2045 <- s2045[s2045$voltage >= 2600, ]
s2055 <- s2055[s2055$voltage >= 2600, ]

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Add duplicate marker column (0: valid; 1: duplicate)
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
s2003$dup <- 0
s2015$dup <- 0
s2025$dup <- 0
s2045$dup <- 0
s2055$dup <- 0

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Add time column (this method uses POSIXct for dates/times)
### and allows to check for time differences between rows in seconds
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
s2003$date <- as.POSIXct(s2003$result_time)
s2015$date <- as.POSIXct(s2015$result_time)
s2025$date <- as.POSIXct(s2025$result_time)
s2045$date <- as.POSIXct(s2045$result_time)
s2055$date <- as.POSIXct(s2055$result_time)

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Mark the duplicates
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## CREATE DUPLICATE-FREE COPIES
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
s2003.df <- s2003[s2003$dup == 0, ]
s2015.df <- s2015[s2015$dup == 0, ]
s2025.df <- s2025[s2025$dup == 0, ]
s2045.df <- s2045[s2045$dup == 0, ]
s2055.df <- s2055[s2055$dup == 0, ]

#
# TODO: 
# 1. combine individual duplicate free and original data.frames together
# 2. sort by time
# 3. define a timestep (e.g., 15 minutes)
# 4. calculate the mean for a given time step
#
