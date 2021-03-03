# Exercise 1.1

## Calculate the missing values in the following table.

t <- c(0, pi/4, pi/2, 3*pi/4, pi)
# Actually calculate the values
Y1t <- round(sin(t), digits=4) # round... to avoid any nasty e^-01 calculation inaccuracies
Y2t <- round(sin(t + pi/2), digits=4)
Mt <- (Y1t+Y2t)/2
# Fit them into a nice dataframe for viewing
my.df <- data.frame(t, Y1t, Y2t, Mt)
# View
print(my.df)

## Calculate the mean for the realization $Y(t) = \sin(t + \pi / 2)$ for $t \in (0, 100)$.

# .2 suffix to differentiate variables from part 1.

# let's see what happens at regular 1 int differences
t.2 <- seq(0,100)
Yt.2 <- sin(t.2 + pi/2)
mean.2.1 <- mean(Yt.2)
print(mean(Yt.2))
# let's try splitting it even smaller (more splits)
t.2 <- seq(0,100,length.out=1001)
Yt.2 <- sin(t.2 + pi/2)
mean.2.2 <- mean(Yt.2)
print(mean(Yt.2))
# we have shown here that it clearly varies even with more values of t.
cat("So over a sequence of (0, 1, 2, ..., 99, 100), the mean would be", mean.2.1)
cat("Though, the realization oscillates between -1 and 1.", "\nSo the more realistic solution would actually 0.")

## What is the difference between the ensemble mean and the mean of a given realization?

cat("The ensemble mean provides us with the average over all of the outcome values, which covers the entire range, whereas the mean of a given realization provides us with the average over a specific given time.")

## Add the missing time series to the plot given below. Make the line dashed blue to match the legend.

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

# we can also use par(new=TRUE) and keep the plot() function instead.
# but this clouds up the y-axis. So let's just go with lines().
lines(
  t,
  Yt2,
  type = "l", 
  col = "blue", 
  lwd = 1, 
  lty = 2,
)

# legend background transparent because it's clogging up my screen
legend(
  "top", 
  inset=0.01, 
  col=c("red","blue"), 
  lty=c(1,2), 
  lwd=c(1,1), 
  legend = c(
    expression(sin(t)),
    expression(sin(t+pi/2))), 
  bg="transparent",
  box.col="white",
  horiz=TRUE
)
