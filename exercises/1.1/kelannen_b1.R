# Exercises 1.1:

# Question 1: Calculate the missing values in the following table
t <-c(0, pi/4, pi/2, (3*pi)/4, pi)

Yt1 <- sin(t)
Yt2 <- sin(t + pi/2)
EYt <- 0.5*Yt1 + 0.5*Yt2

df <- data.frame(t, Yt1, Yt2, EYt)
df


# Question 2: Calculate the mean for the realization 
#     $Y(t) = \sin(t + \pi / 2)$ for $t \in (0, 100)$
trealization <- c(0:100)
yt <- sin(trealization + pi/2)

cat('Mean of Realization (Yt): ', mean(yt), '\n')


# Question 3: What is the difference between the ensemble mean and the 
#             mean of a given realization?

# The ensemble mean is the expected value of all realizations at a single point
# in time and is calculated along the vertical axis. The mean of a given
# realization is the average value of a single realization across an interval
# of time and is calculated along the horizontal axis.


# Question 4: Add the missing time series to the plot given below. 
#             Make the line dashed blue to match the legend

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

lines(
  t,
  Yt2,
  col = "blue",
  lty = 2,
  lwd = 1
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


savehistory(file = "kelannen_b1.Rhistory")
