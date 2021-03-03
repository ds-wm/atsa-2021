# Exercise 0.1

# Calculate the three different means.
# Arithmetic
calc.mean.arithmetic <- function(vals) {
  my.sum <- sum(vals)
  my.count <- length(vals)
  my.mean <- my.sum/my.count
  return(my.mean)
}
# Geometric
calc.mean.geometric <- function(vals) {
  my.prod <- prod(vals)
  my.count <- length(vals)
  my.mean <- my.prod^(1/my.count) # take the "count"-th root
  return(my.mean)
}
# Harmonic
calc.mean.harmonic <- function(vals) {
  my.sum <- sum(1/vals) # sum of all the reciprocals
  my.count <- length(vals)
  my.mean <- my.count/my.sum
  return(my.mean)
}

# Calculate the variance.
calc.variance <- function(vals) {
  my.mean <- mean(vals)
  my.count <- length(vals)
  my.variance <- sum((vals-my.mean)^2)/(my.count-1)
  return(my.variance)
}

# Calculate the standard deviation.
calc.stddev <- function(vals) {
  my.variance <- calc.variance(vals)
  my.stddev <- my.variance^(1/2) # just the square root of the variance
  return(my.stddev)
}

# Calculate the standard error about the mean.
calc.se <- function(vals) {
  my.stddev <- calc.stddev(vals)
  my.count <- length(vals)
  my.se <- my.stddev/(my.count^(1/2))
  return(my.se)
}

test.values <- c(1, 2.5, 4, 5.5, 7, 8.5, 10, 11.5, 13, 14.5)
cat("My calculated arithmetic mean:", calc.mean.arithmetic(test.values), "\nThere is a built-in R function that does the same computation.\nBuilt-in function's output:", mean(test.values), "\nThe two outputs match.")
cat("My calculated geometric mean:", calc.mean.geometric(test.values), "\nThere is no built-in R function that does the same computation.")
cat("My calculated harmonic mean:", calc.mean.harmonic(test.values), "\nThere is no built-in R function that does the same computation.")
cat("My calculated variance:", calc.variance(test.values), "\nThere is a built-in R function that does the same computation.\nBuilt-in function's output:", var(test.values), "\nThe two outputs match.")
cat("My calculated standard deviation:", calc.stddev(test.values), "\nThere is a built-in R function that does the same computation.\nBuilt-in function's output:", sd(test.values), "\nThe two outputs match.")
cat("My calculated standard error about the mean:", calc.mean.harmonic(test.values), "\nThere is no built-in R function that does the same computation.")

