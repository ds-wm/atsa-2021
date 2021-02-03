# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)

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