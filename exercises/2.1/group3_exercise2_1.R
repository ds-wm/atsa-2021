# R-Version 4.0.2 "Taking Off Again"

# File Name: "Group3_Exercise 2.1.R"

# Case Study Description: Duplicate Data Analysis 
##                        The goal of this project was to determine the efficacy of wireless sensor networks (WSN) under natural outdoor conditions for collecting high precision environmental data.

# Created by: Conrad Ning, Connor Sughrue, Matt McCormack, Kimya Shirazi, Keagan DeLong, Monica 

# Last edited on: 3/30/2021

setwd("C:/Users/Winston_Ning/Desktop/Spring 2021/DATA 330/Exercise/Exercsie2.1/")

######Import Sources #####
source("group3_Utility.R")

## Install the packages
#install.packages('latex2exp')
library(latex2exp)
#install.packages('Metrics')
library(Metrics)


# Load Data
data2003 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2003.txt")
data2015 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2015.txt")
data2025 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2025.txt")
data2045 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2045.txt")
data2055 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2055.txt")
data2065 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2065.txt")
data2085 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2085.txt")
data2095 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2095.txt")
data2103 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2103.txt")
data2115 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2115.txt")
data2125 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2125.txt")
data2135 <- read.csv("https://raw.githubusercontent.com/ds-wm/ds-wm.github.io/master/course/atsa/data/MDA300BKUP_resultsConverted-2YR_2135.txt")

# Make it into a list
dataList <- list(data2003, 
                 data2015,
                 data2025,
                 data2045,
                 data2055,
                 data2065,
                 data2085,
                 data2095,
                 data2103,
                 data2115,
                 data2125,
                 data2135)

# Create the duplicate free data and make it into a list again
dpFree2003 <- removeDuplicates(data2003)
dpFree2015 <- removeDuplicates(data2015)
dpFree2025 <- removeDuplicates(data2025)
dpFree2045 <- removeDuplicates(data2045)
dpFree2055 <- removeDuplicates(data2055)
dpFree2065 <- removeDuplicates(data2065)
dpFree2085 <- removeDuplicates(data2085)
dpFree2095 <- removeDuplicates(data2095)
dpFree2103 <- removeDuplicates(data2103)
dpFree2115 <- removeDuplicates(data2115)
dpFree2125 <- removeDuplicates(data2125)
dpFree2135 <- removeDuplicates(data2135)


dpFreeList <- list(dpFree2003, 
                   dpFree2015,
                   dpFree2025,
                   dpFree2045,
                   dpFree2055,
                   dpFree2065,
                   dpFree2085,
                   dpFree2095,
                   dpFree2103,
                   dpFree2115,
                   dpFree2125,
                   dpFree2135)


# Merge the list of dataframe into a single dataframe
origAgg <- mergeDF(dataList)
origAgg$result_time <- strptime(origAgg$result_time, "%Y-%m-%d %H:%M:%S")

dpFreeAgg <- mergeDF(dpFreeList)
dpFreeAgg$result_time <- strptime(dpFreeAgg$result_time, "%Y-%m-%d %H:%M:%S")



# FYI: THIS BLOCK OF CODE TAKES A LONG TIME TO RUN

# original data

origMin15 <- createDataTable(15*60, origAgg)
origMin60 <- createDataTable(60*60, origAgg)
origHour12 <- createDataTable(12*60*60, origAgg)
origHour24 <- createDataTable(24*60*60, origAgg)

# duplicate free data

dpFreeMin15 <- createDataTable(15*60, dpFreeAgg)
dpFreeMin60 <- createDataTable(60*60, dpFreeAgg)
dpFreeHour12 <- createDataTable(12*60*60, dpFreeAgg)
dpFreeHour24 <- createDataTable(24*60*60, dpFreeAgg)

# Create Figure 67
x <- list(origMin15, origMin60, origHour12, origHour24)
y <- list(dpFreeMin15, dpFreeMin60, dpFreeHour12, dpFreeHour24)

createPlots(x, y, variable = 'adc0', lim = c(-500, 0), xlab = 'Duplicate-free soil water potential (kPa)', 
            ylab = "Origional soil water potential (kPa)")


# Create Figure 68
createPlots(x, y, variable = 'adc1', lim = c(0, 0.6), xlab = TeX('Duplicate-free soil moisture content ($m^3 m^{-3}$)'), 
            ylab = "Origional soil moisture content")

createPlots(x, y, variable = 'adc2', lim = c(0, .6), xlab = TeX('Duplicate-free soil moisture content ($m^3 m^{-3}$)'), 
            ylab = "Origional soil moisture content")