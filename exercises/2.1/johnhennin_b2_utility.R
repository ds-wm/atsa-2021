# John Hennin, ATSA Spring 2021
# Last edited 04/7


# Find duplicates function

find_duplicates <- function(my.df) {
  # '''
  # Input: dataframe (ideally with duplicate data)
  # Output: new dataframe without duplicate data
  # ''' 
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
  # print(nrow(my.df[my.df$dup == 1, ]))
  return(my.df)
}


# Merge function

merge_list <- function(listofdf){
  # '''
  # Input: list of dataframes you want merged
  # Output: merged result
  # ''' 
  Reduce(
    function(x, y) merge(x, y, all=TRUE), listofdf)
}


# Aggregation function

aggregate.byts <- function(orig.df, minute) {
  # '''
  # Inputs: dataframe column of values you want aggregated, time in minutes
  # Output: new dataframe aggregated by time specified
  # ''' 
  
  # Define the time step for aggregation
  t.step <- minute*60  # 15-minutes in seconds
  
  # Grab the first instance of time and roll back to the earliest whole hour
  #  * note: I don't know a method to find the earliest whole 15-minute
  #    so this will have to do
  t1 <- trunc(orig.df$date[1], "hour")
  
  # Grab the last time
  tn <- tail(orig.df, 1)$date
  
  # Grab total number of rows
  n <- length(orig.df$result_time)
  
  # Initial the current time with the first time
  curr.t <- t1
  
  # Initialize a new empty dataframe for storing ensemble means
  #ensemble.df <- orig.df[FALSE, ]
  #ensemble.df <- subset(ensemble.df, select = -result_time)# remove this column
  #ensemble.df$time <- NA
  #print(ensemble.df)
  ensemble.df <- data.frame((matrix(nrow=0,ncol=4)))
  names(ensemble.df) <- c("adc0", "adc1", "adc2", "time")
  
  while (curr.t < tn) {
    next.t <- curr.t + t.step
    tmp.df <- orig.df[orig.df$date >= curr.t & orig.df$date < next.t, ]
    
    # Filter out invalid sensor measurements
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
    # Compute the average for valid sensor measurements based on this subset
    # (see ranges for valid sensor measurements) and add values with time
    # to the new dataframe
    #print(length(tmp.df$result_time))
    #print(ensemble.df)
    
    # Update time
    curr.t <- curr.t + t.step
  }
  
  #print('done')
  return(ensemble.df)
}


# Calculate soil water potential function

calc.swp <- function(data){  
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

calc.vwc <- function(data){
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
