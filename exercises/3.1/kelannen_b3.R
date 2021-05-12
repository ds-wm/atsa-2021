# Block 3 - Exercise 3.1:
# Name: Katherine Lannen
# Class: DATA 330
# Created: 2021-04-08
# Updated: 2021-05-12

#install.packages("tswge")
library(tswge)

# 3.1.1 : 

# Part 0 - read in the data
data <- read.table("https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                   col.names = c("year","month","deci_date", "moco2",
                                 "deseason", "nodays", "stdays", "uncertainty"))

# Part 1 - plot reproduction
plot(data$deci_date, data$moco2, type = 'l', col = 'red', lwd = 2,
     xlab = "Year", ylab = "parts per million (ppm)",
     main = "Atmospheric CO2 at Mauna Loa Observatory")
lines(data$deci_date, data$deseason, type = 'l', col = 'black', lwd = 2)
rug(x = c(1965,1975,1985,1995,2005,2015), ticksize = -0.01, side = 1)
rug(x = c(1960,1965,1970,1975,1980,1985,1990,1995,2000,2005,2010,2015,2020),
    ticksize = -0.01, side = 3)
rug(x = c(310,320,330,340,350,360,370,380,390,400,410,420), ticksize = -0.01,
    side = 4)
rug(x = c(310,330,350,370,390,410), ticksize = -0.01,side = 2)
text(1980, 410, 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory', cex = 1)

# Part 2 - Recreate the deseasonlized monthly time series

# Class Notes
## Take a look at the summary stats of a linear model
#summary(lm(data$moco2 ~ data$deci_date))
## Subtract the trend to create a zero mean time series
#detrended <- data$moco2 - predict(lm(data$moco2 ~ data$deci_date))
#plot(detrended, type = 'l')
## Model seasonality
#summary(lm(detrended ~ sin(data$deci_date * 2 * pi) + cos(data$deci_date * 2 * pi)))

data(co2)

decomp_co2 <- stl(co2, 'periodic')
deseasoned <- decomp_co2$time.series[, 'trend']

plot(data$deci_date, data$moco2, 
     type = "l", lwd = 2, col = 'red', xlab = "Year",
     ylab = "parts per million (ppm)",
     main = "Atmospheric CO2 at Mauna Loa Observatory")
lines(deseasoned, type = "l", col = 'black', lwd = 2)

plot(deseasoned, main="Deseasonalized Atmospheric CO2 \n at Mauna Loa Observatory",
     xlab = 'Year', ylab = "parts per million (ppm)")

# 3.1.2:
#For the MA(2) process represented by the following equation:
#X(t) = a(t) + 0.2 a(t-1) - 0.48 a(t-2)
#use the equation for autocorrelation for an MA(q) process to 
#calculate by hand the following values:
#p0, p1, p2, and p3.

# From the MA(2) equation we determine that:
# Theta_1 = -0.2
# Theta_2 = +0.48
# q = 2

# The equation for the autocorrelation for lag k is as follows:
#p_k = \frac{-\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k}}{1 + \sum_{j=1}^{q} \theta^2_j}, \, &k=1,2,..,q \\
#p_k = 0, k > q


# In Autocorrelation functions, by definition, p0 is one.
# p0 = 1

# Calculating p1
#p1 = (-(-0.2) + (-0.2)(0.48))/(1+ ((-0.2)^2)+(0.48)^2)
#p1 = 0.104/1.2704
#p1 = 0.081864

# Calculating p2
#p2 = -0.48/(1 + ((-0.2)^2+(0.48)^2))
#p2 = -0.48/1.2704
#p2 = -0.377835

#Due to the autocorrelation function p3 is zero as the lag of 3 is greater
# than that of the model order, i.e. k>3
#p3 = 0

# To check the values of p1,p2,and p3 the tswge package was used
ma2 <- plotts.true.wge(100, phi=c(0), theta=c(-0.2, 0.48))
#Check for p0
ma2$aut1[1]
#Check for p1
ma2$aut1[2]
#Check for p2
ma2$aut1[3]
#Check for p3
ma2$aut1[4]

#3.1.3:
#Calculate the autocorrelation at lags 0 through 10 for an AR(1) process 
#with phi1 = -0.7.

#For AR(1) Models the autocorrelation is given by the following function:
#p_k = phi_1^{|k|}

#phi1 = -0.7
#p = 1

#p0 = (-0.7)^0 = 1
#p1 = (-0.7)^1 = -0.7
#p2 = (-0.7)^2 = 0.49000000 
#p3 = (-0.7)^3 = -0.34300000 
#p4 = (-0.7)^4 = 0.24010000 
#p5 = (-0.7)^5 = -0.16807000
#p6 = (-0.7)^6 = 0.11764900 
#p7 = (-0.7)^7 = -0.08235430 
#p8 = (-0.7)^8 = 0.05764801 
#p9 = (-0.7)^9 = -0.04035361 
#p10 = (-0.7)^10 = 0.02824752

#To check if these autocorrelation at lags 0 through 10 are correct
# the twsge package will be used
ar1 <- plotts.true.wge(n=200,phi=c(-0.7),theta=c(0),lag.max = 10)
ar1$aut1

