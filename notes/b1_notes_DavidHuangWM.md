Here are some notes that I took that include relevant information pertaining to ATSA.

- It’s important to figure out the “hows” and the “whys” instead of the results to explain what we depict. 
- We care about time series because of modeling. This modeling is important to us because of the existence of big data and the ability to forecast. 
- We can use pandoc to convert file types to many different other file types. It also includes HTML and LaTeX. 
- RStudio can have markdown code (extension .Rmd), can even run code blocks with Python and other languages in RStudio. 

My notes don't use pandoc. I used my own personal code to render LaTeX. Hope it works. Looks clean to me!
Here's the following:

## General R Introductions

Let's see what version of R we are running.
A quick way of accessing this information is to call the `sessionInfo` function.

To do access the runtime, we use code cells (in opposition of the text cells used to type this content).

You can create a code cell by hovering your mouse between two cells and clicking "+ Code" or clicking the "+ Code" in the menu bar above.
There are also shortcut keys.
Check them out in "Tools" `-->` "Keyboard shortcuts" in the menu above.

One benefit of the cloud-based environment is that there are several packages (i.e., libraries that extend the base R language) already installed and waiting for us to use.

To see the list of installed packages, the aptly named `installed.packages` function is available.

For any packages that exist, you may add them to your runtime by calling them by name with the `library` function.

Try adding some libraries to this runtime.

You can see the version of this package by running the `sessionInfo` function again.

Rather than call it again below, go back to your earlier code cell and re-run it there.
Notice that the runtime counter increments each time a cell is executed.

We can actually also use R as a calculator, with many functions that we would need as shown below:

You can use R as a calculator, including any of R's built-in functions, see the table below.

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

There are also vector functions that are useful in R. Some are listed below: 

There are several vector function available in R.
The table below lists some of them.

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

## 1. An Introduction to _Time Series_

### 1.1 Background
A random variable, <img src="https://render.githubusercontent.com/render/math?math=Y">, is a function defined on a sample space, <img src="https://render.githubusercontent.com/render/math?math=\Omega">, whose range is the real numbers, <img src="https://render.githubusercontent.com/render/math?math={\rm I\!R}">.
An observation of a random variable, <img src="https://render.githubusercontent.com/render/math?math=y=Y(\omega)"> for a given <img src="https://render.githubusercontent.com/render/math?math=\omega \in \Omega">, is also a real number.

A stochastic process is a collection of random variables <img src="https://render.githubusercontent.com/render/math?math=\{Y(\omega); \omega \in \Omega \}"> where all random variables are defined on the same sample space.
When this shared sample space represents time, <img src="https://render.githubusercontent.com/render/math?math=T">, then the stochastic process---which can now be written as <img src="https://render.githubusercontent.com/render/math?math=X(t); t \in T">---is referred to as a time series.

Note that the sample space, <img src="https://render.githubusercontent.com/render/math?math=T">, whose range is the real numbers, may be represented as either continuous, for example <img src="https://render.githubusercontent.com/render/math?math=T = (-\infty, \infty)">, or discrete, for example <img src="https://render.githubusercontent.com/render/math?math=T = \{0, \pm1, \pm2, ...\}">.
A realization of a time series, <img src="https://render.githubusercontent.com/render/math?math=x(t); t \in T">, is the set of values that result from the occurrence of some observed event.
The collection of all possible realizations, <img src="https://render.githubusercontent.com/render/math?math=\{ x(t) \}">, is called the ensemble.

Note that the expected value for a stochastic process is the ensemble mean, <img src="https://render.githubusercontent.com/render/math?math=E[Y(t)]">.
It represents the mean of all realizations at a specified <img src="https://render.githubusercontent.com/render/math?math=t"> and is denoted <img src="https://render.githubusercontent.com/render/math?math=\mu_t">.
It should be pointed out that this type of averaging is along the ordinate (i.e., vertical axis) and is computed across all realizations for a given <img src="https://render.githubusercontent.com/render/math?math=t">. This is in contrast to the more traditional averaging along the abscissa (i.e., horizontal axis), which is computed for all values <img src="https://render.githubusercontent.com/render/math?math=t"> for a given realization.

Of particular interest in time series analysis is the covariance between <img src="https://render.githubusercontent.com/render/math?math=X(t_1)"> and <img src="https://render.githubusercontent.com/render/math?math=X(t_2)"> for values <img src="https://render.githubusercontent.com/render/math?math=t_1, t_2 \in T">.
Because this covariance is within the same time series, it is called autocovariance and is given by the following expression.

<img src="https://render.githubusercontent.com/render/math?math=\gamma(t_1, t_2) = E\{[X(t_1) - \mu(t_1)][X(t_2) - \mu(t_2)]\}">

This definition can be extended to include the autocorrelation of a time series, which is given by the following expression.

<img src="https://render.githubusercontent.com/render/math?math=\rho(t_1, t_2) = \frac{\gamma(t_1, t_2)}{\sigma(t_1)\, \sigma(t_2)}">

where <img src="https://render.githubusercontent.com/render/math?math=\sigma"> is the standard deviation of the ensemble at a given <img src="https://render.githubusercontent.com/render/math?math=t">.

### 1.2 Stationary Time Series
In the study of a time series, it is common that only a single realization from the series is available.
Analysis of a time series on the basis of only one realization is analogous to analyzing the properties of a random variable on the basis of a single observation!

To help us solve this problem, we introduce the concept of stationarity, or the state of "statistical equilibriuim" (i.e., the basic behavior of a stationary time series does not change in time).
Therefore, <img src="https://render.githubusercontent.com/render/math?math=\mu(t)"> does not depend on <img src="https://render.githubusercontent.com/render/math?math=t"> at all, which makes it possible to estimate <img src="https://render.githubusercontent.com/render/math?math=\mu"> (the ensemble mean) from a single realization.

A time series where ensemble averages are consistent with those from a single realization are called ergodic processes.

For a time series, <img src="https://render.githubusercontent.com/render/math?math=\{X(t); t \in T\}"> to be strictly stationary, the following must be true:

* for any <img src="https://render.githubusercontent.com/render/math?math=t_1, t_2 \in T">, the distributions of <img src="https://render.githubusercontent.com/render/math?math=X(t_1">) and <img src="https://render.githubusercontent.com/render/math?math=X(t_2)"> must also be the same
* all bivariate distributions <img src="https://render.githubusercontent.com/render/math?math=\{X(t), X(t+h)\}"> must be the same for all values of <img src="https://render.githubusercontent.com/render/math?math=h">

Adherence to these strict rules is often unlikely to occur.

Rather, we are more likely to come across covariance stationarity (or weak stationarity), which states that the following are true:

* <img src="https://render.githubusercontent.com/render/math?math=E[X(t)] = \mu"> and is constant for all values of <img src="https://render.githubusercontent.com/render/math?math=t">
* <img src="https://render.githubusercontent.com/render/math?math=\mathrm{Var}[X(t)] = \sigma^2 < \infty"> (i.e., is finite for all <img src="https://render.githubusercontent.com/render/math?math=t">)
* <img src="https://render.githubusercontent.com/render/math?math=\gamma(t_1, t_2)"> depends only on <img src="https://render.githubusercontent.com/render/math?math=t_2  - t_1"> (also known as the lag or <img src="https://render.githubusercontent.com/render/math?math=h">)
* <img src="https://render.githubusercontent.com/render/math?math=\gamma(h)"> is a semi-definite process (i.e., it's positive or zero for all scalar multiples)

#### 1.2.1 Estimate of the mean

For a stationary time series, the natural estimate of the common mean, <img src="https://render.githubusercontent.com/render/math?math=\mu">, from a single realization is the sample mean:

<img src="https://render.githubusercontent.com/render/math?math=\bar x = \frac{1}{n} \sum_{t=1}^{n} x_t">

#### 1.2.2 Estimate of the autocovariance function

If a time series is stationary, then the autocovariance function, <img src="https://render.githubusercontent.com/render/math?math=\gamma(t, t+h)">, depends only on <img src="https://render.githubusercontent.com/render/math?math=h">, is abbreviated as <img src="https://render.githubusercontent.com/render/math?math=\gamma(h)">, and has the following properties:

* <img src="https://render.githubusercontent.com/render/math?math=\gamma(0) = \sigma^2"> (prove to yourself that when <img src="https://render.githubusercontent.com/render/math?math=h=0">, autocovariance is equal to variance
* <img src="https://render.githubusercontent.com/render/math?math=|\gamma(h)| \le \gamma(0)"> for all <img src="https://render.githubusercontent.com/render/math?math=h"> (i.e., the Cauchy-Schwartz inequality)
* <img src="https://render.githubusercontent.com/render/math?math=\gamma(-h) = \gamma(h)"> (because autocovariance does not depend on time)

The estimate of <img src="https://render.githubusercontent.com/render/math?math=\gamma(h)"> from a single realization that best preserves the overall pattern of <img src="https://render.githubusercontent.com/render/math?math=\gamma_h">, is given by the following:

<img src="https://render.githubusercontent.com/render/math?math=\hat \gamma_h = \frac{1}{n} \sum_{t=1}^{n-|h|} (X_t - \mu) (X_{t + |h|} - \mu)">

This is only true for values of <img src="https://render.githubusercontent.com/render/math?math=h = 0, \pm 1, \pm 2, ..., \pm (n-1)">.
For values of <img src="https://render.githubusercontent.com/render/math?math=h \ge n">, <img src="https://render.githubusercontent.com/render/math?math=\hat \gamma_h = 0">.
This is known as the sample autocovariance function.

#### 1.2.3 Estimate of the autocorrelation function

The autocorrelation function is given by:

<img src="https://render.githubusercontent.com/render/math?math=\rho(h) = \frac{\gamma(h)}{\sigma^2}">

and has the following properties:

* <img src="https://render.githubusercontent.com/render/math?math=\rho(0) = 1"> (see identity above for <img src="https://render.githubusercontent.com/render/math?math=\gamma(0)">)
* <img src="https://render.githubusercontent.com/render/math?math=|\rho(h)| \le 1"> for all <img src="https://render.githubusercontent.com/render/math?math=h">
* <img src="https://render.githubusercontent.com/render/math?math=\rho(-h) = \rho(h)">
* <img src="https://render.githubusercontent.com/render/math?math=\rho(h)"> is a semi-definite process (i.e., it's positive or zero for all scalr multiples)

The natural estimator for <img src="https://render.githubusercontent.com/render/math?math=\rho(h)"> is

<img src="https://render.githubusercontent.com/render/math?math=\hat \rho_h = \frac{\hat \gamma_h}{\hat \gamma_0}">

This estimator is refered to as the sample autocovariance function.

#### 1.2.4 The frequency domain
In the sections above, we discussed and described time series in terms of their realizations, mean, variance, and autocorrelations. 
These are all aspects of a time domain analysis of time series.

It is often important to examine time series realizations and models from the perspective of their frequency domain.

Frequency, <img src="https://render.githubusercontent.com/render/math?math=f">, measures the number of periods or cycles per sampling unit, that is, <img src="https://render.githubusercontent.com/render/math?math=f"> = 1/period.

If the data are collected annually, monthly, or hourly, the sampling units are 1 year, 1 month, and 1 hour, respectively, and the corresponding frequencies measure the number of cycles per year, month, and hour. 
In the scientific and engineering literature, it is common to measure frequency in Hertz (Hz), which is the number of cycles per second.

We define a function <img src="https://render.githubusercontent.com/render/math?math=g(t)"> as periodic with period (or cycle length) <img src="https://render.githubusercontent.com/render/math?math=p > 0"> if there exists a <img src="https://render.githubusercontent.com/render/math?math=p"> such that <img src="https://render.githubusercontent.com/render/math?math=g(t) = g(t + kp)"> for all <img src="https://render.githubusercontent.com/render/math?math=t"> and integers <img src="https://render.githubusercontent.com/render/math?math=k">.
A function <img src="https://render.githubusercontent.com/render/math?math=g(t)"> is said to be aperiodic if no such <img src="https://render.githubusercontent.com/render/math?math=p"> exists.

Examples of <img src="https://render.githubusercontent.com/render/math?math=g(t)"> and its associated frequencies, <img src="https://render.githubusercontent.com/render/math?math=f">, and periods, <img src="https://render.githubusercontent.com/render/math?math=p">, are shown in the figure below.

![Figure 1.11 Woodward et al. (2007)](https://drive.google.com/uc?export=view&id=1V6CR44Bx4vASnHiGlUVRan_mmqb3qOhF)

When we determine the frequency or cyclic content of data, the relevant information in the autocorrelation is more readily conveyed through the Fourier transform of the autocorrelation, called the spectrum, rather than through the autocorrelation itself.

The spectrum and the autocovariance functions are Fourier transform pairs (i.e., they contain equivalent information about the process).
The autocovariance conveys this information in the time domain while the spectrum expresses the equivalent information in the frequency domain.

The power spectrum may be expressed as:

<img src="https://render.githubusercontent.com/render/math?math=P_x(f) = \sigma^2_x + 2 \sum_{k=1}^{\infty} \gamma_k \cos (2 \pi f k)">

and the spectral density may be expressed as:

<img src="https://render.githubusercontent.com/render/math?math=S_x(f) = 1 + 2 \sum_{k=1}^{\infty} \rho_k \cos(2 \pi fk)">

with the restriction that <img src="https://render.githubusercontent.com/render/math?math=|f| \le 0.5">.

#### 1.2.5 Simulated Data
Consider this process:

$$
X_t = 0.9 X_{t-1} + a_t
$$

This is a first-order autoregressive process, or AR(1), where the dependent variable, $X_t$, is equal to 0.9 times its previous value plus some Gaussian white noise, $a_t$, with zero mean and unit variance.

```R
fig1.18 <- plotts.true.wge(n=250, phi=0.9, lag.max = 30)
```

Notice the rapid oscillations in the realization, but overall it has a wandering type of behavior with no obvious periodic tendency.

We see from the autocorrelations that there is a high correlation when the lag, $k$, is small, but this correlation exponentially dampens to zero.

We see in the spectral density a peak at $f=0$, which indicates little to no periodic behavior.

Consider this AR(1) process:

$$
X_t = -0.9 X_{t-1} + a_t
$$

```R
fig1.19 <- plotts.true.wge(n=250, phi=-0.9)
```

Here we can see from the autocorrelations that they are dampen in an oscillating pattern exponentially toward zero (caused by the negative correlation with the previous time value).

In the spectral density graph, we see a peak at $f = 0.5$, which indicates a high frequency oscillation as we see in the data.

Now let's take a look at an AR(2) model with a period of about 10 units:

$$
X_t = 1.6 X_{t-1} - 0.95 X_{t-2} + a_t
$$

```R
fig1.20 <- plotts.true.wge(n=250, phi=c(1.6, -0.95))
```

Here again we see the oscillating dampening autocorrelation function, albeit more sinusoidal in nature than in the previous example.
We see that there is a period of about 10 from the sinusoidal autocorrelation plot, but it's still difficult to pinpoint the exact period from this because the cycles appear to be slightly different lengths.

The spectral density shows a peak at about $f = 0.09$, indicating a periodic behavoir with a period of about $p$ = 1/0.09 = 11.1.
Notice that there is still frequency information to the left and right of the peak, indicating contributions from nearby frequencies.

Let's look at an AR(4) model with a low frequency of about 30 and a higher frequency of about 3.

$$
X_t = 0.85 X_{t-1} + 0.03 X_{t-2} + 0.745 X_{t-3} -0.828 X_{t-4} + a_t
$$

```R
fig1.21 <- plotts.true.wge(n=250, phi=c(0.85, 0.03, 0.745, -0.828), lag.max=70)
```

Again in the autocorrelation we can see evidence of the lower frequency from the sinusoidal oscillations; however, there is little evidence of a higher frequency.

The spectral density clearly shows two frequencies in the data: one at $f = 0.04$ and one at $f = 0.34$.

This highlights how spectrum can detect the presence of cycles in data that are otherwise hidden in the autocorrelation even though both equations mathematically contain the same information.

**Finally**, let example white noise:

$$
X_t = a_t
$$

Here the autocorrelation function is zero for all lags except $k=0$ where the autocorrelation is 1 and the spectrum is zero for all frequencies.

```R
# Simulate white noise
wn <- arima.sim(model = list(order=c(0,0,0)), n = 250)
plot.ts(wn)

par(mfrow = c(2,1))
spectrum(wn)
acf(wn)
```

#### 1.2.6 Real Data

**Sunspot data (`ss08`)**

One of the most intriguing time series data sets is that of sunspot data.
Sunspots are areas of solar explosions or extreme atmospheric disturbances on the sun. 
Sunspots have created much interest among the scientific community partially because of the fact that they seem to have some effect here on Earth. 
For example, high sunspot activity tends to cause interference with radio communication and to be associated with higher ultraviolet light intensity and northern light activity. 
Other studies have attempted to relate sunspot activity to precipitation, global warming, etc., with less than conclusive results. 
In 1848, the Swiss astronomer Rudolf Wolf introduced a method of enumerating daily sunspot activity, and monthly data using his method are available since 1749. 
See Waldmeier (1961) and various Internet sites.

```R
data(ss08)
ss.data <- plotts.sample.wge(ss08)
```

The sunspot data reveal a pseudo-periodic nature, where there is an indication of a period somewhere between 9 and 11 years.
In the spectral density, we notice a reasonably sharp peak at approximately $f$ = 0.09 indicating a predominant period of about 11 years in the data.
It is also interesting to note that there is also a peak at $f$ = 0 indicating possibly a longer period or aperiodic behavior.

**Global temperature data** (`hadley`)

The concern over global warming has attracted a great deal of attention over the past 25 years. 
Of interest are data sets that provide a measure of the average annual temperature. 
One such data set was collected in England by the Climatic Research Unit at the University of East Anglia in conjunction with the Met Office Hadley Centre.

```R
data(hadley)
had.data <- plotts.sample.wge(hadley, lag.max = 80)
```

In the data set, it is clear that there has been a rise in temperatures over this period. 
There is also considerable year to year variability but no apparent cyclic behavior.
We see that the autocorrelations for the lower lags are positive indicating that, for example, there is substantial positive correlation between this year's and next year's annual temperatures.

The smoothed sprectrum also suggests the lack of periodic behavior. 
The peak at $f$ = 0 suggests either a very long period or aperiodic behavior.
The smaller peaks in the spectral estimator may or may not be meaningful.

**Airline data** (`airlog`)

The following is a graph of the natural logarithms of monthly total numbers (in thousands) of passengers in international air travel for 1949&ndash;1960.
This series is examined by Box et al. (2008) and in earlier editions of that text and is often analyzed as a classical example of a seasonal time series. 
A strong seasonal pattern is expected due to the seasonal nature of air travel, for example, heavier travel in the summer months and in November and December.

```R
data(airlog)
air.data <- plotts.sample.wge(airlog, lag.max = 80, trunc = 90)
```

An inspection of the data shows the heavier summer travel, a 12 month annual pattern, and an apparent upward trend. 
Note that the 12 month cycle does not appear to be sinusoidal but rather tends to "copy" the pattern of the previous year.

Note the high power at zero indicating the strong trend (aperiodic) component in the data. 
In addition, the high power at $f$ = 1/12 and at the harmonics of 1/12, that is, $f$ = $i$/12 for $i$ = 2, 3, ..., 6 are quite apparent.

**Bat echolocation signal** (`noctula`)

Below are 96 observations taken from a echolocation signal of a Nyctalus noctula hunting bat sampled at $4 \times 10^{-5}$ s intervals. 
At first glance, the signal appears to be periodic with behavior somewhat similar to the sunspot data.

```R
data(noctula)
noc.data <- plotts.sample.wge(noctula, lag.max = 50)
```

The sample autocorrelations seem unusual, since there is no strong cyclic behavior and examination of the spectral estimate shows no sharp peak; in fact, there is a wide band of frequencies between $f$ = 0.15 and $f$ = 0.35 associated with a broad "peak" (also called a spread spectra).

It appears that the frequency behavior is changing with time. 
More specifically, the cycle lengths tend to lengthen (frequencies decrease) in time and, consequently, it appears that the data may not be stationary.

