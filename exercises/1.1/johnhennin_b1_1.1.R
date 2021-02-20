#John Hennin, Applied Time Series Analysis
#2021-02-20


# Question 1

t <-c(0, pi/4, pi/2, (3*pi)/4, pi)
trealization <-c(0:100)
# y.1
# This function calculates Y1(t)
# Inputs: vector of times
# Outputs: vector of Y1(t) values

y.1 <- function(t) {
  s <- sin(t)
  #for (i in 1:length(t)) {
    #cat("Y1(",t[i],') = ',s[i],'\n')
  #}
  return(s)
}

y.1(t)


# y.2
# This function calculates Y2(t)
# Inputs: vector of times
# Outputs: vector of Y2(t) values

y.2 <- function(t) {
  s <- sin(t + (pi/2))
  #for (i in 1:length(t)) {
    #cat("Y2(",t[i],') = ',s[i],'\n')
  #}
  return(s)
}

y.2(t)


# ens.mean
# This function calculates u(t)
# Inputs: vector of times
# Outputs: vector of mean values for time t

ens.mean <- function(t) {
  s <- (y.1(t)+y.2(t))/2
  #for (i in 1:length(t)) {
    #cat("Ensemble Mean At Time",t[i],'=',s[i],'\n')
  #}
  return(s)
}

ens.mean(t)


# Question 2

# real.mean
# This function calculates the realization mean
# Inputs: range of times
# Outputs: mean value for realization Y2(t) for t (0,100)

real.mean <- function(t) {
  s <- mean(y.2(t))
  #for (i in 1:length(t)) {
  #cat("Ensemble Mean At Time",t[i],'=',s[i],'\n')
  #}
  return(s)
}

real.mean(trealization)


# Question 3

# The ensemble mean is the vertical mean (the mean of the y axis values at a
# single given t) across multiple realizations, whereas the mean of a given
# realization is the horizontal mean (the mean of the y axis values at all 
# specified t values) for a single realization.


# Question 4

t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t+pi/2)

# Plot our time series
plot(
  t, 
  Yt1, 
  ylim = c(-1.1, 1.25), 
  type = "l", 
  col = "red", 
  lwd = 1, 
  lty = 1, 
  xlab = "Time", 
  ylab = NA
)

lines(
  t, 
  Yt2, 
  ylim = c(-1.1, 1.25), 
  type = "l", 
  col = "blue", 
  lwd = 1, 
  lty = 2, 
  xlab = "Time", 
  ylab = NA
)

legend(
  "top", 
  inset=0.01, 
  col=c("red","blue"), 
  lty=c(1,2), 
  lwd=c(1,1), 
  legend = c(
    expression(sin(t)),
    expression(sin(t+pi/2))), 
  bg="white",
  box.col="white",
  horiz=TRUE
)