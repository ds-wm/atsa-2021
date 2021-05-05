# Block 3: Modeling and Predicting
Julian Hayes


## Time Series Models

### Detrending
Some datasets have trends in them– for example, the Hadley dataset we used in class has a clear trend in the data as time moves forward.

We want to remove any trends present in datasets because a lot of the models we use assume a mean of 0 throughout the dataset. The summary of a chunk of data from a dataset will show the level of significance– if there is high significance, the mean is different from 0, which is a problem for us.

We can remove the trend from a datset using linear regression. If the trend is linear, we can start the process with R's built-in lm function.

Using linear regression can help us detrend a dataset by giving us a predicited value for each point in time. By subtracting the predicted value from the actual value, we should get a number close to 0.

R has another function called predict that will provide predicted values when given a linear model. We can use this function and some simple arithmetic to do our subtraction. Plotting based off of this data will result in a detrended dataset.

### Seasonality

A common trend in datasets is when data fluctuates by season (e.g., the something increases in warmer months and decreases in cooler months, providing a constant rise and fall in the data).

This is especially common in weather-related datasets, such as the atmospheric carbon dioxide measurements from the Mauna Loa Observatory; this dataset shows us that while the CO2  parts per million are constantly increasing linearly, there is also fluctuation from month to month within years. This can be explained by the presence of plants absorbing CO2  in the summer but not in the winter.

The equation for modeling seasonal cycles in data is:

$y_t = \beta_0 + \beta_1 sin(2\pi t) + \beta_2 sin(2\pi t) + a_t$

In this equation, the  $\beta$s are coefficients (including the intercept) and  $a$  is a white noise process.

### Moving Averages

Our goal is for the time series we examine to have a stationary mean of 0. Of course, this is not always the case. We have already looked at what to do with time series with means that are not 0, so now we will look at time series with means that are not stationary.

Moving average (MA) processes come in different orders. We call these orders q, so a MA process is denoted as MA(q). MA(q) can be expressed as a time series with this equation:

$$
X_t - \mu = a_t - \theta_1 a_{t-1} - ... -\theta_q a_{t-q}
$$

In this equation, the $\theta$s are real numbers and the $a$s are a white noise process with 0 mean and unit variance.

The MA(q) process is a general linear process with a finite number of terms, so we can calculate various measures for it:

* variance: $$\sigma^2_a = \sigma^2_a(1+\theta^2_1+...+\theta^2_q)$$

* autocovariance (for lag $k$): $$\gamma_k = \sigma^2[-\theta_k \sum^{q-k}_{j=1}] , k = 1,2,...q$$

* autocorrelation (for lag $k$): $$\rho_k = \frac{-\theta_k + \sum^{q-k}_{j=1}\theta_j \theta_{j+k}}{1 + \sum^{q}_{j=1}\theta^2_j}, k = 1,2,...q$$

Note that the model assumes a negative symbol in front of the coefficient. For lag $k$, $k$ is greater than $q$.

#### MA(1)

A MA(1) model is a MA(q) model in which $q = 1$. This gives us an equation of

$$
X_t - \mu = a_t - \theta_1 a_{t-1}
$$

This means that as $\theta_1$ approaches 0, the MA(1) process ($X_t - \mu$) approaches the white noise $a_t$.

Our first example is the opposite scenario, in which $\theta_1$ approaches 1:

$$
X_t = a_t - 0.99a_{t-1}
$$

The realization for this model has a high frequency. There is a negative autocorrelation at lag 1, but there is no autocorrelation or autocovariance at 2 or higher. The strong negative correlation (-0.99) causes the high oscilation within the short period.

Our second example is the same as the first but with the sign reveresed:

$$
X_t = a_t + 0.99a_{t-1}
$$

Note that because the original model uses subtraction, the addition here indicates that the $\theta$ value is -0.99, not 0.99.

The realization has a lower oscilation because of the positive correlation– each point in time is closer to the previous one rather than farther away. The model also shows aperiodic behavior, as opposed to the short period seen previously.

#### MA(2)

A MA(2) is a MA(q) model in which $q = 2$. This gives us the following equation:

$$
X_t = a_t - \theta_1 a_{t-1} - \theta_2 a_{t-2}
$$

Our example for MA(2) is:

$$
X_t = a_t + 0.2a_{t-1} - 0.48a_{t-2}
$$

Note that this is -0.2 and 0.48, not the other way around.

The coefficients are reflected in the autocorrelation: a small positive followed by a larger negative. The spectral density shows the model as being somewhere between aperiodic and periodic.

#### Three-Point MA

One way to examine a MA dataset is to use the three-point MA function:

$$
X_t' = \frac{X_{t-1}+X_t+X_{t+1}}{3}
$$

We use $X_t'$ (prime) to represent as smoothed version of the time series. There is not a built-in function to do this in R but it is not very difficult to do manually.

The three-point MA ignores the first and last elements of the time series because it requires that there be a point before and after the current one.

### Autoregressive

Autoregressive (AR) functions are of an order, which we call $p$. Much like how MA functions are written as MA(q), AR functions are written as AR(p). Here is the equation:

$$
X_t - \mu - \phi_1(X_{t-1}-\mu) - \phi_2(X_{t-2}-\mu) -...-\phi_p(X_{t-p}-\mu) = a_t
$$

Everything means the same thing it did for the MA models, and this time $\phi$s are real constants instead of $\theta$s.

If we assume that the mean is 0, we get

$$
X_t - \phi_1X_{t-1} - \phi_2X_{t-2} -...-\phi_pX_{t-p} = a_t
$$

The problem here is that there is an uncountable number of solutions to this equation. However, we can derive a solution using our requirement of stationarity.

#### AR(1)

An AR(1) model is an AR model of order 1. The equation:

$$
X_1 - \phi_1X_{t-1} = a_t
$$

Since we are requiring stationarity, $|\phi_1|\leq1$. This means that our time series can be defined by this equation:

$$
X_t = \sum^\infty_{k=0} \phi_1^k a_{t-k}
$$

This in turn gives us a characteristic equation:

$$
1 - \phi_1 r = 0
$$

where the single root $r$ is $r_1 = \frac{1}{\phi_1}$.

We can also take the autocovariance of AR(1) for lag $k$:

$$
\gamma_k = \phi_1^{|k|} \gamma_0
$$

$\gamma_0$ here is derived as $\gamma_0 = \sigma^2_a(1-\phi^2_1)^{-1}$.

The autocorrelation is:

$$
\rho_k = \phi_1^{|k|}
$$

We have two examples for AR(1). The first is:

$$
X_t - 0.95X_{t-1} = a_t
$$

Note that the $\phi$ value of 0.95 is correlated with the time series ($X_t$) rather than the noise process ($a_t$).

Since the autocorrelation is calculated by raising the 𝜙 value to the lag value (𝑘), and we have set 𝜙 to always be less than or equal to 1, the autocorrelation will always decrease but stay fairly high even at higher lags. Because of this pattern, as 𝜙 approaches 1, the model nears nonstationarity. A high 𝜙 like this follows an aperiodic, seemingly-random path.

For our second example, we will flip the sign and use a lower $\phi$:

$$
X_t + 0.7X_{t-1}
$$

This results in an autocorrelation that flips between positive and negative correlations for each lag value, and the correlation falls quickly. Much like in MA(1), as the magnitude approaches 0, the model approaches noise.

## Estimating Model Parameters

### Combining Models

We have seen moving average models (MA(q)) and autoregressive models (AR(p)), and now we can combine them into ARMA(p,q).

In order to use ARMA(p,q) models, we need to do estimate several different things, such as $p,q,\phi,$ and $\theta,$ among others.

Our estimates of  $p$  and  $q$  is called <font color = 'blue'>order identification</font>, which is typically the first step, followed by parameter estimation. That being said, the order can change on a case-by-case basis and the processes tend to leak into each other.

Assuming the order of the model is known, there are two types of estimators that we can use: <font color = 'blue'>Preliminary Estimators</font> tend to be easy and fast, while <font color = 'blue'>Maximum Likelihood Estimators</font> are iterative processes that typically take more computational power.

#### MA(q) estimators

These are typically more difficult than parameter estimation for AR(p) models.

There are two Preliminary Estimators for MA(q) models:

* <font  color = 'blue'>The Method of Moments</font> solve for parameters based off of a set of non-linear equations that relate the model to the autocorrelation function. This method is not typically used as real solutions may not exist.

* <font  color = 'blue'>The Innovations Algorithm</font> is a recursive method that fits the models of increasing order until the estimates of $\theta_1,\theta_2,...\theta_q$ stabilize.

We will get into the Maximum Likelihood method for MA(q) models later on.

#### AR(p) estimators

Once again, there are two Preliminary Estimators:

* <font  color = 'blue'>Yule-Walker Estimators</font> are a Method of Moments estimation. This method is based on a series of equations, most importantly this one that relates the coefficients of the AR(p) method to the autocorrelation function: $$\rho_k = \phi_1,\rho_{k-1}+...+\phi_p,\rho_{k-p}$$ Substituting in estimates of autocorrelations ($\hat\rho_k$) produces a set of linear equations that let you solve for everything else. This method involved inverting a matrix, but always gives gives estimates for a stationary process.

* <font  color = 'blue'>The Burg Method</font>, taken from the Ordinary-Least Squares Estimators, is based around minimizing a cost function, $S_c$:

$$
S_c = \sum^n_{t=p+1} \hat{a}_t^2
$$

The cost is the sum of the squares of the white noise processes. This is a non-traditional OLS method and therefore cannot be solved using a standard OLS package in R. Also, because $t$ starts from $p+1$, the method ignores everything from $X_1$ to $X_p$. Ulrych and Clayton tried to fix this with by ignoring the direction in time because a difference of one lag is statistically the same whether it is forward or backward:

$$
S_c = \sum^n_{t=p+1} \hat{a}_t^2 + \sum^{n-p}_{t=1}\delta_t^2
$$

This is called the <font  color = 'blue'>Forward-Backward Least Squares</font> method, or FBLS.

We will get into Maximum Likelihood estimators below.

#### Maximum Likelihood estimators

ML estimation of ARMA(p,q) parameters is an iterative process and requires starting values. There is a log-likelihood function:

$$
l(\phi_1,...,\phi_p,\theta_1,...,\theta_q) = -\frac{n}{2}\ln(2\pi\sigma_a^2) +\frac{1}{2}\ln|M_p| - \frac{S_u}{2\sigma_a^2}
$$

$S_u$ is the unconditional sum of squares. The solutions of $\phi_1,...,\phi_p,\theta_1,...,\theta_q$ and $\sigma_a^2$ are the unconditional/exact ML estimates.

The unconditional estimators can be difficult to find, so we can use conditional estimators instead, and we can use <font  color = 'blue'>backcasting</font> to provide an estimate for $S_u$.

For stationary models, it is typically best to use ML estimators. For AR methods specifically, you should use either Burg or Yule-Walker if you want to guarantee the results are stationary.

#### Order Identification

As mentioned earlier, you will often want to do this before parameter estimation. We can do order identification with <font  color = 'blue'>Akaike's Information Criterion</font>, or AIC. AIC has many applications, but we will be using it to identify $p$ and $q$ in an ARMA(p,q) model.

There is an issue with AIC: if the realization length is too long, AIC will overestimate the model orders; in other words, as $n$ increases, so too do AIC's estimates of $p$ and $q$.

There are ways of correcting this issues, including AICC and BIC; the arma.tswge function in R will find these automatically.

As you add coefficients, cost is added to the cost function that penalizes the model for having more parameters. Therefore, a better model has fewer parameters. AIC will tell you the optimal 𝑝 and 𝑞 values for the model (remember that as the order increases, so too does the number of coefficients) by giviing the model a score for each order; we want this score to be as low as possible. The function in R will optimize everything for us.

## Filters

### Filter Basics

#### What is a filter? (Discussion)

-   Used to select certain data to analyze
-   Only show certain things and not others

#### Examples of filters (Discussion)

-   Instagram/picture filters
-   Internet filters: parental filter, words, search results, etc.
-   Duplicate data points in Block 2
-   Subsetting datasets

### Three-Point Moving Average

This works similarly to how it did in the previous section and smoothes over data. There is a loss/removal of information for the sake of painting a general picture.

### Butterworth Filter

The Butterworth Filter is a linear filter commonly used by scientists and engineers. It can be used in several different types of processes. The filter works by taking an input (a time series), applying certain parameters, and outputting a modified version.

#### Frequencies

We can set a cutoff point for which frequencies can pass through the filter:

* <font  color = 'blue'>Low-pass filters</font>: lower frequencies are able to pass through while higher frequencies are filtered out

* <font  color = 'blue'>High-pass filters</font>: higher frequencies are able to pass through while lower frequencies are filtered out

* <font  color = 'blue'>Band-pass filters</font>: frequencies are able to pass through the filter if they are between two given values

* <font  color = 'blue'>Band-stop filters</font>: frequencies are filtered out if they are between two given values


#### Orders

The order of the Butterworth Filter ($N$) is selected by the user. Higher orders have more severe impacts on frequencies that are filtered out– in a low-pass filter with a high degree ($N=10$, for example), the frequencies below the cutoff have much higher power and the frequencies above the cutoff have much lower power.

#### Using R

There is a butterworth function in the wge package. The function lets the user input a realization (to be filtered), the order, the type (low-pass, etc.), and the cutoff for filtering.
