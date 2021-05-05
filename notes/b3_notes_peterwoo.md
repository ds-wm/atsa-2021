# Applied Time Series Analysis - Block 3 Notes

## Detrending Time Series
- Using R's 
- Using the `stl` function
  - Seasonal decomposition of time series using Loess modeling
  - Extracts the seasonal component 

## Linear Filters
- What is the Butterworth filter and explain the inputs to the `butterworth.wge` function
  - The Butterworth filter is a common filter used by scientists and engineers that was developed in the 1970s and updated in 1997.
  - Can be used in several different types of processes
  - *What happens when you change the value of N?*
    - When the n-value is small, the impact on the spectral density is low. Increasing the value of N will sharpen the filter. 
  - *What is the difference between "low pass," "high pass," "band pass" and "band stop" filter types?*
    - Low: low frequencies pass through the filter more or less unchanged, while filtering our high frequencies
    - High: high frequencies pass through the filter and the low frequencies are filtered out 
    - Pass: also referred to as "band-pass", takes two values and keeps everything inbetween them, filtering out everything higher or lower. 
    - Stop: also referred to as "band-stop" or "notch," stop frequencies in a certain band (opposite of band-pass)
  - the inputs to the `butterworth.wge` function is as follows: `butterworth.wge(x, order, type, cutoff,plot=TRUE)`
    - `x` : realization to be filtered
    - `order` : order of the Butterworth filter
    - `type` : Either "low", "high", "stop", or "pass"
    - `cutoff`: For "low" and "high": cutoff is a real number, and for "stop" and "band": cutoff is a 2-component vector 
    - `plot`: If plot = TRUE then the plots of the original and filtered data are produced. 
    
# Time Series Models 

## Seasonality
- Time series aplications usually involve data that exhibit seasonal cycles. The commonest applications involve weather data. 
- Equation for the seasonal cycle (Crawley, 2007):
  - $$ y_t = \beta_0 + \beta_1 \sin (2 \pi \, t) + \beta_2 \cos (2 \pi \, t) + \alpha_t $$ 
    - $\beta$ are coefficients (including the intercept) and $\alpha_t$ is a white noise process.

## Moving Average

- The moving average process of order q (MA(q)) is experessed as a discrete time series X(t) with the mean μ with this equation:
- $$ X_t - \mu = a_t - \theta_1 a_{t-1} - ... -\theta_q a_{t-q} $$
  - $\theta$: real numbers
  -  $a_t$: white noise process with zero mean and unit variance.
  - We can calculate the variance with: 
    - $$\sigma^2_x = \sigma^2_a \left(1 + \theta^2_1 + ... + \theta^2_q  \right)$$
  - The autocovariance: 
    - $$\gamma_k = \sigma^2[-\theta_k \sum^{q-k}_{j=1}] , k = 1,2,...q$$
  - The autocorrelation:
    - $$\rho_k = \frac{-\theta_k + \sum^{q-k}{j=1}\theta_j \theta{j+k}}{1 + \sum^{q}_{j=1}\theta^2_j}, k = 1,2,...q$$

### MA(1) Model
- The time series X(t) would be: 
  - $$X_t - \mu = a_t - \theta_1 a_{t-1}$$
  - Autocorrelation:
    - $$\rho_k = \frac{-\theta_k}{1 + {\theta_1}^2}$$
- In class, one of the example MA(1) time series realizations we studied was:
  - $$X_t = a_t - 0.99\, a_{t-1}$$
    - To examine this in R, we can use the `plotts.true.wge.` function in the `tswge` package. 
```
#install.packages('tswge'
libarary('tswge')

ma.ts1 <- plotts.true.wge(100, phi=c(0), theta=c(0.99))
```
### MA(2) Model
- Plugging in q = 2 into the X(t) equation mentioned above, we get:
  - $$X_t = a_t - \theta_1\, a_{t-1} - \theta_2\, a_{t-2}$$
- The example we looked at in class for an MA(2) model is:
  - $$X_t = a_t + 0.2\, a_{t-1} - 0.48\, a_{t-2}$$
  - Using the same R function from before, 
```
ma.ts3 <- plotts.true.wge(100, phi=c(0), theta=c(-0.2, 0.48))
```

## Autoregressive
- Autoregressive process of order p is represented as AR(p), and is expressed as a discrete time series Xt with mean μ by the following equation:
  - $$X_t - \mu - \phi_1 (X_{t-1} - \mu) - \phi_2 (X_{t-2} - \mu) - ... - \phi_p (X_{t-p} - \mu) = a_t$$
    - $a_t$: white noise process with zero mean and unit variance
    - $\phi_1, \phi_2, ..., \phi_p$ : real constants

### AR(1) Model
- Plugging in p = 1 in the equation above, such that
  - $$X_t - \phi_1\, X_{t-1} = a_t$$
  - where $|\phi_1| \le 1$ (a requirement for stationarity). The stationary conditions for the AR(1) process are such that:
    - $X_t = \sum_{k=0}^\infty {\phi_1}^k, a_{t-k}$
    - which gives way to the characteristic equation:
      - $1 - \phi_1, r = 0$
        - that has a single root: $r_1 = \frac{1}{\phi_1}$
- The autocovariance for this model is given by:
  - $\gamma_k = {\phi_1}^{|k|}, \gamma_0$
- An example of an AR(1) model we looked at in class:
  - $$X_t - 0.95\, X_{t-1} = a_t$$
  - We can use the same function to write this into R as well. 
```
ar.ts1 <- plotts.true.wge(100, phi=c(0.95), theta=c(0), lag.max = 40)
```
# Estimating Model Parameters
- Two basic types of estimators:
  - Preliminary estimators:
    - relatively easy and fast to compute
  - Maximum likelihood estimators:
    - iterative and generally computationally expensive

## MA(q) estimators
- Two preliminary MA(q) estimator models:
  - Method of moments
    - parameters are solved based on non-linear equations that relate the model to the autocorrelation function
    - real solutions may not exist and this estimator is generally not recommended
  - Innovations algorithm
    - fit moving average models by increasing order until stable estimates of theta values are found.
- R implementation:
  - using the following example MA(2) process:
    - $$X_t = a_t - 1.37\, a_{t-1} + 0.72\, a_{t-2}$$
```
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
ma.ts3 <- plotts.true.wge(
  n=200, 
  phi=c(0), 
  theta=c(1.37, -0.72), 
  vara = 1)
  
ex.ma <- est.arma.wge(ma.ts3$data, q=2)
print(ex.ma$theta)
print(ex.ma$avar)
```

## AR(p) estimators
- Yule-Walker estimators
  - Based on Yule-Walker equations
  - requires inverting and estimates produce a stationary process
- Ordinary-least squares estimators
  - based on minimizing the cost function Sc:
    - $$S_c = \sum_{t=p+1}^{n} {\hat a_t}^2$$
- R implementation:
  - look at the realization of an example AR(4) model:
    - $$X_t - 1.15\, X_{t-1} + 0.19\, X_{t-2} + 0.64\, X_{t-3} - 0.61\, X_{t-4} = a_t$$
```
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
ar.ts3 <- plotts.true.wge(
  n=200, 
  phi=c(1.15, -0.19, -0.64, 0.61), 
  theta=c(0), 
  vara = 1,
  lag.max = 40)
  
# Yule-Walker
ex324.yw <- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type='yw')
# Burg (based on FBLS)
ex324.burg <- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
ex324.mle <- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type='mle')

# Extract the parameter estimates for theta's and white noise variance
ex324.df <- data.frame(
  type=c("True", "YW", "Burg", "MLE"),
  phi1 = c(1.15, ex324.yw$phi[1], ex324.burg$phi[1], ex324.mle$phi[1]),
  phi2 = c(-0.19, ex324.yw$phi[2], ex324.burg$phi[2], ex324.mle$phi[2]),
  phi3 = c(-0.64, ex324.yw$phi[3], ex324.burg$phi[3], ex324.mle$phi[3]),
  phi2 = c(0.61, ex324.yw$phi[4], ex324.burg$phi[4], ex324.mle$phi[4]),
  siga = c(1.0, ex324.yw$avar, ex324.burg$avar, ex324.mle$avar)
)
ex324.df
```

## Maximum likelihood estimator
- Maximum likelihood estimation of the ARMA(p,q,) paramters involves iterative procedures that require starting values. 
- The log-likelihood function:
  - $$l(\phi_1, ..., \phi_p, \theta_1, ..., \theta_q) = -\frac{n}{2} \ln \left( 2\, \pi\, \sigma_a^2 \right) + \frac{1}{2} \ln | M_p | - \frac{S_u}{2\, \sigma_a^2}$$
    - Su: unconditional sum of squares
- Conditional estimators are used since in practice the derivatives of $\ln |M_p|$ are complicated.  
  - backcasting is used to provide an approximation to S_u.

## Order Identification
- Akaike's Information Criterion (AIC):
  - general criterion for statistical model identification with a wide range of applications, including model selection in multivariate regression and in identifying p and q in an ARMA(p,q) model (Akaike, 1973)
  - problem with its use is that as the realization length increases, AIC tends to overestimate the model orders. 

# References
- Akaike, H. 1973. Information theory and an extension of the maximum likelihood principle. In 2nd International Symposium on Information Theory, Petrov, B.N. and Csaki, F. (eds.), Akademiai Kiado: Budapest, 267-281.
- Burg, J.P. 1975. Maximum entropy spectral analysis, PhD dissertation, Department of Geophysics, Stanford University: Stanford, CA.
- Wikimedia Foundation. (2021, April 5). Butterworth filter. Wikipedia. https://en.wikipedia.org/wiki/Butterworth_filter#:~:text=The%20Butterworth%20filter%20is%20a,a%20maximally%20flat%20magnitude%20filter. 
- Woodward, W. (n.d.). butterworth.wge: Perform Butterworth Filter. butterworth.wge: Perform Butterworth Filter in BivinSadler/tswge: Applied Time Series Analysis. https://rdrr.io/github/BivinSadler/tswge/man/butterworth.wge.html. 
