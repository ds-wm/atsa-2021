# Applied Time Series Analysis
# Exercise 3.1
# author: John Hennin, William & Mary
# last updated: 2021-05-02

# Exercise 3.1.1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library('tswge')

# Part 1 - Reproduce the figure -----------------------------------------------


data <- read.table(
  "https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                   col.names = c("year","month","deci_date", "moco2",
                                 "deseason", "nodays", "stdays", "uncertainty"))

plot(data$deci_date, data$moco2, type = 'l', col='red', 
     ylab='parts per million (ppm)', xlab='Year',
     cex.lab=1, las=1, lwd=2)
lines(data$deci_date, data$deseason, type = 'l', col='black', lwd=2)
title(main=expression('Atmospheric CO'[2]*' at Mauna Loa Observatory'),
      cex.main=1)
text(1976, y=405,
     labels='Scripps Institution of Oceanography
NOAA Global Monitoring Laboratory', cex = .95, col = 'black')
axis(1, tcl=.4)
axis(3, tcl=.4, col.axis = 'white', col.ticks = 'black')
axis(2, tcl=.4, las=1)
axis(4, tcl=.4, col.axis = 'white', col.ticks = 'black')

# Part 2 - Recreate deseasonalized trend line --------------------------------

# Pseudo code version:
# At first I thought that I should be able to just integrate through
# each set of three months and take the average value to get the 3 month moving
# average. Then, the value would be plotted with the center month. 
# For example, if the months are December, January, and February, then I take 
# the average value of those months and assign the result to December. This
# should provide a somewhat detrended line. Later, however, Dr. Davis showed us
# the stl function and how it can find the deseasonalized trend line, so I will
# be pursuing that in the code version.

# Code version

data(co2)

co2.decomp <- stl(co2, 'periodic')

co2.decomp$time.series[, 'trend']

# Exercise 3.1.2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# See pdf

# Exercise 3.1.3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Calculate the autocorrelation at lags 0 through 10 for an AR(1) process
#with φ1 = -0.7.

lags <-c(0:10)

autocorrelation <- -.07**lags

autocorrelation

