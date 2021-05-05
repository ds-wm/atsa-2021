# Modeling and Prediction
## Getting Started
We will be using the `tswge` R package.
### Detrending Time Series
Often times we find that the time series data we are working with has some type of trend.

This was evident in the latter portion of the air temperature dataset over the Met Office's Hadley Center.

```R
data(hadley)
options(repr.plot.width=14, repr.plot.height=6, repr.plot.res = 125)
plot(hadley[50:length(hadley)], ylab="air temp")
```
![download](https://user-images.githubusercontent.com/73894812/117097921-fb414800-ad3a-11eb-82cc-38bdb572d5ff.png)

When investigating the autocorrelations and periodogram of this dataset, we said there was evidence of a trend.

Before analyzing a time series, it's a good idea to detrend your datasets. We can detrend the data by subtracting the fitted values from the linear regression using R's predict function.

```R
detrended <- hadley[50:length(hadley)] - predict(lm(hadley[50:length(hadley)] ~ years[50:length(hadley)]))
options(repr.plot.width=12, repr.plot.height=6, repr.plot.res = 125)
plot(hadley[50:length(hadley)], ylab="air temp", type='o')
#lines(detrended, lty=2)
legend(
  'top', 
  legend=c("Original", "Detrended"),
  lty = c(1, 2),
  pch = c(1, NA),
  horiz = TRUE
)
```
![download-1](https://user-images.githubusercontent.com/73894812/117098161-af42d300-ad3b-11eb-8893-18f3fa0468cb.png)

### Linear Filters
- What is the Butterworth filter and explain the inputs to the `butterworth.wge` function.
  * What happens when you change the value of N?
  * What is the difference between "low pass," "high pass," "band pass" and "band stop" filter types?

## Time Series Models

### Seasonality
Many time series applications involve data that exhibit seasonal cycles. The commonest applications involve weather data.

The equation for the seasonal cycle is (Crawley, 2007):

![gif](https://user-images.githubusercontent.com/73894812/117098642-12813500-ad3d-11eb-8416-2d278af49ade.gif)

where ![gif-1](https://user-images.githubusercontent.com/73894812/117098698-3a709880-ad3d-11eb-8492-eb27593732bd.gif)
 are coefficients (including the intercept) and ![gif-2](https://user-images.githubusercontent.com/73894812/117098907-b66ae080-ad3d-11eb-9b9f-30d7a5d255ed.gif)
 is a white noise process.

### Moving Average

A moving average (MA) process of order *q*, or more succinctly MA(*q*), may be expressed as a discrete time series, ![gif-5](https://user-images.githubusercontent.com/73894812/117099977-8cff8400-ad40-11eb-8baa-2ec2bc10d58d.gif)
 with mean ![gif-6](https://user-images.githubusercontent.com/73894812/117100006-9b4da000-ad40-11eb-9172-41f09aadac8b.gif)
, by the following equation.

![gif-3](https://user-images.githubusercontent.com/73894812/117099690-cc79a080-ad3f-11eb-8fd9-9b5c9cae61fb.gif)

where the ![gif-4](https://user-images.githubusercontent.com/73894812/117099759-0a76c480-ad40-11eb-92f6-31c2f21d7a9e.gif)
 values are real numbers and ![gif-2](https://user-images.githubusercontent.com/73894812/117099768-0f3b7880-ad40-11eb-8703-4f81b6a32b82.gif)
 is a white noise process with zero mean and unit variance.

Note that an MA(*q*) process is a general linear process with a finite number of terms.
From this we can calculate
- the variance of our time series:

  * ![gif-7](https://user-images.githubusercontent.com/73894812/117100041-b15b6080-ad40-11eb-9ef9-0dcaa2dd8940.gif)

- the autocovariance for lag *k*:

  * ![gif-8](https://user-images.githubusercontent.com/73894812/117100082-d51ea680-ad40-11eb-8a50-09a5b05c90f2.gif)

- the autocorrelation for lag *k*:

  * ![gif-9](https://user-images.githubusercontent.com/73894812/117100105-e8ca0d00-ad40-11eb-9d78-5eda50afda0f.gif)

**The MA(1) Model**

Let ![gif-10](https://user-images.githubusercontent.com/73894812/117100191-23cc4080-ad41-11eb-9c06-7328bdd8cb90.gif)
 in our definition above and we get:

![gif-11](https://user-images.githubusercontent.com/73894812/117100211-30e92f80-ad41-11eb-8bd5-789291f5cd53.gif)

Notice that as ![gif-12](https://user-images.githubusercontent.com/73894812/117100260-4a8a7700-ad41-11eb-8cd5-a9d83bfbefef.gif)
, the MA(1) process approaches white noise.
The autocorrelation function simplifies to:

![gif-13](https://user-images.githubusercontent.com/73894812/117100279-54ac7580-ad41-11eb-933a-21eb98744020.gif)

**The MA(2) Model**

Let ![gif-15](https://user-images.githubusercontent.com/73894812/117100726-78bc8680-ad42-11eb-9857-b96e9c46159e.gif)
 in our definition above such that we get:

![gif-16](https://user-images.githubusercontent.com/73894812/117100740-84a84880-ad42-11eb-8c2b-00f794f0ea52.gif)

**Three-Point MA**

The simplest way of seeing a pattern in a time series is to plot the moving average and one useful summary statistic to have on hand is the three-point moving average:

![gif-17](https://user-images.githubusercontent.com/73894812/117100893-f385a180-ad42-11eb-9025-87a6fa4ef50b.gif)

In R, this can be expressed as:

```R
ma3 <- function(x) {
  y <- numeric(length(x) - 2)
  for (i in 2:(length(x)-1)) {
    y[i]<-(x[i-1] + x[i] + x[i+1])/3
  }
  y
}
```

### Autoregressive 
The autoregressive (AR) process of order *p*, or more succinctly AR(*p*), may be expreesed as a discrete time series, ![gif-5](https://user-images.githubusercontent.com/73894812/117101140-87576d80-ad43-11eb-861b-efee9d928dd6.gif)
 with mean ![gif-6](https://user-images.githubusercontent.com/73894812/117101152-8cb4b800-ad43-11eb-99cf-cf124710b52c.gif)
, by the following equation.

![gif-18](https://user-images.githubusercontent.com/73894812/117101177-9807e380-ad43-11eb-84b3-69251e5532c3.gif)

where ![gif-2](https://user-images.githubusercontent.com/73894812/117101185-9f2ef180-ad43-11eb-98d5-94a071d41771.gif)
 be a white noise process with zero mean and unit variance and ![gif-19](https://user-images.githubusercontent.com/73894812/117101206-aeae3a80-ad43-11eb-96a2-f92086b0c5d1.gif)
 are real constants.

Oftentimes, we assume the time series has ![gif-20](https://user-images.githubusercontent.com/73894812/117101240-bec61a00-ad43-11eb-863f-b87f5a737c0d.gif)
, which simplifies the expression to:

![gif-21](https://user-images.githubusercontent.com/73894812/117101262-ca194580-ad43-11eb-80d3-4f9ff1fc0c66.gif)

The above equation has an uncountable number of solutions; however, if we impose our stationarity requirement, we can derive a solution.

**The AR(1) Model**

Let ![gif-22](https://user-images.githubusercontent.com/73894812/117101354-0d73b400-ad44-11eb-8da4-36deefe019a4.gif)
 in the equation above, such that:

![gif-23](https://user-images.githubusercontent.com/73894812/117101365-16fd1c00-ad44-11eb-8e60-985ab6571d6f.gif)

where ![gif-24](https://user-images.githubusercontent.com/73894812/117101393-23817480-ad44-11eb-9def-056ea661b74a.gif)
 (a requirement for stationarity).
The stationary conditions for the AR(1) process are such that:

![gif-25](https://user-images.githubusercontent.com/73894812/117101427-37c57180-ad44-11eb-8cbd-003bc5652b76.gif)

which gives way to the characteristic equation:

![gif-26](https://user-images.githubusercontent.com/73894812/117101462-4c096e80-ad44-11eb-97e2-ceeaa737232c.gif)

that has a single root:

![gif-27](https://user-images.githubusercontent.com/73894812/117101487-575c9a00-ad44-11eb-86c3-a7c794dcd023.gif)

The autocovariance is given generally by:

![gif-28](https://user-images.githubusercontent.com/73894812/117101522-617e9880-ad44-11eb-8563-be82efa16a2e.gif)

where ![gif-29](https://user-images.githubusercontent.com/73894812/117101541-6ba09700-ad44-11eb-8817-40b2093fffe2.gif)
and the autocorrelation is given by:

![gif-30](https://user-images.githubusercontent.com/73894812/117101568-7eb36700-ad44-11eb-96da-7fab7808d48d.gif)

## Estimating Model Parameters

### Estimating Model Parameters
Suppose a realization ![gif-31](https://user-images.githubusercontent.com/73894812/117101656-b4f0e680-ad44-11eb-8083-c23afa645267.gif)
 is observed.
The problem of fitting an ARMA(p,q) model to the data is the problem of estimating:

- ![gif-32](https://user-images.githubusercontent.com/73894812/117101692-c6d28980-ad44-11eb-92d1-a32e8a9cfbb3.gif)
- ![gif-19](https://user-images.githubusercontent.com/73894812/117101754-eb2e6600-ad44-11eb-8a46-6c6c53b4ed24.gif)
- ![gif-33](https://user-images.githubusercontent.com/73894812/117101833-1022d900-ad45-11eb-8803-3b9b1de58ce8.gif)
- ![gif-34](https://user-images.githubusercontent.com/73894812/117101898-35174c00-ad45-11eb-8a9a-7af041bfd7eb.gif)

The estimation of ![gif-32](https://user-images.githubusercontent.com/73894812/117101950-46605880-ad45-11eb-9a88-971ac25076dd.gif)
 is called order identification.
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
The first two methods are preliminary estimators.

1. Method of Moments
  * Parameters (![gif-33](https://user-images.githubusercontent.com/73894812/117102342-20878380-ad46-11eb-9fdb-c13d1d9ab7b0.gif)
) are solved based on a series on non-linear equations that relate the MA(q) model to the autocorrelation function.
  * Real solutions may not exist.
  * This method (in general) is not recommended.
2. Innovations Algorithm
  * Based on recursive fitting of MA models of increasing order until estimates of ![gif-33](https://user-images.githubusercontent.com/73894812/117102382-39903480-ad46-11eb-98de-eb9192ab8402.gif)
 stabilize.
3. Maximum Likelihood
  * See below

### AR(p) Estimators
For AR(p) models, there are two basic preliminary methods:

1. Yule-Walker Estimators (a method of moments estimation)
    * Based on the Yule-Walker equations; most importantly is the difference equation that relates the coefficients in the AR(p) model to the autocorrelation function:
    ![gif-35](https://user-images.githubusercontent.com/73894812/117102459-68a6a600-ad46-11eb-9f61-2aa535be490e.gif)

    * Substituting estimates of autocorrelations, ![gif-36](https://user-images.githubusercontent.com/73894812/117102491-73f9d180-ad46-11eb-98f4-014195fe1fdb.gif)
, produces a set of linear equations that may be solved for ![gif-37](https://user-images.githubusercontent.com/73894812/117102514-8116c080-ad46-11eb-9392-e0179e30c3f5.gif)
.
    * Requires inverting 
    * Estimates produce a stationary process.
2. Ordinary-Least Squares Estimators (the Burg method)
    * Based on minimizing the cost function, ![gif-38](https://user-images.githubusercontent.com/73894812/117102722-eb2f6580-ad46-11eb-8a07-5fd234a6a01a.gif)
 
      ![gif-39](https://user-images.githubusercontent.com/73894812/117102656-c4712f00-ad46-11eb-84ee-adea1bc8f777.gif)
    * Non-traditional OLS method (![gif-5](https://user-images.githubusercontent.com/73894812/117102766-ff736280-ad46-11eb-9b11-51de2afba6e0.gif)
 and ![gif-6](https://user-images.githubusercontent.com/73894812/117102773-04381680-ad47-11eb-8c62-f11dec40a56a.gif)
 are simultaneously playing the role of dependent and independent variables and predictors are correlated); thus, cannot be solved using a standard OLS package.
    * Ignores data ![gif-42](https://user-images.githubusercontent.com/73894812/117103120-bd96ec00-ad47-11eb-83c9-f5436ee3e1a9.gif)
 (because ![gif-43](https://user-images.githubusercontent.com/73894812/117103147-c982ae00-ad47-11eb-9bee-58f3f91067ac.gif)
 is undefined).
    * Improved upon by Ulrych & Clayton (1976), who argued no preference in the direction of time (i.e., the driving process forward is the same process driving backward)---created the Forward-Backward Least Squares (FBLS) method:
  
      ![gif-40](https://user-images.githubusercontent.com/73894812/117102816-17e37d00-ad47-11eb-818d-3100ab6945bf.gif)
   
      where ![gif-41](https://user-images.githubusercontent.com/73894812/117102990-76a8f680-ad47-11eb-8194-64ba3acee49b.gif)
 are white noise with zero mean and variance, ![gif-44](https://user-images.githubusercontent.com/73894812/117103261-fe8f0080-ad47-11eb-98ed-cbaeaa125056.gif)
.
    * Burg (1975) decided to use the Durbin-Levinson algorithm to minimimze this cost function and thus guarantee a resulting process that is stationary.
3. Maximum Likelihood
    * See below.

### Maximum Likelihood Estimator
Much work has been done recently by statisticians on the problem of obtaining maximum likelihood (ML) estimates of the parameters due to their well-known optimality properties. 
ML estimation of the ARMA(p,q) parameters involves iterative procedures that require starting values.

The log-likelihood function is given by:

![gif-45](https://user-images.githubusercontent.com/73894812/117103663-c3d99800-ad48-11eb-906d-3f130ae40c15.gif)

where ![gif-46](https://user-images.githubusercontent.com/73894812/117103692-d05df080-ad48-11eb-83cd-8e674d3947be.gif)
 is the unconditional sum of squares.
The solution of ![gif-19](https://user-images.githubusercontent.com/73894812/117104042-71e54200-ad49-11eb-8b7e-4ce573cb1cf9.gif)
, ![gif-33](https://user-images.githubusercontent.com/73894812/117103768-ecfa2880-ad48-11eb-9cd3-b7d796cb6685.gif)
, and ![gif-44](https://user-images.githubusercontent.com/73894812/117103776-f2577300-ad48-11eb-8560-c51419b5e41f.gif)
 that maximizes the above equations is the called the unconditional or exact ML estimates.

In practice, the derivatives of ![gif-47](https://user-images.githubusercontent.com/73894812/117103798-fedbcb80-ad48-11eb-875e-dd4dae37bd64.gif)
 are complicated, so approximations or conditional estimators are used instead.
A technique called backcasting (i.e., first estimating those values of ![gif-5](https://user-images.githubusercontent.com/73894812/117103858-203cb780-ad49-11eb-87bc-732645957427.gif)
 in the past) may be used to provide an approximation to ![gif-46](https://user-images.githubusercontent.com/73894812/117103867-25016b80-ad49-11eb-8e81-1a154b69ff62.gif)
.










