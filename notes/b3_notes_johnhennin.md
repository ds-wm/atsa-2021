# Block 3 Notes: Modeling and Prediction
John Hennin
2021-05-03
Applied Time Series Analysis 

### Packages Used
-  tswge (Woodward, 2016) 

```{r}
library('tswge')
```


### 3.0.1 Detrending Time Series

Sometimes time series data demonstrates trends such as the one demonstrated below from the Hadley dataset, which linearly trends upwards.

```{r}
data(hadley)
plot(hadley, ylab='air temp')
title(main='Hadley Data')
```

You can remove this linear trend by fitting a linear model prediction to the data and then subtracting the predictions at each time from the actual values at the corresponding times.

This can be done with the lm and predict functions. The lm function finds the linear model of the data and then the predict function makes predictions based on the model. Then you are left with a zero-mean and detrended realization.


### 3.0.2 Filters

Definition of Filtering (post discussion): When you filter something you first set a criteria or manipulation (removing NaNs, tripling all pixel values above 50 and below 80, etc.), then you apply it to your data and use the output for visualization, analysis, better efficiency, etc. The output should be similar to the input, but without the information that didn’t fit the criteria. Filtering is important for extracting and separating valuable/relevant information from invaluable/irrelevant information.

#### The Butterworth Filter Function

The Butterworth function allows you to filter out certain frequencies of the data based on a range of values (or a cutoff value). A low pass filter filters out signals of higher frequency than the cutoff value (the lower frequencies pass through). Similarly, a high pass filter filters out signals of lower frequency than the cutoff value (and the higher frequencies pass through). A band pass filter allows you to specify a range of acceptable frequencies based on two cutoff values (so anything outside the range is removed). A band stop does the opposite, allowing only frequencies outside of the range.

### 3.1.1 Seasonality

Seasonality is when data demonstrates predictable and semi-cyclic changes over time. For example, the amount of snow in Chicago every month is seasonal (somewhat by definition), since each year there's barely snow in spring, no snow in summer, barely snow in autumn, and a lot of snow in winter.

The equation for the seasonal cycle is: $ y_t = \beta_0 + \beta_1 \sin (2 \pi \, t) + \beta_2 \cos (2 \pi \, t) + \alpha_t$ (Crawley, 2007)

$\beta$ = coefficients
$\alpha_t$ = a white noise process

#### Vocab Words

(Seasonal) Decomposition: reverting a time series to its seasonal, trend, and irregular components.

LOESS: a locally weighted polynomial regression

### 3.1.2 Moving Average

"A moving average (MA) process of order *q*... may be expressed as a discrete time series, $X(t)$ with mean $\mu$, by the following equation.

$$
X_t - \mu = a_t - \theta_1 a_{t-1} - ... - \theta_q a_{t-q}

$$

where the $\theta$ values are real numbers and $a_t$ is a white noise process with zero mean and unit variance." (Davis, 2021)

The following equation describes the variance of our time series:

$$
\sigma^2_x = \sigma^2_a \left(1 + \theta^2_1 + ... + \theta^2_q \right)

$$

The following equation describes the variance of our time series:

$$
\gamma_k = \sigma^2_a \left[ -\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k} \right],\, k = 1,2,..,q \\

= 0,\, k>q



$$

The following equation describes the autocorrelation for lag k of our time series:

$$
\rho_k = \frac{-\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k}}{1 + \sum_{j=1}^{q} \theta^2_j}, \,    k=1,2,..,q \\

= 0,\, k > q



$$

MA(1)

Let $q = 1$ in our definition above and we get:

$$
X_t - \mu = a_t - \theta_1 a_{t-1}

$$

MA(2)

let $q=2$ in our definition above such that we get:

$$
X_t = a_t - \theta_1\, a_{t-1} - \theta_2\, a_{t-2}

$$

### 3.1.3 Autoregressive 

"The autoregressive (AR) process of order *p*, or more succinctly AR(*p*), may be expreesed as a discrete time series, $X_t$ with mean $\mu$, by the following equation.

$$
X_t - \mu - \phi_1 (X_{t-1} - \mu) - \phi_2 (X_{t-2} - \mu) - ... - \phi_p (X_{t-p} - \mu) = a_t

$$

where $a_t$ be a white noise process with zero mean and unit variance and $\phi_1, \phi_2, ..., \phi_p$ are real constants." (Davis, 2021)

If we assume mean-zero

$$
X_t - \phi_1\, X_{t-1} - \phi_2\, X_{t-2} - ... - \phi_p\, X_{t-p} = a_t

$$


AR(1)

Let $p = 1$:

$$
X_t - \phi_1\, X_{t-1} = a_t

$$

where $|\phi_1| \le 1$ (a requirement for stationarity).

The stationary conditions for the AR(1) process are such that:

$$
X_t = \sum_{k=0}^\infty {\phi_1}^k\, a_{t-k}

$$

which gives way to the characteristic equation:

$$
1 - \phi_1\, r = 0

$$

Autocovariance:

$$
\gamma_k = {\phi_1}^{|k|}\, \gamma_0

$$

where $\gamma_0 = \sigma_a^2\,(1-\phi_1^2)^{-1}$

Autocorrelation:

$$
\rho_k = {\phi_1}^{|k|}

$$

#### Vocab Words

Characteristic equation: the equation obtained by equating zero to the characteristic polynomial

Near nonstationarity: the persistence of the correlation when $\phi_1 \approx 1$

### Estimating Model Parameters 3.2

To fit an ARMA(p,q) model to the data you must estimate

- $p$, $q$

- $\phi_1$, $\phi_2$, ..., $\phi_p$

- $\theta_1$, $\theta_2$, ..., $\theta_q$

- $\mu$, ${\sigma_a}^2$

For $p$ and $q$ you must do something called order identification (**Vocab Word**).

"There are two basic types of estimators (assuming that the order of the model is already known):

1. Preliminary Estimators 
   
   * relatively easy and fast to compute

2. Maximum Likelihood Estimators
   
   * iterative and (generally) computationally expensive" (Davis, 2021)

### MA(q) Estimators 3.2.1

This is usually the more difficult parameter estimation strategy (in comparison to AR(p)).

The first two methods, the Method of Moments and the Innovations Algorithm are preliminary estimators.


#### Vocab Words
Method of Moments
   
   * "Parameters ($\theta_1$, $\theta_2$, ..., $\theta_q$) are solved based on a series on non-linear equations that relate the MA(q) model to the autocorrelation function.
   
   * Real solutions may not exist.
   
   * This method (in general) is not recommended." (Davis, 2021)

Innovations Algorithm
   
   * "Based on recursive fitting of MA models of increasing order until estimates of $\theta_1$, $\theta_2$, ..., $\theta_q$ stabilize." (Davis, 2021)

### AR(p) Esimators

For AR(p) estimators, there are two methods.

Yule-Walker Method
   
   * "Based on the Yule-Walker equations; most importantly is the difference equation that relates the coefficients in the AR(p) model to the autocorrelation function:
   
   $$
   \rho_k = \phi_1\ \rho_{k-1} + ... + \phi_p\ \rho_{k-p}

   $$
   
   * Substituting estimates of autocorrelations, $\hat\rho_k$, produces a set of linear equations that may be solved for $\hat\phi_1$, $\hat\phi_2$, ..., $\hat\phi_p$.
   
   * Requires inverting 
   
   * Estimates produce a stationary process." (Davis, 2021)

Ordinary-Least Squares Estimators or the Burg method (as is used in est.ar.wge)
   
   * "Based on minimizing the cost function, $S_c$
   
   $$
   S_c = \sum_{t=p+1}^{n} {\hat a_t}^2

   $$
   
   * Non-traditional OLS method ($X_t$ and $\mu$) are simultaneously playing the role of dependent and independent variables and predictors are correlated); thus, cannot be solved using a standard OLS package.
   
   * Ignores data $X_1$ to $X_p$ (because $X_{t-p}$ is undefined).
   
   * Improved upon by Ulrych & Clayton (1976), who argued no preference in the direction of time (i.e., the driving process forward is the same process driving backward)---created the Forward-Backward Least Squares (FBLS) method:
   
   $$
   S_c = \sum_{t=p+1}^{n} {\hat a_t}^2 + \sum_{t=1}^{n-p} {\delta_t}^2

   $$
   
   where $\delta_t$ are white noise with zero mean and variance, ${\sigma_a}^2$.
   
   * Burg (1975) decided to use the Durbin-Levinson algorithm to minimimze this cost function and thus guarantee a resulting process that is stationary." (Davis, 2021)

### Maximum Likelihood Estimator 3.2.3 

"The log-likelihood function is given by:

$$
l(\phi_1, ..., \phi_p, \theta_1, ..., \theta_q) = -\frac{n}{2} \ln \left( 2\, \pi\, \sigma_a^2 \right) + \frac{1}{2} \ln | M_p | - \frac{S_u}{2\, \sigma_a^2}

$$

where $S_u$ is the unconditional sum of squares.

The solution of $\phi_1$, ..., $\phi_p$, $\theta_1$, ..., $\theta_q$, and $\sigma_a^2$ that maximizes the above equations is the called the unconditional or exact ML estimates.

In practice, the derivatives of $\ln |M_p|$ are complicated, so approximations or conditional estimators (**Vocab Word**) are used instead.

A technique called backcasting (**Vocab Word**) (i.e., first estimating those values of $X_t$ in the past) may be used to provide an approximation to $S_u$." (Davis, 2021)

#### Applications in R 3.2.4

For AR models, tswge's est.ar.wge function calculates Yule-Walker, OLS or Burg, and Maximum Likelihood estimators.

For ARMA models, the est.arma.wge function calculates the Maximum Likelihood estimators.

For stationary models and near nonstationary models (AR, MA, and ARMA), use the Maximum Likelihood estimators.

"For AR models in particular, if you want a stationary model solution, use Burg or Yule-Walker, as some ML estimation techniques do not assure a stationary result." (Davis, 2021)

### Order Identification 3.2.5

One of the challenges with estimating model parameters is knowing the order identification.

Akaike’s Information Criterion (**Vocab Word**) (AIC) helps identify both p and q in an ARMA(p,q) model.

With a lot of data, AIC can become overestimate the order of the model

Alternatives AICC and BIC have aimed to fix this issue

"In R, the `aic.wge` function is an automated means of finding the ARMA(p, q) model order identification (within specified ranges of p and q) and returns the best fit model orders (i.e., p and q) along with the model parameter estimates: $\hat\theta_q$, $\hat\phi_p$, and $\hat\sigma_a^2$ (based on MLE)." (Davis, 2021)

### References

1. Wayne Woodward (2016). tswge: Applied Time Series Analysis. R package version 1.0.0. https://CRAN.R-project.org/package=tswge
1. Crawley, M. (2007). The R book. Wiley.
1. Davis, T. (2021, April 27). Applied Time Series Analysis: Course Notebook—Student Copy. https://colab.research.google.com/drive/1qIdpd_8WFct9zBZ5uwO_Bcg-F3svu0KJ?authuser=1#scrollTo=3vDtty1FTkMU

