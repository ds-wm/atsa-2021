# Modeling and Prediction
## Getting Started
We will be using the `tswge` R package.
## Detrending Time Series
Often times we find that the time series data we are working with has some type of trend.

This was evident in the latter portion of the air temperature dataset over the Met Office's Hadley Center.

```R
data(hadley)
options(repr.plot.width=14, repr.plot.height=6, repr.plot.res = 125)
plot(hadley[50:length(hadley)], ylab="air temp")
```
![alt text](https://https://github.com/ds-wm/atsa-2021/blob/main/notes/img/download.png)
