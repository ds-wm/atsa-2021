# Block 2 - Exercise 2.1: Utility Script
# Name: Justin Callahan
# Class: DATA 330
# Date: 2021-04-08


# Calculate soil water potential from raw (mv) to kilo Pascals (kPa)
calcSwp <- function(rawWP){
  a = 0.000048;
  b = 0.0846;
  c = 39.45;
  if (rawWP < 591 || rawWP > 841)
  {
    calWP = 0;
  }
  else
  {
    calWP = -1.0*exp( (a * rawWP * rawWP) - (b * rawWP) + c );
  }
  return calWP;
}
  
  # Calculate soil moisture from raw (mV) to volumetric (m^3/m^3)
calcVwc <- function(rawSM)
{
  a = 0.00119
  b = 0.401
  if (rawSM < 337 || rawSM > 841)
  {
    calSM = 0;
  }
  else
  {
    calSM = A * rawSM - B;
  }
  return calSM;
}

#Merge Data
merge_data <- function(listofdf){
  merged_df <- Reduce(function(x, y) merge(x, y, sort = TRUE, all = TRUE), listofdf)
  return(merged_df)
}

#Find and identify duplicates
find_duplicates <- function(my.df) {
  kbd <- (15 - 2)*60
  lts <- length(my.df$result_time)
  check.cols <- c("nodeid", "parent", "voltage", "humid", "humtemp", "adc0", 
                  "adc1",   "adc2",   "adc3",    "adc4",  "adc5",    "adc6")
  for (i in 1:(lts-1)) {
    for (j in (i+1):(lts-1)) {
      if (dt < kbd) {
        d.mat <- all(my.df[i, check.cols] == my.df[j, check.cols])
        if (d.mat) {
          my.df[j, "duplicate"] <- 1
        }
      } 
      else {
        break
      }
    }
  }
  print(nrow(my.df[my.df$duplicate == 1, ]))
  return(my.df)
}

