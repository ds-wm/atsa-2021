setwd("G:/My Drive/Data 330/Exercises/1.2")
#install.packages("tswge")
#install.packages("Rfast", dependencies = T)
library(tswge)
data("ss08")

#Question 1
plot(ss08)
plotts.wge(ss08)

#Question 2
cat("Mean of the Realization: ", mean(ss08))

#Question 3
data(hadley)

acf(hadley,
    type = ("correlation"),
    plot = TRUE)

acf(hadley,
    type = ("covariance"),
    plot = TRUE)

#Question 4

Yh <- function(x,h){
  n <- length(x)
  sum <- 0
  i <- 1
  while(i < (n-h)+1){
    j <- x[i]-mean(x)
    k <- x[i+h]-mean(x)
    sum <- sum + (j*k)
    i <- i+1
  }
  Y <- sum*(1/n)
  
  return(Y)
  
}

Ph <- function(Y,x){
  P <- Y/var(x)
  return(P)
}

#\hat \gamma_0 = \frac{1}{n} \sum_{t=1}^{n} (X_t - \mu) (X_{t} - \mu)
cat("gamma_0=", Yh(hadley,0),"\n")
acf(hadley, lag.max = 0, type = "covariance", plot = F)
  
#\hat \gamma_1 = \frac{1}{n} \sum_{t=1}^{n-1} (X_t - \mu) (X_{t + 1} - \mu)
cat("gamm_1=", Yh(hadley,1),"\n")
acf(hadley, lag.max = 1, type = "covariance", plot = F)
  
#\hat \rho_0 = \frac{\hat \gamma_0}{\hat \gamma_0} = 1
cat("rho_0=", Ph(Yh(hadley,0),hadley),"\n")
acf(hadley, lag.max = 0, type = "correlation", plot = F)
  
#\hat \rho_1 = \frac{\hat \gamma_1}{\hat \gamma_0}
cat("rho_1=", Ph(Yh(hadley,1),hadley),"\n")
acf(hadley, lag.max = 1, type = "correlation", plot = F)

#Question 5

data("fig1.10a")
plotts.wge(fig1.10a)
pgram <- period.wge(fig1.10a)

max1 <- which.max(pgram$pgram)
freq1 <- pgram$freq[max1]*10
max2 <- which.max((pgram$pgram[0:14]))
freq2 <- pgram$freq[max2]*10
max3 <- which.max(pgram$pgram[0:9])
freq3 <- pgram$freq[max3]*10

cat("The three freqencies are", freq1, freq2, freq3, "\n")

t <- 0:1000/10
xt <- cos(2*pi*t*freq3) + (1.5*cos((2*pi*t*freq2)+1)) + (2*(cos((2*pi*t*freq1)+2.5)))
plotts.wge(xt)
plotts.wge(fig1.10a)

savehistory("kndelong-b1_1.2.Rhistory")

