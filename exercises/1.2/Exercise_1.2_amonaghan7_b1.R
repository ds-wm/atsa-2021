#Alex Monaghan
#ATSA
#3 March 2021
#Exercise 1.2

#Question 1

install.packages("tswge")
library("tswge")
data("ss08")
plot(ss08, type = 'l')
plotts.wge(ss08)

#Question 2

mean(ss08) #52.24385

#Question 3

data(hadley)

acf(hadley, type = 'correlation')
acf(hadley, type = 'covariance')

#Question 4

acf(hadley, lag.max = 1, type="covariance", plot = FALSE) #(0,1), (1,0.882)
acf(hadley, lag.max = 1, plot = FALSE) #(0,0.667), (1,0.0588)

#Question 5  

data("fig1.10a")
plotts.wge(fig1.10a)

periodogram <- period.wge(fig1.10a, plot = TRUE)

freq_1 <- period.wge(fig1.10a, plot = FALSE)$freq[which.max(period.wge(fig1.10a, plot = FALSE)$pgram[0:9])]
freq_1 <- freq_1*10

freq_2 <- period.wge(fig1.10a, plot = FALSE)$freq[which.max(period.wge(fig1.10a, plot = FALSE)$pgram[0:14])] 
freq_2 <- freq_2*10

freq_3 <- period.wge(fig1.10a, plot = FALSE)$freq[which.max(period.wge(fig1.10a, plot = FALSE)$pgram)]
freq_3 <- freq_3*10 

freq_1
freq_2
freq_3

#Question 6

t <- 0:1000/10
Xt <- cos(2*pi*t*freq_1) + 1.5*cos(2*pi*t+1*freq_2) + 2*cos(2*pi*t + 2.5*freq_3)
plot.ts(Xt)

savehistory("Exercise_1.2_amonaghan7_b1.Rhistory")
