# **Block 3: Modeling and Predicting Notes**

Justin Callahan

\#Thursday, 8th April - This section uses the tswge R package.
install.packages(“tswge”) library(“tswge”) -**Detrending Data Sets**

-   We noticed back in lesson one that there were some non-periodic
    “trends” in our data. For the purpose of modeling, we should detrend
    these data sets as most assume a 0 mean.
-   Notice in the second half of the air temperature dataset over the
    Met Office’s Hadley Center, there is evidence of linear trends.
-   This dataset is one dimensional, in able to run regression we create
    a Time variable from scratch. From this point, we use the “predict”
    function
    (<https://www.rdocumentation.org/packages/car/versions/3.0-10/topics/Predict>)
    to subtract the predicted linear regression values from the actual
    data, in order to achieve a mean of 0.

\-**Seasonality**

Many time series applications involve data that exhibit seasonal cycles.
The commonest applications involve weather data. The equation for the
seasonal cycle is (Crawley, 2007):

yt=β0+β1sin(2πt)+β2cos(2πt)+αt

where β are coefficients (including the intercept) and αt is a white
noise process. - One of the famous trend datasets is the atmospheric
carbon dioxide (CO2) measurements made at the Mauna Loa Baseline
Observatory in Hawaii. A copy of the latest data is provided by the
Global Monitoring Laboratory and is availble at the following address
and includes both the monthly average CO2 measurements as well as the
deseasonalized trend.
<https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt> -
It is sometimes helpful to perform a seasonal decomposition of a time
series into its seasonal, trend and irregular components. In R, this is
accomplished using the stl function, which the seasonal decomposition of
time series using LOESS (a locally weighted polynomial regression; for
more information, see here). One catch to using the stl function is that
the input must first be converted to a ts object.

-   Exercise 3.1.1 Reproduce the figure above of atmospheric CO2
    concentrations (both seasonal and deseasonalized). Can you recreate
    the deseasonlized time series using R modeling tools starting with
    the monthly average values? Write down your thoughts on the
    methodology (i.e., prepare a pseudo code version) and begin
    implementing code that creates the deseasonalized CO2 trend line.

# Thursday, 15th April

**Moving Average**

A moving average (MA) process of order q, or more succinctly MA(q), may
be expressed as a discrete time series, X(t) with mean μ, by the
following equation.

Xt−μ=at−θ1at−1−…−θqat−q

where the θ values are real numbers and at is a white noise process with
zero mean and unit variance. Note that an MA(q) process is a general
linear process with a finite number of terms. From this we can calculate
the variance of our time series:

σ2x=σ2a(1+θ21+…+θ2q)

as well as the autocovariance for lag k:

γk=σ2a\[−θk+∑j=1q−kθjθj+k\],=0,k=1,2,..,qk\>q

and the autocorrelation for lag k:

ρk=−θk+∑q−kj=1θjθj+k1+∑qj=1θ2j,=0,k=1,2,..,qk\>q

-   MA(1) Model

q=1 in definition above

Xtμ=at−θ1at−1

as θ1→0, the MA(1) process approaches white noise. The autocorrelation
function simplifies to:

ρk=−θk/1+θ1^2

Negative Theta: exhibits a high-frequency behavior, which is to say that
there seems to be a very short period in the data. This behavior can be
attributed to the negative correlation between successive values in the
series.

Positive Theta: not as highly oscillatory (due to the positive
correlation between successive values in the series). More of a
wandering behavior.

-   MA(2) Model q=2 in definition above

Xt=at−θ1at−1−θ2at−2

Using an example, Xt=at+0.2at−1−0.48at−2, we can see that the
realizatioin has correlations at k=1 and k=2 and that the sign of the
correlation changes in association with the coefficients, θ1 and θ2.

The simplest way of seeing a pattern in a time series is to plot the
moving average and one useful summary statistic to have on hand is the
three-point moving average:

Xt′=(Xt−1+Xt+Xt+1)/3

In R:

ma3 \<- function(x) {

y \<- numeric(length(x) - 2)

for (i in 2:(length(x)-1)) {

    y[i]<-(x[i-1] + x[i] + x[i+1])/3

}

y

}

-   Note that a moving average can never capture the maxima or minima of
    a series (because they are averaged away). Note also that the
    three-point moving average is undefined for the first and last
    points in the series.

Exercises 3.1.2 For the MA(2) realization above and using the equation
for autocorrelation, calculate by hand the following values: ρ0, ρ1, ρ2,
and ρ3.

-   **Autoregressive** The autoregressive (AR) process of order p, or
    more succinctly AR(p), may be expreesed as a discrete time series,
    Xt with mean μ, by the following equation.

Xt−μ−ϕ1(Xt−1−μ)−ϕ2(Xt−2−μ)−…−ϕp(Xt−p−μ)=at

where at be a white noise process with zero mean and unit variance and
ϕ1,ϕ2,…,ϕp are real constants. Oftentimes, we assume the time series has
μ=0, which simplifies the expression to:

Xt−ϕ1Xt−1−ϕ2Xt−2−…−ϕpXt−p=at

-   AR(1) Model

p=1 in equation above

Xt−ϕ1Xt−1=at

where \|ϕ1\|≤1 (a requirement for stationarity). The stationary
conditions for the AR(1) process are such that:

Xt=∑k=0∞ϕ1kat−k

which gives way to the characteristic equation:

1−ϕ1r=0

that has a single root:

r1= 1/ϕ1

The autocovariance is given generally by:

γk=(ϕ1^(\|k\|))γ0

where γ0=σa<sup>2(1−ϕ1</sup>2)^−1 and the autocorrelation is given by:
ρk=ϕ1^\|k\|

-   Example 1: Xt−0.95Xt−1=at

Notice the model no longer depends on the white noise.

-   The plot of this realization shows a tendency for observations to
    remain positively correlated across several lags resulting in
    several lengthy runs or a wandering behavior. The autocorrelations
    for this realization show that there is strong positive correlation
    between adjacent observations. This suggests that this realization
    should exhibit a tendency for xt+1 to be fairly close to xt. We can
    see that this positive correlation holds up for a long time. As
    indicated in the equation above, notice that ρ10=0.9510≈0.6. This
    persistence of the correlation when ϕ1≈1 is refered to as near
    nonstationarity.

-   From the periodogram, it can be seen that when ϕ1\>0, the spectral
    density has a peak at f= 0, indicating that the associated
    realizations will tend to wander about the mean with no distinct
    periodic behavior. That is, the data are primarily low frequency
    with no real periodic tendency.

-   Example 2: Xt+0.7Xt−1=at

As expected, this realization has an oscillatory nature associated with
negative ϕ1. As ϕ1→0, the AR(1) approaches white noise, so that
realizations with ϕ1≈0 can be expected to look much like white noise. We
see that the autocorrelations for negative values of ϕ1 show an
oscillating behavior.

-   In other words, ρ1=−0.7 indicates that if a value at time t is above
    the mean then the value at time t+1 will tend to be below the mean,
    and vice versa. Similarly, ρ2=(−0.7)^2=0.49, then the value at t+2
    will tend to be on the same size of the mean as the value at time t.
    The dampening effect of the smaller magnitude of ϕ1 is evident when
    compared to the previous realization with ϕ1=0.95.The spectral
    density for ϕ1\<0 has a maximum at f = 0.5, indicating that the data
    will tend to have a highly oscillatory nature with period of
    about 2.

-   Exercise 3.1.3 Calculate the autocorrelation at lags 0 through 10
    for an AR(1) process with ϕ1=−0.7.

\#Tuesday, 20th April

**Estimating Model Parameters**: Suppose a realization x1, x2, …, xn is
observed. The problem of fitting an ARMA(p,q) model to the data is the
problem of estimating:

p, q

ϕ1, ϕ2, …, ϕp

θ1, θ2, …, θq

μ, σa2

The estimation of p and q is called order identification. An analysis of
a time series using an ARMA model (i.e., a process that is the
combination of AR(p) and MA(q) models) will typically first involve
order identification followed by parameter estimation. The dichotomy
between the order identification and parameter estimation steps is not
clear-cut since the order identification techniques usually involve some
parameter estimation as a means of selecting the appropriate model
orders. In practice, parameter estimation is almost always accomplished
using a time series package. There are two basic types of estimators
(assuming that the order of the model is already known):

Preliminary Estimators: relatively easy and fast to compute

Maximum Likelihood Estimators: iterative and (generally) computationally
expensive

-   MA(q) Estimators:

In general, MA(q) parameter estimation is more difficult that AR(p)
parameter estimation.

The following are estimator methods for determining parameters for the
MA(q) models. The first two methods, the Method of Moments and the
Innovations Algorithm are preliminary estimators.

Method of Moments:

Parameters (θ1, θ2, …, θq) are solved based on a series on non-linear
equations that relate the MA(q) model to the autocorrelation function.
Real solutions may not exist.

This method (in general) is not recommended.

Innovations Algorithm:

Based on recursive fitting of MA models of increasing order until
estimates of θ1, θ2, …, θq stabilize.

-   AR(p) Estimators:

Yule-Walker Estimators (a method of moments estimation): Based on the
Yule-Walker equations; most importantly is the difference equation that
relates the coefficients in the AR(p) model to the autocorrelation
function: ρk=ϕ1ρk−1+…+ϕpρk−p

Substituting estimates of autocorrelations, ρk, produces a set of linear
equations that may be solved for ϕ1, ϕ2, …, ϕp.

Requires inverting.

Estimates always produce a stationary process.

Ordinary-Least Squares Estimators (the Burg method): Based on minimizing
the cost function, Sc

Sc=∑t=p+1na^t2

Non-traditional OLS method (Xt and μ are simultaneously playing the role
of dependent and independent variables and predictors are correlated);
thus, cannot be solved using a standard OLS package.

Ignores data X1 to Xp (because Xt−p is undefined).

Improved upon by Ulrych & Clayton (1976), who argued no preference in
the direction of time (i.e., the driving process forward is the same
process driving backward)—created the Forward-Backward Least Squares
(FBLS) method:

Sc=∑t=p+1na^t2+∑t=1n−pδt2

where δt are white noise with zero mean and variance, σa2. Burg (1975)
decided to use the Durbin-Levinson algorithm to minimimze this cost
function and thus guarantee a resulting process that is stationary.

-   Maximum Likelihood Estimator:

Much work has been done recently by statisticians on the problem of
obtaining maximum likelihood (ML) estimates of the parameters due to
their well-known optimality properties. ML estimation of the ARMA(p,q)
parameters involves iterative procedures that require starting values.

log-likelihood function:
l(ϕ1,…,ϕp,θ1,…,θq)=−(n/2)ln(2πσa<sup>2)+12ln\|Mp\|−(Su/2σa</sup>2)

where Su is the unconditional sum of squares. The solution of ϕ1, …, ϕp,
θ1, …, θq, and σ2a that maximizes the above equations is the called the
unconditional or exact ML estimates.

In practice, the derivatives of ln\|Mp\| are complicated, so
approximations or conditional estimators are used instead. A technique
called backcasting (i.e., first estimating those values of Xt in the
past) may be used to provide an approximation to Su.

-   Applications in R

For AR models, the est.ar.wge function from R package, tswge, provides
the Yule-Walker, Burg (based on FBLS), and Maximum Likelihood
estimators. For ARMA models, the est.arma.wge function calculates the
Maximum Likelihood estimators using a Kalman-filter based algorithm.

For stationary models (AR, MA, and ARMA), it is best to use
Maximum-Likelihood (ML) estimators when possible.

For near nonstationary models, Yule-Walker estimators are especially
poor; therefore, again it is best to use ML estimators.

For AR models in particular, if you want a stationary model solution,
use Burg or Yule-Walker, as some ML estimation techniques do not assure
a stationary result.

Coding Example 1: AR(4)

Xt−1.15Xt−1+0.19Xt−2+0.64Xt−3−0.61Xt−4=at

Code:

options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)

ar.ts3 \<- plotts.true.wge(

n=200,

phi=c(1.15, -0.19, -0.64, 0.61),

theta=c(0),

vara = 1,

lag.max = 40)

Now, use the est.ar.wge function to estimate parameters using each of
the three methods in the table below.

-   Yule-Walker

ex324.yw \<- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type=‘yw’)

-   Burg (based on FBLS)

ex324.burg \<- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type=‘burg’)

-   Maximum-Likelihood Estimators

ex324.mle \<- est.ar.wge(ar.ts3$data, p=4, factor = FALSE, type=‘mle’)

-   Extract the parameter estimates for theta’s and white noise variance

ex324.df \<- data.frame(

type=c(“True”, “YW”, “Burg”, “MLE”),

phi1 = c(1.15, ex324.yw*p**h**i*\[1\], *e**x*324.*b**u**r**g*phi\[1\],
ex324.mle$phi\[1\]),

phi2 = c(-0.19, ex324.yw*p**h**i*\[2\], *e**x*324.*b**u**r**g*phi\[2\],
ex324.mle$phi\[2\]),

phi3 = c(-0.64, ex324.yw*p**h**i*\[3\], *e**x*324.*b**u**r**g*phi\[3\],
ex324.mle$phi\[3\]),

phi2 = c(0.61, ex324.yw*p**h**i*\[4\], *e**x*324.*b**u**r**g*phi\[4\],
ex324.mle$phi\[4\]),

siga = c(1.0, ex324.yw*a**v**a**r*, *e**x*324.*b**u**r**g*avar,
ex324.mle$avar)

)

Ex324.df

Notice that all three methods produce similar results.

-   Coding Example 2: MA(2)

Xt=at−1.37at−1+0.72at−2

Code:

options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)

ma.ts3 \<- plotts.true.wge(

n=200,

phi=c(0),

theta=c(1.37, -0.72),

vara = 1)

Now, use the est.arma.wge function to estimate parameters. Notice that
only the Maximum-Likelihood method for estimation is available.

ex.ma \<- est.arma.wge(ma.ts3$data, q=2)

print(ex.ma$theta)

print(ex.ma$avar)

-   Order Identification

One of the challenges with estimating model parameters is knowing the
order identification. How can we find the best model order?

Akaike’s Information Criterion (AIC) is a general criterion for
statistical model identification with a wide range of applications,
including model selection in multivariate regression and, in our case,
identifying p and q in an ARMA(p,q) model (Akaike, 1973).

A problem with the use of AIC is that as the realization length
increases, AIC tends to overestimate the model orders (i.e., select
models with too many parameters).

Several authors have considered modifications to AIC to adjust for this
problem. Two of the popular alternatives are AICC (Hurvich and Tsai,
1989) and BIC (sometimes called the Schwarz Information Criterion)
(Schwarz, 1978).

In R, the aic.wge function is an automated means of finding the ARMA(p,
q) model order identification (within specified ranges of p and q) and
returns the best fit model orders (i.e., p and q) along with the model
parameter estimates: θq, ϕp, and σa^2 (based on MLE).

Example:

Data: Annual average sunspot numbers from 1749-2008 (ss08)

Code:

data(ss08)

options(repr.plot.width=12, repr.plot.height=6, repr.plot.res = 125)

plot(

ts(ss08, start=c(1749), freq = 1),

ylab = “Ave. Sunspot Number”

)

-   How many samples?

length(ss08)

For a large n, it is better to use AICC or BIC. In this case, the number
of samples is not so large (260); therefore, we could try all three
methods.

aic.wge(ss08, p=0:12, q=0:4, type=“aicc”)

Notice that all three criteria suggest the same best-fitting model
(AR(9)).

-   Exercise 3.2.5

Fit an AR(p) model to the 2014 daily average Dow Jones stock price found
in the dowjones2014 dataset. Plot the realization. Include all parameter
estimates (i.e., ϕp and σa^2) based on the three estimator methods
(i.e., Yule-Walker, Burg and Maximum-Likelihood). Compare the results of
these three methods.

\#Tuesday, 27th April

**Filters:**

What is a filter?

A filter is something that uses a set of criteria to select specific
points from a group that meet these criteria, in order to weed out
instances that are not necessary. In the context of data, it is used to
selectively highlight specific points of data to analyze.

What are some different types of filters?

Filters are used in a variety of forms. They are used in physical forms
such as cooking or chemistry in order to remove unwanted ingredients and
chemicals that are already mixed in with the desired ingredients and
chemicals. They are also used in virtual forms, such as photo filters
that remove imperfections from photos, as well as in data science to do
away with large amounts of unnecessary data in order to find the
specific desirable data.

What are some applications of filters?

Filters can be used in data science to take a subset of a larger data
set or to remove duplicate values from a data set.

-   Butterworth Filter:

What is the Butterworth filter and explain the inputs to the
butterworth.wge function.

The Butterworth filter is one of the more common and popular linear
filters used by scientists and engineers. Frequencies are passed through
this data and are filtered out by a specified cutoff point. There are
four different types of filters to filter the frequencies by different
criteria.

Low-pass filters: Higher frequencies are filtered out

High-pass filters: Lower frequencies are filtered out

Band-pass filters: frequencies are filtered out if they are outside of a
given range.

Band-stop filters: frequencies are filtered out if they are within a
given range.

butterworth.wge: Perform Butterworth Filter
(<https://www.rdocumentation.org/packages/tswge/versions/1.0.0/topics/butterworth.wge>)

Description: “The user can specify the order of the filter, and whether
it is low pass (”low“), high pass (”high“), band stop (”stop“), or band
pass (”pass“) filter. Requires the CRAN package ‘signal’.”

butterworth.wge(x, order, type, cutoff,plot=TRUE) where

x= Realization to be filtered

Order = Order of the Butterworth filter (Higher orders have more severe
impacts on frequencies that are filtered out in a low-pass filter with a
high degree.

Low Order: Low impact on spectral density.

High Order: More ideal for low-pass filters, much larger impact as N
increases.

Type = Either “low”, “high”, “stop”, or “pass”

Cutoff = For “low” and “high”: cutoff is a real number. For “stop” and
“band”: cutoff is a 2-component vector.

Plot = Either TRUE or FALSE. If plot=TRUE then plots of the original and
filtered data are produced.

(“Applied Time Series Analysis with R, 2nd edition” by Woodward, Gray,
and Elliott)
