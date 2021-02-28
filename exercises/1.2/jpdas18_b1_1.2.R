#Exercise 1.2
#Jacinta Das
#Feb 26, 2021
install.packages("tswge")
library("tswge")
#Question 1: load the dataset ss08 and visualize it
data(ss08)
plot(ss08, type="l")
plotts.wge(ss08)
###switch to markdown
#Question 2: calculate the average of this time series realization using the mean function
cat("Mean;", mean(ss08))

#Question 3: load the dataset hadley and plot the sample autocorrelations and sample autocovariance using the acf function
data(hadley)
acf(hadley, type="covariance")
acf(hadley, type="correlation") #??

#Question 4: write equations for 