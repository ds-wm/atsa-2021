# Applied Time Series Analysis
# Exercise 3.2
# Author: Conrad Ning
# Collaborating with Keagan Delong and Matt McCormack
# created: 2021-05-01
# updated: 2021-05-05


# Problem Statement:Fit an AR(p) model to the 2014 daily average Dow Jones stock price found 
#in the dowjones2014 dataset. Plot the realization along with sample autocorrelations and periodogram. 
# Include all parameter estimates (i.e., phi(p) and Sigma(a)(2) based on the three estimator methods 
#(i.e., Yule-Walker, Burg and Maximum-Likelihood). Compare the results of these three methods.

library(tswge)

# Load the data 
data("dowjones2014")

# Since the sample (n) is not too large, we can use aicc to find the value of p
aic.wge(dowjones2014, p = 0:12, q = 0:4, type = 'aic') # p=1

# Plot the realization, sample autocorrelations, and periodogram 
plot(dowjones2014, xlab='Time', ylab = 'Price($)', type='l')
dj.acf <- acf(dowjones2014, lag.max = 25)
dj.period <- period.wge(dowjones2014)
dj.parz <- parzen.wge(dowjones2014)


# Estimator Method 1 - Yule-Walker
dj.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')

# Estimator Method 2 - Burg
dj.burg <- est.ar.wge(dowjones2014, p=1, factor=FALSE, type='burg')

# Estimator Method 3 - Maximum-Likelihood 
dj.mle <- est.ar.wge(dowjones2014, p =1, factor=FALSE, type = 'mle')


# Compare the parameter estimates from these three methods 
phi<- c(0.9720718,dj.yw$phi[1], dj.burg$phi[1], dj.mle$phi[1])
sigma <- c(12591.9,dj.yw$avar,dj.burg$avar, dj.mle$avar) 
dj.compare <- data.frame(phi,sigma, row.names = c( 'Original','Yule-Walker','Burg', 'Maximum-Likelihood'))
dj.compare


# RESULTS
## From the comparison dataframe, we can tell that the Yule-Walker Method has the closest phi value 
## compared to the original data. Whereas the Maximum-Likelihood Method has the closest sigma value. 
