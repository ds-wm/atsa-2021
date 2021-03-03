
# Exercise 1.1
# Rini Gupta
# 2/13/21


# Question 1

t <- c(0, .25*pi, pi/2, .75*pi, pi)
Y1t <- sin(t)
Y2t <- sin(t + .5*pi)
mu.t <- .5*Y1t + .5*Y2t 
cat("Y1(t):", Y1t, "\n")
cat("Y2(t):", Y2t, "\n")
cat("Ensemble mean:", mu.t, "\n\n")

# Question 2
# The graph for the second realization oscillates around 0 for a continuous interval
# As a result, the average value would be 0. 

# Question 3
# The difference between the ensemble mean and the mean of a given realization is that the 
# ensemble mean is a vertical average across different realizations for a particular t, whereas
# the mean is a horizontal average across all time points for a given realization. 
cat('Mean for the first realization', mean(Y1t), "\n")
cat('Mean for the second realization', mean(Y2t), "\n")
cat('Ensemble mean:', mu.t)


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
