# Applied Time Series Analysis
# Exercise 3.2
# author: Kelton Berry
# created: 2021-05-06

#PROBLEM STATEMENT: Fit an AR(p) model to the 2014 daily average Dow Jones stock price
#found in the dowjones2014 dataset. 
#Plot the realization along with sample autocorrelations and periodogram. 
#Include all parameter estimates (i.e., φp and σa2)
#based on the three estimator methods (i.e., Yule-Walker, Burg and Maximum-Likelihood).
#Compare the results of these three methods.

#import the twsge library
library(tswge)

#import the Dow Jones stock data
data("dowjones2014")

dow <- dowjones2014

#plot the data to get an idea of what were working with
#we can plot the realization along with sample autocorrelations and periodogram
#We can do this by the plott.sample.wge function
dow.plotts <- plotts.sample.wge(dowjones2014)


## Find pho using AIC function of twsge

dow_aic <- aic.wge(dow, p=0:12, q=0:4, type="aic")

#from this output we find that p = 1

#Now, we can use the Yule-Walker, Burg, and MLE methods to find the parameter estimates
#we can do this by the est.ar.wge function of twsge

dow_yw <- est.ar.wge(dow, p=1, factor = FALSE, type='yw')
dow_burg <- est.ar.wge(dow, p=1, factor = FALSE, type='burg')
dow_mle <- est.ar.wge(dow, p=1, factor = FALSE, type='mle')

#Extract the results into a dataframe
dow_df <- data.frame(
  type=c("AIC", "YW", "Burg", "MLE"),
  phi = c(0.972072, dow_yw$phi[1], dow_burg$phi[1], dow_mle$phi[1]),
  siga = c(12897.94, dow_yw$avar, dow_burg$avar, dow_mle$avar)
)

dow_df

#From this dataframe of results we can identify that of all the models the Yule-Walker
#is the best estimator for the true phi value, but most estimator are the closests.
#However, on the other hand MLE is by far the closest estimator to the true siga value. 
#Based upon how these findings, I would say that the MLE estimator is the preferred method. 





