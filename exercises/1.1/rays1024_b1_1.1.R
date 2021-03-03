# Ray Shen
# DATA 330 Applied Time Series Analysis
# Feb.20,2021
# Exercise 1.1
#1.Calculate the missing values in the following table. You may ignore the values in the first row (these were adding to fix column width issues).
t <- c(0,0.25*pi,0.5*pi,0.75*pi,pi)
Y1t <- sin(t)
Y2t <- sin(t + pi/2)
ut <- 0.5*Y1t+0.5*Y2t
dt <- data.frame(t,Y1t,Y2t,ut)
print(dt)

#2.Calculate the mean for the realization Y(t) = sin(t +pi/2) for t in (0, 100).
realization = function(t) {
  return (sin(t + (pi/2)))
}
real_int <- integrate(realization, 0, 100)$value
real_mean <- real_int/100
print(real_mean)

#3.What is the difference between the ensemble mean and the mean of a given realization?
#The ensemble mean is the mean of all realizations at one time, t.
#We can derive it by calculating the weighted average for all values of realizations with time t.
#The mean of a given realization is the mean of one realization across a period of time.
#It is the average of a set of observations made in one realization.

#4.Add the missing time series to the plot given below. Make the line dashed blue to match the legend.
# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Y1t <- sin(t)
Y2t <- sin(t + pi/2)

# Plot our time series
plot(
  t,                                             
  Y1t,                                           
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
  Y2t,
  ylim = c(-1.1, 1.25),
  type = "l",
  col = "blue",
  lty = 2,
  lwd = 1,
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