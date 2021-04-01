get.data <- function(){
 # '''
 # This function retrieves all of the data files from their sources and
 # stores the data set in one main data frame. This function thus returns
 # a dataframe object with all of the raw data contained within it.
 # '''
  
  urls <- c(
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt',
    'https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt'
  )
  url <- urls[1]
  data.name <- tail(unlist(strsplit(url, '/')), n=1)
  data.file <- paste('/tmp/', data.name, sep='')
  download.file(url, data.file, method='auto')
  main.data <- read.table(data.file, header = TRUE, row.names = NULL, sep = ',')
  
  for (i in 2:length(urls)){
    url <- urls[i]
    data.name <- tail(unlist(strsplit(url, '/')), n=1)
    data.file <- paste('/tmp/', data.name, sep='')
    download.file(url, data.file, method='auto')
    temp.data <- read.table(data.file, header = TRUE, row.names = NULL, sep = ',')
    main.data <- rbind(main.data, temp.data)
  }
}

no.dupes <- function(main.data){
  seq <- list()
  j <-1 
  for (i in 1:(length(main.data$adc0))){
    
    if (i ==1 ){
      seq[[i]] <- 1
      j <- j + 1
    }
    
    else if (i == length(main.data$adc0)){
      seq[[i]] <- 1
      
    }
    
    else if (main.data$humid[i-1] == main.data$humid[i] & main.data$humid[i] != main.data$humid[i+1]){
      
      seq[[i]] <- j
      j <- 1
    }
    
    else if (main.data$humid[i-1] != main.data$humid[i] & main.data$humid[i] == main.data$humid[i+1]){
      
      seq[[i]] <- j
      j <- j+1
    }
    
    else if (main.data$humid[i-1] == main.data$humid[i]){
      
      seq[[i]] <- j
      j <- j + 1
    }
    
    
    else if (main.data$humid[i-1] != main.data$humid[i]){
      j <- 1
      seq[[i]] <- j
    }
    
  }
  
  main.data$dupes <- seq
  nodupe.data <- main.data[which(main.data$dupes == 1),]
  return(nodupe.data)
}

time_slicer <- function(test, time_col){
  #'''
  #This function will take the data set and slice it into columns
  #based on the desired time aggregations. These columns are:
  
  #15 minutes = quarters
  #1 Hour = hours
  #12 hours = twelve.hours
  #24 hours = twentyfour.hours
  
  #Thus, the data frame is returned with these new columns. 
  #'''
  
  test$timepos <- as.POSIXct(time_col, format="%Y-%m-%d %H:%M:%S")
  
  test$quarters <- cut(test$timepos, breaks = '15 min')
  test$hours <- cut(test$timepos, breaks = '60 min')
  test$twelve.hours <- cut(test$timepos, breaks = '720 min')
  test$twentyfour.hours <- cut(test$timepos, breaks = '1440 min')
  
  return(test)
}

temporal_agg <- function(dataf, time, x){
  #'''
  #This function aggregates the data set based on a specified
  #time aggregation. This function is to be used after the time_agg
  #as you need to specify what aggregation to break the data set up
  #by. This function returns a data set with averaged values relative 
  #to the time aggregation.
  #'''
  
  st.time <- as.character(time)
  adc0 <- aggregate(dataf$adc0, list(x),mean)
  names(adc0) <- c(st.time, 'adc0')
  
  adc1 <- aggregate(dataf$adc1, list(x),mean)
  names(adc1) <- c(st.time, 'adc1')
  
  adc2 <- aggregate(dataf$adc2, list(x),mean)
  names(adc2) <- c(st.time, 'adc2')
  
  humid <- aggregate(dataf$humid, list(x),mean)
  names(humid) <- c(st.time, 'humid')
  
  humtemp <- aggregate(dataf$humtemp, list(x),mean)
  names(humtemp) <- c(st.time, 'humtemp')
  
  days.data <- merge(adc0, adc1, by = c(st.time))
  days.data <- merge(days.data, adc2, by = c(st.time))
  days.data <- merge(days.data, humid, by = c(st.time))
  days.data <- merge(days.data, humtemp, by = c(st.time))
  
  return(days.data)
  
}

swp_calc <- function(data){  
  # '''
  # Takes an input of the dataframe column of adc0 values
  # and outputs the converted SWP, or soil water potential.
  # outputs this value in a vector.
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

vwc_calc <- function(data){
  # '''
  # Takes an input of the dataframe column of adc1 or adc2 values
  # and outputs the converted VWC, or Soil Mosture.
  # outputs this value in a vector.
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

install.packages("MLmetrics")
library('MLmetrics')

r.square <- function(x,y){
  return(cor(x,y)^2)
}

calc.vals <- function(day.data){
  # '''
  # This function simply takes a data frame and
  # calculates the necessary functions needed from
  # the paper. Finally, it adds these values into the
  # passed data frame.
  # '''
  
  day.data$vwc.2 <- vwc_calc(day.data$adc2)
  day.data$vwc.1 <- vwc_calc(day.data$adc1)
  day.data$swp <- swp_calc(day.data$adc0)
  
  return(day.data)
}

calc.stats <- function(day.data,raw.day.data, swp, PLOT = TRUE, calc = TRUE){
  # '''
  # The way this function works its it takes the raw and no-dupe data frames
  # for a given time aggregation, then you must tell it what value to make
  # stats for / plot. Finally, the PLOT boolean just tells the function if
  # it should plot the values or not.
  # '''
  
  if (PLOT == TRUE){
    plot(day.data$swp, raw.day.data$swp)
  }
  
  if (calc == TRUE){
    stats <- data.frame(R=0, pR = 0, RMSE = 0, stringsAsFactors = FALSE)
    R.days <- r.square(day.data$swp, raw.day.data$swp)
    stats$R <- R.days
    
    pearson.R.days <- sqrt(R.days)
    stats$pR <- pearson.R.days
    
    rmse.days <- sqrt(MSE(day.data$swp, raw.day.data$swp))
    stats$RMSE <- rmse.days
    
    return(stats)
  }
  
}

