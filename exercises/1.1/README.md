**Exercise 1.1**

1. Calculate the missing values in the following table.

| t         | Y<sub>1</sub>(t)         | Y<sub>2</sub>(t)         | &mu;<sub>t</sub>          |
| ----------: | ---------------: | ---------------: | ---------------: |
| 0 | ? | ? | ? |
| &pi;/4 | ? | ? | ? |
| &pi;/2 | ? | ? | ? |
| 3 &pi;/4 | 0 | ? | ? |
| &pi; | ? | ? | ? |

2. Calculate the mean for the realization $Y(t) = \sin(t + \pi / 2)$ for $t \in (0, 100)$.

3. What is the difference between the ensemble mean and the mean of a given realization?

4. Add the missing time series to the plot given below.
    Make the line dashed blue to match the legend.

```R
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
```
