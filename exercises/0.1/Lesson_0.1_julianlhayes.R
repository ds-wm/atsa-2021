y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

# Exercise 0.1, question 1
# This function calculates the three types of means
# Inputs: vectors of numbers
# Outputs: vector of length 3
#         1. Arithmetic 
#         2. Geometric 
#         3. Harmonic 
calc.my.means <- function(y) {
  ## Arithmetic mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i < n+1) {
    my.sum <- my.sum + y[i]
    i <- i + 1
  }
  my.arith.mean <- my.sum / n
  # mean(y)
  #cat("Arithmetic mean: ", my.arith.mean, "\n")
  
  ## Geometric mean
  i <- 1
  n <- length(y)
  my.prod <- 1
  while (i < n+1) {
    my.prod <- my.prod * y[i]
    i <- i + 1
  }
  my.geom.mean <- my.prod ** (1/n)
  #cat("Geometric mean: ", my.geom.mean, "\n")
  
  ## Harmonic mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i < n+1) {
    my.sum <- my.sum + (1 / y[i])
    i <- i + 1
  }
  my.harm.mean <- n / my.sum
  #cat("Harmonic mean: ", my.harm.mean)
  
  all.my.means <- c(my.arith.mean, my.geom.mean, my.harm.mean)
  return (all.my.means)
}

my.means <- calc.my.means(y)
print(my.means)

# Variance
temp.sum <- 0
for (num in y) {
  temp.sum <- temp.sum + (num - my.arith.mean) ** 2
  cat(num)
}
variance <- (temp.sum / (n-1))
variance


# Standard deviation
stan.dev <- sqrt(variance)
stan.dev

# Standard error
stan.error <- sqrt(variance/n)
stan.error

