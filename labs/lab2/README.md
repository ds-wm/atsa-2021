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
        lin.mod <- lm(df$NEE_VUT_REF ~ df$SW_IN_F)
        lin.mod$residuals
        ```
    - Repeat the process until all outliers are identified
3. Results
    - Create a scatter plot of SW<sub>in</sub> versus NEE that clearly identifies the outliers from the original data with appropriate title, labels and legend.
    - Explain what is being shown in the figure.
    - Answer the question: how many outliers were found in the dataset?
4. Discussions and conclusions
    - Reflect on your methods and results, what worked and what didn't work, what were the challenges you faced, were the results as you expected, what inferences (if any) can you make.
5. References
     - Include an alphabetized list of your references for all citations used.

## Lab Groups

| Group | Members | Feedback |
| ----: | :------ | -------- |
| 1 | Andrew, Asha, Kelton, Monica | [(.mp3)][grp1mp3] |
| 2 | Joe, John, Matthew C., Alex | [(.mp3)][grp2mp3]
| 3 | Connor, Keagan, Matthew M., Conrad | [(.mp3)][grp3mp3] |
| 4 | Katherine | [(.mp3)][grpkelmp3] |
| 5 | Rini, Jaci, Kimya, David | [(.mp3)][grp5mp3] |
| 6 | Peter | [(.mp3)][pwoomp3] |
| 7 | Ray | [(.mp3)][raymp3] |

[grp1mp3]: https://www.dropbox.com/s/yth163c1g2ei0eq/lab2_group1.mp3?dl=0
[grp2mp3]: https://www.dropbox.com/s/xe238fp49merwkx/lab2_group2.mp3?dl=0
[grp3mp3]: https://www.dropbox.com/s/8k7qzf4zgq14ln3/lab2_group3.mp3?dl=0
[grpkelmp3]: https://www.dropbox.com/s/fsyeqtvsun775j3/lab2_kelannen.mp3?dl=0
[grp5mp3]: https://www.dropbox.com/s/7hk2xx6pftk4f2k/lab2_group5.mp3?dl=0
[pwoomp3]: https://www.dropbox.com/s/5cjgprcsphjlq1g/lab2_peterwoo.mp3?dl=0
[raymp3]: https://www.dropbox.com/s/dkrkfy91s98oadi/lab2_rays1024.mp3?dl=0
