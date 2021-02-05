#Name: Andrew Caietti
#Class: DATA 330
#Date: 2021-2-5

y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

#Question 1: Calculate the Three Different Means
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
# There is a built in mean function; mean()
means[1] - mean(y)
# we see they calculate the same value!

# There is not a built in Geometric Mean function.
# There is not a built in Harmonic Mean function.
# though various libraries could be imported to calculate these means

#Question 2: Calculate the Variance
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
# There is a built-in function for this; var()
calc.var(y) - var(y)
# We see that these functions then calculate the same value


#Question 3: Calculate the Standard Deviation
calc.stdev <- function(my.var){
  my.stdev <- my.var ** (1/2)
  cat("Standard Dev: ", my.stdev, '\n')
  return(my.stdev)
}
# There is a built-in function for this; sd()
my.var <- calc.var(y)
calc.stdev(my.var) - sd(y)
# we see that these functions calculate the same value.


#Question 4: Calculate the Standard Error About the Mean
calc.stderr <- function(my.var){
  n <- length(y)
  my.err <- (my.var/n) ** (1/2)
  cat("Standard Error: ", my.err, '\n')
  return(my.err)
}
# There is not a built in function for standard error,
# though various libraries could be imported for this
