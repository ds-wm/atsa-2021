# Block 1 Notes 
Written by Monica Alicea   
Last edited: 2021-02-28

## Feb. 2-4, 2020
### Lesson 0: Introduction to Time Series
Why do we care about time series in data science?  
1. We define data science as the field that finds patterns in data  
2. A time series is a special type of data  
3. We use special tools to find patterns in time series  

Why do we care about time series?    
Two reasons:  
1. Modeling
    * Big data is any collection of data that is too big to be held in the memory of your computer.  
      The four V’s of big data:  
        1. Volume (how much data do you have)  
        2. Velocity (how fast do we need to process data)  
        3. Variety   
        4. Veracity (truth) (how good is your data)    
2. Forecasting 
    * If there are patterns in data, we can use things that have happened in the past to predict what might happen in the future.

There is a popular belief that all data is a mixture of parametric structures and stochastic noise 
When the shared sample space for the stochastic process is time, we refer to this data as a time series.

### Lesson 0.2: The Jupyter Notebook
The Google Colab is a Jupyter Notebook run in R. 

Missing vocabulary:
   * (Linux) **runtime**: The time it takes for the software to execute your code. 
   * **Kernel**: The most basic unit of the operating system, responsible for resource allocation and file management.

### Lesson 0.3: The R Runtime
Check what version of R is running using: ```sessionInfo()```  
Check list of installed packages using: ```installed.packages()```  
Install packages using: ```install.packages("package_name", dependencies = TRUE)```   
Call package using: ```library("package_name")```   
To figure out package function use: ```help("package_name")```   

### Lesson 0.4 The R Language
To use R as a calculator, use the following functions:
| Function | Meaning |
| :------- | :------ |
| log(x) | log to base $e$ of $x$ |
| exp(x) | antilog of $x$, (i.e. $e^x$) |
| log(x, n) | log to base $n$ of $x$ |
| log10(x) | log to base 10 of $x$ |
| sqrt(x) | square root of $x$ |
| factorial(x) | $x!$ |
| choose(n,x) | binomial coefficients $n!/(x! (n-x)!)$ |
| gamma(x) | $\Gamma(x)$, for real $x (x-1)!$, for integer x |
| lgamma(x) | natural log of $\Gamma(x)$ |
| floor(x) | greatest integer $< x$ |
| ceiling(x) | smallest integer $> x$ |
| trunc(x) | closest integer to $x$ between $x$ and 0 |
| round(x, digits=0) | round the value of $x$ to an integer |
| signif(x, digits=6) | give $x$ to six digits in scientific notation |
| runif(n) | generates $n$ random numbers between 0 and 1 in uniform distribution |
| cos(x) | cosine of $x$ in radians |
| sin(x) | sine of $x$ in radians |
| tan(x) | tangent of $x$ in radians |
| acos(x); asin(x); atan(x) | inverse trigonometric transformations of real or complex numbers |
| acosh(x); asinh(x); atanh(x) | inverse hyperbolic trigonometric transformations of real or complex numbers |
| abs(x) | the absolute value of $x$ ignoring the minus sign if there is one |

You can also use these vector functions in R:
| Operation | Meaning |
| :-------- | :------ |
| max(x) | maximum value in $x$ |
| min(x) | minimum value in $x$ |
| sum(x) | total of all the values in $x$ |
| mean(x) | arithmetic average of the values in $x$ |
| median(x) | median value in $x$ |
| range(x) | vector of $\min(x)$ and $\max(x)$ |
| var(x) | sample variance of $x$ |
| cor(x, y) | correlation between vectors $x$ and $y$ |
| sort(x) | a sorted version of $x$ |
| rank(x) | vector of the ranks of the values in $x$ |
| order(x) | an integer vector containing the permutation to sort x into ascending order |
| quantile(x) | vector containing the minimum, lower quartile, median, upper quartile, and maximum of $x$ |
| cumsum(x) | vector containing the sum of all of the elements up to that point |
| cumprod(x) | vector containing the product of all of the elements up to that point |
| cummax(x) | vector of non-decreasing numbers that are the cumulative maxima of the values in $x$ up to that point |
| cummin(x) | vector of non-increasing numbers which are the cumulative minima of the values in $x$ up to that point |
| pmax(x, y, z) | vector, of length equal to the longest of $x$, $y$ or $z$, containing the maximum of $x$, $y$ or $z$ for the $i$th position in each |
| pmin(x, y, z) | vector, of length equal to the longest of $x$, $y$ or $z$, containing the minimum of $x$, $y$ or $z$ for the $i$th position in each |

### Lesson 0.5: Stats Primer
There are three ways to calculate mean:
1. Arithmetic mean, <img src="https://render.githubusercontent.com/render/math?math=\bar y">
 - The sum of numbers divided by the count of numbers, given by <img src="https://render.githubusercontent.com/render/math?math=\frac{\sum_{i=1}^{n} y(x_i)}{n}">
 - The most common method for calculating the mean
2. Geometric mean, <img src="https://render.githubusercontent.com/render/math?math=\hat y">
 - The $n$-th root of the product of numbers, given by <img src="https://render.githubusercontent.com/render/math?math=\sqrt[n]{\prod_{i=1}^{n} y(x_i)}">
 - For processes that change multiplicatively rather than additively
3. Harmonic mean, <img src="https://render.githubusercontent.com/render/math?math=\tilde y">
 - The reciprocal of the average of the reciprocals, given by <img src="https://render.githubusercontent.com/render/math?math=\frac{n}{\sum_{i=1}^{n} (1/y(x_i))}">
 - For processes that change rates

Variance is a measure of variability. The variance of a sample is measured as: 
<img src="https://render.githubusercontent.com/render/math?math={\rm variance,}\, \sigma^2 = \frac{\sum_{i=1}^{n} [y(x_i) - \bar y]^2}{n - k}">

Standard deviation is the square root of the variance:
<img src="https://render.githubusercontent.com/render/math?math=\sigma = \sqrt{\sigma^2}">

Standard error demonstrates the unreliability of a process. It is measured about the process mean:
<img src="https://render.githubusercontent.com/render/math?math={\rm s.e.}_{\bar y} = \sqrt{\frac{\sigma^2}{n}}">

Missing vocabulary:  
  * **Sum of Squares**: The measure of the variance of a sample.** 
  * **Degrees of freedom**: The number of independent pieces of information in a sample.

## Feb. 9-11, 2020
### Lessons 1.1: Background 
Missing vocabulary:  
  * **Random (variable)**: A function defined on a sample space, $\Omega$.
  * **Real numbers**: Non-imaginary numbers.
  * **Observation** (of a random variable): <img src="https://render.githubusercontent.com/render/math?math=y=Y(\omega)$ for a given $\omega \in \Omega">. It is a real number.
  * **Stochastic (process)**: A collection of random variables <img src="https://render.githubusercontent.com/render/math?math=\{Y(\omega); \omega \in \Omega \}"> where all random variables are defined on the same sample space.
  * **Time**: A possible measure of a sample space. 
  * **Ensemble**: The name of a stochastic process in which the shared sample space represents time. 
  * **Continuous**: Numbers that are measured across a time interval.
  * **Discrete**: Finite numbers that are determined by counting. 
  * **Realization** (of a time series): The set of values that result from the occurrence of some observed event.
  * **Ensemble**: The collection of all possible realizations, <img src="https://render.githubusercontent.com/render/math?math=\{ x(t) \}">.
  * **Expected value**: The ensemble mean for a stochastic process.
  * **Ordinate**: The vertical axis.
  * **Abscissa**: The horizontal axis. 
  * **Covariance**: Joint variability of two random variables,X(t_1) and X(t_2) for values t_1, t_2 in T.
  * **Autocovariance**: When the covariance is within the same time series.
  * **Autocorrelation**: A correlation coefficient when the correlation is between two values of the same variable.

### Lesson 1.2 Stationary Time Series
Missing vocabulary:  
  * **Stationarity**: The basic behavior of a stationary time series that does not change in time.
  * **Ergodic** (processes): A time series where ensemble averages are consistent with those from a single realization
  * **Strict stationarity**: when for any t_1, t_2 in T, the distributions of $X(t_1$) and $X(t_2)$ must also be the same, and all bivariate distributions <img src="https://render.githubusercontent.com/render/math?math=\{X(t), X(t+h)\}"> must be the same for all values of h. 
  * **Covariance stationarity**: When <img src="https://render.githubusercontent.com/render/math?math=E[X(t)] = \mu"> and is constant for all values of t, <img src="https://render.githubusercontent.com/render/math?math=\mathrm{Var}[X(t)] = \sigma^2 < \infty"> (i.e., is finite for all t), <img src="https://render.githubusercontent.com/render/math?math=\gamma(t_1, t_2)"> depends only on t_2  - t_1, and <img src="https://render.githubusercontent.com/render/math?math=\gamma(h)"> is a semi-definite process (i.e., it's positive or zero for all scalar multiples).


### Lesson 1.2.1: Estimate of the mean  
The sample mean for a single realization is calculated by: 
<img src="https://render.githubusercontent.com/render/math?math=\bar x = \frac{1}{n} \sum_{t=1}^{n} x_t">

### Lesson 1.2.2: Estimate of the autocovariance function  
Missing vocabulary:    
  * **Cauchy-Shwartz inequity**: <img src="https://render.githubusercontent.com/render/math?math=|\gamma(h)| \le \gamma(0)">, for all h.
  * **Sample autocovariance function**: The estimate of the autocovariance function from a single realization that best preserves the overall pattern of the autocovariance function. 

### Lesson 1.2.3: Estimate of the autocorrelation function   
Missing vocabulary: 
  * **Sample autocorrelation function**: The natural estimator for the autocorrelation function.

## Feb. 16-18, 2020  
### Lesson 1.2.4: The frequency domain    
Missing vocabulary:   
  * **Time domain**: The analysis of a time series in reference to time 
  * **Frequency domain**: The analysis of a time series in terms of frequency. 
  * **Hertz**: Standard unit of measurement for frequency. 
  * **Aperiodic**: The definition of a function in which there is no period, p, bigger than 0. 
  * **Spectral density**: The Fourier transformation of the autocorrelation. 
  * **Periodogram**: The fundamental tool of spectral analysis. It is used as an estimate of the spectral density of a signal. 
  * **Decibel**: Standard unit for measuring acoustical energy 
  * **Parzen window**: A probability density function that acts as a method for smoothing the the sample spectrum by implementing a truncation point 

## Feb. 23-25, 2020    
### Lesson 1.2.5: Simulated data  
Missing vocabulary:  
  * **AR(1)**: The first order autoregressive process is the process of using observations from the immediate preceding time step as an input to a regressive model that predicts the value of the next time step. 

### Lesson 1.2.6: Real data  
Studying the periodic nature of data by comparing the realization, sample autocorrelation, periodogram, and parzen window graphs. 
