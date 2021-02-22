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

## February 09, 2021
### Progress: Lesson 0, Lesson 1.1, Exercise 1.1

### Fill in the blank for Lesson 1.1
  - Random Variable (Y): It is a function defined on a sample space,  Ω , whose range is the real numbers,  IR . 
  -  An  observation––––––––––––  of a random variable,  y=Y(ω)  for a given  ω∈Ω , is also a real number.

## February 11, 2021


## February 16, 2021


## February 18, 2021


## February 23, 2021


## February 25, 2021
