# Jacinta Das
# Exercise 0.1

#Install relevant packages 
install.packages("psych")
library("psych")
install.packages("plotrix")
library("plotrix")

y <- c(1,2.5,4,5.5,7,8.5,10,11.5,13,14.5)

# Calculate the three different means, variance, standard deviation, and standard error

# Arithmetic mean
arithmetic <- function(y) 
{ sum = 0
n = 0
for (i in y){
  sum = sum + i
  n = n + 1
}
return (sum/n)
}

# Geometric mean
geometric <- function(y)
{ product = 1
n = 0
for (i in y){
  product = product * i 
  n = n + 1
}
return (product^(1/n))
}

# Harmonic mean 
harmonic <- function(y)
{sum = 0 
n = 0
for (i in y){
  sum = sum + (1/i)
  n = n + 1
}
return (1/(sum/n))
}

# Variance
variance <- function(y)
{sum = 0
n = 0
for (i in y){
  sum = sum + i
  n = n + 1
}
average = (sum/n)
sum2 = 0 
for (i in y){
  sum2 <- (i-average)^2 + sum2
}
return(sum2/(n-1))
}

# Standard deviation
standard_deviation <- function(y)
{sum = 0
n = 0
for (i in y){
  sum = sum + i
  n = n + 1
}
average = (sum/n)
sum2 = 0 
for (i in y){
  sum2 <- (i-average)^2 + sum2
}
variance = (sum2/(n-1))
return (variance^(1/2))
}

# Standard error 
standard_error <- function(y)
{sum = 0
n = 0
for (i in y){
  sum = sum + i
  n = n + 1
}
average = (sum/n)
sum2 = 0 
for (i in y){
  sum2 <- (i-average)^2 + sum2
}
variance = (sum2/(n-1))
return ((variance/n)^(1/2))
}

# Test functions against R functions
arithmetic(y)
mean(y)
geometric(y)
geometric.mean(y)
harmonic(y)
harmonic.mean(y)
variance(y)
var(y)
standard_deviation(y)
sd(y)
standard_error(y)
std.error(y)

# Citations:
# Davis, T. (2021, February 4). Exercise 0.1 Lecture Notes.
# Statistics Globe. 2021. Geometric Mean in R (2 Examples) | Manual vs. geometric.mean Fucntion. [online] Available at: <https://statisticsglobe.com/geometric-mean-in-r> 
# Statistics Globe. 2021. Harmonic Mean in R (2 Examples) | harmonic.mean of Vector & Column. [online] Available at <https://statisticsglobe.com/harmonic-mean-in-r> 
# Statistics Globe. 2021. Standard Error in R (2 Example Codes) | User-Defined & std.error Function. [online] Available at <https://statisticsglobe.com/standard-error-in-r-example>