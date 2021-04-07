# Title: Utility Script for Exercise 2.1
# Authors: Rini Gupta and Jacinta Das
# Date: 5/7/21

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
