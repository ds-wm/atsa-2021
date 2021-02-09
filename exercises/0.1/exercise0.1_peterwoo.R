#Excercise 1 
#Peter Woo

install.packages("psych")
install.packages("plotrix")
library("plotrix")
library("psych")

y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

# The means 
y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

## Arithmetic mean
i <- 1
n <- length(y)
my.sum <- 0
while (i < n+1) {
  my.sum <- my.sum + y[i]
  i <- i + 1
}
my.arith.mean <- my.sum / n
my.arith.mean
mean(y)
  
## Geometric mean
i <- 1
n <- length(y)
my.prod <- 1
while (i < n+1) {
  my.prod <- my.prod * y[i]
  i <- i + 1
}
my.geom.mean <- my.prod ** (1/n)
my.geom.mean
geometric.mean(y)
  
  ## Harmonic mean
  i <- 1
  n <- length(y)
  my.sum <- 0
  while (i < n+1) {
    my.sum <- my.sum + (1 / y[i])
    i <- i + 1
  }
  my.harm.mean <- n / my.sum
  #cat("Harmonic mean: ", my.harm.mean)
  
  all.my.means <- c(my.arith.mean, my.geom.mean, my.harm.mean)
  return (all.my.means)
}

my.means <- calc.my.means(y)
print(my.means)
#arithmetic mean
i <- 1
n <- length(y)
my.sum <- 0
while (i < n+1){
  my.sum <- my.sum + y[i]
  i <- i + 1
}

my.arith.mean <- my.sum / n
temp.sum <- 0

for (num in y){
  temp.sum <- temp.sum + (num - my.arith.mean)**2
}
variance <- (temp.sum/(n-1))
variance

stand.dev <- sqrt(variance)
stand.dev

stand.err <- sqrt(variance/n)
stand.err