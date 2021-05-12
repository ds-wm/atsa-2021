install.packages("tswge")

library(tswge)

data(dowjones2014)

dow.plot<-plotts.sample.wge(dowjones2014)

aic.wge(dowjones2014, p=0:12, q=0:4, type="aic")
#p = 1
#phi = 0.97
#var = 12591.90

dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')

dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')

dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

dow.df <- data.frame(
  type=c("AIC", "YW", "Burg", "MLE"),
  phi1 = c(0.97, dow.yw$phi[1], dow.burg$phi[1], dow.mle$phi[1]),
  sigma = c(12591.90, dow.yw$avar, dow.burg$avar, dow.mle$avar)
)
dow.df

# We see that the YW phi estimator is the closest to the true value.
# The MLE sigma estimtor is the closest to the true value.
