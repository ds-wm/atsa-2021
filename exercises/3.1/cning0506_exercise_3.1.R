# Applied Time Series Analysis
# Exercise 3.1
# Authors: Conrad Ning, Keagan Delong, Matt McCormack
# created: 2021-04-10
# updated: 2021-05-04


# Problem Statement: Create a R Script that performs the following analysis
# Reproduce the figure above of atmospheric CO2 concentrations 
# (both seasonal and deseasonalized). Can you create the deseasonalized 
# time series using R modeling tools? Starting with the monthly average values?
# Write down your thoughts on the methodology (i.e., prepare a pseudo code version) 
# and begin implementing code that creates the deseasonalized CO2 trend line. 

library(ggplot2)
library('ggh4x')
library(ggalt)
library(graphics)
library(tswge)
library(forecast)


#install.packages('forecast')
#install.packages("tswge")

# Part 0 - Load the data 
data <- read.table(
  "https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
  col.names = c('year','month', "decidate", "moco2", "deseason","nodays", 'stdays',
                "uncertainty"),
  skip=53
  )

# 3.1.1 - Part 1 - plot reproduction
plot(data$decidate, data$moco2, type='l', col='red', lwd=2,ylim = c(305,420),
     xlab='Year',ylab = 'parts per milion (ppm)',
     main='Atmospheric CO2 at Mauna Loa Observatory')
lines(data$decidate,data$deseason)
plot + 
  scale_x_continuous(n.breaks = 5)




ggplot() +
  geom_line(data=data, aes(x=decidate, y=moco2), color="red", size=0.75)+
  geom_line(data=data, aes(x=decidate, y=deseason), color = 'black', size=0.6)+
  xlab("Year") +
  ylab("parts per million (ppm)") +
  labs(title=(expression(paste("Atmospheric ", CO[2], " at Mauna Moa Observatory"))))+
  scale_x_continuous(minor_breaks=seq(1960,2020, by=5), sec.axis= dup_axis(name = NULL, labels = NULL),
                     breaks = seq(1960, 2020, by = 10)) + 
  scale_y_continuous(sec.axis= dup_axis(name = NULL,labels = NULL),
                     breaks = seq(320 , 420, by =20),minor_breaks=seq(300,420, by=10))+
  theme_bw()+ theme(text = element_text(size=11), axis.ticks.length=unit(-0.25, "cm"),
                    axis.text.x = element_text(margin=unit(c(0.3,0.3,0.3,0.3), "cm")),
                    axis.text.y = element_text(margin=unit(c(0.3,0.3,0.3,0.3), "cm")),
                    panel.grid = element_blank(), plot.title = element_text(hjust = 0.5),
                    axis.text.x.top= element_text(), aspect.ratio = 0.75)+ 
  annotate(geom = "text", x=1980, y=410, 
           label = "   Scripps Institution of Oceanography \n NOAA Global Monitoring Laboratory")



# Part 2 - deseasonalize the monthly time series 
## Take a look at the summary stats of a linear model
#summary(lm(data$moco2~data$decidate))

## Class Notes
#detrended <- data$moco2 - predict(lm(data$moco2~data$decidate))
#plot(detrended, type='l')
#summary(lm(detrended ~ sin(data$decidate*2*pi) + cos(data$decidate*2*pi)))

data(co2)

co2.decomp <- stl(co2, 'periodic')

# Get the trend 
trend <- co2.decomp$time.series[,'trend']

# Plot the trend  
#options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)

plot(data$decidate, 
     data$moco2,
     type = 'l',
     col = 'green',
     lwd = 2,
     main = "Atmospheric CO2 at Mauna Loa Observatory",
     xlab = "Year",
     ylab = "Parts Per Million (ppm)"
)

lines(trend, lty=2, lwd=2) # We can observe that the length of moco2 is shorter than the trend

# Generate the deseasonalized plot with the subtraction of trend
deseason <- data$moco2[1:(length(trend))]-trend

plot(deseason,main = "Deseasonlized Atmospheric CO2 at Observatory",
     xlab = "Year",
     ylab = "Difference with Trend" )


# 3.1.2 - Autocorrelation for an MA(q) process
# Problem Statement: Create a R Script that performs the following analysis
# For the MA(2) process represented by the following equation:
# X(t) = a(t) + 0.2 a(t-1) - 0.48 a(t-2)
# use the equation for autocorrelation for an MA(q) process to calculate by hand the following values:
  #p0, p1, p2, and p3.

#Theta1 = -0.2
#Theta2 = 0.48


# p0
## By definition, we know that the autocorrelation function of p0 equals to 1. Hence, p0 = 1.

# p1
# p1 <- [-(-0.2)+(-0.2)(0.48)]/1+[(-0.2^2)+(0.48^2)] = 0.104/1.2704 = 0.08186398



# Verify with R
ma.ts <- plotts.true.wge(100, phi=c(0), theta=c(-0.2, 0.48))
autocor <- ma.ts$aut1
autocor[2]
## p1 = 0.08186398

# p2
# p2 = [-(0.48)]/1+[(0.2^2)+(0.48^2)] = 0.48/1.2704 = -0.3778338

## Verify with R
autocor[3]
## p2 = -0.3778338

# p3
# p3 = 0 (since we only have two thetas, so by definition if k>q, pk=0. Hence, p3 = 0) 


# 3.1.3 - Autocorrelation Calculation for AR(1) Process
# Problem Statement: Calculate the autocorrelation at 
# lags 0 through 10 for an AR(1) process with p1 = -0.7.


ar.ts <- plotts.true.wge(100, phi=c(-0.7), theta=c(0), lag.max = 10)
ar.ts$aut1
