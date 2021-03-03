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

# \gamma_0^{\hat} = \frac{1}{n} \cdot \sum_{i=1}^{n}(X_i - \mu_i)(X_i - \mu_t)
# \gamma_1^{\hat} = \frac{1}{n} \cdot \sum_{i=1}^{n-1}(X_i - \mu_i)(X_{i+1}-\mu_t)
# \rho_0 = \frac{\gamma_0^{\hat}}{\delta^2}
# \rho_1 = \frac{\gamma_1^{\hat}}{\delta^2}


cat('Gamma Hats : ',acf(hadley, lag.max=1, plot = FALSE, type ='covariance'), '\n')
cat('Autocorrelations: ', acf(hadley, lag.max=1, plot = FALSE, type ='correlation'), '\n')



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




