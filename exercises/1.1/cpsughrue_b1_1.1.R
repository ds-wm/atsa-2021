# Connor Sughrue
# DATA 330 Applied Time Series Analysis
# 2/14/21
# Exercise 1.1

# 1. Calculate the missing values in the following table.

# Y1(t) = sin(t)
# Y2(t) = sin(t + π/2)

# t    Y1(t)	 Y2(t)	μt
# ---------------------
# 0    ?      ?      ?
# π/4  ?      ?      ?
# π/2  ?      ?      ?
# 3π/4 ?      ?      ?
# π    ?      ?      ?


time.orig <- c(0, pi/4, pi/2, (3*pi)/4, pi)
time <- round(time.orig, 3)

Y1.orig <- sin(time)
Y1 <- round(Y1.orig, 3)

Y2.orig <- sin(time + (pi / 2))
Y2 <- round(Y2.orig, 3)

u.orig <- .5*Y1 + .5*Y2
u <- round(u.orig, 3)

value.table <- data.frame(time, Y1, Y2, u)

# output

# time  Y1     Y2     u
# --------------------------
# 0.000 0.000  1.000  0.500
# 0.785 0.707  0.707  0.707
# 1.571 1.000  0.000  0.500
# 2.356 0.707 -0.707  0.000
# 3.142 0.000 -1.000 -0.500


# 2. Calculate the mean for the realization Y(t) = sin(t + π/2) for t ∈ (0, 100).

# to calculate the mean of Y(t) from t = 0 to t = 100
# integrate Y(t) over interval (0, 100) then divide by length of interval (100)

realization = function(t){
  return(sin(t + (pi/2)))
}

# sin(t + π/2) = cos(t), antiderivative of cos(t) = sin(t) + C

realization.integral.manual <- sin(100) - sin(0)
realization.integral.auto <- integrate(realization, 0, 100)$value

cat('realization.integral.manual: ', realization.integral.manual, '\n')
cat('realization.integral.auto: ', realization.integral.auto, '\n\n')

# output
# realization.integral.manual:  -0.5063656
# realization.integral.auto:  -0.5063656

realization.mean <-realization.integral.auto / (100 - 0)

cat('realization.mean between t = 0 and t = 100: ', realization.mean, '\n\n')

# output
# realization.mean between t = 0 and t = 100: -0.0050636

# 3. What is the difference between the ensemble mean and the mean of a given realization?

# The ensemble mean is the average value across all realizations at a single
# point in time. To calculate the ensemble mean at time 't' for a time series
# with 'n' realizations, you would plug 't' into each realization and calculate
# the weighted average of all realization outputs. The mean of a given
# realization is the average value across a single realization during a given
# interval of time. You can use the fundamental theorem of calculus to
# calculate a function's average value over a specified interval.

# 4. Add the missing time series to the plot given below. Make the line dashed blue to match the legend.

# create a sequence (0, 100) and scale values to (0, 25)
t <- c(0:100)
t.scaled <- t * 25/100

# define the time series
Yt1 <- sin(t.scaled)
Yt2 <- sin(t.scaled + (pi/2))

# plot the time series
plot(t.scaled, 
     Yt1, 
     ylim = c(-1.1, 1.25), 
     type = "l", 
     col = "red", 
     lwd = 1, 
     lty = 1, 
     xlab = "Time", 
     ylab = NA)

lines(t.scaled, 
      Yt2, 
      ylim = c(-1.1, 1.25), 
      type = "l", 
      col = "blue", 
      lwd = 1, 
      lty = 2, 
      xlab = "Time", 
      ylab = NA)

legend("top", 
       inset = 0.01, 
       col = c("red","blue"), 
       lty = c(1,2), 
       lwd = c(1,1), 
       legend = c(expression(sin(t)), expression(sin(t+pi/2))), 
       bg = "white",
       box.col = "white",
       horiz = TRUE)

