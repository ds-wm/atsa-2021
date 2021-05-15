install.packages('forecast')
install.packages('ggplot2')
install.packages("tswge")
library(tswge)
library(forecast)
library(ggplot2)

#Load data
data(co2)

#Part 1 Recreate plot
data <- read.table("https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt", col.names = c("year","month","deci_date", "moco2","deseason", "nodays", "stdays", "uncertainty"))
plot(data$deci_date, data$moco2, type = 'l', col = 'red', lwd = 2, xlab='Year', ylab='parts per million (ppm)', main = "Atmospheric CO2 at Mauna Loa Observatory")
lines(data$deci_date, data$deseason, type = 'l', col = 'black', lwd = 2,)

#Decompose series into seasonal, trend and remainder
co2.decomp <- stl(log(co2), s.window="periodic")

#Extract deseasonalized data from stl object
seasonally_adjusted <- exp(seasadj(co2.decomp))

#Plot original and deseasonalized data
options(repr.plot.width=10, repr.plot.height=8, repr.plot.res = 125)
plot(co2, col = 'red', lwd = 2.5, xlab = 'Year', ylab = 'Average CO2 Measurements (ppm)', main = 'Atmospheric CO2 at Mauna Loa Observatory')
lines(seasonally_adjusted, lwd = 2)
legend("top", legend=c("Original Data", "Deseasonalized Data"), col=c("red", "black"), lty=1:1, cex = .7, horiz=TRUE, box.lty=0)