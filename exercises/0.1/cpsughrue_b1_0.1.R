# Connor Sughrue
# DATA 330 Applied Time Series Analysis
# 2/10/21
# Exercise 0.1

# 1. Calculate the three means (arithmetic, geometric, and harmonic)

# arithmetic mean
arithmeticMean <- function(vector){
  
  cumulative.sum <- 0
  length <- 0
  
  for (val in vector){
    cumulative.sum <- cumulative.sum + val
    length <- length + 1
  }
  return(cumulative.sum / length)
}

# geometric mean
geometricMean <- function(vector){
  
  cumulative.product <- 1
  length <- 0
  
  for (val in vector){
    cumulative.product <- cumulative.product * val
    length <- length + 1
  }
  return(cumulative.product ^ (1 / length))
}

# harmonic mean
harmonicMean <- function(vector){
  
  denominator <- 0
  length <- 0
  
  for (val in vector){
    denominator <- denominator + (1 / val)
    length <- length + 1
  }
  return(length / denominator)
}

# 2. Calculate the variance
variance <- function(vector, k){
  length <- length(vector)
  squared.deviation <- sum((vector - mean(vector)) ^ 2)
  return(squared.deviation / (length - k))
}

# 3. Calculate the standard deviation
standardDeviation <- function(vector, k){
  var.num <- variance(vector, k)
  return(sqrt(var.num))
}

# 4. Calculate the standard error about the mean
standardError <- function(vector, k){
  standard.deviation <- standardDeviation(vector, k)
  return(standard.deviation / length(vector))
}

#################################################################

test_vector <- c(1, 2.5, 4, 5.5, 7, 8.5, 10, 11.5, 13, 14.5)

cat('my arithmetic mean: ', arithmeticMean(test_vector), '\n')
cat('built in arithmetic mean: ', mean(test_vector), '\n\n')

# no built in function for geometric mean

# no built in function for harmonic mean

cat('my variance: ', variance(test_vector, 1), '\n')
cat('built in variance: ', var(test_vector), '\n\n')

cat('my standard deviation: ', standardDeviation(test_vector, 1), '\n')
cat('built in standard deviation: ', sd(test_vector), '\n\n')

# no built in function for standard error



