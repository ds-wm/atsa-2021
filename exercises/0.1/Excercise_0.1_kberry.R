# Excercise 0.1

y <- c(1,	2.5,	4,	5.5,	7,	8.5,	10,	11.5,	13,	14.5)

#Part 1 

#Here we are creating a function called arith to calculate the arithmetic mean

arith <- function(inputs) {
  my_sum <- 0
  for (input in inputs) {
    my_sum <- my_sum + input
  }
  return(my_sum/length(inputs))
}

#Here we are creating a function called geo to calculate the geometric mean

geo <- function(inputs) {
  my_sum <- 1
  for (input in inputs) {
    my_sum <- my_sum * input
  }
  return(my_sum**(1/length(inputs)))
}

#Here we are creating a function harmo to calculate the harmonic mean

harmo <- function(inputs) {
  my_sum <- 0
  for (input in inputs) {
    my_sum <- my_sum + (1/input)
  }
  return(length(inputs)/my_sum)
}

#Part 2 

#Here we are going to calculate the variance 
#We will create a function called variance to do so

variance <- function(inputs) {
  my_var <- 0
  for(input in inputs) {
    my_var <- my_var + (input - mean(inputs))**2

  }
  return(my_var/(length(inputs)-1))
}

#Part 3

#Here we will find the standard deviation
#We will create a function called  s_d to do so 

s_d <- function(inputs) {
  sqrt(var(inputs))
}


#Part 4 

#Here we will calculate the standard error about the mean
#We will do so by creating a function called s_d_mean

s_d_mean <- function(inputs) {
  sd(inputs)/sqrt(length(inputs))
}


#Part 5: Let's put them to use!

inputs <- y

arith(inputs)
geo(inputs)
harmo(inputs)
variance(inputs)
s_d(inputs)
s_d_mean(inputs)