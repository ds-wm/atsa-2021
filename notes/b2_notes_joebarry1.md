# Main Challenges of Block 2

## Data Duplication

Data duplication occurs when there are multiple data points in a dataset which come from the same observation. This can often occur when the methods of data collection are imperfect, or multiple datasets are being combined into one. This can damage the utility of datasets, and is a big problem in the business world. Not only can it result in [customer service problems](https://www.qgate.co.uk/blog/10-reasons-why-duplicate-data-is-harming-your-business/) and [general inefficiencies](https://profisee.com/blog/8-business-process-problems-that-result-from-data-duplication/), but can also simply take up storage space; this has led to an emphasis recently on [data deduplication](https://www.druva.com/blog/understanding-data-deduplication/). Depending on the nature of the problem, it may necessite looking at similarities between [data chunks](https://en.wikipedia.org/wiki/Data_deduplication). Luckily, for our application in exercise 2.1, we simply have to compare between adjacent observations to find those which are identical.

## Gap Filling

In time series analysis specifically, it is sometimes necessary or much preferred to have a continuous data set which accounts for all points in time on your given scale. Filling in missing data in a set is generally referred to as [imputation](https://en.wikipedia.org/wiki/Imputation_(statistics)). Imputation methods on multi-feature data can be simple, such as calculating, with OLS or some other model, what we would predict that value to be. However, the nature of this problem is different in time series data, as the only thing we have to go off of is the previous or following observations in the realization. In exercise 2, we have some very sophisticated tools which allow us to accurately fill in missing data. However, under normal circumstances, there are some more generalizable methods. In R, one tool is the [imputeTS library](https://cran.r-project.org/web/packages/imputeTS/vignettes/imputeTS-Time-Series-Missing-Value-Imputation-in-R.pdf), which contains a few different ways of finding missing data in a time series.

## Outliers

Outliers are data points which lie outside of the normal range which we would expect in a given data set. They generally do not fit the "curve" of a data set. They can be difficult to deal with because they are difficult to define; how far from the mean does a point have to be for it to be considered an outlier? One [common, easy method](https://stattrek.com/statistics/dictionary.aspx?definition=outlier) is to label anything an outlier which lies $1.5 \times IQR$ from the bounds of the $IQR$, or interquartile range. However, there is not much statistical backing to this method, which is why, in our lab, we will be using [Peirce's Criterion](https://en.wikipedia.org/wiki/Peirce%27s_criterion).

# Daily Log

## March 9th

- Spent most of class looking at exam 1
- Introduced case study on assymetrical interference in wireless transmission
- We have data from 12 of these transmitter nodes , shown below in .txt files

* [MDA300BKUP_resultsConverted-2YR_2003](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt)
* [MDA300BKUP_resultsConverted-2YR_2015](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt)
* [MDA300BKUP_resultsConverted-2YR_2025](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt)
* [MDA300BKUP_resultsConverted-2YR_2045](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt)
* [MDA300BKUP_resultsConverted-2YR_2055](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt)
* [MDA300BKUP_resultsConverted-2YR_2065](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt)
* [MDA300BKUP_resultsConverted-2YR_2085](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt)
* [MDA300BKUP_resultsConverted-2YR_2095](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt)
* [MDA300BKUP_resultsConverted-2YR_2103](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt)
* [MDA300BKUP_resultsConverted-2YR_2115](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt)
* [MDA300BKUP_resultsConverted-2YR_2125](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt)
* [MDA300BKUP_resultsConverted-2YR_2135](https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt)

We will be reading and processing this data over the next couple of classes.

## March 11th

Discussed the case study and exercise 2.1. Split into groups to go over the exercise.

### Exercise 2.1 - Group 1

Functions:
- Load .txt file into df
- Identify the duplicates
- Create separate df which has duplicates removed
- Combine the data for each category into one df
- Calculate the SMC(ADC 1 or 2) for each df
- Create an array of averages for each bin of time (based on the time frame we want)
- Plot data from array at each time stamp

## March 16th

- Continue working on Exercise 2.1, namely answering discussion board posts and continuing to create a plan for doing the exercise.

## March 18th

### Overview of Case Study 2

- The FLUXNET network has a series of towers which measure incoming sunlight in the form of micro-moles of photons per second per square meter. 
- There are gaps in the data which must be filled if the data is to be worked with.
- Method used to fill these gaps utilizes SPLASH, a program designed to determine radiation using various geographical and meteorological data.

### Working on Exercise 2.1

- Created Google Colab script to load and read in data from URL.
- Script was added to throughout the weekend until next class.


## March 23rd

- Looked further into the second case study.

### Case Study 2 cont.

- We can very accurately model the incident solar radiation at the top Earth's atmosphere.
- We have to scale to account for the things that "get in the way" of solar radiation on it's way through the atmosphere to the Earth's surface.
- Lastly, we need a half-hourly time series value, $I_0$, which is based on the solar constant energy incident on the Earth, a distance factor which accounts for the small distance changes in the Earth-Sun distance, and an inclination factor which accounts for the angle of the Sun relative the surface at that point and time.
- Other things must be accounted for, such as the difference between mean and actual solar time, and the impreciseness of time zones.

In order to apply this model, we will be using various functions from solar.R. These functions account for the adjustments and constants involved in $I_0$.

## March 25th

### Case Study 2 cont.

- Continued to review code from solar.R and solar.py
- Broke into groups to work on exercise 2.2. Most of this was spent independently working.


## March 30th

### Outliers and Peirce's Criterion

- Outliers are tricky for data science in general, as they can skew data, yet it can be hard to determine what to do with them, if anything at all.
- Peirce's criterion helps us reliably identify outliers in an objective yet robust way.
- Went over how we are going to be applying Peirce's criterion to Lab 2 using the GePiSaT dicumentation as a guide.

## April 1st

- Broke out into lab groups to work; once again, largely independent.


```python

```
