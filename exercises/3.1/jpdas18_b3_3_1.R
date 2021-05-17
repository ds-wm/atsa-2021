# Exercise 3.1.1
# Name: Jacinta Das
# Date: 4/28/2021
# Worked with Rini Gupta, Kimya Shirazi 
# 3.1.2 uploaded separately as a pdf 

install.packages('forecast')
install.packages('ggplot2')
install.packages("tswge")
library(tswge)
library(forecast)
library(ggplot2)


# Exercise 3.1.1

# Reproduction of Mauna Loa Plot

ml.url <- "https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt"
ml.name <- tail(unlist(strsplit(ml.url, "/")), n=1)
ml.file <- paste(ml.name, sep="")
download.file(ml.url, ml.file, method = 'auto')
ml.df <- read.table(ml.file)
plot(ml.df$V3, ml.df$V4, type = 'l', col = 'red', main = 'Atmospheric CO2 at Mauna Loa Observatory', xlab = 'Year', ylab = "Average CO2 Measurements (ppm)")
lines(ml.df$V3, ml.df$V5)

# Recreation of Mauna Loa Plot
# Methodology: I used the stl function which is able to decompose a time series into seasonal components. We discussed this function in class and I found examples of its use online.
# I took the log of the time series to decompose it and then later exponentiated, following a specific example my group found online (Stack Overflow, 2016).

data(co2)
de_c <- stl(log(co2), s.window="periodic")
ap_sa <- exp(seasadj(de_c))

options(repr.plot.width=10, repr.plot.height=8, repr.plot.res = 125)
plot(co2, col = 'red', lwd = 2.5, xlab = 'Year', ylab = 'Average CO2 Measurements (ppm)', main = 'Atmospheric CO2 at Mauna Loa Observatory')
lines(ap_sa, lwd = 2)
legend("top", legend=c("Original Data", "Deseasonalized Data"),
       col=c("red", "black"), lty=1:1, cex = .7, horiz=TRUE, box.lty=0)


# Exercise 3.1.3 

ar.ts1 <- plotts.true.wge(100, phi=c(-0.7), theta=c(0), lag.max = 10)
ar.ts1$aut1

## References
#R: Deseasonalizing a time series* [Online forum post]. (2016, October 27). Stack Overflow. https://stackoverflow.com/questions/40307454/r-deseasonalizing-a-time-series 