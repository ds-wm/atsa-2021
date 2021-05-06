#Applied Time Series Analysis
#Excercises 3.1
#Name: Justin Callahan
#Due Date: 5/7/2021

install.packages("tswge")
library("tswge")

#3.1.1

#part 1
data <- read.table("https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                   col.names = c("year","month","deci_date", "moco2",
                                 "deseason", "nodays", "stdays", "uncertainty"))

plot(data$deci_date, data$moco2, type = 'l', col = 'red', lwd = 2, xlab='Year', ylab='parts per million (ppm)', main = "Atmospheric CO2 at Mauna Loa Observatory")
lines(data$deci_date, data$deseason, type = 'l', col = 'black', lwd = 2,)

#part 2
co2.decomp <- stl(co2, 'periodic')
trend_data <- co2.decomp$time.series[, 'trend']
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
deseason<- data$moco2[1:(length(trend_data))] - trend_data
plot(deseason,main = "Deseasonalized Atmospheric CO2 at Observatory", xlab = "Year", ylab = "Difference From Trend" )

#3.1.3

#pk=phi1^(|k|)
#phi1=-0.7

#Code:
ar.1 <- plotts.true.wge(100, phi=c(-0.7), theta=c(0), lag.max = 10)
ar.1$aut1

#Math
p0 <- -0.7^0
p1 <- -0.7^1
p2 <- -0.7^2
p3 <- -0.7^3 
p4 <- -0.7^4 
p5 <- -0.7^5
p6 <- -0.7^6 
p7 <- -0.7^7 
p8 <- -0.7^8 
p9 <- -0.7^9 
p10 <- -0.7^10
p1
p2
p3
p4
p5
p6
p7
p8
p9
p10