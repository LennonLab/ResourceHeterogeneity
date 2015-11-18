# SRP concentration Script
# By Mario Muscarella
# Last Update 23 Aug 2011

#Standard Curve

exp <- c(0,0,5,5,5,10,10,10,25,25,25,50,50,50,100,100,100)
obs <- c(0.009,0.012,0.070,0.072,0.073,0.132,0.135,0.136,0.339,0.336,0.335,0.667,0.664,0.665,1.319,1.341,1.330)
st.crv <- cbind(exp,obs)
st.crv
crv <- lm(exp ~ obs)
summary(crv)

#Predictions based on Curve Data
pred.frame <- data.frame(obs)
pl <- predict(crv, int="p", newdata=pred.frame)
pl

#Visualization of Curve
plot(y=exp,x=obs,ylab="Expected Concentration (ug P/L)",xlab="Absorbance (885 nm)",pch=5)
matlines(pred.frame, pl, lty=c(1,2,2), lw=c(2,1,1), col= c("red","blue","blue"))

#Sample Data
sites <- c("UP","IV","SC","HW","MT","RS","LY","NP","AN","SP","CN")
raw <- c(0.014,0.007,0.012,0.007,0.034,0.008,0.012,0.045,0.010,0.052,0.010)

#Predictions for Sample Data
exp.2 <- c(0,0,5,5,5,10,10,10,25,25,25,50,50,50,100,100,100,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
obs.2 <- c(0.009,0.012,0.070,0.072,0.073,0.132,0.135,0.136,0.339,0.336,0.335,0.667,0.664,0.665,1.319,1.341,1.330,0.014,0.007,0.012,0.007,0.034,0.008,0.012,0.045,0.010,0.052,0.010)
crv.2 <- lm(exp.2 ~ obs.2)
summary(crv.2)
pred.frame.2 <- data.frame(obs.2)
pl.2 <- predict(crv.2, int="p", newdata=pred.frame.2,se.fit=TRUE)
pl.2

#Data Table
sample <- c(exp,sites)
names <- as.data.frame(sample)
data=cbind(names,pl.2$fit,pl.2$se.fit)
colnames(data) <- c("Sample","Concentration (ug P/L)","LCL","UCL","SE")
data

#Export Data
write.table(data,file="/Documents and Settings/Mario/My Documents/PhD Files/HMWF Project Files/Data/Phosphorous_SRPdata.txt", col.names=TRUE,row.names=FALSE,sep="\t")

 
