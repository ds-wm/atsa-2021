# R-Version 4.0.2 "Taking Off Again"

# File Name: "Group3_Utility_Script.R"

# Created by: Conrad Ning, Connor Sughrue, Matt McCormack, Kimya Shirazi, Keagan DeLong, Monica 

# Last edited on: 3/11/2021

##############################
# Function to aggregate data##
##############################

mergeDF <- function(listofdf){
  comboDf <- Reduce(function(x, y) merge(x, y, sort = TRUE, all = TRUE), listofdf)
  return(comboDf)
}

###################################
##Function to Data de-duplication##
###################################
removeDuplicates <- function(data, timeBoundary = 450){
  
  duplicateVector = c()
  numRow <- length(data$result_time)
  
  duplicateVector = c(duplicateVector, TRUE)
  startTime <- strptime(data$result_time[1], "%Y-%m-%d %H:%M:%S")
  
  for (i in 1:numRow - 1){
    
    nextTime <- strptime(data$result_time[i + 1], "%Y-%m-%d %H:%M:%S")
    timeDifference <- as.numeric(difftime(nextTime, startTime, units = c("secs")))
    
    if (timeDifference > timeBoundary){
      duplicateVector = c(duplicateVector, TRUE)
      startTime <- strptime(data$result_time[i + 1], "%Y-%m-%d %H:%M:%S")
    }
    else{
      duplicateVector = c(duplicateVector, FALSE)
    }
  }
  return(data[duplicateVector,])
}

#############################
# remove duplicate function##
#############################
removeDuplicates <- function(data, timeBoundary = 450){
  
  duplicateVector = c()
  numRow <- length(data$result_time)
  
  duplicateVector = c(duplicateVector, TRUE)
  startTime <- strptime(data$result_time[1], "%Y-%m-%d %H:%M:%S")
  
  for (i in 2:numRow){
    
    nextTime <- strptime(data$result_time[i], "%Y-%m-%d %H:%M:%S")
    timeDifference <- as.numeric(difftime(nextTime, startTime, units = c("secs")))
    
    if (timeDifference > timeBoundary){
      duplicateVector = c(duplicateVector, TRUE)
      startTime <- strptime(data$result_time[i], "%Y-%m-%d %H:%M:%S")
    }
    else{
      duplicateVector = c(duplicateVector, FALSE)
    }
  }
  return(data[duplicateVector,])
}

#####################
##Convert the units##
#####################
calcSwp <- function(rawWP)
{
  a = 0.000048
  b = 0.0846
  c = 39.45
  
  if(rawWP < 591 || rawWP > 841)
  {
    calWP = 0
  }
  else
  {
    calWP = -1.0 * exp((a * rawWP * rawWP) - (b * rawWP) + c)
  }
  return(calWP)
}

calcVwc <- function(rawSM)
{
  a = 0.00119
  b = 0.401
  
  if (rawSM < 337 || rawSM > 841)
  {
    calSM = 0
  }
  else
  {
    calSM = a * rawSM - b
  }
  return(calSM)
}

# Function that aggregate data with different time interval
aggregateOverTime <- function(variable, timePeriod, data)
{
  LEN <- length(data$result_time)
  
  # initialize variables
  v <- c()
  currentCount <- 0
  numIteration <- 0
  
  # set time for begining of first period
  periodStart <- strptime("2010-05-29 07:00:00", "%Y-%m-%d %H:%M:%S")
  
  # iterate through each row of the dataframe
  for (i in 1:LEN)
  {
    # calculate the difference in time between the beginning of the period and the current row
    currentTime <- data$result_time[i]
    timeDifference <- as.numeric(difftime(currentTime, periodStart, units = c("secs")))
    
    # if the time difference is less then the period
    if (timeDifference <= timePeriod)
    {
      # increment the variables
      currentCount <- currentCount + data[[variable]][i]
      numIteration <- numIteration + 1
    }
    # if the time difference is greater then the period
    else
    {
      # append the average value of the variable being tracked to a vector
      v <- c(v, currentCount / numIteration)
      
      # calculate how many periods were skipped and when the next period begins
      sinceStart <- as.numeric(difftime(currentTime, periodStart, units = c("sec")))
      periodsSkipped <- floor(sinceStart / timePeriod)
      periodTemp <- periodStart + (periodsSkipped * timePeriod)
      
      # append a zero to the vector for each period skipped 
      if(periodsSkipped - 1 > 0)
      {
        temp <- rep(c(0), times = periodsSkipped - 1)
        v <- c(v, temp)
      }
      
      # redefine periodStart as the beginning of the new period
      periodStart <- periodTemp
      
      # initialize variables for new period
      currentCount <- data[[variable]][i]
      numIteration <- 1
    }
  }
  return(v)
}

# Function to reproduce the figures


createDataTable <- function(time, data)
{
  adc0 <- aggregateOverTime(variable = 'adc0', timePeriod = time, data = data)
  adc0Converted <- vapply(X = adc0, FUN = calcSwp, FUN.VALUE = numeric(1))
  
  adc1 <- aggregateOverTime(variable = 'adc1', timePeriod = time, data = data)
  adc1Converted <- vapply(X = adc1, FUN = calcVwc, FUN.VALUE = numeric(1))
  
  adc2 <- aggregateOverTime(variable = 'adc2', timePeriod = time, data = data)
  adc2Converted <- vapply(X = adc2, FUN = calcVwc, FUN.VALUE = numeric(1))
  
  return(data.frame(adc0 = adc0Converted, adc1 = adc1Converted, adc2 = adc2Converted))
}


###########################################################
# A function that reproduce the plot with the same format##
###########################################################

createPlots <- function(origionalData, duplicateFreeData, variable, lim, xlab, ylab)
{
  par(mfrow = c(2,2))
  options(repr.plot.width = 10, repr.plot.height = 10, repr.plot.res = 150)
  mainList <- list('15 Minute Interval', "60 Minute Interval", "12 Hour Interval", "24 Hour Interval")
  
  for (i in 1:4)
  {
    x = data.frame(duplicateFreeData[i])[[variable]]
    y = data.frame(origionalData[i])[[variable]]
    plot(x, y, xlab = xlab, ylab = ylab, main = mainList[i], xlim = lim, ylim = lim)
    
    rT <- round(summary(lm(x ~ y))$r.squared, 4)
    rmseT <- rmse(y, x)
    
    width <- lim[2] - lim[1]
    ma <- max(lim)
    mi <- min(lim)
    
    text(ma - width*.30, mi + width*.18, sprintf('N = %d', length(x)), cex = 1.2, adj = c(0, 0))
    text(ma - width*.30, mi + width*.10, TeX('$R^2 =$'), cex = 1.2, adj = c(0, 0))
    text(ma - width*.20, mi + width*.10, rT, cex = 1.2, adj = c(0, 0))
    text(ma - width*.30, mi + width*.02, sprintf('RMSE = %.2f', rmseT), cex = 1.2, adj = c(0, 0))
  }
}