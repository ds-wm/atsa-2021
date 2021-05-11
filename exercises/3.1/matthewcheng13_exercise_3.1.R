# Exercise 3.1:
# Matthew Cheng

# install.packages("tswge")
library(tswge)

# 3.1.1 : 

# reproduce figure of atmospheric CO2 concentrations
# recreate deseasonlized time series using R modeling tools 
# starting with monthly average values

# read in data
data <- read.table("https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                   col.names = c("year","month","decidate", "moco2",
                                 "deseason", "nodays", "stdays", "uncertainty"))

# plot
options(repr.plot.width=12, repr.plot.height=4, repr.plot.res = 125)
plot(data$decidate, 
     data$moco2,
     type = 'l',
     col = 'red',
     lwd = 2,
     main = "Atmospheric CO2 at Mauna Loa Observatory",
     xlab = "Year",
     ylab = "parts per million (ppm)"
)
lines(data$decidate, data$deseason)
text(1987, 415, 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory', cex = 1)

# deseasonlized monthly time series

data(co2)

co2.ts <- ts(co2,deltat = 1/12,start = 1959,end=1997)

co2.decomp <- stl(co2.ts, 'periodic')
co2.trend <- co2.decomp$time.series[, 'trend']

#seasonal

# old code that has been fixed
#plot(data$decidate[1:(length(co2.trend))], 
#     data$moco2[1:(length(co2.trend))],
#     type = 'l',
#     col = 'red',
#     lwd = 2,
#     main = "Atmospheric CO2 at Mauna Loa Observatory",
#     xlab = "Year",
#     ylab = "parts per million (ppm)")

options(repr.plot.width=12, repr.plot.height=4, repr.plot.res = 125)
plot(co2,
     type = 'l',
     col = 'red',
     lwd = 2,
     main = "Atmospheric CO2 at Mauna Loa Observatory",
     xlab = "Year",
     ylab = "parts per million (ppm)"
)
lines(co2.trend,lwd=2)
text(1975, 362, 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory', cex = 1)

#co2.deseason <- data$moco2[1:length(co2.trend)] - co2.trend

#deseasonalized
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
plot(co2.trend, 
     main="Deseasonalized Atmospheric CO2\nat Mauna Loa Observatory",
     xlab = "Year", 
     ylab = "Trend"
)

# old code that has been fixed
#plot(co2.deseason, main="Deseasonalized Atmospheric CO2\nat Mauna Loa Observatory",xlab = "Year", ylab = "Trend Offset")



# 3.1.2:

# for MA(2) process:
# X(t) = a(t) + 0.2 a(t-1) - 0.48 a(t-2)
# use equation for autocorrelation for MA(q) process to 
# calculate:
# p0, p1, p2, and p3.
# equation for autocorrelation for MA(q) process:
# p_k = \frac {-\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j + k} } {1 + \sum_{j=1}^q \theta_j^2} 

# p0

# the p0 of any autocorrelation function must be 1, therefore p0 = 1

# p1 

# p1 = (.2 + (-.2)(.48)) / (1 + (-.2)^2 + (.48)^2)
#    = .104 / 1.2704
#    = .0819

# p2

# p2 = (-.48 + 0) / (1 + (-.2)^2 + (.48)^2)
#    = -.48 / 1.2704
#    = -.378

# p3

# the autocorrelation for lags k > q are always 0
# since we have an MA(2) process, p3 = 0

# checking values:
check <- plotts.true.wge(100, phi=c(0), theta=c(-0.2, 0.48))
#Check for p0
check$aut1[1]
#Check for p1
check$aut1[2]
#Check for p2
check$aut1[3]
#Check for p3
check$aut1[4]



#3.1.3:

# calculate autocorrelation at lags 0 through 10 for AR(1) process with phi1 = -0.7.

ar1.ts <- plotts.true.wge(n=200,phi=c(-0.7),theta=c(0),lag.max = 10)
ar1.ts$aut1

