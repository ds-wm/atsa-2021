# Block 3 notes

- Using the package ```tswge``` 

### Detrending 3.0.1

    Time series data sets often have some type of trend. A detrend is the process of removing the effects of trends from data to highlight differences in values from the trend. (Kenton, 2021)

    In the notebook we utilize the Hadley data set to illustrate our point. We use the ```lm``` function as the regressor to identify a trend in the data set. We saw that there is evidence of a linear trend in the data set. To detrend the data, subtract the fitted values of a linear regression using the ```predict``` function in R.

### Removing a linear trend

- Remove the trend by making the points' mean zero

- Using the R `predict`fuction:
  
  - pass an object (the linear model found with the `lm` function)
    
    - gives the predicted values of of the features i.e. the regressors of the years

- By subtracting the predicted values, points of zero mean are found

- Linear trended: a process that can be represented as a line using slope and intercept

- The `lm` function fits the coefficients for a linear model to be detrended

### Linear Filters 3.0.2

"In signal processing, a filter is a function or procedure which removes unwanted parts of a signal. The concept of filtering and filter functions is particularly useful in engineering. One particularly elegant method of filtering Fourier transforms a signal into frequency space, performs the filtering operation there, then transforms back into the original space (Press et al. 1992)" (Weisstein)

The Butterworth filter:

- Butterworth  filter  can  be  of  any  type (low pass, high pass, etc.) our discussion will focus on an N-th order low-pass  Butterworth  filter,  which  has  a  squared  frequency  response  function (Woodard et al.)

$|H(e^{-2\pi if})|^{2}=\frac{1}{1+(\frac{f}{f_c})^{2N}}$

- Low pass: a filter that passes signals with a lower frequency than a selected cutoff and removes frequencies higher than the cutoff value

- High pass: a filter that passes signals with a higher frequency than a selected cutoff and removes frequencies lower than the cutoff value

- Band pass: a filter that passes signals within a range of cutoff values and removes frequencies outside of the specified cutoff range

### Seasonality 3.1.1

    Seasonality is a time series characteristic in which data undergoes regular and predictable changes that recur every calendar year. And predictable pattern or fluctuation that repeats over a 1 year period is determined to be seasonal. (Kenton, 2020)

The equation for the seasonal cycle is: $ y_t = \beta_0 + \beta_1 \sin (2 \pi \, t) + \beta_2 \cos (2 \pi \, t) + \alpha_t$ 

$\beta$ are coefficients and $\alpha_t$ is a white noise process. (Crawley, 2007)

#### 3.1.1 Vocab:

**Decomposition**: breaking a time series into its seaonsal, trend, and irregular components.

**LOESS**: a locally weighted polynomial regression

### Moving Average 3.1.2

A moving average (MA) process of order *q*, or more succinctly MA(*q*), may be expressed as a discrete time series, $X(t)$ with mean $\mu$, by the following equation.

$$
X_t - \mu = a_t - \theta_1 a_{t-1} - ... - \theta_q a_{t-q}

$$

where the $\theta$ values are real numbers and $a_t$ is a white noise process with zero mean and unit variance.

Note that an MA(*q*) process is a general linear process with a finite number of terms.

From this we can calculate the variance of our time series:

$$
\sigma^2_x = \sigma^2_a \left(1 + \theta^2_1 + ... + \theta^2_q  \right)

$$

as well as the autocovariance for lag *k*:

$$
\gamma_k = \sigma^2_a \left[ -\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k} \right],\, k = 1,2,..,q \\

= 0,\, k>q



$$

and the autocorrelation for lag *k*:

$$
\rho_k = \frac{-\theta_k + \sum_{j=1}^{q-k} \theta_j \theta_{j+k}}{1 + \sum_{j=1}^{q} \theta^2_j}, \,    k=1,2,..,q \\

= 0,\, k > q



$$

#### MA(1) Model

Let $q = 1$ in our definition above and we get:

$$
X_t - \mu = a_t - \theta_1 a_{t-1}

$$

Notice that as $\theta_1 \rightarrow 0$, the MA(1) process approaches white noise.

The autocorrelation function simplifies to:

$$
\rho_k = \frac{-\theta_k}{1 + {\theta_1}^2}

$$

#### MA(2) Model

let $q=2$ in our definition above such that we get:

$$
X_t = a_t - \theta_1\, a_{t-1} - \theta_2\, a_{t-2}

$$

### Autoregressive 3.1.3

The autoregressive (AR) process of order *p*, or more succinctly AR(*p*), may be expreesed as a discrete time series, $X_t$ with mean $\mu$, by the following equation.

$$
X_t - \mu - \phi_1 (X_{t-1} - \mu) - \phi_2 (X_{t-2} - \mu) - ... - \phi_p (X_{t-p} - \mu) = a_t

$$

where $a_t$ be a white noise process with zero mean and unit variance and $\phi_1, \phi_2, ..., \phi_p$ are real constants.

Oftentimes, we assume the time series has $\mu = 0$, which simplifies the expression to:

$$
X_t - \phi_1\, X_{t-1} - \phi_2\, X_{t-2} - ... - \phi_p\, X_{t-p} = a_t

$$

The above equation has an uncountable number of solutions; however, if we impose our stationarity requirement, we can derive a solution.

#### AR(1) Model

Let $p = 1$ in the equation above, such that:

$$
X_t - \phi_1\, X_{t-1} = a_t

$$

where $|\phi_1| \le 1$ (a requirement for stationarity).

The stationary conditions for the AR(1) process are such that:

$$
X_t = \sum_{k=0}^\infty {\phi_1}^k\, a_{t-k}

$$

which gives way to the **characteristic equation**:

$$
1 - \phi_1\, r = 0

$$

that has a single root:

$$
r_1 = \frac{1}{\phi_1}

$$

The autocovariance is given generally by:

$$
\gamma_k = {\phi_1}^{|k|}\, \gamma_0

$$

where $\gamma_0 = \sigma_a^2\,(1-\phi_1^2)^{-1}$

and the autocorrelation is given by:

$$
\rho_k = {\phi_1}^{|k|}

$$

#### 3.1.3 Vocab

- **Characteristic Equation**: the equation obtained by equating zero to the characteristic polynomial

- **Near nonstationarity**: persistence of the correlation when $\phi_1 \approx 1$

### Estimating Model Parameters 3.2

Suppose a realization $x_1$, $x_2$, ..., $x_n$ is observed.

The problem of fitting an ARMA(p,q) model to the data is the problem of estimating:

- $p$, $q$

- $\phi_1$, $\phi_2$, ..., $\phi_p$

- $\theta_1$, $\theta_2$, ..., $\theta_q$

- $\mu$, ${\sigma_a}^2$

The estimation of $p$ and $q$ is called **order identification**.

An analysis of a time series using an ARMA model (i.e., a process that is the combination of AR(p) and MA(q) models) will typically first involve order identification followed by parameter estimation.

The dichotomy between the order identification and parameter estimation steps is not clear-cut since the order identification techniques usually involve some parameter estimation as a means of selecting the appropriate model orders.

In practice, parameter estimation is almost always accomplished using a time series package.

There are two basic types of estimators (assuming that the order of the model is already known):

1. Preliminary Estimators 
   
   * relatively easy and fast to compute

2. Maximum Likelihood Estimators
   
   * iterative and (generally) computationally expensive

### MA(q) Estimators

In general, MA(q) parameter estimation is more difficult that AR(p) parameter estimation.

The following are estimator methods for determining parameters for the MA(q) models.

The first two methods, the **Method of Moments** and the **Innovations Algorithm** are preliminary estimators.

1. Method of Moments
   
   * Parameters ($\theta_1$, $\theta_2$, ..., $\theta_q$) are solved based on a series on non-linear equations that relate the MA(q) model to the autocorrelation function.
   
   * Real solutions may not exist.
   
   * This method (in general) is not recommended.

2. Innovations Algorithm
   
   * Based on recursive fitting of MA models of increasing order until estimates of $\theta_1$, $\theta_2$, ..., $\theta_q$ stabilize.

3. Maximum Likelihood
   
   * See &sect;3.2.3 

### AR(p) Esimators

For AR(p) models, there are two basic preliminary methods:

1. Yule-Walker Estimators (a method of moments estimation)
   
   * Based on the Yule-Walker equations; most importantly is the difference equation that relates the coefficients in the AR(p) model to the autocorrelation function:
   
   $$
   \rho_k = \phi_1\ \rho_{k-1} + ... + \phi_p\ \rho_{k-p}

   $$
   
   * Substituting estimates of autocorrelations, $\hat\rho_k$, produces a set of linear equations that may be solved for $\hat\phi_1$, $\hat\phi_2$, ..., $\hat\phi_p$.
   
   * Requires inverting 
   
   * Estimates produce a stationary process.

2. Ordinary-Least Squares Estimators (the Burg method)
   
   * Based on minimizing the cost function, $S_c$
   
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
   
   * Burg (1975) decided to use the Durbin-Levinson algorithm to minimimze this cost function and thus guarantee a resulting process that is stationary.

3. Maximum Likelihood
   
   * See &sect;3.2.3 

### Maximum Likelihood Esitmator 3.2.3

Much work has been done recently by statisticians on the problem of obtaining maximum likelihood (ML) estimates of the parameters due to their well-known optimality properties. 

ML estimation of the ARMA(p,q) parameters involves iterative procedures that require starting values.

The log-likelihood function is given by:

$$
l(\phi_1, ..., \phi_p, \theta_1, ..., \theta_q) = -\frac{n}{2} \ln \left( 2\, \pi\, \sigma_a^2 \right) + \frac{1}{2} \ln | M_p | - \frac{S_u}{2\, \sigma_a^2}

$$

where $S_u$ is the unconditional sum of squares.

The solution of $\phi_1$, ..., $\phi_p$, $\theta_1$, ..., $\theta_q$, and $\sigma_a^2$ that maximizes the above equations is the called the unconditional or exact ML estimates.

In practice, the derivatives of $\ln |M_p|$ are complicated, so approximations or **conditional** estimators are used instead.

A technique called **backcasting** (i.e., first estimating those values of $X_t$ in the past) may be used to provide an approximation to $S_u$.

#### Applications in R

For AR models, the `est.ar.wge` function from R package, `tswge`, provides the Yule-Walker, Burg (based on FBLS), and Maximum Likelihood estimators.

For ARMA models, the `est.arma.wge` function calculates the Maximum Likelihood estimators using a Kalman-filter based algorithm.

For stationary models (AR, MA, and ARMA), it is best to use Maximum-Likelihood (ML) estimators when possible.

For near nonstationary models, Yule-Walker estimators are especially poor; therefore, again it is best to use ML estimators.

For AR models in particular, if you want a stationary model solution, use Burg or Yule-Walker, as some ML estimation techniques do not assure a stationary result.

### Order Identification 3.2.5

One of the challenges with estimating model parameters is knowing the order identification.

**Akaike’s Information Criterion** (AIC) is a general criterion for statistical model identification with a wide range of applications, including model selection in multivariate regression and, in our case, identifying p and q in an ARMA(p,q) model (Akaike, 1973).

A problem with the use of AIC is that as the realization length increases, AIC tends to overestimate the model orders (i.e., select models with too many parameters).

Several authors have considered modifications to AIC to adjust for this problem. Two of the popular alternatives are AICC (Hurvich and Tsai, 1989) and BIC (sometimes called the Schwarz Information Criterion) (Schwarz, 1978).

In R, the `aic.wge` function is an automated means of finding the ARMA(p, q) model order identification (within specified ranges of p and q) and returns the best fit model orders (i.e., p and q) along with the model parameter estimates: $\hat\theta_q$, $\hat\phi_p$, and $\hat\sigma_a^2$ (based on MLE).

### Citations

Akaike, H. 1973. Information theory and an extension of the maximum likelihood principle. In *2nd International* *Symposium on Information Theory*, Petrov, B.N. and         Csaki, F. (eds.), Akademiai Kiado: Budapest, 267-281.

Burg, J.P. 1975. Maximum entropy spectral analysis, PhD dissertation, Department of Geophysics, Stanford University: Stanford, CA.

Hurvich, C.M. and Tsai, C.-L. 1989. Regression and time series model selection in small samples, *Biometrika* 76, 297-307.

Kenton, W. (2021, January 29). Detrend. https://www.investopedia.com/terms/d/detrend.asp. 

Kenton, W. (2020, November 30). Seasonality. Investopedia. https://www.investopedia.com/terms/s/seasonality.asp#:~:text=Seasonality%20is%20a%20characteristic%20of,is%20said%20to%20be%20seasonal. 

Press, W. H.; Flannery, B. P.; Teukolsky, S. A.; and Vetterling, W. T. "Digital Filtering in the Time Domain." §13.5 in Numerical Recipes in FORTRAN: The Art of Scientific Computing, 2nd ed. Cambridge, England: Cambridge University Press, pp. 551-556, 1992.

Schwarz, G. 1978. Estimating the dimension of a model, _The Annals of Statistics_ 6, 461-64.

Ulrych, T.J. and Clayton, R.W. 1976. Time series modelling and maximum entropy, *Physics of the Earth and Planetary Interiors* 12, 180-200.

Weisstein, Eric W. "Filter." From MathWorld--A Wolfram Web Resource. https://mathworld.wolfram.com/Filter.html
