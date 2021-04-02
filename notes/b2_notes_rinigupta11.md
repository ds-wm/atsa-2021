# Block 2 Notes
Rini Gupta 
4/2/21
Applied Time Series Analysis 

## General Outline of Class Days:
| Date | What We Did |
|--|--|
| 3/30 | We went over the code snippets/exercises/lab. |
| 3/25 | We discussed options for the exam/lab due dates and decided on a soft deadline of April 4th for the exam/lab/exercises and a hard deadline of April 9th after spring break. We went over how to calculate $I_o$. We went back into our breakout rooms to continue working on exercise 2.2 |
| 3/23 | We went over the theoretical background of the SPLASH model used to calculate missing values. More notes on this topic can be found below. |
| 3/18 | We started discussing the background for the second case study and were assigned a discussion post to write our first impressions and how we might approach solving for $I_o$ |
| 3/16 | Continue working in breakout rooms for Exercise 2.1 |
| 3/11 |  Go into breakout rooms to start working on Exercise 2.1|
| 3/9 | Started introduction of Case Study 1 |

## Three Primary Challenges of Block 2
### Data Duplication
Data duplication occurs when there are repeated observations within a dataset. In the context of Case Study 1, data duplication could occur when a node does not receive acknowledgement from its neighbor that the message was actually received (Davis 2012). Data duplication is a problem outside of the context of Case Study 1 as well. Data duplication can lead to data anomalies [(more information here)](https://www.thecomputingteacher.com/csc/index.php/man-data/data/data-duplication-redundancy). The process of [data deduplication](https://www.druva.com/blog/a-simple-definition-what-is-data-deduplication/) involves removing repeated observations from a dataset. Data duplication can be negative because of the [amount of storage](https://www.druva.com/blog/a-simple-definition-what-is-data-deduplication/) repeated observations take up. For example, if there are 100 identical attachments in 100 emails, each member of a company saving that image results in 100x more storage capacity used than needed. Because analysis of datasets usually involves computation, removing redundant data points can speed up the process of mathematically analyzing observations. It is possible for a multitude of research that utilizes real-life data to encounter the problem of data duplication.
### Gap Filling
Missing data is an unavoidable part of most datasets, especially those with real-life data collection. When conducting research, bridging the gaps in the missing data can be helpful in order to complete analysis of the dataset. In the case of the second study, we need a time series of solar data; however, there are a lot of gaps in the dataset. In this case study, we used the Simple Process-Led Algorithms for Simulating Habitats (SPLASH) algorithm to fill in the missing data.  The "process of replacing missing values" is called [imputation](https://cran.r-project.org/web/packages/imputeTS/vignettes/imputeTS-Time-Series-Missing-Value-Imputation-in-R.pdf). There are a variety of R packages to replace missing data, namely AMELIA, mice, VIM, and missMDA. These packages only work on multivariate datasets. For univariate datasets, the imputeTS package is useful. (More information can be found in the R documentation here https://cran.r-project.org/web/packages/imputeTS/vignettes/imputeTS-Time-Series-Missing-Value-Imputation-in-R.pdf). Gap filling is a common problem with time series data in particular because of the nature of the data needing prior and later data to analyze. 

### Outliers 
Outliers are data points that lie outside of expectations. Removing outliers can improve model performance. In the context of the lab, we seek to identify doubtful observations and utilize Peirce's criterion to robustly identify outlier values with a statistical foundation. Peirce's criterion is an early example of identifying outliers, but there are a multitude of different approaches in the world of academia for identifying outliers today depending on if the outliers are univariate or multivariate. There are [different classifications](https://towardsdatascience.com/a-brief-overview-of-outlier-detection-techniques-1e0b2c19e561) of outliers as well such as point outliers, contextual outliers, and collective outliers. Other methods for detecting outliers include z score analysis, linear regression models, information theory models, and high dimensional outlier detection methods. 

[TowardsDataScience](https://towardsdatascience.com/a-brief-overview-of-outlier-detection-techniques-1e0b2c19e561) lists the most common cause of outliers to be...
-  " Data entry errors (human errors)
-   Measurement errors (instrument errors)
-   Experimental errors (data extraction or experiment planning/executing errors)
-   Intentional (dummy outliers made to test detection methods)
-   Data processing errors (data manipulation or data set unintended mutations)
-   Sampling errors (extracting or mixing data from wrong or various sources)
-   Natural (not an error, novelties in data) "

## Lecture Notes

### Introduction to Case Study 1: Data Duplication
Case study 1 involves wireless sensor nodes placed out in the real world (specifically in Pennsylvania) to see how effective wireless sensor networks are in natural outdoor conditions. The goal of this case study is to analyze the effects of data duplication on the results of analysis. We will be using datasets uploaded to GitHub and attempting to remove duplication within these datasets. Furthermore, we will aggregate this data by time and calculate means. 

### Case Study 2: Gap Filling: Lecture Notes 
- Solar radiation is a metric we care about when we are modeling plant growth 
- US Goo is in Mississippi and that is what we will be examining 
- There are large gaps in the data from a random month in Mississippi 
- The question is how do we fill in the gaps?
- SPLASH model gives robust indices of radiation, evapotranspiration, and plant available moisture. 
#### 2.3 Extraterrestrial Solar Radiation Flux (SPLASH Documentation)
- Radiation matters the most for what we are concerned about
- Specifically, we care about $I_o$ which is the extraterrestrial solar radiation flux 
- $I_o$ gives us the discrete time series that we want, but it is on the outer edge of Earth's atmosphere. 
- The scaling factor in the equation $Q_{gap} = fFEC \times \frac{\int_{day} SW_{down}}{H_o} \times I_o$ takes account of all the weird atmospheric stuff like pollution and different types of air. 
- $H_o$ comes from the solar.R script from the SPLASH code. 
- $fFEC$ is a conversion factor 
- We have a lot of observations that have been turned into composites 
- - $I_o = I_{sc} d_r cos(\theta_z)$ 
- The term $cos(\theta_z)$ can be viewed as a time series 
- $I_{sc}$ = 1360.8 watts per meter squared
- $d_r$ is the distance factor -- it accounts for the variability of solar radiation that reaches the earth due to the relative change in distance between the earth and the sun caused by the eccentricity of Earth's orbit (SPLASH Documentation) 
	- Equivalent to 1/the relative earth-sun distance squared
	- The relative earth sun distance is $\frac{r}{a}$ where $r$ is the distance from the earth to the sun in km and $a$ is the length of the semi-major axis of Earth's orbit, km. 
- The semi major axis of Earth's orbit does not change significantly 
	- $r = \frac {a(1-e^2
	)}{1+e cos(\nu)}$ 
	e is eccentricity
- The calendar we currently use was predicated on the Julian calendar but is called the Gregorian calendar
	- The calendar changes over time to include little bits of new information that we learn over time. Calendars are essentially arbitrary. 
	- Eccentricity basically does not change so we can ignore higher orders
	- A Fourier transform is a combination of sines and cosines 
	- The **declination angle** is the angular position between the sun at solar noon and the earth's equator 
		- Basically , declination angle = $arcsin(sin($heliocentric longitude relative to the vernal equinox$)sin($the obliquity  of earth's axis in radians$))$ 
		- Obliquity is constant 
- Clock time is not the same as solar time, solar time is constant and clock time is arbitrary 
- Clock time is based on universal time which is based on Greenwich mean time
- $t_s = LCT + \frac{EOT}{60} - LC - DS$
	- LCT = local clock time
	- EOT = equation of time (difference between mean solar time and true solar time)
	- LC = longitudinal correction factor
	- DS = daylight savings correction factor, h
### Coding Section: 
- The script is called solar.R 
- dcos and dsin functions calculates the cosine/sine of an angle in degrees
- You can get the number of days in a specific year, N, by calling the julian_day function which includes the equation $N =$ julian_day $(y+1, 1, 1) -$ julian_day $(y, 1, 1)$
- The julian_day function gets the number of days since a particular epoch
- You can get the current day of the year, $n$, using the same function and this formula
$n =$ julian_day$(y, m, i)$ - julian_day$(y, 1, 1) + 1$
- Prefix lowercase k is for constant in the code 
- get_daily_solar depends on dcos and dsin
	- Fraction of sunlight hours and air temperature parameters are optional
	- The function includes some checks for bad input 
	- You can get the latitude for the US Goo by going to the linked site in the Colab Notebook
	- The output of this function is a list with all of the variables as dollar signs 
- Now, how do we get the discrete time series $I_o$
	- We started by creating an empty function and listing out what we need for that function in a comment 
	- We also had to convert python to R 
	- We could use the Rscript we already had to extract the dr, ru, and rv using the calc_daily_solar function
	- w_hh was copy pasted which required ts_hh
		- We then copied and pasted ts_hh and continued copying and pasted all the variables that each variable was dependent on
		- There is no int function in R, so we had to add some additional steps using the floor function to achieve the same result 
		- We could also pull kN from existing R script
		- Had to add the long way in R because there is no += syntax in R
		- A good way to check if you changed code correctly from language to language is to run it in both and see if you get the same answer 
		- If sunlight is negative, then it is not shining on you so it should be changed to zero 
### Lecture on the Lab
- Same dataset as Exercise 2.2
- This time we are looking at outliers 
- Figure out why there is a big debate in the scientific community about what to do with outliers
- **Peirce's Criterion** 
	- You can actually look at the original publication he wrote from 1852
	- Method he wrote was very ahead of his time
	- Gould came up with lookup tables that provided some value before computers/widespread calculators
	- The US postal service used this in the 1800s
	- The Chauvenet method is what gets discussed the most 
	- Prof. Davis thinks that the most robust and scriptable method is Peirce's criteria 
		- Statistically based
		- Can find multiple outliers in a single iteration
		- If you repeat the same process on the same dataset, you get the same outliers (so it is possible to replicate the results)
		- There is an R package titled Peirce 
		- We can see the R implementation on Wikipedia for Peirce's criterion (https://en.wikipedia.org/wiki/Peirce%27s_criterion) 
		- Does not care about what the data is, only cares about total number of observations, number of outliers to be removed, and number of model unknowns. 
	- We are supposed to make a linear model of energy versus carbon. 
	- ~ Means depends upon in R
	- It is easy to get a list of all the residual values from the linear model and you just pass in the squared residuals to the outlier function 
	- You take Peirce's $x^2$ and multiply by MSE to scale it to the dataset 
	- Outlier Python script in gepisat_doc.py is similar to what we are doing. 

## Breakout Room Meeting Minutes 
***Note*: My group worked silently for a good portion of the time we were in breakout rooms so the minutes below are a combination of the methods discussed with my official group and with some others who I know in the class. 
#### Working on the Exercise 2.1: Raw Meeting Minutes:
- Include a function to load every file into a dataframe 
- Clean up the files 
- Are duplicates from one node or different nodes?
- Duplicates are cases where the 0, 1, 2 are the same number
	- All the data packets would be the same, the timings would be slightly off
- Function to ID duplicates 
- 7.5 minute room for error 
- How to differentiate when time stamp and data are identical 
- Duplicate of the same data has the same node has the same or similar time stamp
- Game plan is to get all of the text files and put them into a dataframe, identify which observations are duplicates and remove them, merge the dataframes, get the SMC, find the ensemble mean for each time interval, and create plots using the data acquired. 
#### Exercise 2.2
At the time these notes are due, we have not yet worked on exercise 2.2 in group 1 breakout rooms. I can update the notes to reflect any helpful information for exercise 2.2 past the due date if that is okay. 


## Helpful Links
#### Data Duplication

https://profisee.com/blog/8-business-process-problems-that-result-from-data-duplication/

https://www.netapp.com/data-management/what-is-data-deduplication/

https://www.druva.com/blog/a-simple-definition-what-is-data-deduplication/

#### Missing Data 
https://cran.r-project.org/web/packages/imputeTS/vignettes/imputeTS-Time-Series-Missing-Value-Imputation-in-R.pdf

https://arxiv.org/abs/2011.11347

https://www.kaggle.com/juejuewang/handle-missing-values-in-time-series-for-beginners

#### Outliers 

https://datascience.foundation/sciencewhitepaper/knowing-all-about-outliers-in-machine-learning

https://towardsdatascience.com/a-brief-overview-of-outlier-detection-techniques-1e0b2c19e561

https://www.aquare.la/en/what-are-outliers-and-how-to-treat-them-in-data-analytics/

#### Reference from Colab Notebook
Davis, T. W. (2012). Environmental monitoring through wireless sensor networks [Doctoral dissertation, University of Pittsburgh]. d-scholarship.pitt.edu
