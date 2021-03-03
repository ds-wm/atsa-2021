# Ray Shen 
# DATA 330 Applied Time Series Analysis
# Feb.20, 2021
# Exercise 0.1
y <- c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

#1.Calculate the three different means.
arithmetic <- function(y) {
  sum = 0
  for (i in y){
    sum = sum+i
  }
  return (sum/length(y))
}

geometric <- function(y) {
  product = 1
  for (i in y) {
    product = product*i
  }
  return (product**(1/length(y)))
}              

harmonic <- function(y) {
  sum = 0
  for (i in y) {
    sum = sum+1/i
  }
  return (length(y)/sum)
}

#2.Calculate the variance.
variance <- function(y) {
  sum = 0
  m = mean(y)
  for (i in y) {
    sum = sum+(i-m)**2
  }
  return (sum / (length(y) - 1))
}

#3.Calculate the standard deviation.
sd <- function(y) {
  sum = 0
  m = mean(y)
  for (i in y) {
    sum = sum+(i-m)**2
  }
  return ((sum / (length(y) - 1))**0.5)
}

#4.Calculate the standard error about the mean.
se <- function(y) {
  sum = 0
  m = mean(y)
  for (i in y) {
    sum = sum+(i-m)**2
  }  
  return (((sum/(length(y)-1))/length(y))**0.5)
} 