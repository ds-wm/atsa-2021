# Exercise 1.2

## Load the dataset ss08 and visualize it. Try both the base plot in R and the plotts.wge function provided by the textbook.

#install.packages("tswge")
library("tswge") # run previous line (above) if tswge "not found"
data("ss08")
plot(ss08, type = "l")
plotts.wge(ss08)

## Calculate the average of this time series realization using the mean function.

print(mean(ss08))

## Load the dataset hadley and plot the sample autocorrelations and sample autocovariances using the acf function

data("hadley")
acf(hadley, type="correlation")
acf(hadley, type="covariance")

## Write the equations for ^γ0, ^γ1, ^ρ0 and ^ρ1 and compute them using R (note the hats, ^, are to represent the estimators).

cat("I guess I will proceed to use LaTeX to write the equations, as it is hard to write them out without using LaTeX on the keyboard. Please render them using some sort of LaTeX renderer that can render the hat character.")
# autocovariance
# $\hat\gamma_0=\frac{1}{n}\sum_{t=1}^{n}(X_t-\bar{X}_t)(X_{t}-\bar{X}_t)$\\
# $\hat\gamma_1=\frac{1}{n}\sum_{t=1}^{n-1}(X_t-\bar{X}_t)(X_{t+1}-\bar{X}_t)$\\
# autocorrelation
# $\hat\rho_0=\frac{\hat\gamma_0}{\hat\gamma_0}$\\
# $\hat\rho_0=\frac{\hat\gamma_1}{\hat\gamma_0}$\\
# these cannot be printed as \h will cause an error and not print

y <- acf(hadley, lag.max = 1, plot = FALSE, type = "covariance")
print(y)
cat("^y0, ^y1, respectively")
p <- acf(hadley, lag.max = 1, plot = FALSE, type = "correlation")
print(p)
cat("^p0, ^p1, respectively")
cat("it makes sense that ^p0 is 1, as the equation (written as LaTeX) simplifies to 1 as it's just ^y0/^y0")

## Plot the time series and the periodogram for Figure 1.10a of Woodward et al. (fig1.10a). Note that the sampling rate for the x-axis is in 1/10ths. What are the three dominant frequencies of this dataset?

data("fig1.10a")
plot(1:1000/10, fig1.10a, type = "l")
p.f10a <- period.wge(fig1.10a, dbcalc = TRUE, plot = TRUE)
# from the notes, we can find that the pgram is stored here:
pgrams <- p.f10a$pgram
freqs <- p.f10a$freq
# which.max() returns us the index of the largest value
# allows us to use this index to grab the corresponding frequency!
dom1 <- freqs[which.max(pgrams)] # store it
pgrams[which.max(pgrams)] <- (-Inf) # now delete the largest value (negative infinity)
dom2 <- freqs[which.max(pgrams)] # we can now look for the next largest
pgrams[which.max(pgrams)] <- (-Inf)
dom3 <- freqs[which.max(pgrams)]
cat("The three dominant frequencies are as follows:", dom1, dom2, dom3)
# I got 0.015, 0.01, and 0.003

## The time series in Figure 1.10a (Woodward et al.) can be expressed as the following: where f1, f2, and f3 are the three dominant frequencies (in order from lowest to highest) found in the previous question. Replace the frequencies you found in the equation above and recreate using R the Figure 1.10a using values for t ∈ (0, 100) (e.g., x <- 0:1000/10).
## X(t) = cos(2π t f1) + 1.5 cos(2π t f2 + 1) + 2 cos(2 π t f3 + 2.5)

# given... ?
x <- 0:1000/10
# put the vector into t (into the equation)
t <- x
Xt = cos(2*pi*t*dom1) + 1.5*cos(2*pi*t*dom2 + 1) + 2*cos(2*pi*t*dom3 + 2.5)
# now plot
plot(Xt, type = "l")

