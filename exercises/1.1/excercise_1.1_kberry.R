#Exercise 1.1 

#Question 1: Find the missing values in dataframe
t <- c(0,pi/4,pi/2, (3*pi)/4, pi) 

Y1t <- sin(t)
Y2t <- sin(t+(pi/2))
EYt <- (.5*Y1t) + (.5*Y2t)

table_1.1 <- data.frame(t, Y1t, Y2t, EYt)
table_1.1


#Question 2: Calculate the mean for the realization 

realization <- function(t) {
  sin(t + (pi/2))
}

real_t <- integrate(realization,0,100)$value

mean_realization <- real_t/100
cat("The calculated mean of the realization from t = 0 to t=100 is",
    mean_realization)

#Question 3 
#What is the difference between the ensemble mean and the mean of a given realization?

#The ensemble mean encompasses the value of the mean of all the realizations at time t. 
#It is calculated via the vertical/y axis. 
#This is different than the mean of a given realization, which refers to mean of all values t for a single given realization. 
#It is calculated by the horizontal/x axis.


#Question 4
# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t + (pi/2))

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
#Add the missing lines
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
