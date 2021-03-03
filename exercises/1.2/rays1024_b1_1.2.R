# Ray Shen
# DATA 330 Applied Time Series Analysis
# Mar.1,2021
# Exercise 1.2
install.packages("tswge")
library("tswge")

#1.Load the dataset ss08 and visualize it. Try both the base plot in R and the plotts.wge function provided by the textbook.
data("ss08")
plot.ts(ss08)
plotts.wge(ss08)

#2.Calculate the average of this time series realization using the mean function.
mean(ss08)

#3.Load the dataset hadley and plot the sample autocorrelations and sample autocovariances using the acf function
data("hadley")
acf(hadley,type="correlation")
acf(hadley,type="covariance")

#4.Write the equations for ^γ0, ^γ1, ^ρ0 and ^ρ1 and compute them using R (note the hats, ^, are to represent the estimators).
#Equations:
#$\hat \gamma_0 = \frac{1}{n} \sum_{t=1}^{n} (X_{t}-\mu) (X_{t}-\mu)$
#$\hat \gamma_1 = \frac{1}{n} \sum_{t=1}^{n-1} (X_{t}-\mu) (X_{t+1}-\mu)$
#$\hat \rho_0 = \frac{\hat \gamma_0}{\hat \gamma_0}$
#$\hat \rho_1 = \frac{\hat \gamma_1}{\hat \gamma_0}$
  
acf(hadley,lag.max=1,type="covariance",plot=FALSE)
acf(hadley,lag.max=1,type="correlation",plot=FALSE)

#5.Plot the time series and the periodogram for Figure 1.10a of Woodward et al. (fig1.10a). Note that the sampling rate for the x-axis is in 1/10ths. What are the three dominant frequencies of this dataset?
data("fig1.10a")
plotts.wge(fig1.10a)
periodogram<-period.wge(fig1.10a,dbcalc=T,plot=TRUE)
which.max(periodogram$pgram)
which.max(periodogram$pgram[1:14])
which.max(periodogram$pgram[1:9])

#6.The time series in Figure 1.10a (Woodward et al.) can be expressed as the following:
#X(t) = cos(2π t f1) + 1.5 cos(2π t f2 + 1) + 2 cos(2 π t f3 + 2.5)
#where f1, f2, and f3 are the three dominant frequencies (in order from lowest to highest) found in the previous question. Replace the frequencies you found in the equation above and recreate using R the Figure 1.10a using values for t ∈ (0, 100) (e.g., x <- 0:1000/10).
f1<-0.03
f2<-0.1
f3<-0.15
t<-0:1000/10
Xt<-(cos(2*pi*t*f1)+1.5*cos(2*pi*t*f2+1)+2*cos(2*pi*t*f3*+2.5))
plotts.wge(Xt)
savehistory(file="exercise_b1_1.2")