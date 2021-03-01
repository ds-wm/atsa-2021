Here are some notes that I took that include relevant information pertaining to ATSA.

- It’s important to figure out the “hows” and the “whys” instead of the results to explain what we depict. 
- We care about time series because of modeling. This modeling is important to us because of the existence of big data and the ability to forecast. 
- We can use pandoc to convert file types to many different other file types. It also includes HTML and LaTeX. 
- RStudio can have markdown code (extension .Rmd), can even run code blocks with Python and other languages in RStudio. 

My notes don't use pandoc. I used my own personal code to render LaTeX. Hope it works. Looks clean to me!
Here's the following:

## 1. Introduction to Time Series

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

When we determine the frequency or cyclic content of data, the relevant information in the autocorrelation is more readily conveyed through the Fourier transform of the autocorrelation, called the <img src="https://render.githubusercontent.com/render/math?math=\underline{\qquad}">, rather than through the autocorrelation itself.

The spectrum and the autocovariance functions are Fourier transform pairs (i.e., they contain equivalent information about the process).
The autocovariance conveys this information in the time domain while the spectrum expresses the equivalent information in the frequency domain.

The power spectrum may be expressed as:

<img src="https://render.githubusercontent.com/render/math?math=P_x(f) = \sigma^2_x + 2 \sum_{k=1}^{\infty} \gamma_k \cos (2 \pi f k)">

and the spectral density may be expressed as:

<img src="https://render.githubusercontent.com/render/math?math=S_x(f) = 1 + 2 \sum_{k=1}^{\infty} \rho_k \cos(2 \pi fk)">

with the restriction that <img src="https://render.githubusercontent.com/render/math?math=|f| \le 0.5">.
