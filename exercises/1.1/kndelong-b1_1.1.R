setwd("G:/My Drive/Data 330")

#Question 1

t <- round(c(0, pi/4, pi/2, (3*pi)/4, pi),3)
yt1 <- round(sin(t),3)
yt2 <- round(sin(t+(pi/2)),3)
Eyt <- round((0.5*yt1) + (0.5*yt2),3)

table <- matrix(c(t, yt1, yt2, Eyt),ncol=4,byrow=FALSE)
colnames(table) <- c("t", "Yt1", "Yt2", "Eyt")

#Question 2

t <- c(0:100)
yt <- function(t){
  return(sin(t + (pi/2)))
}

cat("Mean of the Realization Y(t):", mean(yt(t)),"\n")

#Question 3

# The ensemble mean is the collection of all of the possible realization means,
# and the mean of a realization is the mean at one particular point in the interval.

#Question 4

t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t +(pi/2))

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
  col="blue",
  lty=2,
  lwd=1
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

savehistory("kndelong-b1_1.1.Rhistory")
