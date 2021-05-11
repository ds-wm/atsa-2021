install.packages("tswge")
library("tswge")

#Load data
data("dowjones2014")

#Plot data
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
plot(dowjones2014, type="l", main="Dow Jones Index (2014)", ylab="Price", xlab="Time")

#Find best fit parameters
aic.wge(dowjones2014, p = 0:12, q = 0:4, type = 'aicc')

#Based on the above results we will use an AR(1) model

# Yule-Walker
dowjones2014.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')

# Burg (based on FBLS)
dowjones2014.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')

# Maximum-Likelihood Estimators
dowjones2014.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Create table of parameters
dowjones2014.df <- data.frame(
  type=c("YW", "Burg", "MLE"),
  phi1 = c(dowjones2014.yw$phi[1], dowjones2014.burg$phi[1], dowjones2014.mle$phi[1]),
  siga = c(dowjones2014.yw$avar, dowjones2014.burg$avar, dowjones2014.mle$avar)
)

dowjones2014.df

#Extract best fit realization
realization <- gen.arma.wge(length(dowjones2014), phi = dowjones2014.mle$phi, theta = 0, vara = dowjones2014.mle$avar, plot = TRUE)

#Plot best fit realization
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
plot(realization, type="l", main="Dow Jones Index Best Fit Realization", ylab="Price", xlab="Time")

#ACF Plot
acf(realization)

#Periodogram
period.wge(realization)


