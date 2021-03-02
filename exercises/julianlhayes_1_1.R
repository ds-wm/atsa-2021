# Exercise 1

# Question 1
t <- c(0, pi/4, pi/2, 0.75*pi, pi)
Yt1 <- sin(t)
Yt2 <- sin(t + pi/2)

EYt <- 0.5*Yt1 + 0.5*Yt2

EY1 <- mean(Yt1)
EY2 <- mean(Yt2)

n <- 5
i <- 1
cat("t\tY(t1)\tY(t2)\tmu(t)\n")
while (i < n +1) {
  cat(round(t[i], 3), round(Yt1[i], 3), "\t", round(Yt2[i], 3), "\t", round(EYt[i], 3), "\n")
  i <- i + 1
}