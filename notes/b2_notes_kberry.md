# Notes Part 2: ATSA
#### Kelton Berry


## Main Concepts

### Data Duplication
Data duplication occurs when there are exact copies of the same data in a database or dataset. Replication in data causes inaccurate descriptives statistics and renders our analysis and findings as skewed and unreflective of the data we are working with. It does not take much imagination to see that this lack of precision caused by duplicates can have serious consequences if working with important data. Removing duplicates, as we did attempt to do in exercise 2.1, is a prerequisite for any data project and allows us to be confident in our results.


### Gap-Filling 
Gap-filling refers to the process of filling in data where a dataset lacks values or inputs. It is often caused by errors or malfunctions in the collection of data and depending on its size, missing data points can cause significant biases and issues for data projects. Therefore, it is often a good rule of thumb to use a standardized method to fill in, or gap-fill, the missing data. This is often done by various input techniques, such as using the nearest values in the column or the average of all observations within a column. The FLUXNET data used in our second case study had significant data gaps and the use of the Global ecosystem Production in Space and Time (GePiSaT) model was necessary for beginning our analysis. 


### Outliers
Outliers are data points found out of the normal distribution or cluster expected for a data set. These are points that appear alienated from the majority of the data and are significantly greater or lesser than the rest of the data. Much like data duplication, outliers can heavily skew or alter our findings and results, the prime example being an outlier in the context of the mean. There are numerous ways to counter and remove outliers, including the common method using the interquartile range. For this unit, we extensively worked with Pierce's Criterion, which is a method used to eliminate outliers in a dataset.

 




## Class 1: March 9

#### Exam 1
Count up self-examine scores. If over 18 points receive checkmark. If under 18 points, consider answering the extra problem. 

#### Case Study 1
Abstract: a network of autonomous wireless sensor nodes with the job of collecting data set up in two field sites in a forested hillslope region. The goal of this project was to determine the efficacy of wireless sensor networks (WSN) under natural outdoor conditions for collecting high precision environmental data. 
 


## Class 2: March 11

Must find and remove duplicate packets: potential at multiple hops that duplicates are made.
Original analysis is done in R. Ongoing project but data we look at is concentrated in two years. 
The goal is to replicate the graphs of the paper. 


#### Breakout Rooms (Room 2)

Prerequisite: create joint Google colab

Objective 1 for Group: Successfully read in the data. 

How do we remove duplicates?
* compare entries within a set timeframe and remove exact duplicate
* could use a for loop to compare every data point to every other data point and delete the duplicates (must compare every value)
* must narrow the time range (+ or - 15 min or hour) --> can't be the entirety of dataset time as replicates are inevitable
* Agreed upon 15 min range (most accurate?)

Creating a loop to create a list of nodes

Must also filter out invalid values: those affected by moisture, etc


## Class 3: March 16:

#### Breakout Rooms (Room 2)

Before removing duplicates should remove invalid values
* convert the measurements and then determine if in range to be valid

difftime() function within R
* only looks for points after the current point
* keeps last of the duplicate group
* only look at time intervals after 15 minutes
* remove all the values until 14 minutes and then after 14 minutes check to see if duplicates


Where does the implementation of Pearl Code go: goes in last?


## Class 4: March 18

#### Case Study 2: FLUXNET Data

FLUXNET is a collection of observation towers that measure fluxes between the Earth's surface and the atmosphere. These towers are found all over the world. 
However, extensive gaps in the data (due to malfunctions, errors, interruptions, etc.). Therefore, we need to fill these missing data points with a gap-filling technique. 
 


#### Breakout Room 2
The group decided the best approach was to do individual work to complete exercise 2.1


## Class 5: March 23

Case Study 2: Solar radiation
 * use to predict plant response/production

There are gaps in time series, need to fill in gaps. 
* look to the physical model, i.e. solar radiation (dependent on time)

𝐼𝑜 represents radiation of the sun on a specific location on earth

Challenge: finding half-hour 𝐼𝑜 values
  *  Can find by the following components:
        * solar constant, distance factor, and inclination factor

Simple Process-Led Algorithms for Simulating Habitats (SPLASH) mode:
* this is a way for the team to fill in missing data
* included within the code are various R functions 
* Solar R: julian_day, dsin, dcos, calc_daily_solar, berger_ts
    * julian_day: helps us find the day of year n
    * calc_daily_solar: requires constants, input: latitude; day of the year; elevation, year, a fraction of sunshine days, and daily average air temp (optional)
    * berger_ts: calculates true anomalies and true longitude
    * distance factor via the Berger method
    * calculate declination angle (delta)
    * calculate sunset hour angle
    * calculate daily extraterrestrial radiation



## Class 6: March 25

Output of calc_daily_solar is ra_j.m2. This represents daily solar radiation in joules/sq meter. 

However, we still have the problem of being unable to find 𝐼𝑜 
  * Can do this by replacing the sunset hour angle with the hour angle
  * This can be helped by code of GePiSaT

GePiSaT: in its solar.py file has a solution for converting half-hour estimate  
  * need to convert this into R code
  * can help us gap-fill


## Class 7: March 30

Dealing with outliers

Peirce's criterion:
* a form of removing outliers, that rejects doubtful observations
* Pierce's criterion works by removing points outside of the max deviation expected from our data
* The deviation is based upon the squared error, i.e. squared residuals


For Lab 2 work to remove outliers from FLUXNET data by using Peirce's criterion:
  * Specifically remove outliers from the linear relationship between incoming shortwave radiation (SW_IN_F) and Net Ecosystem exchange
  * the mean squared error of our dataset is multilpied by pierces criterion, this is the threshold for outliers (i.e. points greater than this are outliers)



## Class 8: April 1

Today, the class comprised of working on our labs in breakout rooms. 

