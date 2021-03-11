# Instructions

You may work together on this exercise.
Be sure to add your name to the author by line in the comments at the top of your script(s). 

1. Create utility R script(s) with functions that serve this analysis. Try to keep each script to a single (or single set) of utility functions. Provide a docstring with each function that described what it does, its expected inputs and outputs, and any dependencies on other functions. Publish your script(s) to our GitHub repository (atsa-2021/excercises/2.1 folder).
    * What function(s) did you create?
    * What does it do (e.g., inputs/outputs/procedure)?
    * How does it address this analysis?
2. Create a single R script that performs the following analysis. You may import utility functions from other R scripts by adding source function calls at the top of your script (e.g., `source("utility.R")`; be sure all your R scripts are in the same directory).
    1. Combine the twelve individual sensors' measurements into two versions of the site's data.  
        * an original time-sorted dataset
        * a duplicate-free time-sorted dataset

     For consistency across all scripts and computing platforms, access the data files from the URLs provided.
    1. Aggregate (using arithmetic means) the two individual time series into 15-minute, 60-minute, 12-hour, and 24-hour averages (i.e., create eight total versions of the original data).
    1. Calculate the correlation coefficient (Pearson's R), the coefficient of determination (r-squared), and root-mean-squared error (RMSE) for each of the four time aggregations of ADC0, ADC1, and ADC2 (converted to physical units) comparing the original versus duplicate-free data.
    1. Create three plots&mdash;one for each sensor (ADC0, ADC1, ADC2)&mdash;showing the original time-aggregated data plotted against the duplicate free data. Include the metrics in the plot.
