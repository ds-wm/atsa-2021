# Exercises 0.1:

y <- c(1, 2.5, 4, 5.5, 7, 8.5, 10, 11.5, 13, 14.5)

# Question 1: Calculate the three different means

# calc_means
# This function calculates the three types of means
# Inputs: vector of numbers
# Outputs: vector of length 3
#     1. Arithmetic
#     2. Geometric
#     3. Harmonic
calc_means <- function(y) {
  ## Arithmetic mean
  i <- 1
  n <- length(y)
  sum <- 0
  while(i < n + 1) {
    sum <- sum + y[i]
    i <- i + 1
  }
  arith_mean <- sum / n
  
  ## Geometric mean
  i <- 1
  n <- length(y)
  prod <- 1
  while (i < n+1) {
    prod <- prod * y[i]
    i <- i + 1
  }
  geom_mean <- prod ** (1/n)
  
  ## Harmonic mean
  i <- 1
  n <- length(y)
  sum <- 0
  while (i < n+1) {
    sum <- sum + (1 / y[i])
    i <- i + 1
  }
  harm_mean <- n / sum
  
  all_means <- c(arith_mean, geom_mean, harm_mean)
  return (all_means)
}

my_means <- calc_means(y)
my_means

#Comparison
mean(y)


# Question 2: Calculate the variance

# calc_var
# This function calculates the variance
# Inputs: vector of numbers
# Outputs: variance of vector
calc_var <- function(y) {
  arith_mean = calc_means(y)[1]
  k <- 1
  n <- length(y)
  sum <- 0
  for (num in y) {
    sum <- sum + ((num - arith_mean) ** 2)
  }
  variance <- sum / (n - k)
  return (variance)
}

my_var = calc_var(y)
my_var

#Comparison
var(y)


# Question 3: Calculate the standard deviation

# calc_sd
# This function calculates the standard deviation
# Inputs: vector of numbers
# Outputs: standard deviation of vector
calc_sd <- function(y) {
  return(sqrt(calc_var(y)))
}

my_sd = calc_sd(y)
my_sd

#Comparison
sd(y)


# Question 4: Calculate the standard error about the mean

# calc_standard_error
# This function calculates the standard error about the mean
# Inputs: vector of numbers
# Outputs: standard error about mean of vector
calc_standard_error <- function(y) {
  n <- length(y)
  standard_error <- sqrt(calc_var(y)/n)
  return(standard_error)
}

my_stan_error <- calc_standard_error(y)
my_stan_error


savehistory(file = "kelannen_b1.Rhistory")
