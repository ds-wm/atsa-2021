#Exercise 1.1
#Jacinta Das
#February 18,2021
#Question 1: Calculate the missing values in the following table
t <- c(0,pi/4,pi/2,.75*pi, pi)
#Missing values are y1t, y2t, and E(y(t))
y1t <- sin(t)
y2t <- sin(t+(pi/2))
Eyt <- (.5*y1t) + (.5*y2t)
my.df <- data.frame(t,y1t,y2t,Eyt)
my.df # this dataframe includes all values

#Question 2: Calculate the mean for the realization Y(t) = sin(t+pi/2) for t in (0,100)
calc.t <- function(t){
  answer = sin(t+(pi/2))
  return(answer)
}
x = integrate(calc.t, 0,100)$value
average = x/100
print(average)

#Question 3: What is the difference between the ensemble mean and the mean of a given realization?
#An ensemble mean is the mean of all the possible realizations at a point in time.
#The mean of a given realization is the mean of that particular function over an interval of time.
#The ensemble mean requires an average along the y axis whereas the mean of a given realization requires an average along the x axis.

#Question 4: Add the missing time series to the plot given below. Make the line dashed blue to match the legend.
#Create a sequence to 100 and scale the values (0,25)
t <- c(0:100)
t <- t*25/100
#Define the time series
yt1 <- sin(t)
yt2 <- sin(t + (pi/2))
Eyt <- .5*yt1 + .5*yt2
#Plot the time series
plot(
  main = "Example Time Series",
  t,
  yt1,
  ylim = c(-1.1,1.25), #(ymin,ymax)
  type = "l", #l = line
  col = "red",
  lwd = 1, #line width
  lty = 1, #line type
  xlab = "Time", #x-axis label
  ylab = NA #y-axis label
)

lines(t,yt2, type="l", col="blue", lty=2)

legend(
  "top", # location of legend
  inset=.01, # buffer around the legend
  col=c("red","blue"), 
  lty = c(1,2),
  lwd = c(1,1),
  legend = c(
    expression(sin(t)),
    expression(sin(t+(pi/2))),
    bg = "white",
    box.col = "white",
    horiz = TRUE)
plot.new()

#Bibliography
#Davis, T. (2021, February 9). Exercise 1.1 Lecture Notes.