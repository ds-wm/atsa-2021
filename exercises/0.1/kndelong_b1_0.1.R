setwd("G:/My Drive/Data 330")

y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

#Arithmetic Mean

sum <- 0
for (i in y){
  sum <- sum + i
}

n <- length(y)
arith.mean <- sum/n
arith.mean.check <- mean(y)

#Geometric Mean

product <- 1
for(i in y){
  product <- product*i
}

n <- length(y)
geo.mean <- product**(1/n)
#no built-in function

#harmonic mean

sum <- 0
for (i in y){
  sum <- sum + (1/i)
}

harm.mean <- (n/sum)
#no-built in function


temp <- 0
for (i in y){
  temp <- temp + ((i-arith.mean)**2)

}
#variance
variance <- temp/(n-1)


#standard deviation
dev <- sqrt(variance)


#standard error
err <- sqrt(variance/n)

savehistory("kndelong_b1_0.1.Rhistory")
