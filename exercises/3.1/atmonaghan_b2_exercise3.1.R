#Exercise 3.1

#Alex Monaghan
#Professor Davis
#Applied Time Series Analysis
#7 May 2021

#Installing Required Packages
#install.packages('tswge')
library(tswge)
#install.packages('forecast')
library(forecast)
#install.packages('ggplot2')
library(ggplot2)

#Part One

#Loading the Data
url <- 'https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt'
data <- read.table(url, col.names = c('year','month','date(decimal)','co2_mon','deseasonalized','days','days_std', 'uncertainty'))

#Creating the Object
carbo <- ts(data$co2_mon, freq=12, start=1958)

#Reproducing the Plot
deseasonalized <- ts(data$deseasonalized, freq=12, start=1958)
plot(carbo, col='red', xlab='Year', ylab='parts per million (ppm)', main='Atmospheric CO2 at Mauna Loa Observatory')
lines(deseasonalized,type='l')

#Part Two

#Recreating the Plot
carbo.d <- stl(carbo, 'periodic')
plot(carbo.d$time.series[,2], ylab='CO2')

#3.1.2

#phi0
#phi0 is always 1

#phi1
#q=2,k=1
#phi1 = 0.0819

#phi2
#q=2,k=2
#phi2 = -0.378

#phi3
#phi3 = 0, since k > q

#3.1.3
#Autocorrellation with phi = -0.7
for (i in 0:10){
  cat('autocorrelation at lag ' , i, ': ', (-0.7)^i, '\n')
}

