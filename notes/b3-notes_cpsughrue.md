# Modeling and Prediction

## 3.0 Getting Started

#### 3.0.1 Detrending Time Series

Detrending is the act of removing a trend from time-series data to analyze subtrends that may not have been so obvious. The word "trend" usually refers to a global upwards or downwards shift over time. Detrending is crucial because it is the basis of ensuring a stationary process. Stationarity is a stochastic process whose joint probability distribution does not change when shifted in time (i.e., the mean and variance do not change over time). Many time series analysis models rely on the assumption of stationarity in their analysis.

In general, to detrend a times seres you begin with a curve fitting technique such as linear regression, polinomial regression, or logistic regression and subtract the linear approzimation from the time series. The residuals are the detrended time series.

<p align = "center">
<img src="http://scipy-lectures.org/_images/sphx_glr_plot_detrend_001.png">
</p>

#### 3.0.2 Linear Filters
In time series analysis a linear filter is a tool that can remove certain types of frequency behavior from a time series realization.

Common Terminology:
* <u>Passband</u>: range of frequencies that can pass through a filter
* <u>Stopband</u>: range of frequencies that can not pass through a filter

<p align = "center">
<img width="440" height="280" src="https://infosys.beckhoff.com/content/1033/tf3680_tc3_filter/Images/png/5844943371__Web.png">
</p>

Common Linear Filters:
* <u>Low Pass</u>: a filter that passes signals with a frequency lower than a selected cutoff frequency and reduces signals with frequencies higher than the cutoff frequency
* <u>High Pass</u>: a filter that passes signals with a frequency higher than a certain cutoff frequency and reduces signals with frequencies lower than the cutoff frequency
* <u>Band Pass</u>: a filter that passes frequencies within a certain range and reduces frequencies outside that range
* <u>Band Stop</u>: a filter that passes frequencies outside a certain range and reduces frequencies inside that range

<p align = "center">
<img width="497" height="370" src="https://www.allaboutcircuits.com/uploads/articles/6.13_Band-Pass_and_Band-Reject_Active_Filters1_.jpg">
</p>

Butterworth Filter:
* A filter desinged to have a frequency response as flat as possible in the passband
* "An ideal electrical filter should not only completely reject the unwanted frequencies but should also have uniform sensitivity for the wanted frequencies" -- Butterworth
* Can be any type of filter (low pass, high pass, ect.)


## 3.1 Time Series Models

#### 3.1.1 Seasonality
Many time series applications involve data that exhibit seasonality. Seasonality occurs when the data experiences regular and predictable changes that reacur over a given period of time. It is important to note that there is a difference between seasonal and cyclic behavior. A great explanation of the difference can be found on this StackExchange page (<a href="https://stats.stackexchange.com/a/234601">What is the difference between period cycle and seasonality?</a>). The equation for the seasonality is (Crawley, 2007)

<p align = "center">
y<sub>t</sub> = &beta;<sub>0</sub> + &beta;<sub>1</sub> &#183; sin(2&pi;t)
                                   + &beta;<sub>2</sub> &#183; cos(2&pi;t)
                                   + &alpha;<sub>t</sub>
</p>


#### 3.1.2 Moving Average
Moving averages are a smoothing technique used in time series analysis. To calculate a moving average, create a new series comprised of averages taken from subsets of the original data. A moving average is a low pass filter. As the size of the subset used to calculate the mean increases the amplitude of the series decreases.

<p align = "center">
<img width="373" height="315" src="https://a.c-dn.net/b/3Ziogk/moving-average_body_EURUSDMA.png.full.png">
</p>

A moving average (MA) process of order *q*, or more succinctly as a discrete time seres, *X*(*t*) with a mean &mu;, by the following equation where the &theta; values are real numbers and a<sub>t</sub> is a white noise process with zero mean and unit variance.

<p align = "center">
X<sub>t</sub> - &mu; = a<sub>t</sub> - &theta;<sub>1</sub>  &#183; a<sub>t-1</sub> 
                                     - &#8230;
                                     - &theta;<sub>q</sub>  &#183; a<sub>t-q</sub> 
</p>

Let *q* = 1 in our equation above such that:
<p align = "center">
    X<sub>t</sub> - &mu; = a<sub>t</sub> - &theta;<sub>1</sub>  &#183; a<sub>t-1</sub>
</p>

Let *q* = 2 in our equation above such that:
<p align = "center">
    X<sub>t</sub> - &mu; = a<sub>t</sub> - &theta;<sub>1</sub>  &#183; a<sub>t-1</sub>
                                         - &theta;<sub>2</sub>  &#183; a<sub>t-2</sub>
</p>


#### 3.1.3 Autoregressive
Autoregression is a time series model that uses observations from previous time steps as input to a regression equation to predict the value at the next time step. Specifically, the autoregressive model specifies that the output variable depends linearly on its own previous values and on a stochastic term. In other words autoregressive models use a linear combination of past vairables to predict a variable of interest.

The autoregressive (AR) process of order *p*, or more succinctly AR(*p*), may be expreesed as a discrete time series, *X*<sub>t</sub> with mean &mu;, by the following equation where a<sub>t</sub> is a white noise process with zero mean and unit variance and &varphi;<sub>1</sub>, &varphi;<sub>2</sub>, &#8230; , &varphi;<sub>p</sub> are real constants.

<p align = "center">
X<sub>t</sub> - &mu; - &varphi;<sub>1</sub> &#183; (X<sub>t-1</sub>  - &mu;)
                     - &varphi;<sub>2</sub> &#183; (X<sub>t-2</sub>  - &mu;)
                     - &#8230;
                     - &varphi;<sub>p</sub> &#183; (X<sub>t-p</sub>  - &mu;) = a<sub>t</sub>
</p>

Let *p* = 1 and assume &mu; = 0 in the equation above such that:
<p align = "center">
X<sub>t</sub> - &varphi;<sub>1</sub> &#183; X<sub>t-1</sub> = a<sub>t</sub>
</p>

Let *p* = 2 and assume &mu; = 0 in the equation above such that:
<p align = "center">
X<sub>t</sub> - &varphi;<sub>1</sub> &#183; X<sub>t-1</sub> 
              - &varphi;<sub>2</sub> &#183; X<sub>t-2</sub> = a<sub>t</sub>
</p>




## 3.2 Estimating Model Parameters
Suppose a realization is observed. To model the time series the next step is to estimate the model parameters. Estimating model parameters fall into two catagorites.

1. Order Identification
    * Estimation of:
        * *p* and *q*

2. Parameter Estimation
    * Estimation of:
        * &varphi;<sub>1</sub>, &varphi;<sub>2</sub>, &#8230;, &varphi;<sub>p</sub>
        * &theta;<sub>1</sub>, &theta;<sub>2</sub>, &#8230;, &theta;<sub>q</sub>
        * &mu;, &sigma;<sub>a</sub><sup>2</sup>

There are two basic methods for parameter estimation:
1. Preliminary Estimators: relatively easy and fast to compute  
2. Maximum Likelihood Estimators: iterative and (generally) computationally expensive

#### 3.2.1 MA(q) Estimators
In general, MA(q) parameter estimation is more difficult that AR(p) parameter estimation. Bellow are estimator methods for determining parameters for the MA(q) models. Methods of moments and the Innovations Algorithm are preliminary estimators.

1. Method of Moments
    * Parameters (&theta;<sub>1</sub>, &theta;<sub>2</sub>, &#8230;, &theta;<sub>q</sub>) are solved based on a series of non-linear equations that relate the MA(q) model to the autocorrelation function.
    * Real solutions may not exist.
2. Innovations Algorithm
    * Recursive algorithm
    * Fits moving average models of increasing order until estimates of &theta;<sub>1</sub>, &theta;<sub>2</sub>, &#8230;, &theta;<sub>q</sub> stabilize.
3. Mazimum Likelihood
    * See &sect;3.2.3 below


#### 3.2.2 AR(p) Estimators
For AR(p) models, Yule-Walker Estimators and  Ordinary-Lest Squares Estimators are two basic preliminary methods:

1. Yule-Walker Estimators (a mthod of moments estimation)
    * Based on the Yule-Walker equations
    * Requires Inverting
    * Estimates produce a stationary process 
2. Ordinary-Lest Squares Estimators
    * Based on minimizing a cost function
3. Maximum Likelihood
    * See &sect;3.2.3 below

#### 3.2.3 Maximum Likelihood Estimator
The maximum likelihood estimation (MLE) is a method of estimating the parameters of a probability distribution by maximizing a likelihood function. The likelihood function measures the goodness of fit of the parameters and describes a hypersurface whose peak represents the combination of model parameter values that maximize the probability of reproducing the observed data.

#### 3.2.4 Applications in R

Practical considerations for parameter estimation in R
* For AR models, the <code>est.ar.wge</code> function from R package, <code>tswge</code>, provides the Yule-Walker, Burg (based on FBLS), and Maximum Likelihood estimators.
* For ARMA models, the <code>est.arma.wge</code> function calculates the Maximum Likelihood estimators using a Kalman-filter based algorithm.
* For stationary models (AR, MA, and ARMA), it is best to use Maximum-Likelihood (ML) estimators when possible.
* For near nonstationary models, Yule-Walker estimators are especially poor; therefore, again it is best to use ML estimators.
* For AR models in particular, if you want a stationary model solution, use Burg or Yule-Walker, as some ML estimation techniques do not assure a stationary result.


#### 3.2.5 Order Identification

The Akaike information criterion (AIC) is a general criterion for statistical model identification such as identifying p and q in an ARMA(p,1) model (Akaike, 1973). The AIC deals with the trade-off between the goodness of fit of the model and the simplicity of the model.

Two simple ways to view the AIC:
1. An estimator of prediction error which can shed some light on the quality of a statistical model for a given time series data set.
2. An estimator of the realative amount of information lost by a given model. The less information a model loses, the higher the quality of the model.

WARNING: As the realization length increases, AIC tends to overestimate the model orders (i.e., select models with too many parameters)
