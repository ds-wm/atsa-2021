## Lab assignment

In this lab, you will be looking to identify doubful observations based on the theoretical linear relationship between net ecosysytem exchange (NEE)&mdash;the amount of carbon released or absorbed into our atmosphere&mdash;and incoming shortwave radiation (SW<sub>in</sub>)&mdash;energy received from the sun. 
In theory, more energy from the sun supports for more vegetation, which in turn, absorbs more carbon from the atmosphere.

In order to produce models of this relationship, observation data (provided by FLUXNET) are used from across the world.
To improve model performance, doubtful observations are identified and removed using the robust statistical method of Peirce's criterion.

You may work in teams of two to four.

1. Introduction
   - Do some research and come up with a definition of "outliers" and provide one or two examples of where they are found, what causes them, and why we should care about them.
   - Do some research on Peirce's Criterion for the rejections of doubtful observations.
       Give a summary of what this method does and how it accomplishes it.
   - Find at least one other method for outlier identification and give your impression on the benefits and/or drawbacks of Peirce's criterion compared to the other method(s) you found.
   - Provide an introduction to FLUXNET and their 2015 dataset. 
2. Methods 
    - Read over &sect;11.2 of the GePiSaT documentation (https://bitbucket.org/labprentice/gepisat/), paying special attention to the algorith and example code in Appedix A.1 and A.2. 
        Note that this code is written in Python and uses the SciPy error function, which can be reproduced in base R with the `pnorm` function (*hint*: read the Wikipedia article for Peirce's criterion).
    - In R, reproduce the algorithm to find outliers in the April 2004 time series based on a linear model fitting SW<sub>in</sub> (independent variable) against NEE (dependent variable). 
        Ignore the fact that some SW<sub>in</sub> and NEE values are not true observations (i.e., use the dataset 'as is').
        A linear model using ordinary least squares method is achieved in base R with the `lm` function, which, if saved to an object, provides the coefficients (including the intercept) and residuals.
        Check the variables or documentation of `lm`.

        ```R
        help(lm)
        lin.mod <- lm(df$SW_IN_F ~ df$NEE_VUT_REF)
        lin.mod$residuals
        ```
    - Repeat the process until all outliers are identified
3. Results
    - Create a scatter plot of SW<sub>in</sub> versus NEE that identifies the outliers from the original data with appropriate title, labels and legend.
    - Explain what is being shown in the figure.
    - Answer the question: how many outliers were found in the dataset?
4. Discussions and conclusions
    - Reflect on your methods and results, what worked and what didn't work, what were the challenges you faced, were the results as you expected, what inferences (if any) can you make.
5. References
     - Include an alphabetized list of your references for all citations used.
