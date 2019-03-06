################################################################################
#                                                                              #
# Dissolved Organic Carbon Calculations for HMWF Data                          #
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
# Notes: This script processes the raw data obtained for total nitrogen        #
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
obs <- c(raw.data[9,5],raw.data[16,5],raw.data[23,5],raw.data[29,5],
         raw.data[35,5],raw.data[41,5])
st.crv <- cbind(exp,obs)
st.crv
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)
pl

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (mg C/L)",xlab="Mean Area",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sample <- c("MEM2011_001","MEM2011_002","MEM2011_003","MEM2011_004",
            "MEM2011_005","MEM2011_006","MEM2011_007","MEM2011_008",
            "MEM2011_009","MEM2011_010","MEM2011_011","MEM2011_012",
            "MEM2011_013","MEM2011_014","MEM2011_015","MEM2011_016",
            "MEM2011_017","MEM2011_018","MEM2011_019","MEM2011_020",
            "MEM2011_021","MEM2011_022")

raw <- c(raw.data[132,5],raw.data[140,5],raw.data[149,5],raw.data[159,5],
         raw.data[167,5],raw.data[173,5],raw.data[182,5],raw.data[194,5],
         raw.data[200,5],raw.data[206,5],raw.data[212,5],raw.data[218,5],
         raw.data[225,5],raw.data[233,5],raw.data[242,5],raw.data[249,5],
         raw.data[257,5],raw.data[266,5],raw.data[273,5],raw.data[279,5],
         raw.data[289,5],raw.data[295,5])

#Predictions for Sample Data
exp.2 <- c(0,5,10,25,50,100,rep(NA, 22))
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
colnames(data) <- c("Sample","Concentration (mg C/L)","LCL","UCL","SE")

#Export Data
write.table(data, file="./data/2011DOC_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")

################################################################################
# 2012 Data                                                                    #
################################################################################

HMWF2012.raw <- read.delim("./data/HMWF2012_DOC_TN_Raw.txt", header=TRUE)
HMWF2012.raw
colnames(HMWF2012.raw) <- c("Sample", "Injection", "Analysis", "Area",
                            "Mean_Area", "Excluded", "Vol", "X")

HMWF2012.doc <- HMWF2012.raw[HMWF2012.raw$Analysis == "NPOC", ]

#Standard Curve

exp <- c(0,5,10,25,50,100)
obs <- c(mean(HMWF2012.doc[HMWF2012.doc$Sample == "Blank Sipper", 5]),
         mean(HMWF2012.doc[HMWF2012.doc$Sample == "5ppm C,N", 5]),
         mean(HMWF2012.doc[HMWF2012.doc$Sample == "10ppm C,N", 5]),
         mean(HMWF2012.doc[HMWF2012.doc$Sample == "25ppm C,N", 5]),
         mean(HMWF2012.doc[HMWF2012.doc$Sample == "50ppm C,N", 5]),
         mean(HMWF2012.doc[HMWF2012.doc$Sample == "100ppm C,N", 5]))
st.crv <- cbind(exp,obs)
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (mg C/L)",xlab="Mean Area",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sample <- c("MEM2012_001","MEM2012_002","MEM2012_003","MEM2012_004",
            "MEM2012_005","MEM2012_006","MEM2012_007","MEM2012_008",
            "MEM2012_009","MEM2012_010","MEM2012_011","MEM2012_012",
            "MEM2012_013","MEM2012_014","MEM2012_015","MEM2012_016",
            "MEM2012_017","MEM2012_018","MEM2012_019","MEM2012_020",
            "MEM2012_021","MEM2012_022","MEM2012_023","MEM2012_024",
            "MEM2012_025","MEM2012_026","MEM2012_027","MEM2012_028",
            "MEM2012_029","MEM2012_030")

raw <- rep(NA, length(sample))

for (i in 1:length(raw)){
  raw[i] <- mean(HMWF2012.doc[HMWF2012.doc$Sample == sample[i], 5])
}

#Predictions for Sample Data
exp.2 <- c(0,5,10,25,50,100,rep(NA, length(sample)))
obs.2 <- c(obs, raw)
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2$fit
pl.2$se

#Data Table
sample.2 <- c(exp,sample)
sample.2
names <- as.data.frame(sample.2)
se <- as.data.frame(pl.2$se)

data <- cbind(names,pl.2$fit,se)
colnames(data) <- c("Sample","Concentration (mg C/L)","LCL","UCL","SE")
data

#Export Data
write.table(data,file="./data/2012DOC_data.txt", col.names=TRUE,
            row.names=FALSE,sep="\t")
