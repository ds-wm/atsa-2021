# Exercise 3.2.5
# Monica Alicea and Asha Silva

library("tswge")
data(dowjones2014)

#Plots 
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
ar.dow <- plotts.sample.wge(dowjones2014)

# p = 1 according to aic 
aic.wge(dowjones2014, p=0:12, q=0:4, type="aic")

# Yule-Walker
dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Extract the parameter estimates, true p = 0.9816
dow.df <- data.frame(
  type=c("True", "YW", "Burg", "MLE"),
  phi1 = c(0.9816, dow.yw$phi[1], dow.burg$phi[1], dow.mle$phi[1]),
  siga = c(12591.9, dow.yw$avar, dow.burg$avar, dow.mle$avar)
)
dow.df

# Overall, the maximum likelihood estimator shows the least variance, 
# which aligns with the class notes stating that it is best to use ML estimators in stationary models

savehistory(file = "ashamsilva_exercise3.2.Rhistory")


