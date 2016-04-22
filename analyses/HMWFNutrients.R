################################################################################
#                                                                              #
# HMWF: Nutrient Analysis and Data Organizing                                  #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Created: 21 Apr 2016                                                         #
#                                                                              #
# Last update: 21 Apr 2016                                                     #
#                                                                              #
################################################################################
#                                                                              #
# Notes:                                                                       #
#                                                                              #
# Issues: Non Identified                                                       #
#                                                                              #
# Recent Changes:                                                              #
#         1.                                                                   #
#                                                                              #
# Future Changes (To-Do List):                                                 #
#         1.                                                                   #
#                                                                              #
################################################################################

# Initial Setup
rm(list=ls())
getwd()
setwd("~/GitHub/ResourceHeterogeneity/analyses")

# DOC
DOC2011 <- read.delim("../data/2011DOC_data.txt", header=T)
DOC2012 <- read.delim("../data/2012DOC_data.txt", header=T)
DOC <- rbind(DOC2011, DOC2012)
DOC <- DOC[grep("MEM*", DOC$Sample), ]
colnames(DOC) <- c("sample", "conc", "LCL", "UCL", "se")
DOCkey <- read.delim("../data/DOC_KEY_epi.txt", header=T)
DOC$code <- DOC$sample
DOC <- DOC[which(DOC$code %in% DOCkey$Sample.Name), ]
DOC$sample <- DOCkey$Site[match(DOCkey$Sample.Name, DOC$code)]
DOC$year <- substr(DOC$code, 4, 7)
DOC$conc <- pmax(DOC$conc, 0)
DOC$sample[grep("Pony", DOC$sample)] <- "Pony"
DOC <- droplevels(DOC)
DOC2 <- data.frame("sample" = DOC$sample, "year" = DOC$year, 
                   "conc" =  DOC$conc)[order(DOC$sample, DOC$year), ]

# Total Nitrogen
TN <- read.delim("../data/HMWF_TN.txt")
colnames(TN) <- c("sample", "year", "conc")
TN2 <- data.frame("sample" = TN$sample, "year" = TN$year, 
                  "conc" = TN$conc)[order(TN$sample, TN$year), ]
TN2 <- droplevels(TN2)

# Total Phosphorus
TP2011 <- read.delim("../data/2011TP_data.txt")
TP2012 <- read.delim("../data/2012TP_data.txt")
TP2011$year <- rep("2011", dim(TP2011)[1])
TP2012$year <- rep("2012", dim(TP2012)[1])
TP <- rbind(TP2011, TP2012)
TP <- TP[grep("*iltered", TP$Sample), ]
colnames(TP) <- c("sample", "conc", "LCL", "UCL", "se", "year")
TP$code <- TP$sample
TDP <- TP[grep("*Filtered", TP$sample), ]
TP <- TP[grep("*Unfiltered", TP$sample), ]
TP$sample <- gsub(" Unfiltered", "", TP$sample)
TDP$sample <- gsub(" Filtered", "", TDP$sample)
TP[6, ] <- TDP[6, ] # Replace Rush with TDP data since it is missing
TP[15, c(1:5)] <- TDP[15, c(1:5)] # Replace Pony with Pony TDP: values are outrageos
TP <- TP[-c(which(TP$sample == "CanyonHypo" | TP$sample == "CanyonChemo")), ]
TP$sample <- gsub("CanyonEpi", "Canyon", TP$sample)
TP$sample <- as.factor(TP$sample)
TP$conc <- pmax(TP$conc, 0)
TP$sample[grep("Pony", TP$sample)] <- "Pony"
TP <- droplevels(TP)
TP2 <- data.frame("sample" = TP$sample, "year" = TP$year, 
                  "conc" = TP$conc)[order(TP$sample, TP$year), ]

## Organize Final Data Table
DOC2 <- aggregate(conc ~ sample + year, DOC2, mean)
TN2 <- aggregate(conc ~ sample + year, TN2, mean)
TP2 <- aggregate(conc ~ sample + year, TP2, mean)

if (identical(DOC2$sample, TN2$sample)){
  nuts <- data.frame("Site" = DOC2$sample, "Year" = DOC2$year, 
                   "DOC" = round(DOC2$conc, 2), "TN" = round(TN2$conc, 2))
  } else {
    stop(print("DOC and TN are not organized correctly"))
  }

if (identical(nuts$Site, TP2$sample)){
  nuts$TP <- round(TP2$conc, 2)
  } else {
    stop(print("DOC, TN, and TP are not organized correctly"))
  }

write.csv(nuts, file = "../data/HMWF_Nutrients.txt", 
          quote = FALSE, row.names = FALSE)
