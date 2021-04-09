# Applied Time Series Analysis
# Exercise 2.1
# author: John Hennin, William & Mary
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

#install.packages('Metrics')
library('Metrics')
source('johnhennin_b2_utility.R')
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## READ THE DATA
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Grab all 12 files
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
#.
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

s2003 <- find_duplicates(s2003) # Found 435 duplicates
s2015 <- find_duplicates(s2015) # Found 285 duplicates
s2025 <- find_duplicates(s2025) # Found 350 duplicates
s2045 <- find_duplicates(s2045) # Found 422 duplicates
s2055 <- find_duplicates(s2055) # Found 308 duplicates
s2065 <- find_duplicates(s2065) # Found 400 duplicates
s2085 <- find_duplicates(s2085) # Found 287 duplicates
s2095 <- find_duplicates(s2095) # Found 395 duplicates
s2103 <- find_duplicates(s2103) # Found 262 duplicates
s2115 <- find_duplicates(s2115) # Found 464 duplicates
s2125 <- find_duplicates(s2125) # Found 244 duplicates
s2135 <- find_duplicates(s2135) # Found 294 duplicates
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
## Q1: CREATE SINGLE DATAFRAME WITH ALL OBSERVATIONS SORTED BY TIME
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Merge all data.frames together
orig.df <- merge_list(list(s2003, s2015, s2025, s2045, s2055, s2065, s2085,
                           s2095, s2103, s2115, s2125, s2135))
nodup.df <- merge_list(list(s2003.df, s2015.df, s2025.df, s2045.df, s2055.df,
                            s2065.df, s2085.df, s2095.df, s2103.df, s2115.df,
                            s2125.df, s2135.df))

# Sort by time
orig.df <- orig.df[order(orig.df$date), ]
nodup.df <- nodup.df[order(nodup.df$date), ]

orig.test <- orig.df
nodup.test <- nodup.df


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Q2: AGGREGATE BY TIME STEP
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ensemble15.org <- aggregate.byts(orig.df = orig.df, 15)
ensemble60.org <- aggregate.byts(orig.df = orig.df, 60)
ensemble12.org <- aggregate.byts(orig.df = orig.df, 12*60)
ensemble24.org <- aggregate.byts(orig.df = orig.df, 24*60)

ensemble15.nd <- aggregate.byts(orig.df = nodup.df, 15)
ensemble60.nd <- aggregate.byts(orig.df = nodup.df, 60)
ensemble12.nd <- aggregate.byts(orig.df = nodup.df, 12*60)
ensemble24.nd <- aggregate.byts(orig.df = nodup.df, 24*60)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Converting values
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ensemble15.org$adc0 <- calc.swp(ensemble15.org$adc0)
ensemble15.org$adc1 <- calc.vwc(ensemble15.org$adc1)
ensemble15.org$adc2 <- calc.vwc(ensemble15.org$adc2)

ensemble15.nd$adc0 <- calc.swp(ensemble15.nd$adc0)
ensemble15.nd$adc1 <- calc.vwc(ensemble15.nd$adc1)
ensemble15.nd$adc2 <- calc.vwc(ensemble15.nd$adc2)

#-------------------------------------------------

ensemble60.org$adc0 <- calc.swp(ensemble60.org$adc0)
ensemble60.org$adc1 <- calc.vwc(ensemble60.org$adc1)
ensemble60.org$adc2 <- calc.vwc(ensemble60.org$adc2)

ensemble60.nd$adc0 <- calc.swp(ensemble60.nd$adc0)
ensemble60.nd$adc1 <- calc.vwc(ensemble60.nd$adc1)
ensemble60.nd$adc2 <- calc.vwc(ensemble60.nd$adc2)

#-------------------------------------------------

ensemble12.org$adc0 <- calc.swp(ensemble12.org$adc0)
ensemble12.org$adc1 <- calc.vwc(ensemble12.org$adc1)
ensemble12.org$adc2 <- calc.vwc(ensemble12.org$adc2)

ensemble12.nd$adc0 <- calc.swp(ensemble12.nd$adc0)
ensemble12.nd$adc1 <- calc.vwc(ensemble12.nd$adc1)
ensemble12.nd$adc2 <- calc.vwc(ensemble12.nd$adc2)

#-------------------------------------------------

ensemble24.org$adc0 <- calc.swp(ensemble24.org$adc0)
ensemble24.org$adc1 <- calc.vwc(ensemble24.org$adc1)
ensemble24.org$adc2 <- calc.vwc(ensemble24.org$adc2)

ensemble24.nd$adc0 <- calc.swp(ensemble24.nd$adc0)
ensemble24.nd$adc1 <- calc.vwc(ensemble24.nd$adc1)
ensemble24.nd$adc2 <- calc.vwc(ensemble24.nd$adc2)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Q3: Calculate Pearson's R, R-Squared, and RMSE
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 15 minutes, Pearson's R
r15 <- cor(ensemble15.org[1:3], ensemble15.nd[1:3], method = 'pearson')

# 60 minutes, Pearson's R
r60 <- cor(ensemble60.org[1:3], ensemble60.nd[1:3], method = 'pearson')

# 12 hours, Pearson's R
r12 <- cor(ensemble12.org[1:3], ensemble12.nd[1:3], method = 'pearson')

# 24 hours, Pearson's R
r24 <- cor(ensemble24.org[1:3], ensemble24.nd[1:3], method = 'pearson')

#-------------------------------------------------------------

# 15 minutes, R-Squared
r15.2 <- r15^2

# 60 minutes, R-Squared
r60.2 <- r60^2

# 12 hours, R-Squared
r12.2 <- r12^2

# 24 hours, R-Squared
r24.2 <- r24^2

#-------------------------------------------------------------

# 15 minutes, RMSE
rmse15a0 <- rmse(ensemble15.org$adc0, ensemble15.nd$adc0)
rmse15a1 <- rmse(ensemble15.org$adc1, ensemble15.nd$adc1)
rmse15a2 <- rmse(ensemble15.org$adc2, ensemble15.nd$adc2)

# 60 minutes, RMSE
rmse60a0 <- rmse(ensemble60.org$adc0, ensemble60.nd$adc0)
rmse60a1 <- rmse(ensemble60.org$adc1, ensemble60.nd$adc1)
rmse60a2 <- rmse(ensemble60.org$adc2, ensemble60.nd$adc2)

# 12 hours, RMSE
rmse12a0 <- rmse(ensemble12.org$adc0, ensemble12.nd$adc0)
rmse12a1 <- rmse(ensemble12.org$adc1, ensemble12.nd$adc1)
rmse12a2 <- rmse(ensemble12.org$adc2, ensemble12.nd$adc2)

# 24 hours, RMSE
rmse24a0 <- rmse(ensemble24.org$adc0, ensemble24.nd$adc0)
rmse24a1 <- rmse(ensemble24.org$adc1, ensemble24.nd$adc1)
rmse24a2 <- rmse(ensemble24.org$adc2, ensemble24.nd$adc2)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Q4: Creating Plots
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# adc0  --------------------------------------------------------------
par(mfrow=c(2,2))
par(pty = "s", pin = c(.65,.65), cxy = c(.015,.015),
    mar=c(4,4,3.5,3), oma = c(0, 0, 0, 0))

plot(ensemble15.org$adc0, ensemble15.nd$adc0, type = 'p', cex = .5,
     xlab = "Orig. soil water potent.", 
     ylab = "Dup-free soil water potent.")
mtext("15 minute", cex = .7, side=3)
mtext(paste("r = ",round(r15[1,1],digits=4), 
            'R^2 = ' ,round(r15.2[1,1],digits=4),
            "\nrmse =",round(rmse15a0, digits=4),
            "N = ", length(ensemble15.org$adc0)),
      cex = .45,side = 3,line = -1.3)

plot(ensemble60.org$adc0, ensemble60.nd$adc0, type = 'p', cex = .5, 
     xlab = "Orig. soil water potent.", 
     ylab = "Dup-free soil water potent.")
mtext("60 minute", cex = .7, side=3)
mtext(paste("r = ",round(r60[1,1],digits=4), 
            'R^2 = ' ,round(r60.2[1,1], digits=4),
            "\nrmse =",round(rmse60a0, digits=4),
            "N = ", length(ensemble60.org$adc0)),
      cex = .45,side = 3,line = -1.3)


plot(ensemble12.org$adc0, ensemble12.nd$adc0, type = 'p', cex = .5, 
     xlab = "Orig. soil water potent.", 
     ylab = "Dup-free soil water potent.")
mtext("12 hour", cex = .7, side=3)
mtext(paste("r = ",round(r12[1,1], digits=4),
            'R^2 = ' ,round(r12.2[1,1], digits=4),
            "\nrmse =",round(rmse12a0, digits = 4),
            "N = ", length(ensemble12.org$adc0)),
      cex = .45,side = 3,line = -1.3)


plot(ensemble24.org$adc0, ensemble24.nd$adc0, type = 'p', cex = .5, 
     xlab = "Orig. soil water potent.", 
     ylab = "Dup-free soil water potent.")
mtext("24 hour", cex = .7, side=3)
mtext(paste("r = ",round(r24[1,1], digits = 4),
            'R^2 = ' ,round(r24.2[1,1], digits = 4),
            "\nrmse =", round(rmse24a0, digits=4),
            "N = ", length(ensemble24.org$adc0)),
      cex = .45,side = 3,line = -1.3)
mtext("ADC0", side = 3, line = -2, outer = TRUE, cex = 2)

# adc1 --------------------------------------------------------------

par(mfrow=c(2,2))
par(pty = "s", pin = c(.65,.65), cxy = c(.015,.015),
    mar=c(4,4,3.5,3.5), oma = c(0, 0, 0, 0))

plot(ensemble15.org$adc1, ensemble15.nd$adc1, type = 'p', cex = .5,
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("15 minute", cex = .7, side=3)
mtext(paste("r = ",round(r15[2,2],digits=4), 
            'R^2 = ' ,round(r15.2[2,2],digits=4),
            "\nrmse =",round(rmse15a1, digits=4),
            "N = ", length(ensemble15.org$adc1)),
      cex = .45,side = 3,line = -1.3)


plot(ensemble60.org$adc1, ensemble60.nd$adc1, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("60 minute", cex = .7, side=3)
mtext(paste("r = ",round(r60[2,2],digits=4), 
            'R^2 = ' ,round(r60.2[2,2], digits=4),
            "\nrmse =",round(rmse60a1, digits=4),
            "N = ", length(ensemble60.org$adc1)),
      cex = .45,side = 3,line = -1.3)


plot(ensemble12.org$adc1, ensemble12.nd$adc1, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("12 hour", cex = .7, side=3)
mtext(paste("r = ",round(r12[2,2], digits=4),
            'R^2 = ' ,round(r12.2[2,2], digits=4)
            ,"\nrmse =",round(rmse12a1, digits = 4),
            "N = ", length(ensemble12.org$adc1)),
      cex = .45,side = 3,line = -1.3)


plot(ensemble24.org$adc1, ensemble24.nd$adc1, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("24 hour", cex = .7, side=3)
mtext(paste("r = ",round(r24[2,2], digits = 4),
            'R^2 = ' ,round(r24.2[2,2], digits = 4),
            "\nrmse =", round(rmse24a1, digits=4),
            "N = ", length(ensemble24.org$adc1)),
      cex = .45,side = 3,line = -1.3)
mtext("ADC1", side = 3, line = -2, outer = TRUE, cex = 2)

# adc2 --------------------------------------------------------------

par(mfrow=c(2,2))
par(pty = "s", pin = c(.65,.65), cxy = c(.015,.015),
    mar=c(4,4,3.5,3.5), oma = c(0, 0, 0, 0))

plot(ensemble15.org$adc2, ensemble15.nd$adc2, type = 'p', cex = .5,
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("15 minute", cex = .7, side=3)
mtext(paste("r = ",round(r15[3,3],digits=4), 
            'R^2 = ' ,round(r15.2[3,3],digits=4),
            "\nrmse =",round(rmse15a2, digits=4),
            "N = ", length(ensemble15.org$adc2)),
      cex = .45,side = 3,line = -1.3)

plot(ensemble60.org$adc2, ensemble60.nd$adc2, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("60 minute", cex = .7, side=3)
mtext(paste("r = ",round(r60[3,3],digits=4), 
            'R^2 = ' ,round(r60.2[3,3], digits=4),
            "\nrmse =",round(rmse60a2, digits=4),
            "N = ", length(ensemble60.org$adc2)),
      cex = .45,side = 3,line = -1.3)

plot(ensemble12.org$adc2, ensemble12.nd$adc2, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("12 hour", cex = .7, side=3)
mtext(paste("r = ",round(r12[3,3], digits=4),
            'R^2 = ' ,round(r12.2[3,3], digits=4),
            "\nrmse =",round(rmse12a2, digits = 4),
            "N = ", length(ensemble12.org$adc2)),
      cex = .45,side = 3,line = -1.3)

plot(ensemble24.org$adc2, ensemble24.nd$adc2, type = 'p', cex = .5, 
     xlab = "Orig. soil moisture", 
     ylab = "Dup-free soil moisture")
mtext("24 hour", cex = .7, side=3)
mtext(paste("r = ",round(r24[3,3], digits = 4),
            'R^2 = ' ,round(r24.2[3,3], digits = 4),
            "\nrmse =", round(rmse24a2, digits=4),
            "N = ", length(ensemble24.org$adc2)),
      cex = .45,side = 3,line = -1.3)

mtext("ADC2", side = 3, line = -2, outer = TRUE, cex = 2)

