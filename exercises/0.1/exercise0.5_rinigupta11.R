arithmetic_mean <- function(numbers) {
  # Name: arithmetic_mean
  # Features: Returns the arithmetic mean of a set of numbers
  # Inputs: Vector, numbers 
  # Outputs: The arithmetic mean value 
  sum <- 0 
  for (num in numbers) {
    sum <- sum + num
  }
  return(sum/length(numbers))
}

geometric_mean <- function(numbers) {
  # Name: geometric_mean
  # Features: Returns the geometric mean of a set of numbers
  # Inputs: Vector, numbers 
  # Outputs: The geometric mean value 
  product <- 1
  for (num in numbers) {
    product <- product*num
  }
  return(product^(1/length(numbers)))
}

harmonic_mean <- function(numbers) { 
  # Name: harmonic_mean
  # Features: Returns the harmonic mean of a set of numbers
  # Inputs: Vector, numbers 
  # Outputs: The harmonic mean value 
  sum <- 0 
  for (num in numbers) {
    sum <- (1/num) + sum
  }
  return(length(numbers)/(sum)) 
}

get_three_means <- function(numbers) {
  # Name: get_three_means
  # Features: Computes the arithmetic mean, the geometric mean, and the harmonic mean 
  # Inputs: Vector, numbers 
  # Outputs: Vector, the arithmetic mean, the geometric mean, and the harmonic mean 
  return(c(arithmetic_mean(numbers), geometric_mean(numbers), harmonic_mean(numbers)))
}

variance <- function(numbers) {
  # Name: variance
  # Features: Computes the variance of a set of numbers
  # Inputs: Vector, numbers
  # Outputs: The variance value 
  
  sample_mean <- arithmetic_mean(numbers)
  squared_diff <- 0 
  for (num in numbers) {
    squared_diff <- (num-sample_mean)^2 + squared_diff 
  }
  return(squared_diff/(length(numbers)-1))
}

standard_deviation <- function(numbers) {
  # Name: standard_deviation
  # Features: Computes the standard deviation of a set of numbers 
  # Inputs: Vector, numbers
  # Outputs: The standard deviation value 
  return(sqrt(variance(numbers)))
}

standard_error <- function(numbers) { 
  # Name: standard_error 
  # Features: Computes the standard error of a given set of numbers
  # Inputs: Vector, numbers
  # Outputs: The standard error value 
  return(sqrt(variance(numbers)/length(numbers)))
}

vec <- c(1, 2.5, 4, 5.5, 7, 8.5, 10, 11.5, 13, 14.5) # Y(x)

# My function calls 
get_three_means(vec)
variance(vec)
standard_deviation(vec)
standard_error(vec)

# Built-in function calls 
mean(vec)
var(vec)
sd(vec)

