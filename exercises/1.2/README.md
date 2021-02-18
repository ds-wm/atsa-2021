**Exercise 1.2**

Calculating the sample means and sample autocorrelations.

1. Load the dataset `ss08` and visualize it.
    Try both the base plot in R and the `plotts.wge` function provided by the textbook.
1. Calculate the average of this time series realization using the `mean` function.
1. Load the dataset `hadley` and plot the sample autocorrelations and sample autocovariances using the `acf` function
1. Write the equations for &Hat;&gamma;<sub>0</sub>, &Hat;&gamma;<sub>1</sub>, &Hat;&rho;<sub>0</sub> and &Hat;&rho;<sub>1</sub> and compute them using R (note the hats, &Hat;, are to represent the estimators).
1. Plot the time series and the periodogram for Figure 1.10a of Woodward et al. (`fig1.10a`). Note that the sampling rate for the x-axis is in 1/10ths.  What are the three dominant frequencies of this dataset?
1. The time series in Figure 1.10a (Woodward et al.) can be expressed as the following:

    
    X(t) = cos(2&pi; t f<sub>1</sub>) + 1.5 cos(2&pi; t f<sub>2</sub> + 1) + 2 cos(2 &pi; t f<sub>3</sub> + 2.5)
    

    where f<sub>1</sub>, f<sub>2</sub>, and f<sub>3</sub> are the three dominant frequencies (in order from lowest to highest) found in the previous question.
    Replace the frequencies you found in the equation above and recreate using R the Figure 1.10a using values for t &in; (0, 100) (e.g., `x <- 0:1000/10`).
