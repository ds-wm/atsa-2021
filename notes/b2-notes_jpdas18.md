# Block 2 Notes
#### Written by Jacinta Das 
#### Last edited 2021-04-01 

## Case Study 1, Exercise 2.1
### Background on case study:
- There are 12 wireless sensor battery powered nodes set up outside in a hilly forested area, designed to collect data as part of a project "to determine the efficacy of wireless sensor networks (WSN) under natural outdoor conditions for collecting high precision environmental data" (Davis, 2012)
- Sometimes messages are received by a sensor but the sending node does not receive an acknowledgment of the reception, so it resends it; this results in data duplication. The purpose of our case study is to study data duplication at various time scales.
### Goals for analysis/Game Plan:
- Read and sort data
- Filter and remove invalid data packets based on measurements (first, filter to make sure all dead battery sensors are taken out and later filter for water potential and soil moisture)
- Create discrete time series at 15-minute, 60-minute, 12-hour, and 24-hour intervals for the original and duplicate-free datasets to compare 
- Convert values to physical quantities
- Calculate Pearson's R, $R^2$, and RMSE and create plots
### Group Discussion
- Initial impressions: the case study seems interesting but a little confusing. we have questions about how to practically implement what we have talked about during class. we posted about some of our questions on the sticking points discussion board. 
#### Sticking Points:
- How do we remove our duplicate observations?
- Our first question: What time range should we search for duplicates in? 
- We chose 15 minutes on either side of our data point. Are there any drawbacks to choosing this time period?
- Our second question: How do we remove duplicate data points using this definition?
- Check the value in each column for each row against the corresponding values in every other row in this time interval 
- Could the duplicate occur before the observation? Does it matter?
- Is there a more efficient way of accomplishing this goal?
#### Time Series Analysis:
- We plan to use the difftime, sort, and as.Date function to sort our data and remove duplicates
- We will use the tswge library 
#### Group Code:
- As a group, we developed a loop to read in data. This loop took an input of links to the data and the numbers of the node. We created a list with all the node numbers. We then iterated over the length of the list, pasted each node number at the end of the generic github link to access its unique link, and read each node's data into an individual data frame.
- We discussed methods for addressing the issue of duplicate data points. However, we ultimately decided to work individually for the remainder of the exercise. 

### Mentions of Data Duplication (outside this case study)
#### Data duplication in business - the bullets below come from (Profisee, 2019)
- Duplicate records can cause problems for businesses. Several examples are below.
- Data duplication wastes space and can increase costs. 
- In the case of insurance companies, if there are duplicate records for members, when members file claims these may be processed twice.
- Organizations may overestimate how many customers or products they have. 
- It may be difficult to combine data if it is recorded differently and duplicated in different ways (i.e., not exact duplications but the same information is recorded twice in  different formats).
#### Avoiding data duplication in databases  - the bullets below come from (Bhoi et. al, 2017)
- being able to detect duplicate data (duplication detection) is important for customer relationship management, personal information management and data mining 
- The article defines duplicate detection as "a method of detecting all cases of multiple illustrations of the same real world object"
- The authors cite a similar example to the previous article - a company can lose money if it has multiple records of one customer and sends them duplicate mail items
- Duplicate records take up more space and require more memory to store; they also complicate the database more because it becomes difficult to retrieve the correct record (especially when there are data anomalies)
- In their discussion of data duplication, they propose two algorithms to remove duplicate records. These algorithms are Parallel Progressive Sorted Neighbourhood Method (PPSNM) and Map Reduce. Benefits of implementing the author's system for removing duplicates of data are increasing both ease and speed of access to the database.

## Case Study 2, Exercise 2.2 
### Background on case study:
- FLUXNET is a network of towers that measure energy and gas fluctuations between the Earth's surface and atmosphere
- FLUXNET data is helpful for creating models that ultimately help researchers study the climate.
- One research group studied global primary production in particular; for this they needed FLUXNET data on solar radiation (in micro-moles of photons of photosynthetic light per square meter per second). The researchers' model needs a complete time series of solar data.
- However, for various reasons (interruptions or malfunctions), sometimes the towers do not record data, creating gaps in the time series. The purpose of this case study is to address the issue of missing data. That is, how do we create a complete time series to use in spite of these gaps? 
- The research team in the example used the SPLASH model to address the issue of missing data. (SPLASH stands for Simple Process-Led Algorithms for Simulating Habitats.)
### Goals for the case study: 
- Calculate half hourly solar radiation values 
- Create a complete time series by overlaying the values from the AmeriFlux* site 
- Create a plot that shows original and gap-filled values
- Produce an R script that reads the data, performs the calculations, and creates the plots 
### Details/game plan of the case study:
- For this case study, we use the *AmeriFlux Station "Goodwin Creek" or US-Goo, located in Mississippi. Like the aforementioned researchers, for this case study, we are interested in PPFD_IN. We will fill in gaps by computing a half-hourly radiation curve that would reach the outer edge of the Earth's atmosphere, scaled down based on shortwave radiation, to the daily extraterrestrial solar radiation, and converted from flux units to the amount of photon energy in a shortwave solar radiation based on a conversion factor. 
- My group decided to work individually for this exercise as well.

## Mentions/examples of missing data outside this case study 
### "Understanding and Handling Missing Data" - the bullets below come from (Wyss, 2020)
- Although this is simply a blog entry, I found the information on different kinds of missing data both interesting and useful. 
- Types of missing data:
- Missing Completely at Random: "the missing data are unrelated to the observation being studied or the other variables in the data set... there are no systemic differences between the observations with and without missing data"
- Missing at Random: "missing data can be predicted from the other variables in the study, but not from the missing data themselves." note - these datasets can be biased, so it is important to consider missing data.
- Missing Not at Random: the missing data is "directly related to the value of the missing observation"
- Solutions to missing data:
- Deletion (listwise, pairwise, entire variables)
- Imputation (filling in missing values) using mean/median/mode, KNN, linear regression, linear interpolation 

## Lab 2 
### Background for lab:
- We care about incoming solar energy and carbon flux between the surface of the earth and the atmosphere
- The columns of interest in the dataset include both observations and gap-filling values. We will include both (no filtering).
- Generally, more sunshine means more plants, and more plants mean less carbon, so the two variables are inversely correlated. 
- Create a linear model for r where x is solar radiation and y is carbon flux
### Goals for lab:
- Define outliers and provide examples of where they are found, what causes them, and why we should care
- Research Peirce's Criterion for the rejections of doubtful observations, and summarize findings
- Find another method for outlier identification and compare it to Peirce's Criterion
- Provide an intro to FLUXNET
- Reproduce the algorithm to find outliers 
- Create a scatter plot of $SW_in$ versus NEE identifying outliers, explain the plot, and count the # of outliers shown 
### Outliers
- Initial impressions: outliers are values that are different from the rest of the data. perhaps outliers could indicate measurement error. when I think of outliers, I think of a box and whisker plot - by that definition, outliers are values that are greater than 1.5 times IQR away from the box.
### Peirce's criterion - bullets below are from the lecture and the Wikipedia page (referenced during the lecture)
- Comes from Benjamin Peirce; he proposed a paper on the rejection of doubtful observations in 1852
- Gould calculated (by hand) lookup tables for all the equations that Peirce proposed 
- Peirce's criterion is statistically based and can find multiple outliers in a single iteration. Repeating the same process on the same dataset yields the same outliers. 
- Dardis created an R package for Peirce in 2012, and it was later reimagined in Python 
- Peirce's criterion provides max deviation (specifically a squared error) that can be expected for a dataset; points that have deviations in excess of this max are outliers.
- The method takes an input of the number of observations, a guess for the number outliers, and number of model unknowns. It returns the squared error threshold. 
- The Peirce is robust because it works on all datasets; it only cares about the number of observations, outliers, and unknowns - not about the specifics of the data itself. 

## Mentions/examples of outliers outside this lab
### "Understanding outliers in time series analysis" - the bullets below come from (ArcGIS Pro 2.7)
- outliers can be both true and false values. for example, an outlier could be an invalid value stemming from error in data entry or measurement. an outlier could also be a result of a strange event (for example, in the case of weather, a horrible storm). 
- it is important to be able to identify outliers in time series forecasting because it will affect the model used to forecast the future, thereby impacting accuracy and reliability of the forecasts 
- it can be helpful to visualize outliers using pop up charts or a space-time cube; there is a generalized Extreme Studentized Deviate test which can "test for the presence of outliers at each location of the space-time cube"
- contextual and global outliers can be helpful for identifying outliers caused by anomalies or special events (holidays)


#### References
- ArcGIS Pro 2.7. Understanding outliers in time series analysis. ArcGIS Pro. https://pro.arcgis.com/en/pro-app/latest/tool-reference/space-time-pattern-mining/understanding-outliers-in-time-series-analysis.htm#:~:text=Outliers%20in%20time%20series%20data,outliers%20in%20their%20time%20series.
- B. Bhoi, P. Vyawahare, P. Avhad and N. Patil. (2017) Data duplication avoidance in larger database. 2017 International Conference on Innovations in Information, Embedded and Communication Systems (ICIIECS), pp. 1-4,
doi: 10.1109/ICIIECS.2017.8276031
- Davis, T. W. (2012). Environmental monitoring through wireless sensor networks [Doctoral dissertation, University of Pittsburgh]. d-scholarship.pitt.edu
- Peirce's criterion. In Wikipedia. https://en.wikipedia.org/wiki/Peirce%27s_criterion
- Profisee. (2019). 8 problems that result from data Duplication • PROFISEE. Retrieved April 01, 2021, from https://profisee.com/blog/8-business-process-problems-that-result-from-data-duplication/
- Wyss, A. (2020) Understanding and Handling Missing Data. https://www.inwt-statistics.com/read-blog/understanding-and-handling-missing-data.html 

