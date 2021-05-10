# load packages
install.packages("tswge")
library(tswge)

# load data
col.names <- c('year', 'month', 'decimal.date', 'monthly.avg', 'deseasonalized', 'V6', 'V7', 'V8')
data <- read.table(file = 'https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt',
                   col.names = col.names)

# 3.1.1
# Part 1: Reproduce figure 

title = expression('Atmospheric CO'[2] * ' at Mauna Loa Observatory')
plot(data$decimal.date, data$monthly.avg, type = 'l', 
                                          xlab = 'Year',
                                          ylab = 'parts per million (ppm)',
                                          main = title,
                                          col = 'red', 
                                          tcl = .5)

lines(data$decimal.date, data$deseasonalized)

t <- 'Scripps Institution of Oceanography \nNOAA Global Monitoring Laboratory'
text(1960, 410, t, cex = 1.25, pos = c(4, 1))

xaxis <- seq(from = 1960, to = 2020, by = 5)
yaxis <- seq(from = 310, to = 420, by = 10)
rug(x = xaxis, ticksize = 0.015, side = 1)
rug(x = yaxis, ticksize = 0.015, side = 2)


# Part 2:  Recreate deseasonlized time series of monthly.avg

# first, detrend the time series
log.model <- lm(log(monthly.avg) ~ decimal.date, data = data)
detrended <- data$monthly.avg - exp(predict(log.model))

# second, fit seasonal model to detrended time series
seasonal.model <- lm(detrended ~ sin(data$decimal.date * 2 * pi) + cos(data$decimal.date * 2 * pi))

# third, subtract seasonal model from origional time series
deseasonalized <- data$monthly.avg - predict(seasonal.model)

# fourth, measure similarity between origional time sereies and recreated time series
cor(deseasonalized, data$deseasonalized)
# 0.999795371747044


# 3.1.2
# I uploaded a picture of my handwritten work
# file is named cpsughrue_b3.pdf


# 3.1.3 Calculate the autocorrelation at lags 0 through 10 for an AR(1) process with phi = -0.7
lag <- seq(1, 10, 1)
phi <- c(-0.7)

autocorrelation <- phi ^ lag
# -0.700, 0.490, -0.343, 0.240, -0.168, 0.118, -0.082, 0.058, -0.04, 0.028

# alternative method using tswge package
ar1.ts <- plotts.true.wge(100, phi = c(-0.7), theta = c(0), lag.max = 10)
ar1.ts$aut1
