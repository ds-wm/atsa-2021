# Andrew Caietti
# 4/8/2021
# Exercise 3.1
#######################

library('tswge')


url <- 'https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt'
data <- read.table(url, col.names = c('year','month','decidate','moco2','deseason','nodays','stdays', 'uncertainty'))

## Plot from downloaded data
options(repr.plot.width=8, repr.plot.height=6, repr.plot.res = 125)
plot(data$decidate, data$moco2, type='l', 
     lwd = 2, col = 'red', 
     xlab = 'Year', 
     ylab='parts per million (ppm)', 
     main='Atmospheric CO2 at Mauna Loa Observatory')
lines(data$decidate, data$deseason, lwd = 1.35)
text(1975, 410, 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory', cex = 1.25)


# First we can plot the data based on a yearly average technique and see what we get
yearly.average <- aggregate(data$moco2, by = list(data$year), data = data, FUN = mean)
plot(yearly.average, data$decidate, type = 'l')
# I am able to run the above line of code to plot the averages by year for each observation
# as a sort of smoothing of the data over time.


# Now we can handle detrending seasionality from the data
################################
# To tackle decomposing seasonality from the data set, we can utilize stl() to generate the 
# detrended data set. 

# Load data and plot
data(co2)
co2.decomp <- stl(co2, 'periodic')

plot(data$decidate, as.numeric(co2.decomp$time.series[, 'trend']), type='l', 
     lwd = 2, col = 'red', 
     xlab = 'Year', 
     ylab='parts per million (ppm)', 
     main='Atmospheric CO2 at Mauna Loa Observatory')

dates <- data$decidate[1:468]
 plot(dates, as.numeric(co2.decomp$time.series[, 'trend']), type='l', 
           lwd = 2, col = 'red', 
             xlab = 'Year', 
             ylab='parts per million (ppm)', 
             main='Atmospheric CO2 at Mauna Loa Observatory')
 text(1970, 360, 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory', cex = 0.75)
 
 # I can finally plot the co2 data with the seasonality removed and see that this
# data set is similar to the data$deseason column in the original data set.
 
 
 
 
#####################
## 3.1.2
#####################
 
#a(t) = u + wt
#a(t-1) = 0.2 * wt-1
#a(t-2) = -0.48 * wt-2


# P(h) = autocovar/sigma^2
ma.ts3 <- plotts.true.wge(100, phi=c(0), theta=c(-0.2, 0.48))
data <- ma.ts3$data
var(data)

# Variance (sigma^2) = 1.430089

# P_0 = 0.99 about equal to 1
1.4158/1.430089
# P_1 = 0.06406
0.0907/1.4158 
# P_2 = -0.3563 
-0.5044/1.4158 
# P_3 = 0.1444 
0.2045/1.4158 




#####################
## 3.1.3
#####################

ar.ts3 <- plotts.true.wge(
 n=200, 
 phi=c(-0.7), 
 theta=c(0), 
 vara = 1,
 lag.max = 10)
acf(ar.ts3$data, lag.max=10, plot = FALSE, type = 'correlation')