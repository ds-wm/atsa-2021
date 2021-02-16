# Data Challenge 1.1
setwd("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Data Challenge/")

#install.packages("XML")
library("XML")

gpx.url <- "https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/back-to-the-garden.gpx"

gpx.name <- tail(unlist(strsplit(gpx.url,"/")), n= 1)
gpx.name

gpx.dest <- paste("/tmp/", gpx.name, sep="")
gpx.dest

download.file(gpx.url, gpx.dest, method = "auto")

result <- xmlParse(gpx.dest)

rootNode <- xmlRoot(result)
rootNode[[8]][[2]]

my.df <- xmlToDataFrame(rootNode[[8]][[2]])
my.df

my.df$time[1]

a <- tail(unlist(strsplit(my.df$time[1], "T")),n=1)

gsub("Z", "", a)

#install.packages("chron")
library("chron")

my.datetime <- do.call(
  rbind, sapply(gsub("Z","", my.df$time), strsplit, split ="T")
)
#my.datetime

my.tstamp <- chron(
  dates = as.character(my.datetime[,1]),
  times = as.character(my.datetime[,2]),
  format = c("Y-m-d", "h:m:s")
)
my.tstamp

plot(my.tstamp, my.df$speed, 
     type = "l", 
     lwd=1, 
     lty=1,
     xlab="Time", 
     ylab = "speed")

plot(my.tstamp, as.numeric(my.df$ele), 
     type = "l", 
     lwd=1, 
     lty=1,
     xlab="Time", 
     ylab = "Elevation")
