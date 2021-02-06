# Exercise 0.1

##Q1. Calculate the three different means.
##Q2. Calculate the variance.
##Q3. Calculate the standard deviation.
##Q4. Calculate the standard error about the mean.

setwd("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330")

# Question 1
y <- c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

# calc.my.means
# This function of calculate the three types of means 
# Inputs : Vector of numbers
# Outputs : vector of length 3
#           - arithmetic
#           - geometric
#           - harmonic 

calc.my.means <- function (y) {
  ## Arithmetic mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while(i < n+1){
    my.sum <- my.sum + y[i]
    i <- i + 1
  }
  my.arith.mean <- my.sum/n
  #my.arith.mean
  #mean(y)
  
  cat("Arithmetic mean:", my.arith.mean)
  
  ## Geometric Mean
  i <- 1
  n <- length(y)
  my.prod <- 1
  while(i < n+1){
    my.prod <- my.prod * y[i]
    i <- i+1
  }
  my.geom.mean <- my.prod ** (1/n)
  cat("Geometric Mean: ", my.geom.mean)
  
  ## Harmonic Mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i < n+1) {
    my.sum <- my.sum + (1/y[i])
    i <- i + 1
  }
  my.harm.mean <- n/my.sum
  cat("Harmonic mean: ", my.harm.mean)
  
  all.my.means <- c(my.arith.mean, my.geom.mean, my.harm.mean)
  return(all.my.means)
}


my.means <-calc.my.means(y)
print(my.means)

# Question 2 - Variance 

## Arithmetic Mean
i <- 1
n <- length(y)
my.sum <- 0
while(i < n+1){
  my.sum <- my.sum + y[i]
  i <- i + 1
}

temp.sum <- 0

my.arith.mean <- my.sum/n


for (num in y){
  temp.sum <- temp.sum + (num-my.arith.mean)**2
  cat(num)
}

variance <- (temp.sum/(n-1))
variance 

# Built-in Function for Variance <- var(y)


# Question 3 - Standard Deviation

standard.deviation <- sqrt(variance)
standard.deviation 

# Built-in Function for standard deviation <- sd(y)

# Question 4 - Standard Error 

standard.error <- sqrt(variance/n)
standard.error
