#Name: Andrew Caietti
#Class: DATA 330
#Date: 2021-2-5


############### 1.2


#Question 1.2.1 
data(ss08) 

plot(ss08, type = 'l')
plotts.wge(ss08)


# Question 1.2.2
data <- ss08
cat('Realization: ',mean(data))


# Question 1.2.3

data(hadley)
acf(hadley, type = 'covariance') 
# lag 0 is the variance of TS itself
# we see that, as lag increases, covariance decreases.

acf(hadley, type = 'correlation') # same is observed for correlation as well


# Question 1.2.4

gamma.hat <- function(x,h){
  n <- length(x)
  temp.sum <- 0 
  for (i in 1:(n-h)){
    a <- (x[i]-mean(x))
    b <- (x[i+h]-mean(x))
    temp.sum <- temp.sum + a*b
  }
  temp.sum
  gam.hat <- temp.sum*(1/n)
  return(gam.hat)
} 

auto.corr <- function(gam.hat, x){
  ac <- gam.hat/var(x)
  return(ac)
}

cat('Gamma Hat 0 : ', gamma.hat(hadley,0), '\n')
cat('Autocorrelation for 0 : ', auto.corr(gamma.hat(hadley,0), hadley), '\n')
cat('Gamma Hat 1 : ', gamma.hat(hadley,1), '\n')
cat('Autocorrelation for 1 : ', auto.corr(gamma.hat(hadley,1), hadley), '\n')


# Question 1.2.5

p.f10a <- period.wge(fig1.10a, dbcalc = TRUE, plot = TRUE)

plot(p.f10a$pgram, type = 'l')
plot(p.f10a$pgram, type = 'l', xlim=c(1,30))
which.max(p.f10a$pgram[1:20])
which.max(p.f10a$pgram[1:14])
which.max(p.f10a$pgram[1:9])
which.max(p.f10a$pgram[1:2])
15/100
10/100
(2+3)/200
cat('Frequencies are: ',15/100,10/100,(2+3)/200)


# Question 1.2.6

# plug the three dominant frequencies into the additive TS of cosines (formula for data above)
# then, will be able to recreate the graph for values t in (0,100)...see below x

t <- 0:1000/10

X <- cos(2*pi*t*0.025) + 1.5*cos(2*pi*t*(0.1)+1)+2*cos(2*pi*t*(0.15)+2.5)
plot.ts(t,X, type = 'l')




