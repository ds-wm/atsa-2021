## Monica Alicea
## Exercise 0.1

install.packages("psych")
install.packages("plotrix")
library("plotrix")
library("psych")

#1.Calculate the three different means.
#Find the arithmetic mean
arithmetic_mean <- function(vector) {
  
  sum_variables <- 0
  for (number_a in vector) {
    sum_variables <- sum_variables + number_a
  }
  return(sum_variables/length(vector))
}

#Find the geometric mean 
geometric_mean <- function(vector) {
  multiply_variables <- 1
  for (number_g in vector) {
    multiply_variables <- multiply_variables * number_g
  }
  return(multiply_variables**(1/length(vector)))
}

#Find the harmonic mean
harmonic_mean <- function(vector) {
  divide_variables <- 0
  for (number_h in vector) {
    divide_variables <- divide_variables + (1/number_h)
  }
  return(length(vector)/divide_variables)
}

#2.Calculate the variance.
variance <- function(vector) {
  sum_variables <- 0
  for (number in vector) {
    sum_variables <- sum_variables + (number - arithmetic_mean(vector))**2
  }
  return(sum_variables/(length(vector)-1))
}

#3.Calculate the standard deviation.
stnd_deviation <- function(vector) {
  return(sqrt(variance(vector)))
}

#4.Calculate the standard error about the mean.
stnd_error <- function(vector) {
  return(stnd_deviation(vector)/sqrt(length(vector)))
}

#Test 
vector <- c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

arithmetic_mean(vector)
mean(vector)

geometric_mean(vector)
geometric.mean(vector)

harmonic_mean(vector)
harmonic.mean(vector)

variance(vector)
var(vector)

stnd_deviation(vector)
sd(vector)

stnd_error(vector)
std.error(vector)
