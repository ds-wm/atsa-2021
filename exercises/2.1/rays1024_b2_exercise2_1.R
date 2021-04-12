setwd("/Users/wangqingjiu/Desktop")
source('Utility.R')


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


data.og<-merged(list(data2003,data2015,data2025,data2045,data2055,data2065,data2085,data2095,data2103,data2115,data2125,data2135))
data.dedup<-deduped(data.og)

for (i in 1:nrow(data.og)){
  data.og[i,'adc0']<-calcSwp(data.og[i,'adc0'])
  data.og[i,'adc1']<-calcVwc(data.og[i,'adc1'])
  data.og[i,'adc2']<-calcVwc(data.og[i,'adc2'])
}

for (i in 1:nrow(data.dedup)){
  data.dedup[i,'adc0']<-calcSwp(data.dedup[i,'adc0'])
  data.dedup[i,'adc1']<-calcVwc(data.dedup[i,'adc1'])
  data.dedup[i,'adc2']<-calcVwc(data.dedup[i,'adc2'])
}

og.quarter<-time(data.og,15)
og.hour<-time(data.og,60)
og.halfday<-time(data.og,12*60)
og.day<-time(data.og,24*60)

dedup.quarter<-time(data.dedup,15)
dedup.hour<-time(data.dedup,60)
dedup.halfday<-time(data.dedup,12*60)
dedup.day<-time(data.dedup,24*60)

print(cor(og.quarter$adc0,dedup.quarter$adc0))
print(cor(og.quarter$adc0,dedup.quarter$adc0)^2)
print(sqrt(mean((lm(dedup.quarter$adc0~og.quarter$adc0)$residuals)^2)))

print(cor(og.quarter$adc1,dedup.quarter$adc1))
print(cor(og.quarter$adc1,dedup.quarter$adc1)^2)
print(sqrt(mean((lm(dedup.quarter$adc1~og.quarter$adc1)$residuals)^2)))

print(cor(og.quarter$adc2,dedup.quarter$adc2))
print(cor(og.quarter$adc2,dedup.quarter$adc2)^2)
print(sqrt(mean((lm(dedup.quarter$adc2~og.quarter$adc2)$residuals)^2)))

print(cor(og.hour$adc0,dedup.hour$adc0))
print(cor(og.hour$adc0,dedup.hour$adc0)^2)
print(sqrt(mean((lm(dedup.hour$adc0~og.hour$adc0)$residuals)^2)))

print(cor(og.hour$adc1,dedup.hour$adc1))
print(cor(og.hour$adc1,dedup.hour$adc1)^2)
print(sqrt(mean((lm(dedup.hour$adc1~og.hour$adc1)$residuals)^2)))

print(cor(og.hour$adc2,og.hour$adc2))
print(cor(og.hour$adc2,dedup.hour$adc2)^2)
print(sqrt(mean((lm(dedup.hour$adc2~og.hour$adc2)$residuals)^2)))

print(cor(og.halfday$adc0,dedup.halfday$adc0))
print(cor(og.halfday$adc0,dedup.halfday$adc0)^2)
print(sqrt(mean((lm(dedup.halfday$adc0~og.halfday$adc0)$residuals)^2)))

print(cor(og.halfday$adc1,dedup.halfday$adc1))
print(cor(og.halfday$adc1,dedup.halfday$adc1)^2)
print(sqrt(mean((lm(dedup.halfday$adc1~og.halfday$adc1)$residuals)^2)))

print(cor(og.halfday$adc2,dedup.halfday$adc2))
print(cor(og.halfday$adc2,dedup.halfday$adc2)^2)
print(sqrt(mean((lm(dedup.halfday$adc2~og.halfday$adc2)$residuals)^2)))

print(cor(og.day$adc0,dedup.day$adc0))
print(cor(og.day$adc0,dedup.day$adc0)^2)
print(sqrt(mean((lm(dedup.day$adc0~og.day$adc0)$residuals)^2)))

print(cor(og.day$adc1,dedup.day$adc1))
print(cor(og.day$adc1,dedup.day$adc1)^2)
print(sqrt(mean((lm(dedup.day$adc1~og.day$adc1)$residuals)^2)))

print(cor(og.day$adc2,dedup.day$adc2))
print(cor(og.day$adc2,dedup.day$adc2)^2)
print(sqrt(mean((lm(dedup.day$adc2~og.day$adc2)$residuals)^2)))

par(mfrow=c(2,2))
plot(og.quarter$adc0, dedup.quarter$adc0,type = 'p',
     xlab = "Original Soil Water Potential", 
     ylab = "Deduped Soil Water Potential",
     main = "15-Minute Aggregation: ADC0")
plot(og.hour$adc0, dedup.hour$adc0,type = 'p',
     xlab = "Original Soil Water Potential", 
     ylab = "Deduped Soil Water Potential",
     main = "60-Minute Aggregation: ADC0")
plot(og.halfday$adc0, dedup.halfday$adc0,type = 'p',
     xlab = "Original Soil Water Potential", 
     ylab = "Deduped Soil Water Potential",
     main = "12-Hour Aggregation: ADC0")
plot(og.day$adc0, dedup.day$adc0,type = 'p',
     xlab = "Original Soil Water Potential", 
     ylab = "Deduped Soil Water Potential",
     main = "24-Hour Aggregation: ADC0")

par(mfrow=c(2,2))
plot(og.quarter$adc1, dedup.quarter$adc1,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "15-Minute Aggregation: ADC1")
plot(og.hour$adc1, dedup.hour$adc1,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "60-Minute Aggregation: ADC1")
plot(og.halfday$adc1, dedup.halfday$adc1,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "12-Hour Aggregation: ADC1")
plot(og.day$adc1, dedup.day$adc1,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "24-Hour Aggregation: ADC1")

par(mfrow=c(2,2))
plot(og.quarter$adc2, dedup.quarter$adc2,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "15-Minute Aggregation: ADC2")
plot(og.hour$adc2, dedup.hour$adc2,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "60-Minute Aggregation: ADC2")
plot(og.halfday$adc2, dedup.halfday$adc2,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "12-Hour Aggregation: ADC2")
plot(og.day$adc2, dedup.day$adc2,type = 'p',
     xlab = "Original Soil Moisture", 
     ylab = "Deduped Soil Moisture",
     main = "24-Hour Aggregation: ADC2")







