setwd("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/")

# Question 1
t <- c(0,pi/4,pi/2, 0.75*pi, pi) 
Y1t <- sin(t)
Y2t <- sin(t + pi/2)

my.df <- data.frame(t,Y1t,Y2t)
#my.df

EYt <- 0.5*Y1t + 0.5*Y2t

my.df$EYt <- EYt
print(my.df)

# Output
#t          Y1t           Y2t           EYt
#1 0.0000000 0.000000e+00  1.000000e+00  5.000000e-01
#2 0.7853982 7.071068e-01  7.071068e-01  7.071068e-01
#3 1.5707963 1.000000e+00  1.224606e-16  5.000000e-01
#4 2.3561945 7.071068e-01 -7.071068e-01  5.551115e-17
#5 3.1415927 1.224606e-16 -1.000000e+00 -5.000000e-01

# Question 2
# calculate the mean of Y(t) from t = 0 to t = 100  
realization = function(t){
  return(sin(t + (pi/2)))
}

realization.int <- integrate(realization, 0, 100)$value

mean.realization <- realization.int/100

cat('mean of realization between t=0 and t = 100: ', mean.realization)

# Output
# mean of realization between t=0 and t = 100:  -0.005063656

# Question 3 

# The ensemble mean is the expected value or the average of all realizations at a single moment. 
# In the context of time series, if we want to get the ensemble mean, we need to apply time 't' 
# into 'n' number of realizations.We can the weighted average of realization outputs by applying 
# different time into each realization. The mean of a realization is the set of values that is 
# observed during a time series. With the help of integration, we can find the average value over
# a time interval.



# Question 4
# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t+ pi/2)
EYt <- 0.5*Yt1 + 0.5*Yt2

# Plot our time series
plot(
  t,                                             # x values
  Yt1,                                           # y values
  main = "Time Series Example for Exercise 1.1", # Title
  sub = NA,                                      # subtitle
  ylim = c(-1.1, 1.25),                          # limit to plot in y-axis (ymin,ymax) 
  type = "l",                                    # type line 'l', 'p', 'o'
  col = "red",                                   # color code
  lwd = 1,                                       # line width 
  lty = 1,                                       # line types
  xlab = "Time",                                 # x-axis label
  ylab = NA                                      # y-axis label
)

lines(
  t,
  Yt2,
  col = "blue",
  lty = 2,
  lwd = 1
)


legend(
  "top",           # location of legend
  inset=0.01,         # buffer around the legend
  col=c("red","blue"),    # 
  lty=c(1,2), 
  lwd=c(1,1), 
  legend = c(
    expression(sin(t)),
    expression(sin(t+pi/2))), 
  bg="white",         # background color
  box.col="white",
  horiz=TRUE         # Legend side by side or not
)
