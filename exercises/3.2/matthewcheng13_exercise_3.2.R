# Exercise 3.1:
# Matthew Cheng

#install.packages("tswge")
library(tswge)

# fit AR(p) model to dowjones2014 dataset. 
# plot the realization along with sample 
# autocorrelations and periodogram. 
# include phi(p) and Sigma(a)(2)
# based on Yule-Walker, Burg and Maximum-Likelihood 
# compare the results methods.

# data("ss08")
# length(ss08)

data("dowjones2014")
length(dowjones2014)

# the dj dataset is about the same size as the ss08 dataset
# from the example, so we can use aic.wge to find the p value

dj.aic <- aic.wge(dowjones2014, p=0:12,q=0:4,type = 'aicc')
# p = 1
# phi = .982 
# vara(sigma) = 12897.94

# The realization, sample autocorrelations and periodogram of the data
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
plot(dowjones2014, 
     main = 'Average Daily Dow Jones Price in 2014',
     xlab ='Time',
     ylab = 'Price ($)',
     type = 'l')

# sample autocorrelation
dj.acf <- acf(dowjones2014, lag.max = 25)

# periodogram
dj.pgram <- period.wge(dowjones2014)

#parzen window
dj.parzen <- parzen.wge(dowjones2014)

# Yule-Walker
dj.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
dj.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
dj.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Extract the parameter estimates for theta's and white noise variance
dj.df <- data.frame(
  type = c("YW", "Burg", "MLE"),
  phi = c(dj.yw$phi[1], dj.burg$phi[1], dj.mle$phi[1]),
  sigma = c(dj.yw$avar, dj.burg$avar, dj.mle$avar)
)
dj.df

# compare the results methods. 

#   type       phi    sigma
# 1   YW 0.9708351 12954.69
# 2 Burg 0.9785300 12906.99
# 3  MLE 0.9815898 12897.94

# As we can see, the each of the estimates produces slightly different
# results, however, all of the values are relatively close. In this case,
# MLE has the highest phi value and the lowest sigma value, while the
# Yule-Walker has the lowest phi value and the highest sigma value.
# Burg seems to estimate more middle-ground values, however its values are
# closer to that of MLE.


