# DATA 330 Applied Time Series Analysis
# Exercise 3.2
# Connor Sughrue


# install packages 
# install.packages('tswge')
library('tswge')

# load data
data(dowjones2014)

# fit an AR(p) model to dowjones2014
dow.aic <- aic.wge(dowjones2014, p = 0:12, q = 0, type = "aic")
# value: 9.480696
# p = 1

# plot the realization
plot(dowjones2014, type = 'l',
                   main = 'Dow Jones in 2014',
                   xlab ='Time',
                   ylab = 'Average Daily Dow Jones Price (USD)')

# sample autocorrelations
dow.acf <- acf(dowjones2014, lag.max = 25, main = 'Autocorrelations for Dow Jones Price')

# periodogram
dow.pgram <- period.wge(dowjones2014)
dow.parzen <- parzen.wge(dowjones2014)

dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw') # Yule Walker estimator
dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg') # Burg estimator
dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle') # Maximum-likelihood estimator

# compare the three parameter estimation methods
dow.df <- data.frame(
  type = c("True", "YW", "Burg", "MLE"),
  phi1 = round(c(dow.aic$phi, dow.yw$phi, dow.burg$phi, dow.mle$phi), 3),
  siga = round(c(dow.aic$vara, dow.yw$avar, dow.burg$avar, dow.mle$avar), 3)
)
dow.df
