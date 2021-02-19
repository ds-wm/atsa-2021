#1.Calculate the missing values in the following table.
t <- c(0, pi/4, pi/2, .75*pi, pi)
Y1t <- round(sin(t),3)
Y2t <- round(sin(t + pi/2),3)
u <- round(.5*Y1t + .5*Y2t,3) 

df_1 <- data.frame(t,Y1t,Y2t,u)
df_1

#2.Calculate the mean for the realization $Y(t) = \sin(t + \pi / 2)$ for $t \in (0, 100)$.
realization <- function(t){
  return(sin(t + pi/2))
}

integral_realization <- integrate(realization, 0, 100)$value

mean_realization <- integral_realization/100

# mean of the realization is: -0.005

#3.What is the difference between the ensemble mean and the mean of a given realization?
  #The ensemble mean is the average of all of the realizations at a time, t. 
  #This is calculated along the vertical axis. 
  #The mean of a given realization is the average of all times for a given realization. 
  #This is calculated along the horizontal axis. 

#4.Add the missing time series to the plot given below. Make the line dashed blue to match the legend.

# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Y2t <- sin(t + pi/2)
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
