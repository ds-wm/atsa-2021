# Applied Time Series Analysis
# Exercise 3.1
# author: Kelton Berry
# created: 2021-05-06


#Question 1: Part 1
#PROBLEM STATEMENT: Part 1. Reproduce the figure below of atmospheric CO2
#concentrations (both seasonal and deseasonalized). Attempt to match the plotting parameters, title and labels; you do not need to include the logo.

#install and import nessecary libaries
install.packages("tswge")
library("tswge")

#import the data 
q1 <- read.table("https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                 col.names = c(
                   "year", "month", "decidate", "moco2", "deseason", "nodays", "stdays",
                   "uncertainty"))

#plot the data
plot(q1$decidate, q1$moco2, type='l',
     lwd = 2, col = 'red',
     xlab = 'Year',
     ylab='Parts per million (ppm)',
     main='Atmospheric CO2 at Mauna Loa Observatory')
lines(q1$decidate, q1$deseason, type = 'l', col = 'black', lwd = 1)

#Question 1: Part 2
#PROBLEM STATEMENT: Recreate the deseasonlized time series using R modeling tools
#starting with the monthly average values. Write down your thoughts on the methodology
#(i.e., prepare a pseudo code version) and implement a coding strategy that creates
#the deseasonalized CO2 trend line.

#import the co2 dataset trend datasets which is the atmospheric carbon dioxide
#(CO2) measurements fromMauna Loa Baseline Observatory in Hawaii.
data("co2")

#decomposing the co2 dataset into its seasonal, trend and residuals
co2.decomp <- stl(co2, 'periodic')


co2.trend <- co2.decomp$time.series[, 'trend']


#plot the original plot with the addition of the trend lines
#the trend line is noticably shorter so the need to deseasonize the data here seems valid
plot(q1$decidate, 
     q1$moco2,
     type = 'l',
     col = 'black',
     lwd = 1,
     main = "Atmospheric CO2 at Mauna Loa Observatory",
     xlab = "Year",
     ylab = "Parts Per Million (ppm)"
)
lines(co2.trend)

#deseasonize the data by taking moco2 to the values of the length of the trend line
#and then subtract those values by the corresponding trend values
co2.deseasoned <- q1$moco2[1:length(co2.trend)] - co2.trend

#plot the deseasoned data!
plot(co2.deseasoned,
     type = 'l',
     col = 'black',
     lwd = 2,
     main = "Deseasonlized Atmospheric CO2 \n at Mauna Loa Observatory",
     xlab = "Year",
     ylab = "Differences w/ the trend" )


#Question 2
#PROBLEM STATEMENT:For the MA(2) process represented by the following equation:
#X(t) = a(t) + 0.2 a(t-1) - 0.48 a(t-2)
#use the equation for autocorrelation for an MA(q) process to calculate by hand the following values:
#ρ0, ρ1, ρ2, and ρ3.

#From the equation above we have both theta values
# Theta1 = -0.2 & Theta2 = 0.48
theta1 <- -0.2
theta2 <- 0.48
#Now we can go about finding our ρ or rho values

#By definition we know that ρ0 or rho0 is 1
rho0 <- 1

#The equation for ρ1 or rho1 is:
#rho1 <- (-1*theta1 + theta1*theta2)/(1 + (theta1^2) + (theta2^2))
#We can plug in our given theta values to find ρ1

rho1 <- (-1*theta1 + theta1*theta2)/(1 + (theta1^2) + (theta2^2))
rho1

#rho1 value is: 0.08186397985

#The equation for ρ2 or rho2 has a simplier numerator and is:
#rho_2 <- (-1*theta2)/(1 + (theta1^2) + (theta2^2))
#We can plug in our given theta values to find ρ2
rho2 <- (-1*theta2)/(1 + (theta1^2) + (theta2^2))
rho2

#rho2 value is: -0.3778337531

#By definition we know that ρ3 or rho3 is 0
rho3 <- 0

#Now we have all four rho values:
rho0
rho1
rho2
rho3


#Question 3
#PROBLEM STATEMENT: Calculate the autocorrelation at lags 0 through 10
#for an AR(1) process with φ1 = -0.7.

#We can do this by running the plotts.true.wge funtcion from the twsge library
q3 <- plotts.true.wge(200, phi=c(-0.7),theta=c(0),lag.max = 10)

#We can then pull out the autocorrelations from lags 0 through 10
q3$aut1
























