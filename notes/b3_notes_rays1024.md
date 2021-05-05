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

**Example 3.1**


![co2_data_mlo](https://user-images.githubusercontent.com/73894812/117099380-0007fb00-ad3f-11eb-94de-3e8143307b7e.png)

One of the famous trend datasets is the atmospheric carbon dioxide (CO<sub>2</sub>) measurements made at the [Mauna Loa](https://www.esrl.noaa.gov/gmd/obop/mlo/) Baseline Observatory in Hawaii.

A copy of the latest data is provided by the [Global Monitoring Laboratory](https://www.esrl.noaa.gov/gmd/ccgg/trends/) and is availble at the following address and includes both the monthly average CO<sub>2</sub> measurements as well as the deseasonalized trend.

- https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2/co2_mm_mlo.txt

It is sometimes helpful to perform a seasonal decomposition of a time series into its seasonal, trend and irregular components.
In R, this is accomplished using the `stl` function, which the seasonal decomposition of time series using LOESS (a locally weighted polynomial regression; for more information, see [here](https://www.itl.nist.gov/div898/handbook/pmd/section1/pmd144.htm)).
One catch to using the `stl` function is that the input must first be converted to a `ts` object.

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

