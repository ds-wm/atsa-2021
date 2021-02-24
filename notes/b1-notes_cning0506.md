# Note-Taking for Block 1 - Introduction to Time Series and R

#### Written by Conrad Ning 

#### Last edited: 2021-02-21

## February 02, 2021
[Lecture Slides](https://ds-wm.github.io/course/atsa/lectures/intro-to-ts/index.html#/applied-time-series-analysis)

**Why Time Series?**
There are three main reasons why we care about Time Series in Data Science. One, data science is the field that find patterns in data. Two, Time Series is a specific type of data. Three, we use special tools to find patterns in time series. Time Series data can be useful in two cases, **modelling** and **forecasting**. 

**The Four V's of Big Data**
  - Volume
  - Velocity
  - Variety
  - Veracity (Truth)  

**Note pieces from the lecture slides**
  - There's a popular belief that all data is a mixture of parametric structures and stochastic noise. When the sample space of the stochastic process is time, that is time series data. 
  - Focus on the "hows" and "whys" and not the results to explain what we depict

### Useful codes for RStudio and Google Colab

How to save Rhistory File
```
savehistory(file = "filename.Rhistory")
```
Install packages and load data from the textbook
```
install.packages("tswge")
library("tswge")
```

## February 04, 2021
[Google Collab](https://colab.research.google.com/drive/1OSNx-28tf384VOuS71_n5tCIrqc_UfmK?usp=sharing)
### Progress: Lesson 0, Exercise 0.1
**Google Colab is a Jupyter Notebook using R**
```
sessionInfo()
```
**Look up the function of the package in R**
```
help("package_name")
```

### Some functions in R
The table below lists some of them.

| Operation | Meaning |
| :-------- | :------ |
| max(x) | maximum value in x |
| min(x) | minimum value in x |
| sum(x) | total of all the values in x |
| mean(x) | arithmetic average of the values in x |
| median(x) | median value in x |
| range(x) | vector of min(x) and max(x) |
| var(x) | sample variance of x |
| cor(x, y) | correlation between vectors x and y |
| sort(x) | a sorted version of x |
| rank(x) | vector of the ranks of the values in x |
| order(x) | an integer vector containing the permutation to sort x into ascending order |
| quantile(x) | vector containing the minimum, lower quartile, median, upper quartile, and maximum of x |
| cumsum(x) | vector containing the sum of all of the elements up to that point |
| cumprod(x) | vector containing the product of all of the elements up to that point |
| cummax(x) | vector of non-decreasing numbers that are the cumulative maxima of the values in x up to that point |
| cummin(x) | vector of non-increasing numbers which are the cumulative minima of the values in x up to that point |
| pmax(x, y, z) | vector, of length equal to the longest of x, y or z, containing the maximum of x, y or z for the ith position in each |
| pmin(x, y, z) | vector, of length equal to the longest of x, y or z, containing the minimum of x, y or z for the ith position in each |

### Mean
  - Arithmetic Mean : The sum of numbers divided by the count of numbers and the most common method for calculating the mean.
  - Geometric Mean : The  n -th root of the product of numbers. For processes that change multiplicatively rather than additively.
  - Harmonic Mean : The reciprocal of the average of the reciprocals. For processes that change rates

### Other Key Terms
  - Variance
  - Standard Deviation (Built-in Function available)
  ```
  sd( )
  ```
  - Standard Error
### Missing Vocabulary Terms for Lesson 0 (The missing words are bolded)
  - **Sum of the Squares** : The variance of a sample is measured as a function of "the sum of the squares of the difference between the data and the arithmetic mean." 
  - **Degree of Freedom** : Variance is defined as the ratio of the sum of the squares to the degree of freedom.


## February 09, 2021
### Progress: Lesson 0, Lesson 1.1, Exercise 1.1

### Missing Vocabulary Terms for Lesson 1.1 (The missing words are bolded)
  - **Random Variable** (Y) is a function defined on a sample space,  Ω , whose range is the real numbers,  IR . 
  - An **observation** of a random variable,  y=Y(ω)  for a given  ω∈Ω , is also a real number.
  - A  **stochastic** process is a collection of random variables  {Y(ω);ω∈Ω}  where all random variables are defined on the same sample space.
  - When this shared sample space represents  **time**,  T , then the stochastic process---which can now be written as  X(t);t∈T ---is referred to as a **time series**.
  - Note that the sample space,  T , whose range is the real numbers, may be represented as either continuous, for example  T=(−∞,∞) , or  **discrete**.
  - A **realization** of a time series,  x(t);t∈T , is the set of values that result from the occurrence of some observed event.
  - The collection of all possible realizations,  {x(t)} , is called the **ensemble**.
  - The **expected value** for a stochastic process is the ensemble mean, E[Y(t)] .
  - The **ordinate** is the vertical axis.
  - The  **abscissa** is the horizontal axis.
  - Of particular interest in time series analysis is the **covariance** between  X(t1)  and  X(t2)  for values  t1,t2∈T . Because this covariance is within the same time series, it is called  **autocovariance** and is given by the following expression.  
  ```
  γ(t1,t2)=E{[X(t1)−μ(t1)][X(t2)−μ(t2)]}
  ```
  - **Autocorrelation** of a time series, which is given by the following expression, where  σ  is the standard deviation of the ensemble at a given t .
  ```
  ρ(t1,t2)=γ(t1,t2)/σ(t1)σ(t2)
  ```

### An example for plotting in R

```
plot(
  t,                            # x values
  Yt1,                          # y values
  main = "Example Time Series", # Title
  sub = NA,                     #subtitle
  ylim = c(-1.1, 1.25),         # limit to plot in y-axis (ymin,ymax) 
  type = "l",                   # type line 'l', 'p', 'o'
  col = "red",                  # color code
  lwd = 1,                      # line width 
  lty = 1,                      # line types
  xlab = "xlabel_name",         # x-axis label
  ylab = NA                     # y-axis label
  )
```

## February 11, 2021
### Progress: Data Challenge 1.1, Lesson 1.2- Lesson 1.2.4

### Data Challenge 1.1
Using R and manipulating data by plotting both speed and elevation against time in this [.gpx](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/back-to-the-garden.gpx) dataset.

### Missing Vocabulary Terms for Lesson 1.2 - 1.2.4 (The missing words are bolded)
  - **Stationarity** :  The state of "statistical equilibriuim" (i.e., the basic behavior of a stationary time series does not change in time)
  - **Ergodic**: A time series where ensemble averages are consistent with those from a single realization are called ergodic processes.
  - **Strictly stationary** : The following must be true, (1)for any  t1,t2∈T , the distributions of  X(t1 ) and  X(t2)  must also be the same; (2)all bivariate distributions  {X(t),X(t+h)}  must be the same for all values of  h
  - **Covariance Stationarity (Weak Stationarity)**: The following must be true, 
    - E[X(t)]=μ  and is constant for all values of t 
    - Var[X(t)]=σ2<∞ (i.e., is finite for all t)
    - γ(t1,t2) depends only on t2−t1
    - γ(h) is a semi-definite process (i.e., it's positive or zero for all scalar multiples)
  - **Cauchy-Schwartz inequality**: |γ(h)|≤γ(0)  for all  h
  - **Sample autocorrelation function** : A purely random time series, where the data are identically distributed (i.e., the data are balanced on the time series)
  - **Sample autocorrelation function** : ρ^h=γ^h/γ^0
  - **Time Domain** : The realizations, mean, variance, and autocorrelations of time series. These are all aspects of a time domain analysis of time series.
  - **Frequency Domain**
  - **Aperiodic** : We define a function  g(t)  as periodic with period (or cycle length) p>0  if there exists a p such that  g(t)=g(t+kp) for all  t and integers k. A function g(t) is said to be aperiodic if no such p exists.
  - **Spectral Density** : When we determine the frequency or cyclic content of data, the relevant information in the autocorrelation is more readily conveyed through the Fourier transform of the autocorrelation, called the spectral density.
  - **Periodogram** : This is based on the squared correlation between the time series and the sine/cosine waves of frequency, f , and displays exactly the same information as the autocovariance function.

## February 16, 2021


## February 18, 2021


## February 23, 2021


## February 25, 2021
