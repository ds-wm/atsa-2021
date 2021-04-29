# Overview
As with the last lab, you may again work in groups.
Be sure to indicate the names of everyone in your group.
The basic requirements are outlined below.

1. Background
    - Define what are filters and explain why we care about them.
    - Provide a few examples of filters and their application.
3. Methods
    - Find a dataset.
    - Provide some summary stats (e.g., number of samples, sampling interval, units)
    - Apply at least two types of filters (e.g., high-pass, low-pass, band-pass, or notch) testing at least two cut-off values.
        You may use the Butterworth (`butterworth.wge`) and/or the (three-point) moving average as your filters.
3. Results
    - Plot the realization, autocorrelation, periodogram of original data.
    - Replot the realization, sample autocorrelations, and Parzen window-based spectral density for each of the filtered realizations.
        Be sure to label your plots clearly.
4. Discussion/Conclusion
    - Discuss the cyclic behavior in the original data along with the effects that each filter had on the data.
