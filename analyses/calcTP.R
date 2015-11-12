################################################################################
#                                                                              #
# Total Phosphorus Calculations for HMWF Data                                  #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Created: 23 Aug 2011                                                         #
#                                                                              #
# Last update: 12 Nov 2015                                                     #
#                                                                              #
################################################################################
#                                                                              #
# Notes: This script processes the raw data optained for total phosphorus      #
#         concentrations in Huron Mountain lakes. The data were generated      #
#         using a the ammonium molybdate method with oxidation                 #
#                                                                              #
# Issues: Non Identified                                                       #
#                                                                              #
# Recent Changes:                                                              #
#         1. Added calculations for 2012 data                                  #
#                                                                              #
# Future Changes (To-Do List):                                                 #
#         1.                                                                   #
#                                                                              #
################################################################################

setwd("~/GitHub/ResourceHeterogeneity")

################################################################################
# 2011 Data                                                                    #
################################################################################

raw.data=read.delim("./data/HMWF2011_TP_Raw.txt", header=TRUE)

#Standard Curve
exp <- c(0,0,5,5,10,10,25,25,50,50,100,100)
obs <- c(raw.data[1:2,2],raw.data[7:16,2])
st.crv <- cbind(exp,obs)
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (ug P/L)",xlab="Absorbance (885 nm)",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sites <- as.character(raw.data$Sample[17:38])
sites
raw <- c(raw.data[17:38,2])
raw

#Predictions for Sample Data
exp.2 <- c(0,0,5,5,10,10,25,25,50,50,100,100,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
           NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
obs.2 <- c(raw.data[1:2,2],raw.data[7:16,2],raw.data[17:38,2])
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2$fit

#Data Table
sample <- c(exp,sites)
names <- as.data.frame(sample)

data=cbind(names,pl.2$fit,pl.2$se.fit)
colnames(data) <- c("Sample","Concentration (ug P/L)","LCL","UCL","SE")
data

#Export Data
write.table(data, file="./data/2011TP_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")

################################################################################
# 2012 Data                                                                    #
################################################################################

raw.data=read.delim("./data/HMWF2012_TP_Raw.txt", header=TRUE)

#Standard Curve
exp <- c(0,0,5,5,10,10,25,25,50,50,100,100)
obs <- c(raw.data[1:2,2],raw.data[7:16,2])
st.crv <- cbind(exp,obs)
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (ug P/L)",xlab="Absorbance (885 nm)",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sites <- as.character(raw.data$Sample[17:40])
raw <- c(raw.data[17:40,2])

#Predictions for Sample Data
exp.2 <- c(0,0,5,5,10,10,25,25,50,50,100,100,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
           NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
obs.2 <- c(raw.data[1:2,2],raw.data[7:16,2],raw.data[17:40,2])
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2$fit

#Data Table
sample <- c(exp,sites)
names <- as.data.frame(sample)

data=cbind(names,pl.2$fit,pl.2$se.fit)
colnames(data) <- c("Sample","Concentration (ug P/L)","LCL","UCL","SE")
data

#Export Data
write.table(data, file="./data/2012TP_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")



