#Alex Monaghan
#ATSA
#3 March 2021
#Exercise 1.1

#Question 1
t <- c(0,pi/4,pi/2,.75*pi,pi)
Y1t <- round(sin(t),3)
Y2t <- round(sin(t +pi/2),3)
u <- round(.5*Y1t + .5*Y2t,3)

df_1 <- data.frame(t,Y1t,Y2t,u)
df_1

#Question 2

realization <- function(t){
  return(sin(t +pi/2))
}

realiztion.int <- integrate(realization,0,100)$value

mean.realization <- realiztion.int/100

cat("Mean Realization: ",mean.realization) #-0.005063656

#Question 3

#The ensemble mean is the average value of all realizations at one point in time
#To calculate the ensemble mean at a certain time (t) for a time-series with "n"
#realizations, I would need to calculate the weighted average of all the
#realizations (vertical)
#The mean of a given realization is the average of all times for that
#realization (horizontal)

#Question 4

#Create a sequence to 100 and scale
t <- c(0:100)
t <- t * 25/100

#Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t + pi/2)

#Plot the time series
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

savehistory("Exercise_1.1_amonaghan7_b1.Rhistory")

