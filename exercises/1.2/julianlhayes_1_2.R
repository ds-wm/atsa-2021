# Exercise 1.2

install.packages("tswge")
library("tswge")

# Qusetion 1
data(ss08)
ss.data <- plotts.wge(ss08)

# Question 2
ss.mean <- mean(ss08)
cat(ss.mean)

# Question 3
data(hadley)
hadley.acf <- acf(hadley)
print(hadley.acf)

# Question 4
had.len <- length(hadley)
had.mean <- mean(hadley)
had.sum <- vector(mode = "list", length = had.len)
for (i in had.len) {
  res <- (hadley[i] - had.mean)*(hadley[i+1] - had.mean)
  had.sum[i] <- res
}
had.sum.2 <- 0
for (i in had.len) {
  had.sum.2 <- had.sum.2 + had.sum[i]
}
had.autocov.0 <- sd(hadley)
had.autocov.1 <- (1/had.len)*had.sum.2
had.autocor.0 <- 1
had.autocor.1 <- had.autocov.1/had.autocov.0

cat("autocovariance_0: ", had.autocov.0, "\n",
    "autocovariance_1: ", had.autocov.1, "\n",
    "autocorrelation_0: ", had.autocor.0, "\n",
    "autocorrelation_1: ", had.autocor.1)

# Question 5
data(fig1.10a)
fig.ts <- plotts.wge(fig1.10a)
fig.per <- period.wge(fig1.10a)

