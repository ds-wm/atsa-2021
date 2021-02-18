# DATA Challenge 1.2 - King Kong Eats Grass 
# Check Figure 1.12 from textbook (Kingkong eat grass example)
# 8k Hz "King Kong Eats Grass" spoken over an electric fan

#install.packages("tswge")
library("tswge")

data(kingkong)
plotts.wge(kingkong)

par(mfrow = c(4,1))
plot(1:4000/8000, kingkong[1:4000], type = "l", xlab = 'Seconds', ylab = NA) #King
plot(4000:8000/8000, kingkong[4000:8000],type = "l", xlab = 'Seconds', ylab = NA) #Kong
plot(8000:12000/8000, kingkong[8000:12000],type = "l", xlab = 'Seconds', ylab = NA) #Eats
plot(12000:length(kingkong)/8000, kingkong[12000:length(kingkong)],type = "l", xlab = 'Seconds', ylab = NA) #Grass
