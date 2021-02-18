# DATA 330 Applied Time Series Analysis
# Peter Woo
# Excercise 1.1

# Question 1

t <- c(0, .25*pi, pi/2, .75*pi, pi)
Y1t <- sin(t)
Y2t <- sin(t + .5*pi)
EYt <- .5*Y1t + .5*Y2t 
cat("Y1(t):", Y1t, "\n")
cat("Y2(t):", Y2t, "\n")
cat("E{Y(t)}:", EYt, "\n")

# Question 2

# The graph of the function oscillates at a regular interval between -1 and 1, 
# therefore the mean is 0. 

# Question 3

# The ensemble mean refers to the mean of all possible realizations at a given
# time and is calculated along the ordinate (vertical axis). The mean of a given
# realization is the mean of all values t for a given realization and is 
# calculated along the abscissa (horizontal axis)

# Question 4

# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t + .5*pi)
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

