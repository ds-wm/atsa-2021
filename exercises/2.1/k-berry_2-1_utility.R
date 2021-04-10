#R Utility for Exercise 2.1
#Kelton Berry



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

#Create a helper function for aggregating by time step

agg_time <- function(t.step, mydf) {
  #Define the time step for aggregation
  t.step <- t.step*60 
  # The first instance of time and roll back to the earliest whole hour
  t1 <- trunc(mydf$date[1], "hour")
  # Grab the last time
  tn <- tail(mydf, 1)$date
  # Grab total number of rows
  n <- length(mydf$result_time)
  # Initialize a new empty dataframe for storing ensemble means
  ensemble.df <- mydf[1==2, ]
  ensemble.df <- subset(ensemble.df, select = -result_time)  # remove this column
  # Initial the current time with the first time
  curr.t <- t1
  while (curr.t < tn) {
    next.t <- curr.t + t.step
    tmp.df <- orig.df[orig.df$date >= curr.t & orig.df$date < next.t, ]
    #find ADCs
    adc0 <- mean(tmp.df[tmp.df$adc0 >= 500 & tmp.df$adc0 <= 1000, "adc0"])
    adc1 <- mean(tmp.df[tmp.df$adc1 >= 250 & tmp.df$adc1 <= 1000, "adc1"])
    adc2 <- mean(tmp.df[tmp.df$adc2 >= 250 & tmp.df$adc2 <= 1000, "adc2"])
    hold <- data.frame(adc0,adc1,adc2,curr.t)
    names(hold) <- c("ADC0", "ADC1", "ADC2", "Curr_Time")
    ensemble.df <- rbind(ensemble.df, hold)
    curr.t <- curr.t + t.step
    
  }
  return(ensemble.df)
} 

# Calculate soil water potential from raw (mv) to kilo Pascals (kPa)
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

# Calculate soil moisture from raw (mV) to volumetric (m^3/m^3)



calcVwc<- function(data){
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
