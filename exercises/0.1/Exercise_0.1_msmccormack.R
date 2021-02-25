# Exercise .1
# Part 1: means
## Arithmetic mean
setwd('C:/Users/mmcco/DATA330/exercises')
y <- c(1, 2.5, 4, 5.5, 7, 8.5, 10, 11.5, 13, 14.5)

calc.my.means <- function(y){
  i <- 1
  n <- length(y)
  my.sum <- 0
  
  while (i<n+1){
    my.sum <- my.sum +y[i]
    i <- i + 1
  }
  
  my.arith.mean <- my.sum / n
  cat("Arithmetic mean: ", my.arith.mean)
  
  ## Geometric mean
  i <- 1
  n <- length(y)
  my.prod <- 1
  while (i<n+1){
    my.prod <- my.prod*y[i]
    i <- i+1
  }
  my.geom.mean <- (my.prod)^(1/n)
  cat("\n Geometric mean: ", my.geom.mean)
  
  ## Harmonic mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i<n+1){
    my.sum <- my.sum + (1/y[i])
    i <- i + 1
  }
  my.harm.mean <- (n/my.sum)
  cat("\n Harmonic mean: ", my.harm.mean)
}

calc.my.means(y)

# Part 2: Variance
i <- 1
n <- length(y)
my.sum <- 0
while (i<n+1){
  my.sum <- my.sum + (y[i]-mean(y))^2
  i <- i + 1
}
my.var <- my.sum/(n-1)
cat("\n Variance: ", my.var)

# Part 3: Standard Deviation
my.std_dev <- my.var^(1/2)
cat("\n Standard Deviation: ", my.std_dev)

# Part 4: Standard Error
my.std_err <- (my.var/n)^(1/2)
cat("\n Standard Error: ", my.std_err)