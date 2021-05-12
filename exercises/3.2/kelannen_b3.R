# Block 3 - Exercise 3.2:
# Name: Katherine Lannen
# Class: DATA 330
# Created: 2021-05-05
# Updated: 2021-05-12

#install.packages('tswge')
library(tswge)

#Fit an AR(p) model to the 2014 daily average Dow Jones stock price found
#in the dowjones2014 dataset. Plot the realization along with sample 
#autocorrelations and periodogram. Include all parameter estimates 
#(i.e., phi(p) and Sigma(a)(2)) based on the three estimator methods 
#(i.e., Yule-Walker, Burg and Maximum-Likelihood). 
#Compare the results of these three methods.

#Load the data
data("dowjones2014")

# Use aicc to find the the value of p
aic.wge(dowjones2014, p=0:12,q=0:4,type = 'aicc')
# The above code shows that p = 1
# It also identifies the true value of phi and variance which is
# 0.9815898 and 12897.94 respectively.

# The realization, sample autocorrelations and periodogram of the data
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
par(mfrow=c(2,2))
plot(dowjones2014, type = 'l', xlab = 'Time', ylab = 'Daily Average Price')
acf(dowjones2014, lag.max = 25)
data_period <- period.wge(dowjones2014)
data_parzen <- parzen.wge(dowjones2014)

# Yule-Walker
dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Extract the parameter estimates for theta's and white noise variance
dow.df <- data.frame(
  type=c("MLE estimation from the AIC method", "YW", "Burg", "MLE"),
  phi1 = c(0.9815898, dow.yw$phi[1], dow.burg$phi[1], dow.mle$phi[1]),
  siga = c(12897.94, dow.yw$avar, dow.burg$avar, dow.mle$avar)
)
dow.df

# As mentioned earlier, when identifying the best p for the AR model of 
# the 2014 daily average Dow Jones stock price dataset, aicc was used 
# which found the best p to be 1. Using that p and the dataset three
# estimator methods were used to get estimates for the parameters phi 
# and sigma. These three methods were Yule-Walker, Burg and 
# Maximum-Likelihood. The above code created the table you see down 
# below which contains the parameter estimates for the models along
# with the MLE estimation from the AIC method values which was calculated
# as a part of aicc. Based off this table the Maximum-Likelihood method 
# achieves the MLE estimation from the AIC method value of phi while the 
# next closest phi estimate was found by the Burg method, followed by 
# Yule-Walker. Similarly, Maximum-Likelihood does best for estimating the 
# parameter siga however, this time the Yule-Walker method is the next
# best method and not the Burg method. In this case Maximum-Likelihood is
# the best overall method for estimating the parameters and Yule-Walker 
# and Burg are about the same though each is slightly better than the 
# other depending on which parameter you focus on.

#type                                      phi1     siga
#1 MLE estimation from the AIC method 0.9815898 12897.94
#2   YW                               0.9708351 12954.69
#3 Burg                               0.9785300 12906.99
#4  MLE                               0.9815898 12897.94

