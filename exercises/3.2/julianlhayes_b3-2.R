# Exercise 3.2
# Julian Hayes

# Exercise 3.2.2

# Load the data
library(tswge)
data(dowjones2014)

# Find the length of the data to figure out which AIC method to use
length(dowjones2014)

# We will use AICC
aic.wge(dowjones2014, p=0:12, q=0:4, type="aicc")

# Plot the data
options(repr.plot.width=12, repr.plot.height=10, repr.plot.res = 125)
plot(dowjones2014, type="l", main="Dow Jones Index (2014)", 
     ylab="Dow Value", xlab="Time")

# Estimators:
# Yule-Walker
dow.yw <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='yw')
# Burg (based on FBLS)
dow.burg <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='burg')
# Maximum-Likelihood Estimators
dow.mle <- est.ar.wge(dowjones2014, p=1, factor = FALSE, type='mle')

# Compare results

# All three estimators suggested a phi value between 0.971 (Y-W) and 
# 0.982 (MLE), which are all close together. The sigma values range from 12898
# (MLE) and 12955 (Y-W) (Burg is in the middle for both). Every other result
# from each of the three is practically identical, if not completely 
# identical. It would seem as though each of the estimators produces 
# similar results.