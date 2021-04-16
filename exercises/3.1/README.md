# Exercises 3.1.1

**Part 1.** Reproduce the figure below of atmospheric CO<sub>2</sub> concentrations (both seasonal and deseasonalized).
Attempt to match the plotting parameters, title and labels; you do not need to include the logo.

![](https://www.esrl.noaa.gov/gmd/webdata/ccgg/trends/co2_data_mlo.png)

**Part 2.** Recreate the deseasonlized time series using R modeling tools starting with the monthly average values.
Write down your thoughts on the methodology (i.e., prepare a pseudo code version) and implement a coding strategy that creates the deseasonalized CO<sub>2</sub> trend line.

# Exercises 3.1.2
For the MA(2) process represented by the following equation:

```
X(t) = a(t) + 0.2 a(t-1) - 0.48 a(t-2)
```

use the equation for autocorrelation for an MA(q) process to calculate by hand the following values: 

&rho;<sub>0</sub>, &rho;<sub>1</sub>, &rho;<sub>2</sub>, and &rho;<sub>3</sub>.

# Exercises 3.1.3

Calculate the autocorrelation at lags 0 through 10 for an AR(1) process with &phi;<sub>1</sub> = -0.7.
