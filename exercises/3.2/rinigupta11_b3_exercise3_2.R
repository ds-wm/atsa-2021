# Exercise 3.1.2
# Name: Rini Gupta
# Date: 4/28/2021
# Worked with Jacinta Das, Kimya Shirazi 


install.packages('tswge')
library(tswge)

# Load data
data("dowjones2014")
aic.wge(dowjones2014, p = 0:12, q = 0:4, type = 'aicc')
# Yule-Walker
ex324.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
ex324.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
ex324.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')
# Extract the parameter estimates for theta's and white noise variance
ex324.df <- data.frame(
  type=c("True", "YW", "Burg", "MLE"),
  phi1 = c(0.9816 , ex324.yw$phi[1], ex324.burg$phi[1], ex324.mle$phi[1]),
  siga = c('something', ex324.yw$avar, ex324.burg$avar, ex324.mle$avar)
)
ex324.df

## Plotting the realization 
plot(dowjones2014, type = 'l', main = 'Dow Jones in 2014', ylab = 'Daily Average Dow Jones Price', xlab = 'Time Realization')

