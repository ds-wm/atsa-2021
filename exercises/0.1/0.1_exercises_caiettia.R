# Part 1: the means

y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)


# calc.my.means
# Inputs: vector of numbers
# Outputs: vector of length 3
#         - arithmetic mean
#         - geometric mean
#         - harmonic mean

calc.my.means <- function(y) {
  
  ## Arithmetic Mean
  i <- 1
  n <- length(y)
  my.sum <- 0 
  while (i < n+1) {
    my.sum <- my.sum + y[i]
    i <- i + 1
  }
  my.arith.mean <-sum(y)/n
  cat("Arithmetic Mean: ", my.arith.mean, "\n")
  
  
  ## Geometric Mean
  i <- 1
  n <- length(y)
  my.prod <- 1
  while (i < n+1) {
    my.prod <- my.prod*y[i]
    i <- i + 1
  }
  my.geom.mean <- my.prod ** (1/n)
  cat("Geometric Mean: ", my.geom.mean,"\n")
  
  
  ## Harmonic Mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i < n+1) {
    my.sum <- my.sum + (1/y[i])
    i <- i + 1
  }
  my.harm.mean <- n/my.sum
  cat("Harmonic Mean: ", my.harm.mean,'\n')
  return(c(my.arith.mean, my.geom.mean, my.harm.mean))
}
calc.my.means(y)

calc.var <- function(y){
  temp.sum <- 0
  i <- 1
  n <- length(y)
  my.mean <- sum(y)/n
  while (i < n+1) {
    temp.sum <- temp.sum + ((y[i] - my.mean)**2)
    i <- i+1
  }
  my.var <- temp.sum/(n-1)
  cat("Variance: ", my.var, '\n')
  return(my.var)
}

calc.stdev <- function(my.var){
  my.stdev <- my.var ** (1/2)
  cat("Standard Dev: ", my.stdev, '\n')
  return(my.stdev)
}

calc.stderr <- function(my.var){
  n <- length(y)
  my.err <- (my.var/n) ** (1/2)
  cat("Standard Error: ", my.err, '\n')
  return(my.err)
}
