################################################################################
#                                                                              #
# Total Nitrogen Calculations for HMWF Data                                    #
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
# Notes: This script processes the raw data optained for total nitrogen        #
#         concentrations in Huron Mountain lakes. The data were generated      #
#         using a Tic/Toc-TN instrument (specs                                 #
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

raw.data=read.delim("./data/HMWF2011_DOC_TN_Raw.txt", header=TRUE)
raw.data

#Standard Curve

exp <- c(0,5,10,25,50,100)
obs <- c(raw.data[14,5],raw.data[21,5],raw.data[27,5],raw.data[33,5],
         raw.data[39,5],raw.data[45,5])
st.crv <- cbind(exp,obs)
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (mg N/L)",xlab="Mean Area",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sample <- c("MEM2011_001","MEM2011_002","MEM2011_003","MEM2011_004",
            "MEM2011_005","MEM2011_006","MEM2011_007","MEM2011_008",
            "MEM2011_009","MEM2011_010","MEM2011_011","MEM2011_012",
            "MEM2011_013","MEM2011_014","MEM2011_015","MEM2011_016",
            "MEM2011_017","MEM2011_018","MEM2011_019","MEM2011_020",
            "MEM2011_021","MEM2011_022")

raw <- c(raw.data[136,5],raw.data[146,5],raw.data[152,5],raw.data[162,5],
         raw.data[170,5],raw.data[176,5],raw.data[185,5],raw.data[197,5],
         raw.data[203,5],raw.data[209,5],raw.data[215,5],raw.data[222,5],
         raw.data[228,5],raw.data[237,5],raw.data[246,5],raw.data[253,5],
         raw.data[260,5],raw.data[269,5],raw.data[276,5],raw.data[284,5],
         raw.data[292,5],raw.data[299,5])

#Predictions for Sample Data
exp.2 <- c(0,5,10,25,50,100,rep(NA,22))
obs.2 <- c(obs, raw)
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2$fit
pl.2$se

#Data Table
sample.2 <- c(exp,sample)
names <- as.data.frame(sample.2)
se <- as.data.frame(pl.2$se)

data <- cbind(names,pl.2$fit,se)
colnames(data) <- c("Sample","Concentration (mg N/L)","LCL","UCL","SE")
data

#Export Data
write.table(data, file="./data/2011TN_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")

################################################################################
# 2012 Data                                                                    #
################################################################################

raw.data=read.delim("./data/HMWF2012_DOC_TN_Raw.txt", header=TRUE)
raw.data

#Standard Curve

exp <- c(0,5,10,25,50,100)
obs <- c(raw.data[15,5],raw.data[23,5],raw.data[29,5],raw.data[35,5],
         raw.data[41,5],raw.data[47,5])
st.crv <- cbind(exp,obs)
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (mg N/L)",xlab="Mean Area",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sample <- c("MEM2012_001","MEM2012_002","MEM2012_003","MEM2012_004",
            "MEM2012_005","MEM2012_006","MEM2012_007","MEM2012_008",
            "MEM2012_009","MEM2012_010","MEM2012_011","MEM2012_012",
            "MEM2012_013","MEM2012_014","MEM2012_015","MEM2012_016",
            "MEM2012_017","MEM2012_018","MEM2012_019","MEM2012_020",
            "MEM2012_021","MEM2012_022","MEM2012_023","MEM2012_024",
            "MEM2012_025","MEM2012_026","MEM2012_027","MEM2012_027",
            "MEM2012_029","MEM2012_030")

raw <- c(raw.data[54,5],raw.data[62,5],raw.data[70,5],raw.data[78,5],
         raw.data[85,5],raw.data[91,5],raw.data[97,5],raw.data[103,5],
         raw.data[110,5],raw.data[118,5],raw.data[127,5],raw.data[135,5],
         raw.data[142,5],raw.data[150,5],raw.data[158,5],raw.data[164,5],
         raw.data[172,5],raw.data[178,5],raw.data[192,5],raw.data[199,5],
         raw.data[207,5],raw.data[213,5],raw.data[221,5],raw.data[229,5],
         raw.data[235,5],raw.data[241,5],raw.data[248,5],raw.data[256,5],
         raw.data[263,5],raw.data[272,5])

#Predictions for Sample Data
exp.2 <- c(0,5,10,25,50,100,rep(NA, 30))
obs.2 <- c(obs, raw)
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2$fit
pl.2$se

#Data Table
sample.2 <- c(exp,sample)
names <- as.data.frame(sample.2)
se <- as.data.frame(pl.2$se)

data <- cbind(names,pl.2$fit,se)
colnames(data) <- c("Sample","Concentration (mg N/L)","LCL","UCL","SE")
data

#Export Data
write.table(data, file="./data/2012TN_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")

