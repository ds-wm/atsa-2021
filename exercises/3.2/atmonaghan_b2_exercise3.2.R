#Exercise 3.2

#Alex Monaghan
#Professor Davis
#ATSA
#7 May 2021

#import tswge library and load dow jones data
library(tswge)
data(dowjones2014)

#plot
ar.dow <- plotts.sample.wge(dowjones2014)

#aic
aic.wge(dowjones2014, p=0:12, q=0:4, type="aic")

#Yule-Walker
dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')

#FBLS Burg
dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')

#Maximum-Likelihood
dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

#Compare the Models
dow.df <- data.frame(
  type=c("True", "YW", "Burg", "MLE"),
  phi1 = c(0.9816, dow.yw$phi[1], dow.burg$phi[1], dow.mle$phi[1]),
  siga = c(12591.9, dow.yw$avar, dow.burg$avar, dow.mle$avar)
)

dow.df

