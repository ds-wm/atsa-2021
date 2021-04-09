# Exercise 2.1
# Date: 5/6/21
# Authors: Rini Gupta and Jacinta Das

install.packages("hydroGOF") # For computing RMSE later on
library(hydroGOF)

# 1. read in data 
# input: link to data and node numbers
# output: data frame for each node
nodes <- c('2003', '2015', '2025', '2045', '2055', '2065', '2085', '2095', '2103', '2115', '2125', '2135')
nodes.df <- list()

for (i in 1:length(nodes)){
  sensor.url <- paste("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_",
                      nodes[i],".txt", sep="")
  sensor.name <- tail(unlist(strsplit(sensor.url, "/")), n=1)
  sensor.file <- paste("/tmp/", sensor.name, sep="")
  download.file(sensor.url, sensor.file, method = 'auto')
  
  nodes.df[[i]] <- read.table(sensor.file, header = TRUE, row.names=NULL, sep = ",")
}
# assign names to each data frame
s2003 <- nodes.df[[1]]
s2015 <- nodes.df[[2]]
s2025 <- nodes.df[[3]]
s2045 <- nodes.df[[4]]
s2055 <- nodes.df[[5]]
s2065 <- nodes.df[[6]]
s2085 <- nodes.df[[7]]
s2095 <- nodes.df[[8]]
s2103 <- nodes.df[[9]]
s2115 <- nodes.df[[10]]
s2125 <- nodes.df[[11]]
s2135 <- nodes.df[[12]]

# 2. filter for valid measurements for battery level
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

# 3. find and remove duplicate data packets
# input: packets from the same node ordered by time and marked as valid 
# output: packets marked either as valid or duplicate 

# add duplicate marker column (0: valid, 1: duplicate)
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


# add time column 
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

# mark the duplicates 
find_duplicates <- function(my.df){
  #  define the experimental delta, seconds 
  kbd <- (15-2)*60
  
  # get length of time series 
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
s2065 <- find_duplicates(s2065) # Found 400 duplicates
s2085 <- find_duplicates(s2085) # Found 287 duplicates
s2095 <- find_duplicates(s2095) # Found 395 duplicates
s2103 <- find_duplicates(s2103) # Found 262 duplicates
s2115 <- find_duplicates(s2115) # Found 464 duplicates
s2125 <- find_duplicates(s2125) # Found 244 duplicates
s2135 <- find_duplicates(s2135) # Found 294 duplicates

# Used this code to get the number of duplicates
count <- 0
for (i in s2135$dup) {
  if (i == 1){
    count <- count + 1
  }
}

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
s2125.df <- s2065[s2125$dup == 0, ]
s2135.df <- s2135[s2135$dup == 0, ]

# Merge and sort a list of dataframes
# Citation: R-bloggers
# https://www.r-bloggers.com/2011/01/merging-multiple-data-frames-in-r/
#
# Reduce: successively calls items from a list into a given function.
#     In this case, x is the output from merge and y is the next item
#     in the list of dataframes. The only exception is the first time
#     it runs, where x is the first item in the list and y is the 
#     second item in the list.
# Merge combines two dataframes by their columns and sorts by default.
#     Note that the timestamp character string is in ISO format, which
#     can be lexicographically sorted without having to mess with 
#     converting the strings to time objects.

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
  
  # ************************************************************************
  # Name:     get_ensemble_df
  # Inputs:   - numeric, time step to aggregate by
  #           - DataFrame, the dataframe to aggregate on with a time column
  # Returns:  DataFrame, dataframe containing the ensemble means for each time aggregation 
  # Features: Aggregates by time step and calculates the ensemble mean for each aggregation  
  
  # ************************************************************************
  
get_ensemble_df <- function(t.step, orig.df) { # Might want to add in a parameter for the df so that there is only one function later 
  t.step <- t.step 
  t1 <- trunc(orig.df$date[1], "hour") # First time
  tn <- tail(orig.df, 1)$date # Last time
  n <- length(orig.df$result_time)
  # Initialize a new empty dataframe for storing ensemble means
  ensemble.df <- orig.df[1==2, ]
  ensemble.df <- subset(ensemble.df, select = -result_time)  # remove this column
  # Initial the current time with the first time
  curr.t <- t1
  while (curr.t < tn) {
    next.t <- curr.t + t.step
    next.i <- nrow(ensemble.df) + 1
    tmp.df <- orig.df[orig.df$date >= curr.t & orig.df$date < next.t, ]
    # Find ADC means (Note that NAs are for nothing found in valid range)
    adc0.ave <- mean(tmp.df[tmp.df$adc0 >= 500 & tmp.df$adc0 <= 1000, "adc0"])
    adc1.ave <- mean(tmp.df[tmp.df$adc1 >= 250 & tmp.df$adc1 <= 1000, "adc1"])
    adc2.ave <- mean(tmp.df[tmp.df$adc2 >= 250 & tmp.df$adc2 <= 1000, "adc2"])
    ensemble.df[next.i, ]$date <- curr.t
    ensemble.df[next.i, ]$adc0 <- adc0.ave
    ensemble.df[next.i, ]$adc1 <- adc1.ave
    ensemble.df[next.i, ]$adc2 <- adc2.ave  
    curr.t <- curr.t + t.step
  }
  return(ensemble.df)
}



## Get aggregate data for each time interval: Data Frame with Duplicates
fifteen.minutes <- get_ensemble_df(t.step = 15*60, orig.df)
sixty.minutes <- get_ensemble_df(t.step = 60*60, orig.df)
twelve.hour <- get_ensemble_df(t.step = 12*60*60, orig.df)
day <- get_ensemble_df(t.step = 24*60*60, orig.df)


## Get aggregate data for each time interval: Data Frame WITHOUT Duplicates
fifteen.minutes.nodup <- get_ensemble_df(t.step = 15*60, nodup.df)
sixty.minutes.nodup <- get_ensemble_df(t.step = 60*60, nodup.df)
twelve.hour.nodup <- get_ensemble_df(t.step = 12*60*60, nodup.df)
day.nodup <- get_ensemble_df(t.step = 24*60*60, nodup.df)


## Convert raw aggregate values to physical quantities 

# ************************************************************************
# Name:     calcSwp
# Inputs:   - df.col, column of dataframe with water potential values
# Returns:  numeric list, list of physical quantities in kPa
# Features: Converts raw aggregate values into their physical quantities 

# ************************************************************************
calcSwp <- function(df.col) {
  a <- 0.000048
  b <- 0.0846
  c <- 39.45
  
  result = list()
  
  # Non-data logger water potential:
  for (idx in 1:length(df.col)) {
    if (!is.na(df.col[idx])) {
      if (df.col[idx] < 591 | df.col[idx] > 841) {
        result[[idx]] = 0;
      }
      else {
        calWP = -1.0*exp((a*df.col[idx]*df.col[idx])-(b*df.col[idx])+c )
        result[[idx]] = calWP
      }
    }
  }
  result <- unlist(result)
  return(result)
}

# ************************************************************************
# Name:     calcVwc
# Inputs:   - df.col, column of dataframe with soil moisture raw values (mV)
# Returns:  numeric list, soil moisture physical quantities, volumetric (m^3/m^3)
# Features: Calculate soil moisture from raw (mV) to volumetric (m^3/m^3) 

# ************************************************************************
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

# Duplicates

fifteen.dup.adc0 <- calcSwp(fifteen.minutes$adc0)
fifteen.dup.adc1 <- calcVwc(fifteen.minutes$adc1)
fifteen.dup.adc2 <- calcVwc(fifteen.minutes$adc2)

sixty.dup.adc0 <- calcSwp(sixty.minutes$adc0)
sixty.dup.adc1 <- calcVwc(sixty.minutes$adc1)
sixty.dup.adc2 <- calcVwc(sixty.minutes$adc2)

twelve.hour.dup.adc0 <- calcSwp(twelve.hour$adc0)
twelve.hour.dup.adc1 <- calcVwc(twelve.hour$adc1)
twelve.hour.dup.adc2 <- calcVwc(twelve.hour$adc2)

day.dup.adc0 <- calcSwp(day$adc0)
day.dup.adc1 <- calcVwc(day$adc1)
day.dup.adc2 <- calcVwc(day$adc2)

# No Duplicates
# Duplicates
fifteen.adc0 <- calcSwp(fifteen.minutes.nodup$adc0)
fifteen.adc1 <- calcVwc(fifteen.minutes.nodup$adc1)
fifteen.adc2 <- calcVwc(fifteen.minutes.nodup$adc2)

sixty.adc0 <- calcSwp(sixty.minutes.nodup$adc0)
sixty.adc1 <- calcVwc(sixty.minutes.nodup$adc1)
sixty.adc2 <- calcVwc(sixty.minutes.nodup$adc2)

twelve.hour.adc0 <- calcSwp(twelve.hour.nodup$adc0)
twelve.hour.adc1 <- calcVwc(twelve.hour.nodup$adc1)
twelve.hour.adc2 <- calcVwc(twelve.hour.nodup$adc2)

day.adc0 <- calcSwp(day.nodup$adc0)
day.adc1 <- calcVwc(day.nodup$adc1)
day.adc2 <- calcVwc(day.nodup$adc2)


# Computing R, R^2, RMSE, and Plotting for ADC0
mins.15.ts.adc0 <- ts(fifteen.minutes$adc0,  start = 2010, end = 2012, frequency = 35040)
mins.15.ts.adc0.nodup <- ts(fifteen.minutes.nodup$adc0, start = 2010, end = 2012, frequency = 35040)
adc0.15.mins.r <- cor(x=mins.15.ts.adc0, y=mins.15.ts.adc0.nodup, use="complete.obs")
adc0.15.mins.rsquared <- adc0.15.mins.r^2
rmse.adc0.15.mins <- rmse(mins.15.ts.adc0, mins.15.ts.adc0.nodup, na.rm=T)
plot(mins.15.ts.adc0, mins.15.ts.adc0.nodup, xlab = 'ADC0 with Duplicates', ylab = "ADC0 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Fifteen Minute Time Aggregation of ADC0")

hour.ts.adc0 <- ts(sixty.minutes$adc0, start = 2010, end = 2012, frequency = 8760)
hour.ts.adc0.nodup <- ts(sixty.minutes.nodup$adc0, start = 2010, end = 2012, frequency = 8760)
adc0.hour.r <- cor(x=hour.ts.adc0, y=hour.ts.adc0.nodup, use="complete.obs")
adc0.hour.rsquared <- adc0.hour.r^2
rmse.adc0.hour <- rmse(hour.ts.adc0, hour.ts.adc0.nodup, na.rm=T)
plot(hour.ts.adc0, hour.ts.adc0.nodup, xlab = 'ADC0 with Duplicates', ylab = "ADC0 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Sixty Minute Time Aggregation of ADC0")

hours.12.ts.adc0 <- ts(twelve.hour$adc0, start = 2010, end = 2012, frequency = 730)
hours.12.ts.adc0.nodup <- ts(twelve.hour.nodup$adc0, start = 2010, end = 2012, frequency = 730)
adc0.hours.12.r <- cor(x=hours.12.ts.adc0, y=hours.12.ts.adc0.nodup, use="complete.obs")
adc0.hours.12.rsquared <- adc0.hours.12.r^2
rmse.adc0.hours.12 <- rmse(hours.12.ts.adc0, hours.12.ts.adc0.nodup, na.rm=T)
plot(hours.12.ts.adc0, hours.12.ts.adc0.nodup, xlab = 'ADC0 with Duplicates', ylab = "ADC0 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Twelve Hour Time Aggregation of ADC0")

day.ts.adc0 <- ts(day$adc0, start = 2010, end = 2012, frequency = 365)
day.ts.adc0.nodup <- ts(day.nodup$adc0, start = 2010, end = 2012, frequency = 365)
adc0.day.r <- cor(x=day.ts.adc0, y=day.ts.adc0.nodup, use="complete.obs")
adc0.day.rsquared <- adc0.day.r^2
rmse.adc0.day <- rmse(day.ts.adc0, day.ts.adc0.nodup, na.rm=T)
plot(day.ts.adc0, day.ts.adc0.nodup, xlab = 'ADC0 with Duplicates', ylab = "ADC0 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Daily Time Aggregation of ADC0")

# Computing R, R^2, RMSE, and Plotting for ADC1
mins.15.ts.adc1 <- ts(fifteen.minutes$adc1, start = 2010, end = 2012, frequency = 35040)
mins.15.ts.adc1.nodup <- ts(fifteen.minutes.nodup$adc1, start = 2010, end = 2012, frequency = 35040)
adc1.15.mins.r <- cor(x=mins.15.ts.adc1, y=mins.15.ts.adc1.nodup, use="complete.obs")
adc1.15.mins.rsquared <- adc1.15.mins.r^2
rmse.adc1.15.mins <- rmse(mins.15.ts.adc1, mins.15.ts.adc1.nodup, na.rm=T)
plot(mins.15.ts.adc1, mins.15.ts.adc1.nodup, xlab = 'ADC1 with Duplicates', ylab = "ADC1 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Fifteen Minute Time Aggregation of ADC1")

hour.ts.adc1 <- ts(sixty.minutes$adc1, start = 2010, end = 2012, frequency = 8760)
hour.ts.adc1.nodup <- ts(sixty.minutes.nodup$adc1, start = 2010, end = 2012, frequency = 8760)
adc1.hour.r <- cor(x=hour.ts.adc1, y=hour.ts.adc1.nodup, use="complete.obs")
adc1.hour.rsquared <- adc1.hour.r^2
rmse.adc1.hour <- rmse(hour.ts.adc1, hour.ts.adc1.nodup, na.rm=T)
plot(hour.ts.adc1, hour.ts.adc1.nodup, xlab = 'ADC1 with Duplicates', ylab = "ADC1 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Sixty Minute Time Aggregation of ADC1")

hours.12.ts.adc1 <- ts(twelve.hour$adc1, start = 2010, end = 2012, frequency = 730)
hours.12.ts.adc1.nodup <- ts(twelve.hour.nodup$adc1, start = 2010, end = 2012, frequency = 730)
adc1.hours.12.r <- cor(x=hours.12.ts.adc1, y=hours.12.ts.adc1.nodup, use="complete.obs")
adc1.hours.12.rsquared <- adc1.hours.12.r^2
rmse.adc1.hours.12 <- rmse(hours.12.ts.adc1, hours.12.ts.adc1.nodup, na.rm=T)
plot(hours.12.ts.adc1, hours.12.ts.adc1.nodup, xlab = 'ADC1 with Duplicates', ylab = "ADC1 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Twelve Hour Time Aggregation of ADC1")

day.ts.adc1 <- ts(day$adc1, start = 2010, end = 2012, frequency = 365)
day.ts.adc1.nodup <- ts(day.nodup$adc1, start = 2010, end = 2012, frequency = 365)
adc1.day.r <- cor(x=day.ts.adc1, y=day.ts.adc1.nodup, use="complete.obs")
adc1.day.rsquared <- adc1.day.r^2
rmse.adc1.day <- rmse(day.ts.adc1, day.ts.adc1.nodup, na.rm=T)
plot(day.ts.adc1, day.ts.adc1.nodup, xlab = 'ADC1 with Duplicates', ylab = "ADC1 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Daily Time Aggregation of ADC1")


# Computing R, R^2, RMSE, and Plotting for ADC2
mins.15.ts.adc2 <- ts(fifteen.minutes$adc2,  start = 2010, end = 2012, frequency = 35040)
mins.15.ts.adc2.nodup <- ts(fifteen.minutes.nodup$adc2,  start = 2010, end = 2012, frequency = 35040)
adc2.15.mins.r <- cor(x=mins.15.ts.adc2, y=mins.15.ts.adc2.nodup, use="complete.obs")
adc2.15.mins.rsquared <- adc2.15.mins.r^2
rmse.adc2.15.mins <- rmse(mins.15.ts.adc2, mins.15.ts.adc2.nodup, na.rm=T)
plot(mins.15.ts.adc2, mins.15.ts.adc2.nodup, xlab = 'ADC2 with Duplicates', ylab = "ADC2 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Fifteen Minute Time Aggregation of ADC2")

hour.ts.adc2 <- ts(sixty.minutes$adc2, start = 2010, end = 2012, frequency = 8760)
hour.ts.adc2.nodup <- ts(sixty.minutes.nodup$adc2, start = 2010, end = 2012, frequency = 8760)
adc2.hour.r <- cor(x=hour.ts.adc2, y=hour.ts.adc2.nodup, use="complete.obs")
adc2.hour.rsquared <- adc2.hour.r^2
rmse.adc2.hour <- rmse(hour.ts.adc2, hour.ts.adc2.nodup, na.rm=T)
plot(hour.ts.adc2, hour.ts.adc2.nodup, xlab = 'ADC2 with Duplicates', ylab = "ADC2 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Sixty Minute Time Aggregation of ADC2")

hours.12.ts.adc2 <- ts(twelve.hour$adc2, start = 2010, end = 2012, frequency = 730)
hours.12.ts.adc2.nodup <- ts(twelve.hour.nodup$adc2, start = 2010, end = 2012, frequency = 730)
adc2.hours.12.r <- cor(x=hours.12.ts.adc2, y=hours.12.ts.adc2.nodup, use="complete.obs")
adc2.hours.12.rsquared <- adc2.hours.12.r^2
rmse.adc2.hours.12 <- rmse(hours.12.ts.adc2, hours.12.ts.adc2.nodup, na.rm=T)
plot(hours.12.ts.adc2, hours.12.ts.adc2.nodup, xlab = 'ADC2 with Duplicates', ylab = "ADC2 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Twelve Hour Time Aggregation of ADC2")

day.ts.adc2 <- ts(day$adc2, start = 2010, end = 2012, frequency = 365)
day.ts.adc2.nodup <- ts(day.nodup$adc2, start = 2010, end = 2012, frequency = 365)
adc2.day.r <- cor(x=day.ts.adc2, y=day.ts.adc2.nodup, use="complete.obs")
adc2.day.rsquared <- adc2.day.r^2
rmse.adc2.day <- rmse(day.ts.adc2, day.ts.adc2.nodup, na.rm=T)
plot(day.ts.adc2, day.ts.adc2.nodup, xlab = 'ADC2 with Duplicates', ylab = "ADC2 without Duplicates",
     main = "Duplicates Versus No Duplicates For \n Daily Time Aggregation of ADC2")




