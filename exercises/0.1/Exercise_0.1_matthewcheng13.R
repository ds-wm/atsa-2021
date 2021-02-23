# Matthew Cheng
# Exercise 0.1

# functions

# arithmetic mean
# mean() is the equivalent
arithmetic <- function(set) {
  sumx <- 0
  for (x in set) {
    sumx <- sumx + x
  }
  return(sumx/length(set))
}


# geometric mean
# no equivalent
geometric <- function(set) {
  prod <- 1
  for (x in set) {
    prod <- prod * x
  }
  return(prod^(1/length(set)))
}

# harmonic mean
# no equivalent
harmonic <- function(set) {
  sumx <- 0
  for (x in set) {
    sumx <- sumx + (1/x)
  }
  return(length(set)/sumx)
}

# variance
# var() is the equivalent
variance <- function(set) {
   arith_mean <- arithmetic(set)
   sum_sq <- 0
   for (x in set) {
     sum_sq <- (x-arith_mean)^2 + sum_sq
   }
   return(sum_sq/(length(set)-1))
}

# standard deviation
# sd() is the equivalent
st_dev <- function(set) {
  return(sqrt(variance(set)))
}

# standard error
# no equivalent
st_err <- function(set) {
  return(sqrt(variance(set)/length(set)))
}

y <- c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

# exercise

# 1
cat("Arithmetic mean: ",arithmetic(y),"\nGeometric mean: ",geometric(y),"\nHarmonic mean: ",harmonic(y))

# 2
cat("\nVariance: ",variance(y))

# 3
cat("\nStandard deviation: ",st_dev(y))

# 4
cat("\nStandard error: ",st_err(y))