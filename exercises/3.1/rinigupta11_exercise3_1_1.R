# Exercise 3.1.1
# Name: Rini Gupta
# Date: 4/28/2021
# Worked with Jacinta Das, Kimya Shirazi 
# Will update this file with 3.1.2 and 3.1.3 

install.packages('forecast')
install.packages('ggplot2')

library(forecast)
library(ggplot2)

de_c <- stl(log(co2), s.window="periodic")
ap_sa <- exp(seasadj(de_c))

options(repr.plot.width=10, repr.plot.height=8, repr.plot.res = 125)
plot(co2, col = 'red', lwd = 2.5, xlab = 'Year', ylab = 'Average CO2 Measurements (ppm)', main = 'Atmospheric CO2 at Mauna Loa Observatory')
lines(ap_sa, lwd = 2)
legend("top", legend=c("Original Data", "Deseasonalized Data"),
       col=c("red", "black"), lty=1:1, cex = .7, horiz=TRUE, box.lty=0)

## References
#R: Deseasonalizing a time series* [Online forum post]. (2016, October 27). Stack Overflow. https://stackoverflow.com/questions/40307454/r-deseasonalizing-a-time-series 