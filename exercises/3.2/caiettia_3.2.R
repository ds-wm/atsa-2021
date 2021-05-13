# Andrew Caietti
# 4/21/2021
# Exercise 3.2
#########################


library('tswge')

data(dowjones2014)
data <- dowjones2014

# To determine what p to use, we run this code and see that
# we need p = 1
aic.wge(data, p=0:12, q=0:4, type="aic")

plot(data, type = 'l', xlab = 'Time', ylab='Price ($)')
data.par <- parzen.wge(data)
data.period <- period.wge(data)
data.acf <- acf(data, lag.max = 50)
# Based on these plots, we see the Parzen does not 
# indicate much periodicity due to the main spike at 0
# and subsequent lack of peaks. The realization further
# does not indicate periodicity, while the Autocorrelations plot
# shows us strong autocorrelation gradual dampening over time.


# Yule-Walker
stock.yw <- est.ar.wge(data, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
stock.burg <- est.ar.wge(data, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
stock.mle <- est.ar.wge(data, p=1, factor = FALSE, type='mle')

stock.df <- data.frame(
  type=c("YW", "Burg", "MLE"),
  phi1 = c(stock.yw$phi[1], stock.burg$phi[1], stock.mle$phi[1]),
  siga = c(stock.yw$avar, stock.burg$avar, stock.mle$avar)
)
stock.df

# We can finally see that the smallest variance is achieved by the
# Maximum Likelihood Estimators method which makes MLE the best estimation
# method for this data set. 
