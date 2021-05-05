# Block 3: Modeling and Predicting

Katherine Lannen

## General Outline of Class Days:
| Date | What We Did |
|--|--|
| 4/8 | Learned about Seasonality and started exercise 3.1 |
| 4/15 | Covered moving average and autoregressive processes |
| 4/20 | Went over estimating model parameters for MA and AR models and their applications in R |
| 4/27 | Discussion about filters and started activity using linear filters |
| 4/29 | Go over Exam 3 problems, continue working in breakout rooms on the activity |
| 5/4 |  Go into breakout rooms to work on Lab 3 and Exam 3|

## Detrending

Often times we find that the time series data we are working with has some type of trend, an example of which being evident in the latter portion of the air temperature dataset over the Met Office's Hadley Center.

Before analyzing a time series, it's a good idea to detrend your datasets. We can detrend the data by subtracting the fitted values from the linear regression.

Detrending your dataset is beneficial as it maintains the assumption of a mean of 0 that a lot of models make. 

## Seasonality

Many time series applications involve data that exhibit seasonal cycles.
The commonest applications involve weather data.

The equation for the seasonal cycle is (Crawley, 2007):

$y_t = \beta_0 + \beta_1 \sin (2 \pi \, t) + \beta_2 \cos (2 \pi \, t) + \alpha_t$

where $\beta$ are coefficients (including the intercept) and $\alpha_t$ is a white noise process.

It is sometimes helpful to perform a seasonal **decomposition** of a time series into its seasonal, trend and irregular components. In R, this is accomplished using the stl function, which the seasonal decomposition of time series using **Loess** (a locally weighted polynomial regression). One catch to using the stl function is that the input must first be converted to a ts object.

## Moving Average

A moving average (MA) process of order *q*, or more succinctly MA(*q*), may be expressed as a discrete time series, $X(t)$ with mean $\mu$, by the following equation.

$X_t - \mu = a_t - \theta_1 a_{t-1} - ... - \theta_q a_{t-q}$

where the $\theta$ values are real numbers and $a_t$ is a white noise process with zero mean and unit variance.

Note that an MA(*q*) process is a general linear process with a finite number of terms.
From this we can calculate the variance of our time series:

$\sigma^2_x = \sigma^2_a \left(1 + \theta^2_1 + ... + \theta^2_q  \right)$

as well as the autocovariance for lag *k*:

$\begin{align}
\gamma_k &= \sigma^2_a \left[ -\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k}  \right],\, &k = 1,2,..,q \\
&= 0,\, &k>q
\end{align}$

and the autocorrelation for lag *k*:

$\begin{align}
\rho_k &= \frac{-\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k}}{1 + \sum_{j=1}^{q} \theta^2_j}, \, &k=1,2,..,q \\
&= 0,\, &k > q
\end{align}$

**The MA(1) Model**

Let $q = 1$ in our definition above and we get:

$X_t - \mu = a_t - \theta_1 a_{t-1}$

Notice that as $\theta_1 \rightarrow 0$, the MA(1) process approaches white noise.

Let's simulate two example MA(1) time series realizations.

First up is:

$X_t = a_t - 0.99\, a_{t-1}$

**The MA(2) Model**

Let $q=2$ in our definition above such that we get:

$X_t = a_t - \theta_1\, a_{t-1} - \theta_2\, a_{t-2}$

Let's simulating an example realization:

$X_t = a_t + 0.2\, a_{t-1} - 0.48\, a_{t-2}$

**Three Point MA**

The simplest way of seeing a pattern in a time series is to plot the moving average and one useful summary statistic to have on hand is the three-point moving average:

${X_t}' = \frac{X_{t-1} + X_{t} + X_{t+1}}{3}$

In R, this can be expressed as:

```r
#####################################################
# Name:      ma2
# Inputs:    numeric vector (x)
# Outputs:   numeric vector of 3-point MA
# Features:  Returns the 3-point MA for values in x
# Reference: Crawley (2007)
#####################################################
ma3 <- function(x) {
  y <- numeric(length(x) - 2)
  for (i in 2:(length(x)-1)) {
    y[i]<-(x[i-1] + x[i] + x[i+1])/3
  }
  y
}
```

Note that a moving average can never capture the maxima or minima of a series (because they are averaged away). Note also that the three-point moving average is undefined for the first and last points in the series.

MA ignores the first and last points in the time series and assumes a negative before the coefficient.

## Autoregressive

The autoregressive (AR) process of order *p*, or more succinctly AR(*p*), may be expreesed as a discrete time series, $X_t$ with mean $\mu$, by the following equation.

$X_t - \mu - \phi_1 (X_{t-1} - \mu) - \phi_2 (X_{t-2} - \mu) - ... - \phi_p (X_{t-p} - \mu) = a_t$

where $a_t$ be a white noise process with zero mean and unit variance and $\phi_1, \phi_2, ..., \phi_p$ are real constants.

Oftentimes, we assume the time series has $\mu = 0$, which simplifies the expression to:

$X_t - \phi_1\, X_{t-1} - \phi_2\, X_{t-2} - ... - \phi_p\, X_{t-p} = a_t$

The above equation has an uncountable number of solutions; however, if we impose our stationarity requirement, we can derive a solution.

**The AR(1) Model**

Let $p = 1$ in the equation above, such that:

$X_t - \phi_1\, X_{t-1} = a_t$

where $|\phi_1| \le 1$ (a requirement for stationarity).
The $\psi$ weights and stationary conditions for the AR(1) process are such that:

$X_t = \sum_{k=0}^\infty {\phi_1}^k\, a_{t-k}$

which gives way to the **characteristic equation**:

$1 - \phi_1\, r = 0$

that has a single root:

$r_1 = \frac{1}{\phi_1}$

The autocovariance is given generally by:

$\gamma_k = {\phi_1}^{|k|}\, \gamma_0$

where $\gamma_0 = \sigma_a^2\,(1-\phi_1^2)^{-1}$
and the autocorrelation is given by:

$\rho_k = {\phi_1}^{|k|}$

Let's take a look at two realizations.

First up is:

$X_t - 0.95\, X_{t-1} = a_t$

ar.ts1 <- plotts.true.wge(100, phi=c(0.95), theta=c(0), lag.max = 40)

The plot of this realization shows a tendency for observations to remain positively correlated across several lags resulting in several lengthy runs or a wandering behavior.

The autocorrelations for this realization show that there is strong positive correlation between adjacent observations.
This suggests that this realization should exhibit a tendency for $x_{t+1}$to be fairly close to $x_t$.
We can see that this positive correlation holds up for a long time.
As indicated in the equation above, notice that $\rho_{10} = 0.95^{10} \approx 0.6$.
This persistence of the correlation when $\phi_1 \approx 1$ is refered to as **near  nonstationarity**.


From the periodogram, it can be seen that when $\phi_1 > 0$, the spectral density has a peak at $f$= 0, indicating that the associated realizations will tend to wander about the mean with no distinct periodic behavior.
That is, the data are primarily low frequency with no real periodic tendency.

Next, let's look at a realization of the following AR(1) process:

$X_t + 0.7\, X{t-1} = a_t$

ar.ts2 <- plotts.true.wge(100, phi=c(-0.7), theta=c(0), lag.max = 40)

As expected, this realization has an oscillatory nature associated with negative $\phi_1$.
As $\phi_1 \rightarrow 0$, the AR(1) approaches white noise, so that realizations with $\phi_1 \approx 0$ can be expected to look much like white
noise.

We see that the autocorrelations for negative values of $\phi_1$ show an oscillating behavior.
In other words, $\rho_1 = -0.7$ indicates that if a value at time $t$ is above the mean then the value at time $t + 1$ will tend to be below the mean, and vice versa.
Similarly, $\rho_2 = (-0.7)^2 = 0.49$, then the value at $t+2$ will tend to be on the same size of the mean as the value at time $t$.
The dampening effect of the smaller magnitude of $\phi_1$ is evident when compared to the previous realization with $\phi_1 = 0.95$.

The spectral density for $\phi_1 < 0$ has a maximum at f = 0.5, indicating that the data will tend to have a highly oscillatory nature with period of about 2.

## Estimating Model Parameters

Suppose a realization $x_1$, $x_2$, ..., $x_n$ is observed.
The problem of fitting an ARMA(p,q) model to the data is the problem of estimating:

- $p$, $q$
- $\phi_1$, $\phi_2$, ..., $\phi_p$
- $\theta_1$, $\theta_2$, ..., $\theta_q$
- $\mu$, ${\sigma_a}^2$

The estimation of $p$ and $q$ is called **order identification**.
An analysis of a time series using an ARMA model (i.e., a process that is the combination of AR(p) and MA(q) models) will typically first involve order identification followed by parameter estimation.
The dichotomy between the order identification and parameter estimation steps is not clear-cut since the order identification techniques usually involve some parameter estimation as a means of selecting the appropriate model orders.

In practice, parameter estimation is almost always accomplished using a time series package.

There are two basic types of estimators (assuming that the order of the model is already known):

1. Preliminary Estimators 
  * relatively easy and fast to compute
2. Maximum Likelihood Estimators
  * iterative and (generally) computationally expensive
  
### MA(q) Estimators

In general, MA(q) parameter estimation is more difficult that AR(p) parameter estimation.

The following are estimator methods for determining parameters for the MA(q) models.
The first two methods, the **Methods of Moments** and the **Innovations Algorithm** are preliminary estimators.

1. Method of Moments
  * Parameters ($\theta_1$, $\theta_2$, ..., $\theta_q$) are solved based on a series on non-linear equations that relate the MA(q) model to the autocorrelation function.
  * Real solutions may not exist.
  * This method (in general) is not recommended.
2. Innovations Algorithm
  * Based on recursive fitting of MA models of increasing order until estimates of $\theta_1$, $\theta_2$, ..., $\theta_q$ stabilize.
3. Maximum Likelihood

### AR(p) Estimators

For AR(p) models, there are two basic preliminary methods:

1. Yule-Walker Estimators (a method of moments estimation)
  * Based on the Yule-Walker equations; most importantly is the difference equation that relates the coefficients in the AR(p) model to the autocorrelation function:
    $$
    \rho_k = \phi_1 \ \rho_{k-1} + ... + \phi_p \ \rho_{k-p}
    $$
  * Substituting estimates of autocorrelations, $\hat\rho_k$, produces a set of linear equations that may be solved for $\hat\phi_1$, $\hat\phi_2$, ..., $\hat\phi_p$.
  * Requires inverting 
  * Estimates produce a stationary process.
2. Ordinary-Least Squares Estimators (the Burg method)
  * Based on minimizing the cost function, $S_c$
    $$
    S_c = \sum_{t=p+1}^{n} {\hat a_t}^2
    $$
  * Non-traditional OLS method ($X_t$ and $\mu$ are simultaneously playing the role of dependent and independent variables and predictors are correlated); thus, cannot be solved using a standard OLS package.
  * Ignores data $X_1$ to $X_p$ (because $X_{t-p}$ is undefined).
  * Improved upon by Ulrych & Clayton (1976), who argued no preference in the direction of time (i.e., the driving process forward is the same process driving backward)---created the Forward-Backward Least Squares (FBLS) method:
    $$
    S_c = \sum_{t=p+1}^{n} {\hat a_t}^2 + \sum_{t=1}^{n-p} {\delta_t}^2
    $$
    where $\delta_t$ are white noise with zero mean and variance, ${\sigma_a}^2$.
  * Burg (1975) decided to use the Durbin-Levinson algorithm to minimimze this cost function and thus guarantee a resulting process that is stationary.
3. Maximum Likelihood

### Maximum Likelihood Estimator

Much work has been done recently by statisticians on the problem of obtaining maximum likelihood (ML) estimates of the parameters due to their well-known optimality properties. 
ML estimation of the ARMA(p,q) parameters involves iterative procedures that require starting values.

The log-likelihood function is given by:

$$
l(\phi_1, ..., \phi_p, \theta_1, ..., \theta_q) = -\frac{n}{2} \ln \left( 2\, \pi\, \sigma_a^2 \right) + \frac{1}{2} \ln | M_p | - \frac{S_u}{2\, \sigma_a^2}
$$

where $S_u$ is the unconditional sum of squares.
The solution of $\phi_1$, ..., $\phi_p$, $\theta_1$, ..., $\theta_q$, and $\sigma_a^2$ that maximizes the above equations is the called the unconditional or exact ML estimates.

In practice, the derivatives of $\ln |M_p|$ are complicated, so approximations or **conditional** estimators are used instead.
A technique called **backcasting** (i.e., first estimating those values of $X_t$ in the past) may be used to provide an approximation to $S_u$.

### Applications in R

For AR models, the `est.ar.wge` function from R package, `tswge`, provides the Yule-Walker, Burg (based on FBLS), and Maximum Likelihood estimators.
For ARMA models, the `est.arma.wge` function calculates the Maximum Likelihood estimators using a Kalman-filter based algorithm.

For stationary models (AR, MA, and ARMA), it is best to use Maximum-Likelihood (ML) estimators when possible.

For near nonstationary models, Yule-Walker estimators are especially poor; therefore, again it is best to use ML estimators.

For AR models in particular, if you want a stationary model solution, use Burg or Yule-Walker, as some ML estimation techniques do not assure a stationary result.

## Order Identification

One of the challenges with estimating model parameters is knowing the order identification.

**Akaike's Information Criterion** (AIC) is a general criterion for statistical model identification with a wide range of applications, including model selection in multivariate regression and, in our case, identifying p and q in an ARMA(p,q) model (Akaike, 1973).

A problem with the use of AIC is that as the realization length increases, AIC tends to overestimate the model orders (i.e., select models with too many parameters).

Several authors have considered modifications to AIC to adjust for this problem. Two of the popular alternatives are AICC (Hurvich and Tsai, 1989) and BIC (sometimes called the Schwarz Information Criterion) (Schwarz, 1978).

In R, the `aic.wge` function is an automated means of finding the ARMA(p, q) model order identification (within specified ranges of p and q) and returns the best fit model orders (i.e., p and q) along with the model parameter estimates: $\hat\theta_q$, $\hat\phi_p$, and $\hat\sigma_a^2$ (based on MLE).

## Filters

### What is a Filter?

A subset made from original data, filters strain something away. Separating or combining data into different categories, labels, or sections.

Given a certain criteria and input, something will happen and produce an altered output. Filters add addictional contraints or modifications to the data.

### Examples of Filters:

- Instagram/Snapchat filters
- Filters in neural nets
- text filters (banned words, search results, etc.)
- Parental Controls
- Three point moving average is another example of a filter (filters aggregate data, taking in more input and reducing it to a smaller size while retaining values)

### Why Filter:

To get a specific range of data or get data more relevant to what you want to analyze.

Can filter out outliers or things out of scope.

Can filter out duplicates, like what was done in block 2.

### Linear Filters

Have some coefficients that are then multiplied against the random variables (time series or discrete values) and then summed.

### Butterworth Filter:

Butterworth is a common linear filter used by scientists and engineers and can be used in several different types of processes. This filter takes in different cutoff points for frequencies and has four main types.

- Low pass: lower frequencies are able to pass through relatively unchanged while higher frequencies are filtered out
- high pass: higher frequencies are able to pass through relatively unchanged while lower frequencies are filtered out
- band pass: give 2 values, keep frequencies between these two values and filter out those not within said range
- band stop: give 2 values, filter out everything between these two values and keep everything outside of that range

The order of the Butterworth Filter ($N$) is selected by the user.

- Higher orders have more severe impacts on frequencies that are filtered out– in a low-pass filter with a high degree ($N=10$, for example), the frequencies below the cutoff have much higher power and the frequencies above the cutoff have much lower power.
- Low Order: Low impact on spectral density
- High Order: More ideal for low-pass filters, much larger impact as N increases

## References

- Akaike, H. 1973. Information theory and an extension of the maximum likelihood
principle. In _2nd International Symposium on Information Theory_, Petrov, B.N. and Csaki, F. (eds.), Akademiai Kiado: Budapest, 267-281.
- Burg, J.P. 1975. Maximum entropy spectral analysis, PhD dissertation, Department of Geophysics, Stanford University: Stanford, CA.
- Hurvich, C.M. and Tsai, C.-L. 1989. Regression and time series model selection in small samples, _Biometrika_ 76, 297-307.
- Schwarz, G. 1978. Estimating the dimension of a model, _The Annals of Statistics_ 6, 461-64.
- Ulrych, T.J. and Clayton, R.W. 1976. Time series modelling and maximum entropy, _Physics of the Earth and Planetary Interiors_ 12, 180-200.
- https://www.rdocumentation.org/packages/tswge/versions/1.0.0/topics/butterworth.wge
