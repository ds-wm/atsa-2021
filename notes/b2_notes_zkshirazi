# Block 2 Notes
## Meeting Minutes
### Case Study One
Step #1
- First step is to determine which functions are needed and to initially outline utility functions
- We know we need to create a function that can read the data 
- Utility functions 
  - Function to load in data
  - Arithmetic mean based on the specified time horizon 
  - Data duplication 

Step #2
- We need to interpret the time because some have six observations in 12 hours and some sections have 48 48 observations in 12 hours 
  - This could either mean duplicates or that there are missing data sets 
  - The time is slightly confusing
- Start with reading in 12 sets 
  - Do we need to download all 12 because it's in 'txt' rather than how we usually can insert a link for a 'csv' file 
  - There is actually a way to dilineate in R
- Assign variable name as 'id' followed by the year number of the data set (i.e. id003, id015, etc.)
- Think of a utility function
### Discussion Question Brainstorming 
#### Defining Duplicates
Approach One
- Read each file into a datframe
- Iterate over rows in time column
- Initialize a vector of length equivalent to rows in the dataframe
- Look at each subsequent row and see if it's within 7:30 minutes. if it is, add false to our vector. else, true
~~~ 
data <- read the data
vector <- c()
for (row in data){
	time_cur <- row
	time_next <- row+1
if(time_nexttime_cur>450)
	vector <- c(vector, FALSE)}
else{
	vector <- c(vector, TRUE)}
~~~ 
Approach Two
- Read the data in
- Save the first row in a variable 
- Iterate over each subsequent row. if it is the same, delete it. if it is different, proceed normally and update the current row you are on 
~~~ 
data <- read the data
cur_row <- first row of data
for (row in data){
	if (cur_row==row){
		cur_row <- row
		delete the row}
	else{
		cur_row <- row}
~~~ 
#### The Game Plan
1. Read in all the data 
2. Filter each dataframe for duplicates 
3. Merge the data together 
4. Sort by time 
5. Aggregate
6. Create figures 
#### Time Series Analysis 
1. Create vectors of numbers to represent month, day, hour, minute, second (pros: numeric, easy to aggregate, easy to filter with) rather than using strings)
2. Look for an R package that processes the date and time data we have for ease of comparison
### Case Study Two 
- Overview 
  - Flux tower have sensors attached to them that measure the energy and gas exchanges between the atmosphere and the surface of the Earth
  - Understand how climate is changing
  - How plants are growing and interacting with these changing environments of the world
- Canada, America, Brazil, Australia, the EU, China, etc. have their own network & manage them at a regional scale 
  - Then share them through an online database 
### Approach 
- Utilize Solar R code 
  - Part of this code is function that returns half hourly data 
- Use code snippets from course notebook to read in data 
- Get discrete time series, create function, get value 
- Need gap filling function 
- Calculate q gap for each day 
  - Link together for a monthly time series
  - Plot this below given plot to fill in gaps 
- Given plot of observations 
  - Missing spot values 
  - Back fill where there are gaps with this product we are calculating 
## Three Main Challenges 
In the data analysis block, there are three primary challenges of interest: data duplication, gap filling, and detecting outliers. Encountering these problems is common when dealing with real-world data sets, and understanding them can offer better insight on how to approach data analysis. In this block, we encounter data duplication between nodes in sensor networks (exercise 2.1), missing solar daily flux data (exercise 2.2), and removing doubtful observations using statistical methods, specifically Pierce's criterion (Lab). 
### Data Duplication 
In exercise 2.1, duplicate data points were the primary challenge in approaching the problem at hand. This is a relevant issue for a few reasons. First, it can inflate various descriptive statistics which in turn could lead to other problems during data analysis, data extrapolation etc. Accurate data is necesary when using data analysis to make policy decisions, for example, and duplicate data points can skew the results. 
The process of data deduplication involves removing repeated observations from a dataset. Specifically, it's a technique for eliminating redundant data in a data set. In the process of deduplication, extra copies of the same data are deleted, leaving only one copy to be stored. Data is analyzed to identify duplicate byte patterns to ensure the single instance is indeed the single file. Then, duplicates are replaced with a reference that points to the stored chunk. (Helpful link: https://www.druva.com/blog/a-simple-definition-what-is-data-deduplication/)
### Gap Filling
Missing data is a relevant problem in statistical data anlysis, thus gap filling is a key componoent of refining data sets. According to the NIH, missing data (or missing values) is defined as the data value that is not stored for a variable in the observation of interest. The problem of missing data is relatively common in almost all research and can have a significant effect on the conclusions that can be drawn from the data.
Furthermore, according to the NIH, missing data presents various problems. First, the absence of data reduces statistical power, which refers to the probability that the test will reject the null hypothesis when it is false. Second, the lost data can cause bias in the estimation of parameters. Third, it can reduce the representativeness of the samples. Fourth, it may complicate the analysis of the study. Each of these distortions may threaten the validity of the trials and can lead to invalid conclusions. (Helpful link: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3668100/#:~:text=Missing%20data%20present%20various%20problems,the%20representativeness%20of%20the%20samples.)
### Outliers 
Outliers can cause serious problems in data analysis. First, most parametric analysis methods require valid data distribution assumptions, and the existence of outliers very often results in the violation of such assumptions. Second, outliers increase data variation and thus reduce the power of statistical tests, which is not desirable. Third, if outliers reflect a mixture of observations from a population other than the target population, analyzing data with such outliers produces biased estimations of the target population parameters. In addition, outliers might be erroneous observations, e.g., errors occurred during data input. Therefore, to achieve meaningful and unbiased data analysis, outliers have to be appropriately identified and handled. (Helpful link: https://pulmonarychronicles.com/index.php/pulmonarychronicles/article/view/252/635)
