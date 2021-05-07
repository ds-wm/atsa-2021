# Applied Time Series Analysis
# Exercise 2.1
# author: Peter Woo
# created: 2021-04-05
# updated: 2021-05-07

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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: calc_aggregate
# Inputs: dataframe , time in minutes 
# Returns: aggregated dataframe
# Featrues: aggregates by the time inputted 
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
calc_aggregate <- function(data, time){
  # Define the time step for aggregation
  t.step <- time*60  # 15-minutes in seconds
  
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





















