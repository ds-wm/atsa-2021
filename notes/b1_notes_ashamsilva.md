# Block 1: Notes
#### Asha Silva
#### GoogleColab Link for notes: https://colab.research.google.com/drive/1tSuPduID16wYuqxAx_toHsf1FCdEs3QR?usp=sharing
Formulas are easier to read in the GoogleColab version
### Basics

Why is Time Series Important?

1. Data Science is a field designed to find patterns within data.
2. Time Series is a unique type of data.
3. We can utilize tools to find patterns in the time series.

We use time series data for both modeling and forcasting.

Good to Know: The Four V's of Big Data are Volume, Velocity, Variety, and Veracity (Truth)

Check session info:
```
sessionInfo()
```

How to save Rhistory File
```
savehistory(file = "filename.Rhistory")
```

Install a package: this only needs to be done once if you are in RStudio (desktop)
```
installed.packages("package_name")
```

Load a package:
```
library("package_name")
```

Install and load textbook package
```
install.packages("tswge")
library("tswge")
```

Get help on what a package does:
```
help("package_name")
```

#### Background : General code and math functions in R

Exponential functions
```
2^3
2**3
```

Scientific notation
```
8.6e3
```

Integer quotients
```
150 %/% 4
```

Integer remainder
```
150 %% 4
```

Check if a number is NaN
```
is.na(0/0)
```

na.rm = TRUE will remove na from the vector
IMPORTANT: NA != NaN
```
mean(c(0:10, NA), na.rm = TRUE)
```

Create a vector 
>remember that R is 1 indexed, not 0 like Python

```
assignment <- c(8:60)
assignment[1]
```

You can index based on mathematical conditions
```
assignment[assignment > 55]
```

**Operation in R:	Meaning**

log(x):	log to base  𝑒  of  𝑥 

exp(x):	antilog of  𝑥 , (i.e.  𝑒𝑥 )

log(x, n):	log to base  𝑛  of  𝑥 

log10(x):	log to base 10 of  𝑥 

sqrt(x):	square root of  𝑥 

factorial(x):	 𝑥! 

choose(n,x):	binomial coefficients  𝑛!/(𝑥!(𝑛−𝑥)!) 

gamma(x):	 Γ(𝑥) , for real  𝑥(𝑥−1)! , for integer x

lgamma(x):	natural log of  Γ(𝑥) 

floor(x):	greatest integer  <𝑥 

ceiling(x):	smallest integer  >𝑥 

trunc(x):	closest integer to  𝑥  between  𝑥  and 0

round(x, digits=0):	round the value of  𝑥  to an integer

signif(x, digits=6):	give  𝑥  to six digits in scientific notation

runif(n):	generates  𝑛  random numbers between 0 and 1 in uniform distribution

cos(x):	cosine of  𝑥  in radians

sin(x):	sine of  𝑥  in radians

tan(x):	tangent of  𝑥  in radians

acos(x), asin(x), atan(x):	inverse trigonometric transformations of real or 
complex numbers

acosh(x), asinh(x), atanh(x):	inverse hyperbolic trigonometric transformations of real or complex numbers

abs(x):	the absolute value of  𝑥  ignoring the minus sign if there is one

#### Formulas

Arithmetic Mean: $\bar y$ = $\frac{\sum_{i=1}^{n} y(x_i)}{n}$ 

Geometric Mean: $\hat y$ = $\sqrt[n]{\prod_{i=1}^{n} y(x_i)}$

Harmonic mean, $\tilde y$ = $\frac{n}{\sum_{i=1}^{n} (1/y(x_i))}$

${\rm Variance:}\, \sigma^2 = \frac{\sum_{i=1}^{n} [y(x_i) - \bar y]^2}{n - k} 
$

Standard Deviation: $\sigma$ 

## Section 0

NOTE: you can access GoogleColab in R by going to http://colab.to/r

### Blanks 

0.2 Blanks:
This allows you to access a Linux **runtime** with a particular **kernel** loaded. In our case, the kernel is providing us with some basic computation software.

0.5.2 Blanks:
sum of squares 
degrees of freedom 

### Plot a time series - code

```
# Create a sequence to 100 and scale values to (0, 25)
t <- c(0:100)
t <- t * 25/100

# Define the time series
Yt1 <- sin(t)
Yt2 <- sin(t + pi/2)
EYt <- (Yt1 + Yt2)/2


# Plot our time series
plot(
  t,                          # x values
  Yt1,                        # y values
  main = "Example Time Series",
  # sub = "By Professor Davis",
  ylim = c(-1.1, 1.25),       # limit to plot in y-axis (ymin, ymax)
  type = "l",                 # type line "l", "p", "o"
  col = "red",                # color code
  lwd = 1,                    # line width 
  lty = 1,                    # line type 1: solid, 2: dashed, 3: dotted 
  xlab = "Time", 
  ylab = NA
)

lines (
  t, 
  Yt2,
  col = "blue",
  lwd = 1,
  lty = 2
)

legend(
  "top",                      # location of legend
  inset=0.01,                 # buffer around the legend 
  col=c("red","blue"), 
  lty=c(1,2), 
  lwd=c(1,1), 
  legend = c(
    expression(sin(t)),
    expression(sin(t+pi/2))), 
  bg="white",
  box.col="white",
  horiz=TRUE                  # horizontal stack verses vertically
)
```

## Section 1.1

### 1.1 Vocabulary

Random Variable: 
*   A **RANDOM** variable, $Y$, is a function defined on a sample space, $\Omega$, whose range is the **REAL NUMBERS**, ${\rm I\!R}$.
An **OBSERVATION** of a random variable, $y=Y(\omega)$ for a given $\omega \in \Omega$, is also a real number.

Stochastic Process: 
*   **STOCHASTIC** process is a collection of random variables $\{Y(\omega); \omega \in \Omega \}$ where all random variables are defined on the same sample space.
When this shared sample space represents **TIME**, $T$, then the stochastic process---which can now be written as $X(t); t \in T$---is referred to as a **TIME SERIES**.

Continuous or Discrete:
*   The sample space, $T$, whose range is the real numbers, may be represented as either **CONTINUOUS**, for example $T = (-\infty, \infty)$, or **DISCRETE**, for example $T = \{0, \pm1, \pm2, ...\}$.

Realization:
*   A **REALIZATION** of a time series, $x(t); t \in T$, is the set of values that result from the occurrence of some observed event.

Ensemble:
*   The collection of all possible realizations, $\{ x(t) \}$, is called the **ENSEMBLE**.

Expected Value:
*   The **EXPECTED VALUE** for a stochastic process is the ensemble mean, $E[Y(t)]$. It represents the mean of all realizations at a specified $t$ and is denoted $\mu_t$.
*   This type of averaging is along the **ORDINATE** (i.e., vertical axis) and is computed across all realizations for a given $t$. 
*   This is in contrast to the more traditional averaging along the **ABSCISSA** (i.e., horizontal axis), which is computed for all values $t$ for a given realization.

Covariance, Autocovariance, and Autocorrelation:
*   In time series analysis the **COVARIANCE** between $X(t_1)$ and $X(t_2)$ for values $t_1, t_2 \in T$ is important
*   Because this covariance is within the same time series, it is called **AUTOCOVARIANCE** and is given by the following expression.
$$
\gamma(t_1, t_2) = E\{[X(t_1) - \mu(t_1)][X(t_2) - \mu(t_2)]\}
$$
*   We can elaborate the equation to include the **AUTOCORRELATION** of a time series, which is given by the following expression. ($\sigma$ is the standard deviation of the ensemble at a given $t$.)
$$
\rho(t_1, t_2) = \frac{\gamma(t_1, t_2)}{\sigma(t_1)\, \sigma(t_2)}
$$

### 1.1 Formulas

Ensemble Mean: $E[Y(t)]$

Autocovariance: $\gamma(t_1, t_2) = E\{[X(t_1) - \mu(t_1)][X(t_2) - \mu(t_2)]\}$

Autocorrelation: $\rho(t_1, t_2) = \frac{\gamma(t_1, t_2)}{\sigma(t_1)\, \sigma(t_2)}$

## Section 1.2

### 1.2 

**STATIONARITY**: The state of "statistical equilibriuim" - The basic behavior of a stationary time series does not change in time).
*   $\mu(t)$ does not depend on $t$ 
*   Makes it possible to estimate $\mu$ ( ensemble mean) from a single realization.

**ERGODIC** Processes: A time series where ensemble averages are consistent with those from a single realization

For a time series, $\{X(t); t \in T\}$ to be **STRICTLY STATIONARY**, the following must be true:
* for any $t_1, t_2 \in T$, the distributions of $X(t_1$) and $X(t_2)$ must also be the same
* all bivariate distributions $\{X(t), X(t+h)\}$ must be the same for all values of $h$

Because it is so hard to meet all the above rules, we must commonly use **COVARIANCE STATIONARITY** (or weak stationarity), which states that the following are true:

* $E[X(t)] = \mu$ and is constant for all values of $t$
* $\mathrm{Var}[X(t)] = \sigma^2 < \infty$ (i.e., is finite for all $t$)
* $\gamma(t_1, t_2)$ depends only on $t_2  - t_1$ (also known as the lag or $h$)
* $\gamma(h)$ is a semi-definite process (i.e., it's positive or zero for all scalar multiples)

#### 1.2.1 Estimate of the mean

For a stationary time series, the sample mean is the natural estimation of $\mu$ from a single realization.
$$
\bar x = \frac{1}{n} \sum_{t=1}^{n} x_t
$$

#### 1.2.2 Estimate of the autocovariance function

Autocovariance function: $\gamma(t, t+h)$, 
If the time series is stationary then it depends only on $h$, and can be written as: $\gamma(h)$

It has the following properties:

* $\gamma(0) = \sigma^2$ (prove to yourself that when $h=0$, autocovariance is equal to variance
* $|\gamma(h)| \le \gamma(0)$ for all $h$ (i.e., the **CAUCHY=SCHWARTZ INEQUALITY**)
* $\gamma(-h) = \gamma(h)$ (because autocovariance does not depend on time)

The estimate of $\gamma(h)$ from a single realization that best preserves the overall pattern of $\gamma_h$
$$
\hat \gamma_h = \frac{1}{n} \sum_{t=1}^{n-|h|} (X_t - \mu) (X_{t + |h|} - \mu)
$$

IMPORTANT NOTE: This is only true for values of $h = 0, \pm 1, \pm 2, ..., \pm (n-1)$.
For values of $h \ge n$, $\hat \gamma_h = 0$.
This is known as the **SAMPLE AUTOCOVARIANCE FUNCTION**.

#### 1.2.3 Estimate of the autocorrelation function

The autocorrelation function is given by:

$$
\rho(h) = \frac{\gamma(h)}{\sigma^2}
$$

and has the following properties:

* $\rho(0) = 1$ (see identity above for $\gamma(0)$)
* $|\rho(h)| \le 1$ for all $h$
* $\rho(-h) = \rho(h)$
* $\rho(h)$ is a semi-definite process (i.e., it's positive or zero for all scalr multiples)

The natural estimator for $\rho(h)$ is

$$
\hat \rho_h = \frac{\hat \gamma_h}{\hat \gamma_0}
$$

This estimator is refered to as the **SAMPLE AUTOCOVARIANCE FUNCTION**.


#### 1.2.4 The frequency domain
Realizations, mean, variance and autocorrelations are all aspects of a **TIME DOMAIN** analysis of time series.
 
**FREQUENCY DOMAIN**:
Frequency, $f$, measures the number of periods or cycles per sampling unit ($f$ = 1/period). It is common to measure frequency in **HERTZ** (Hz), which is the number of cycles per second.

Example of period sampling units
*   data collected annually: 1 year
*   data collected monthly: 1 month
*   data collected hourly: 1 hour

Corresponding frequencies measure number of cycles within a given year, month, hour

$g(t)$ is a periodic function with a period (or cycle length) $p > 0$ if a $p$ exists such that $g(t) = g(t + kp)$ for all $t$ and integers $k$.

The function $g(t)$ is said to be **APERIODIC** if no such $p$ exists.

Examples of $g(t)$ and its associated frequencies, $f$, and periods, $p$, can be found at the link below:

[Figure 1.11 Woodward et al. (2007)](https://drive.google.com/uc?export=view&id=1V6CR44Bx4vASnHiGlUVRan_mmqb3qOhF)

When we determine the frequency or cyclic content of data, the relevant information in the autocorrelation is more readily conveyed through the Fourier transform of the autocorrelation, called the **SPECTRAL DENSITY**, rather than through the autocorrelation itself.

The spectrum and the autocovariance functions contain equivalent information about the process (ie. Fourier transform pairs).
>The autocovariance conveys this information in the time domain.
>The spectrum expresses the equivalent information in the frequency domain.

For a discrete time series, $\{X(t); t \in T\}$, the power spectrum, $P_X$ may be estimated by the following:

$$
\hat P_X(f) = \hat\sigma^2_X + 2 \sum_{k=1}^{n-1} \hat\gamma_k \cos (2 \pi f k)
$$

for $|f| \le 0.5$.
The spectral density, $S_X$, may be estimated using:

$$
\hat S_X(f) = 1 + 2 \sum_{k=1}^{n-1} \hat\rho_k \cos(2 \pi fk)
$$

where:

- $f$ is the frequency
- $k$ is the lag (integer for a discrete time series)
- $\hat\sigma^2_X$ is the sample variance of the discrete time series, $X$
- $\hat\gamma_k$ is the sample autocovariance of time series $X$ for a lag of $k$
- $\hat\rho_k$ is the sample autocorrelation of time series $X$ for a lag of $k$

**PERIODOGRAM**: the fundamental tool of spectral analysis  
* Based on the squared correlation between the time series and the frequency, $f$ 
* Displays exactly the same information as the autocovariance function.
* Used as an estimate of the spectral density of a signal.





#### 1.2.5 Simulated Data


Consider this process:
$X_t = 0.9 X_{t-1} + a_t$

This is a first-order autoregressive process, or **AR(1)**, where the dependent variable, $X_t$, is equal to 0.9 times its previous value plus some Gaussian white noise ($a_t$) with zero mean and unit variance.


*   No obvious periodic tendency.
*   Strong correlation when the lag (k) is small.
*   Correlation decreases towards zero with little correlation past lag 25.
*   Spectral density peak at $f$ = 0 which indicates no periodic behavior

```
fig1.18 <- plotts.true.wge(n=250, phi=0.9, lag.max = 30)
```

Consider this AR(1) process: $X_t = -0.9 X_{t-1} + a_t$

*   Autocorrelations in an oscillating patter exponentially towards zero.
*   Spectral peak at $f$ = 0.5 : indicated high frequency oscillation

```
fig1.19 <- plotts.true.wge(n=250, phi=-0.9)
```

Consider this AR(2) model with a period of ~10 units: $X_t = 1.6 X_{t-1} - 0.95 X_{t-2} + a_t$

* Observed oscillating dampening autocorrelation function (more sinusoidal than in the previous example)
* Period of about 10 determined from the sinusoidal autocorrelation plot, 
>  difficut to determine the exact period from this because the cycles appear to be slightly different lengths
* Spectral density shows a peak at about $f = 0.09$
> indicates periodic behavoir with a period of $p$ = 1/0.09 = 11.1.

Note: there is still frequency information to the left and right of the peak, indicating contributions from nearby frequencies.


```
fig1.20 <- plotts.true.wge(n=250, phi=c(1.6, -0.95))
```

Consider this AR(4) model with a low frequency of ~30 and a higher frequency of ~3: $X_t = 0.85 X_{t-1} + 0.03 X_{t-2} + 0.745 X_{t-3} -0.828 X_{t-4} + a_t$

* From the autocorrelation we can see lower frequency from the sinusoidal oscillations (there is little evidence of a higher frequency)
* Spectral density shows two frequencies in the data: one at $f = 0.04$ and one at $f = 0.34$.

This example highlights how spectrum can detect the presence of cycles in data that are otherwise hidden in the autocorrelation.

```
fig1.21 <- plotts.true.wge(n=250, phi=c(0.85, 0.03, 0.745, -0.828), lag.max=70)
```

### 1.2 Formulas

Sample Mean:  $$\bar x = \frac{1}{n} \sum_{t=1}^{n} x_t$$

Estimate of $\gamma(h)$ (values of $h = 0, \pm 1, \pm 2, ..., \pm (n-1)$
> > > > > > and 

Sample Autocovariance Function (values of $h \ge n$, $\hat \gamma_h = 0$):
$$\hat \gamma_h = \frac{1}{n} \sum_{t=1}^{n-|h|} (X_t - \mu) (X_{t + |h|} - \mu)$$

Autocorrelation function:
$\rho(h) = \frac{\gamma(h)}{\sigma^2}$

* Autocorrelation function properties:
> * $\rho(0) = 1$ (see identity above for $\gamma(0)$)
> * $|\rho(h)| \le 1$ for all $h$
> * $\rho(-h) = \rho(h)$
> * $\rho(h)$ is a semi-definite process (i.e., it's positive or zero for all scalr multiples)

Natural Estimator for $\rho(h)$:

$$\hat \rho_h = \frac{\hat \gamma_h}{\hat \gamma_0}$$

Power Spectrum, $P_X$ (Discrete Time Series):
$$
\hat P_X(f) = \hat\sigma^2_X + 2 \sum_{k=1}^{n-1} \hat\gamma_k \cos (2 \pi f k)
$$

Spectral Density, $S_X$ (If $|f| \le 0.5$):
$$
\hat S_X(f) = 1 + 2 \sum_{k=1}^{n-1} \hat\rho_k \cos(2 \pi fk)
$$

## Additional Resources
Autocovariance, Autocorrelation, and Stationarity:
https://www.stat.berkeley.edu/~bartlett/courses/153-fall2010/lectures/4.pdf

Discrete Time Series:
http://www2.stat.duke.edu/~cr173/Sta444_Sp17/slides/Lec6.pdf

Autoregressive model:
https://online.stat.psu.edu/stat501/lesson/14/14.1
