# Exercise 1.1 
  
# Q1: Calculate the missing values in the following table.
  
# OUTPUT  
# | t     | Y1(t) | Y2(t)  | mu    |
# |-------|-------|--------|-------| 
# | 0     | 0     | 1      | 0.5   |
# | pi/4  | 0.707 | 0.707  | 0.707 |
# | pi/2  | 1     | 0      | 0.5   |
# | 3pi/4 | 0.707 | -0.707 | 0     |
# | pi    | 0     | -1     | -0.5  |

t <- c(0, .25*pi, pi/2, .75*pi, pi)
Y1t <- sin(t)
Y2t <- sin(t + .5*pi)
mu <- .5*Y1t + .5*Y2t 
Y1t.table <- cat("Y1(t):", Y1t, "\n")
Y2t.table <- cat("Y2(t):", Y2t, "\n")
mu.table <- cat("Ensemble mean:", mu.t, "\n\n")

# Q2: Calculate the mean for the realization $Y(t) = \sin(t + \pi / 2)$ for $t \in (0, 100)$.
real <- function(t){
  return(sin(t + (pi/2)))
}
realization.t <- integrate(realization,0,100)$value/100
cat("The mean of the realization between t=0 and t=100 is ", realization.t)

# OUTPUT
# The mean of the realization between t=0 and t=100 is  -0.005063656

# Q3: What is the difference between the ensemble mean and the mean of a given realization?
# The ensemble mean is the mean of multiple realizations at one given time. (one time, multiple realizations)
# The mean of a given realization is the mean for all times in that realization. (multiple times, one realization)
  
# Q4: Add the missing time series to the plot given below. Make the line dashed blue to match the legend.

# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t + pi/2)

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

lines (
  t, 
  Yt2,
  type = "l",
  col = "blue",
  lwd = 1,
  lty = 2,
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


savehistory(file = "exercise_1.1_ashamsilva.Rhistory")
