# Name: Connor Sughrue
# Class: DATA 330
# Date: 3-2-2021
# Exercise: 1.2

install.packages('tswge')
library('tswge')

# Question 1
# Load data and visualize

# load data
data(ss08)

# base plot in R
plot(ss08)

# function provided by textbook
plotts.wge(ss08)



# Question 2
# Calculate the mean of the time series realization

mean(ss08) # = 52.24385



# Question 3
# Load dataset 'hadley' and 
# Plot sample autocorrelation and sample autocovariance

# load data
data(hadley)

# sample autocorrelation and sample autocovariance plots
acf(hadley, type = 'correlation')
acf(hadley, type = 'covariance')



# Question 4
# Write equations for Y0, Y1, p0, p1 and compute them using R

sample.autocovariance <- function(ts.data, lag){
  n <- length(ts.data)
  mu <- mean(ts.data)
  
  t.dev.offset <- n - lag
  h.dev.offset <- 1 + lag
  
  t.deviation <- ts.data[1 : t.dev.offset] - mu
  h.deviation <- ts.data[h.dev.offset : n] - mu
  
  product <- t.deviation * h.deviation
  summation <- sum(product)
  
  return((1 / n) * summation)
}

sample.autocorrelation <- function(ts.data, lag){
  lag.h <- sample.autocovariance(ts.data, lag)
  lag.0 <- sample.autocovariance(ts.data, 0)
  return(lag.h / lag.0)
}

# Y0 = sample autocovariance of time series X for a lag of 0
# $$\hat \gamma_0 = \frac{1}{n} \sum_{t = 1}^{n - 0} (X_t - \mu) (X_{t + 0} - \mu)$$
Y0 <- sample.autocovariance(hadley, 0) # = 0.66682

# Y1 = sample autocovariance of time series X for a lag of 1
# $$\hat \gamma_1 = \frac{1}{n} \sum_{t = 1}^{n - 1} (X_t - \mu) (X_{t + 1} - \mu)$$
Y1 <- sample.autocovariance(hadley, 1) # = 0.05881

# p0 = sample autocovariance of time series X for a lag of 0
# $$\hat \rho_0 = \frac{\hat \gamma_0}{\hat \gamma_0}$$
p0 <- sample.autocorrelation(hadley, 0) # = 1

# p1 = sample autocovariance of time series X for a lag of 1
# $$\hat \rho_1 = \frac{\hat \gamma_1}{\hat \gamma_0}$$
p0 <- sample.autocorrelation(hadley, 1) # = 0.88206



# Quesion 5
# Plot the time series and periodogram for Figure 1.10a of Woodward et al.
# What are the three domain frequencies of this dataset?

# load data
data('fig1.10a')
p1.10a <- period.wge(fig1.10a)

# plots
plotts.wge(fig1.10a)
plotts.wge(p1.10a$pgram)

# three domain frequencies
max1 <- which.max(p1.10a$pgram)
freq1 <- p1.10a$freq[max1] * 10

max2 <- which.max(p1.10a$pgram[0:14])
freq2 <- p1.10a$freq[max2] * 10

max3 <- which.max(p1.10a$pgram[0:9])
freq3 <- p1.10a$freq[max3] * 10

cat('The three freqencies are:', freq1, ',', freq2, ', and', freq3, "\n")



# Question 6
# Recreate the time series in Figure 1.10a (Woodward et al.)

t <- 0:1000/10
X <- cos(2*pi*t*freq3) + 1.5*cos((2*pi*t*freq2) + 1) + 2*cos((2*pi*t*freq3) + 2.5)

plot(t, X, type = 'l')

