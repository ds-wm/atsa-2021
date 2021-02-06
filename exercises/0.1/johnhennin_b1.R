y <-c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

# calc.means
# This function calculates three types of means
# Inputs: vector of numbers
# Outputs: vector of length 3
#     1. Arithmetic
#     2. Geometric
#     3. Harmonic
calc.means <- function(y) {
  l <- 1
  n <- length(y)
  my.sum <- 0
  while (l < n+1) {
    my.sum <- my.sum + y[l]
    l <- l + 1
  }
  arith.mean <- my.sum/n
  #cat("Arithmetic Mean: ", arith.mean)
  
  ##Geometric Mean
  i <- 1
  n <- length(y)
  my.prod <- 1
  while (i < n+1) {
    my.prod <- my.prod * y[i]
    i <- i + 1
  }
  geom.mean <- my.prod**(1/n)
  #cat("\nGeometric Mean: ", geom.mean)
  
  ##Harmonic Mean
  l <- 1
  n <- length(y)
  my.sum <- 0
  while (l < n+1) {
    my.sum <- my.sum + (1/y[l])
    l <- l + 1
  }
  harm.mean <- n/my.sum
  #cat("\nHarmonic Mean: ", harm.mean)
  my.means <-c(arith.mean, geom.mean, harm.mean)
  return (my.means)
}

my.means <- calc.means(y)
my.means
# Comparison
mean(y)

# calc.variance
# This function calculates the variance
# Inputs: vector of numbers
# Outputs: vector of length 1; variance of original vector
calc.variance <- function(y) {
  i <- 1
  sum <- 0
  n <- length(y)
  while (i<n+1) {
    sum = (y[i]- calc.means(y)[1])**2 + sum
    i = i +1
 }
  return (sum/(n-1))
}
calc.variance(y)

# Comparison
var(y)

# calc.sd
# This function calculates the standard deviation
# Inputs: vector of numbers
# Outputs: vector of length 1; standard deviation of original vector
calc.sd <- function(y){
  return(calc.variance(y)**.5)
}
calc.sd(y)

# Comparison
sd(y)

# calc.soe
# This function calculates the standard of error
# Inputs: vector of numbers
# Outputs: vector of length 1; standard of error of original vector
calc.soe <- function(y){
  n <- length(y)
  return(calc.variance(y)/n)
}
calc.soe(y)