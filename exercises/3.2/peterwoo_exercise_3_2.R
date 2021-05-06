# DATA 330 Applied Time Series Analysis
# Exercise 3.2
# Peter Woo
# 5/6/2021

# PROBLEM STATEMENT: 
# Fit an AR(p) model to the 2014 daily average Dow Jones stock price found in 
# the dowjones2014 dataset.Plot the realization along with sample
# autocorrelations and periodogram. Include all parameter estimates
# (i.e., φp and σa2) based on the three estimator methods 
# (i.e., Yule-Walker, Burg and Maximum-Likelihood). Compare the results of 
# these three methods.

# Install the package tswge for this exercise 
#install.packages('tswge')
library('tswge')

# Load the Dow Jones data
data('dowjones2014')

# Fit it to the AR(p) model
model <- aic.wge(dowjones2014, p = 0:12, q = 0:4, type = 'aicc')
# we see here that p = 1. 

# Plot the realization 
plot(dowjones2014, 
     main = 'Average Daily Dow Jones Price in 2014',
     xlab ='Time',
     ylab = 'Average Daily Dow Jones Price ($)',
     type = 'l')

# Sample autocorrelations
dowjones2014.acf <- acf(dowjones2014, lag.max = 25, main = 'ACF for Average Daily Dow Jones Price in 2014')

# Periodogram
dowjones2014.pgram <- period.wge(dowjones2014)
dowjones2014.parzen <- parzen.wge(dowjones2014)

# Yule Walker estimator
yulewalker <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')

# Burg estimator
burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')

# Maximum-likelihood estimator
maxl <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Compare the results
compare <- data.frame(
  type=c("True", "YW", "Burg", "MLE"),
  phi = c(model$phi, yulewalker$phi[1], burg$phi[1], maxl$phi[1]),
  sigma = c(model$vara, yulewalker$avar, burg$avar, maxl$avar)
)
compare










