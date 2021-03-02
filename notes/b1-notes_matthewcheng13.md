

# Section 1 Notes
## Matthew Cheng

## Front Matter

### Jupyter Notebook
provides a cloud-based computation environment
* be sure to click "connect" in the top-right corner to access the runtime
* a green checkmark should appear
* you should save files in other locations

### R Runtime
* create a code cell by clicking "+ Code"
* click "Tools" -> "Keyboard shortcuts" to view other shortcut keys
* the runtime includes packages that we can view by typing "installed.packages()"
* the "library()" function can be used to add packages to your runtime as well
* if the package is unavailable, use "install.packages("name", dependencies = TRUE)" to install the package and any necessary dependencies
* calling "help" will tell you what the package does

### R Language
* R can be used as a calculator, as it has many built-in functions, including logarithmic, trigonometric, and more (see atsa lesson 1 ipynb for the full list)
* exponents can be handled using ^ or \*\*
* scientific notation: 4.5e5 (450000)
* integer division: %/%
* remainder: %%
* Inf stands for infinity
* NaN means not a number, but NA means not available/missing value
* TRUE and FALSE must be all caps, but can be represented with T and F
* <- or = means assignment
* \#:\# indexes from the first \# to the second \#
* indexing starts at 1 and not 0
* c() creates a vector
* logical expressions can also be used to index a vector, such as y[y > 5]

### Stats Primer
* there are three types of means, including arithmetic, geometric, and harmonic
* arithmetic is the most common method and calculated with <img src="[https://render.githubusercontent.com/render/math?math=\bar{y}](https://render.githubusercontent.com/render/math?math=\bar{y}) = \frac {\sum_{i=1}^{n} y(x_i)} {n}">
* geometric is for processes that change multiplicatively rather than additively and is calculated with <img src="[https://render.githubusercontent.com/render/math?math=\hat{y}](https://render.githubusercontent.com/render/math?math=\hat{y}) = \sqrt[n]{\prod_{i=1}^{n} y(x_i)}">
* harmonic is for processes that change rates and is calculated with img src="[https://render.githubusercontent.com/render/math?math=\tilde{y}](https://render.githubusercontent.com/render/math?math=\tilde{y}) = \frac {n} {\sum_{i=1}^{n} \frac {1} {y(x_i)}}">
* variance is a measure of the variability of the data (sum of the squares of the difference between the data and the arithmetic mean) and is calculated with <img src="[https://render.githubusercontent.com/render/math?math=\sigma](https://render.githubusercontent.com/render/math?math=\sigma)^2 = \frac {\sum_{i=1}^n [y(x_i)-\bar{y}]^2} {n-k}">, where k is the number of unknown parameters in the analysis
* standard deviation (same unit as data), <img src="[https://render.githubusercontent.com/render/math?math=\sigma](https://render.githubusercontent.com/render/math?math=\sigma) = \sqrt{\sigma^2}">
* standard error can measure the unreliability of the data in the same units of the data, <img src="[https://render.githubusercontent.com/render/math?math=s.e._{\bar{y}}](https://render.githubusercontent.com/render/math?math=s.e._{\bar{y}}) = \sqrt{\frac {\sigma^2} {n}}">

### R Markdown
* R markdown files (.Rmd) can be used to combine the text elements of markdown with executable code blocks
* can be rendered to HTML, PDF, and MS Word (or more with pandoc)
* make an R environment with "\`\`\`{r}" at the beginning of the code and "\`\`\`" at the end
* to make the code not execute, include "eval = FALSE" in the {r} statement
* to hide the code in the rendering, include "echo = FALSE"

## Intro to Time Series
Be sure to include the tswge package.

### Background
* a time series (type of stochastic process) is a collection of random variables where all random variables have a range of the real numbers and are defined on time
* time series can be continuous or discrete
* the expected value for a stochastic process is the ensemble mean (averaging along the ordinate)
* the covariance within the same time series is the autocovariance: <img src="[https://render.githubusercontent.com/render/math?math=\gamma(t_1,t_2)](https://render.githubusercontent.com/render/math?math=\gamma(t_1,t_2)) = E{[X(t_1)-\mu(t_1)][X(t_2)-\mu(t_2)]}">
* the autocorrelation of a time series: <img src="[https://render.githubusercontent.com/render/math?math=\rho(t_1,t_2)](https://render.githubusercontent.com/render/math?math=\rho(t_1,t_2)) = \frac {\gamma(t_1,t_2)} {\sigma(t_1)\sigma(t_2)}">
* the expected value can be written based on the sum of the (probabilities of each outcome times their realization) 

### Stationary Time Series
* ergodic process: in order to estimate the ensemble mean from a single realization, we use the concept of stationary (the behavior of a stationary time series does not change with time)
* for a time series to be strictly stationary:
	1. for any two times in the time series, their distributions must be the same
	2. all bivariate distributions must be the same for all values of h (as in X(t + h)
* for a time series to be covariance stationary:
	1. the expected value must equal the ensemble mean and be constant for all values of t
	2. the variance must be finite
	3. the autocovariance must only be dependent on the lag (<img src="[https://render.githubusercontent.com/render/math?math=t_{2}](https://render.githubusercontent.com/render/math?math=t_{2}) - t_{1}">)
	4. the autocovariance must be a semi-definite process (positive or zero for all scalar multiples)
* for a stationary time series, the natural estimate of the common mean is <img src="[https://render.githubusercontent.com/render/math?math=\bar{x}](https://render.githubusercontent.com/render/math?math=\bar{x}) = \frac {1} {n} \sum_{t=1}^{n} x_t">
* in a stationary time series, the autocovariance function has the following properties:
	1. the autocovariance at lag = 0 is equal to the variance
	2. the autocovariance at all other lags is less than or equal to that at lag 0 (Cauchy-Schwartz Inequality)
	3. since autocovariance doesn't depend on time, it is equal for lag h and lag -h
* the best estimate of the autocovariance from a single realization (sample) is <img src="[https://render.githubusercontent.com/render/math?math=\hat{y}_{h}](https://render.githubusercontent.com/render/math?math=\hat{y}_{h}) = \frac {1} {n} \sum_{t=1}^{n-\|h\|} (X_t - \mu)(X_(t+\|h\|) - \mu)"> but this is only true for values less than n
* the autocorrelation function, <img src="[https://render.githubusercontent.com/render/math?math=\rho](https://render.githubusercontent.com/render/math?math=\rho) (h) = \frac {\gamma(h)} {\sigma^{2}}">, has the properties:
	1. autocorrelation for lag 0 is 1
	2. all other autocorrelations are less than or equal to 1
	3. the autocorrelation is equivalent for h and -h
	4. it is a semi-definite process
* the sample autocorrelation function is: <img src="[https://render.githubusercontent.com/render/math?math=\hat{rho}_h](https://render.githubusercontent.com/render/math?math=\hat{rho}_h) = \frac {\gamma_h} {\gamma_0}">
* mean, variance, and autocorrelations are aspects of a time domain analysis of a time series
* frequency (inverse period) is measured in Hertz (cycles per second)
* a function is periodic if there exists a p such that <img src="[https://render.githubusercontent.com/render/math?math=g(t)](https://render.githubusercontent.com/render/math?math=g(t)) = g(t + kp)"> for all t and integers k (otherwise aperiodic)
* the autocovariance conveys information in the time domain and the spectrum (Fourier transform of the autocorrelation) expresses the equivalent information in the frequency domain
* spectral density can be estimated using: <img src="[https://render.githubusercontent.com/render/math?math=\hat{S}_{x}(f)](https://render.githubusercontent.com/render/math?math=\hat{S}_{x}(f)) = 1 + 2 \sum_{k=1}^{n-1} \hat{\rho}_{k}cos(2 \pi f k)"> (dependent on sample variance, autocovariance, and autocorrelation)
* periodogram (based on squared correlation between the time series and sinusoidal waves of frequency) estimates the spectral density of a signal
* having a spectral density peak at <img src="[https://render.githubusercontent.com/render/math?math=f](https://render.githubusercontent.com/render/math?math=f) = 0"> indicates little to no periodic behavior
* the spectrum can also detect the presence of cycles in data that are otherwise hidden
* the frequency in the spectral density can help estimate the period of the autocorrelation
