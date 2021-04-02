# Notes for Block 2
Matt McCormack

## Case study 1: Wireless Sensor Node Data
The first case study of block two that we are going to looking at is dealing with wireless sensor node data.
In the discussions/block 2 portion of blackboard, our classmates posted all their questions/concerns/thoughts on this case study and how we might approach these data for our own use. Particular questions seemed to include how we will identify duplicates in some situations and when do sensors turn on in relation to other sensors.

### Discussion Board Posts for Case Study 1:
#### Defining Duplicates
Pseudo code for defining duplicates:

read each file into a dataframe

initialize a vector of length equivalent to rows in the dataframe

iterate over rows in time column

look at each subsequent row and see if its within 7:30 minutes, if it is, add false to our vector. else, true


    data <- read the data

    vector <- c()

    for (row in data){

        time_cur <- row
    
        time_next <- row+1
    
        if (time_next-time_cur<450){
    
           vector <- c(vector, FALSE)}
       
        else{
    
           vector <- c(vector, TRUE)}
        
#### The Game Plan
1) Read in all the data
2) Filter each dataframe for duplicates
3) Merge the data together
4) Sort by time
5) Aggregate
6) Create figures

#### Temporal Data
1) Maybe create vectors of numbers to represent month, day, hour, minute, second (pros: numeric, easy to aggregate, easy to filter with) rather than using strings
2) Look for an R package that processes the date and time data we have for ease of comparison


### Excercise 2.1: My Group (Group 3)'s Approach
(Group members: Matt, Kimya, Conrad, Keagan, Connor, and Monica)

((Note: I refined the notes I took on my group's approach to this finalized version, since we made a fair number of alterations.))
* We began by installing/importing any packages needed, which we decided to be the 'latex2exp' and 'Metrics' packages. 
* The first function we defined was a 'removeDuplicates' function. This function begins by creating an empty vector called duplicateVector, and it goes on to iterate through each entry in the provided dataframe. We used a series of if/else statements within a for loop to then determine if each pair of the rows were duplicates. After it has finished iterating, the function returns the subset of the provided dataframe that are not duplicates.
* We then created a function called mergeDF, that combines all of the dataframes using merge.
* Next, we made a function aggregateOverTime. We began by saving the time of the first period, and then we iterated over each row of the given dataframe and calculated the difference in time between the beginning of the period and the current row. We also generalized it so we could pick any variable and get the aggregated data. The end result of the function would be a vector of the average values of the variable being tracked, with zeroes in the vector for each period that the function skipped. (This function is used to create a more formal data table in the createDataTable function that we made as well).
* As a culmination of all of these functions, we used them to give us what we wanted. We started by reading in each data file using the read.csv function. Next, we removed duplicates from each dataset using the removeDuplicates function we created above. Next, we used the mergeDF function that we created to get the merged original data and the merged de-duplicated data.


The notebook for the code I described can be found here: https://colab.research.google.com/drive/15fXZXc7AF30C3SGUJpT0licCfGquLaKh

## Case Study 2: Working with FLUXNET Tower Data
The second case study looked into FLUXNET tower data. This data consists of a network of towers that measure energy and gas fluctuations between the Earth's surface and the atmosphere. There are times when sensors malfunction, operations are interupted, or other factors that cause gaps in the datasets. Our goal with this case study is to figure out how to reconstruct missing data. 

### Exercise 2.2: My Group's Approach
* My group has spent most of our time in class on exercise 2.1. Unfortunately at the time of writing these notes, we have not gotten incredibly far past the code snippets from Professor Davis at this link https://github.com/ds-wm/atsa-2021/blob/main/exercises/2.2/dt-woods_exercise_2-2.R , as well as from course notebook 2.

## Background on Data Duplication
Data duplication is when there are multiple records present in a dataset that hold the same data. The excess entries provide no additional information, and are rather just redundant data; this can affect our analysis. To remedy data duplication, we turn to the process of data deduplication. Data deduplication is when "extra copies of the same data are deleted, leaving only one copy to be stored." Data deduplication helps minimize unnecessary repetition of data and rather keep only the data that is needed. Deduplication both speeds up computational functions (this impacts the efficiency of our analysis), and it makes sure that data isn't double-counted (this helps preserve the integrity of our analysis). This challenge is present in many different areas, not just time series data. 

Helpful links/sources for the above background information:
https://www.druva.com/blog/a-simple-definition-what-is-data-deduplication/
https://www.kaggle.com/rtatman/data-cleaning-challenge-deduplication

## Background on Gap Filling
If time series data is missing datapoints, gaps can form in the overall dataset that restrict our analysis. The larger a gap is, the harder it can be to fill gaps with good data. Gaps in time series data can be filled in a variety of ways. According to RAVENDB, the most common form of gap filling is using data points on either side of the gap, and extrapolating to fill gaps with extra data points; this is called interpolation. The two interpolation methods that RAVENDB highlighted were nearest (add values equal to the value of the nearest entry) and linear (place the data points on a straight line between the entries on either side). However, the gap filling process really depends on the dataset and how much data is missing. An example of how an overall dataset impacts gap filling is in exercise 2; we use the gap-filling methodology described in the Global ecosystem Production in Space and Time (GePiSaT) model, which is a relatively complicated method. If we encountered this problem when working with other datasets that aren't as complex or with smaller gaps, we may be more inclined to use just the linear or nearest methods of interpolation. While this problem can manifest in other types of data, it is certainly most common and disruptive in time series data.

Helpful links/sources for the above background information:
https://ravendb.net/docs/article-page/5.1/csharp/document-extensions/timeseries/querying/gap-filling
https://colab.research.google.com/drive/1AtH8dXyTebnm4fl9Amx0o4s9VZ6Wzsqk?usp=sharing#scrollTo=ytX6uLYP6TOQ
https://ieeexplore.ieee.org/document/8229730

## Background on Outliers
An Outlier is defined as "an observation that lies an abnormal distance from other values in a random sample from a population". Essentially, they are points that deviate substantially from the majority of the rest of the data and its trends. The most common/easy way to identify an outlier is by adding 1.5 times the interquartile range (IQR) to the third quartile and subtracting 1.5 times the IQR from the first quartile. Any data point outside of this new range is a suspected outlier. There are a variety of other criterion that can determine if a point is an outlier, such as Pierce's Criterion. To use Peirce's Criterion, you need to follow these steps (as found at https://www.statisticshowto.com/pierces-criterion/): 
1. Find the mean and sample standard deviation for the entire set.
2. Look up the value of R in a Peirce’s table that corresponds to the number of observations in your sample set. Begin by assuming one outlier, although you may repeat the process to discover more than one.
3. Use the formula |X<sub>i</sub> – X<sub>m</sub>| max= σ R to calculate the maximum allowable deviation.
4. Calculate the actual deviation of your potential outliers. |X<sub>i</sub> – X<sub>m</sub>|
5. Check if |X<sub>i</sub> – X<sub>m</sub>| > |X<sub>i</sub> – X<sub>m</sub>|max, and if it is, eliminate that outlier.
6. Now assume two outliers, and go through step 2-5 again. Keep the original number of measurements as well as the original values of the standard deviation and mean.
7. If your calculations in step 6 give you another outlier, you can repeat the process. Assume an additional outlier each time through and use the original number of measurements, mean and standard deviation each time.
8. Once all questionable data has been tested, calculate the mean and standard deviation again for your final data set.
Outliers affect many datasets, not just time series. Even in introductory statistics, we are told how outliers can be present in the simplest of datasets.

Helpful links/sources for the above background information on outliers:
https://www.itl.nist.gov/div898/handbook/prc/section1/prc16.htm#:~:text=Definition%20of%20outliers,what%20will%20be%20considered%20abnormal
https://www.statisticshowto.com/pierces-criterion/
https://mathworld.wolfram.com/Outlier.html
