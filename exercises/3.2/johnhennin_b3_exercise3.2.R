# Applied Time Series Analysis
# Exercise 3.2
# author: John Hennin, William & Mary
# last updated: 2021-05-03

library('tswge')

data(dowjones2014)
data <- dowjones2014

# Find p using AIC function
aic.dow <- aic.wge(data, p=0:15, q=0:5, type="aic")
aic.dow$p

# Find parameter estimates using Yule-Walker, Burg, and MLE
yw.dow <- est.ar.wge(data, p=aic.dow$p, factor = FALSE, type='yw')
burg.dow <- est.ar.wge(data, p=aic.dow$p, factor = FALSE, type='burg')
mle.dow <- est.ar.wge(data, p=aic.dow$p, factor = FALSE, type='mle')

# Plots
par(mfrow=c(2,2))
plot(data, type = 'l', xlab = 'Time', ylab='Price ($)')
acf(data, lag.max=65)
period.wge(data)
parzen.wge(data)

# Build dataframe for actuals and estimates
df.dow <- data.frame(
  type = c("Actual", "Yule-Walker", "Burg", "MLE"),
  phi = c(aic.dow$phi, yw.dow$phi, burg.dow$phi, mle.dow$phi),
  vara = c(aic.dow$vara, yw.dow$avar, burg.dow$avar, mle.dow$avar)
)
# It seems that the Yule-Walker estimator had a better estimation of the phi 
# value, but MLE's variance estimation was the most accurate.