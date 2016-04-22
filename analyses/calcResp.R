################################################################################
#                                                                              #
# HMWF 2011 & 2012 Respiration                                                 #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Last update: 2015/12/03                                                      #
#                                                                              #
################################################################################
#                                                                              #
# Notes: This code provides the initial analysis for the HMWF 2011/2012        #
#        Bacterial respiration analysis. The code imports all of the raw       #
#        PreSens data and uses linear regression to calculate respiration      #
#        rate during the first 5 quality hours of the experiments. At the      #
#        moment the user has to define the start time for the calcuation       #
#                                                                              #
# Dependencies:                                                                #
#         1. PreSensRespiration.R                                              #
#         2. PreSensInteractiveRegression.R                                    #
#                                                                              #
# Issues: It seems inefficient to do each analysis by itself                   #
#                                                                              #
# Recent Changes:                                                              #
#                                                                              #
# Future Changes (To-Do List):                                                 #
#         1.                                                                   #
#                                                                              #
################################################################################

# Initial Setup
rm(list=ls())
getwd()
setwd("~/GitHub/ResourceHeterogeneity/analyses")

# Load PreSens Package
# Inport the function from source file
source("../bin/PreSensInteractiveRegression.r") # Use to pick the time windows
source("../bin/PreSensRespiration.R")

# Test
# PreSens.Respiration(infile = input, outfile = "./test.txt", in.format = "Rows")

# HMWF Respiration Analyses
# HMWF 2011 Day 1
input  <-  "../data/PreSens/HMWF2011_Day1_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day1_BR.txt"
in.name <- c("Ives", "Howe", "Rush", "NPony", "Pony", "Empty",
             rep("Empty", 6),
             "UF.Ives", "UF.Howe", "UF.Rush", "UF.NPony", "UF.Pony", "Empty",
             rep("Empty", 6))
PreSens.Respiration2(infile = input, outfile = output, start = 32,
                     end = 40, name.in = in.name)

# HMWF 2011 Day 2
input  <-  "../data/PreSens/HMWF2011_Day2_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day2_BR.txt"
in.name <- c("UpperPine", "SecondPine", "Mountain", "Lily", rep("Empty", 2),
             "UF.UpperPine", "UF.SecondPine", "UF.Mountain", "UF.Lily", rep("Empty", 2),
             rep("Empty", 6),
             rep("Empty", 6))
PreSens.Respiration2(infile = input, outfile = output, start = 32,
                     end = 40, name.in = in.name)

# HMWF 2011 Day 3
input  <-  "../data/PreSens/HMWF2011_Day2_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day3_BR.txt"
in.name <- c(rep("Empty", 6),
             rep("Empty", 6),
             "Ann", "Canyon", rep("Empty", 4),
             "UF.Ann", "UF.Canyon", rep("Empty", 4))
PreSens.Respiration2(infile = input, outfile = output, start = 43,
                     end = 53, name.in = in.name)

# HMWF 2012 Set 1 Day 1
input  <-  "../data/PreSens/HMWF2012_171_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day1_BR.txt"
in.name <- c("Canyon", "Canyon", "Canyon", rep("Empty", 21))
PreSens.Respiration2(infile = input, outfile = output, start = 70,
                     end = 90, name.in = in.name)

# HMWF 2012 Set 1 Day 2
input  <-  "../data/PreSens/HMWF2012_171_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day2_BR.txt"
in.name <- c(rep("Empty", 3), rep("SecondPine", 3),
             rep("Empty", 3), rep("UpperPine", 3),
             rep("Empty", 3), rep("Ann", 3),
             rep("Empty", 3), rep("Mountain", 3))
PreSens.Respiration2(infile = input, outfile = output, start = 70,
                     end = 90, name.in = in.name)

# HMWF 2012 Set 2 Day 1
input  <-  "../data/PreSens/HMWF2012_189_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day3_BR.txt"
in.name <- c(rep("Howe", 3), rep("Empty", 3),
             rep("Rush", 3), rep("Empty", 3),
             rep("Pony", 3), rep("Empty", 3),
             rep("Empty", 3), rep("Empty", 3))
# PreSens.Respiration(infile = input, outfile = "./test.txt", in.format = "Rows")
PreSens.Respiration2(infile = input, outfile = output, start = 90,
                     end = 100, name.in = in.name)

# HMWF 2012 Set 2 Day 2
input  <-  "../data/PreSens/HMWF2012_189_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day4_BR.txt"
in.name <- c(rep("Empty", 3), rep("Ives", 3),
             rep("Empty", 3), rep("Lily", 3),
             rep("Empty", 3), rep("Empty", 3),
             rep("Empty", 3), rep("Empty", 3))
PreSens.Respiration2(infile = input, outfile = output, start = 118,
                     end = 130, name.in = in.name)

# Import Individual Output Files
hmwf2011a <- read.csv("../data/PreSens/HMWF2011_Day1_BR.txt")
hmwf2011b <- read.csv("../data/PreSens/HMWF2011_Day2_BR.txt")
hmwf2011c <- read.csv("../data/PreSens/HMWF2011_Day3_BR.txt")
hmwf2012a <- read.csv("../data/PreSens/HMWF2012_Day1_BR.txt")
hmwf2012b <- read.csv("../data/PreSens/HMWF2012_Day2_BR.txt")
hmwf2012c <- read.csv("../data/PreSens/HMWF2012_Day3_BR.txt")
hmwf2012d <- read.csv("../data/PreSens/HMWF2012_Day4_BR.txt")

# Add Years
hmwf2011a$year <- 2011
hmwf2011b$year <- 2011
hmwf2011c$year <- 2011
hmwf2012a$year <- 2012
hmwf2012b$year <- 2012
hmwf2012c$year <- 2012
hmwf2012d$year <- 2012

hmwf_resp <- do.call("rbind", list(hmwf2011a, hmwf2011b, hmwf2011c, hmwf2012a,
                                   hmwf2012b, hmwf2012c, hmwf2012d))

colnames(hmwf_resp) <- c("sample", "start", "end", "rate", "r2", "p", "year")

lakes <- c("Ann", "Canyon", "Howe", "Ives", "Lily", "Mountain", "Pony", "Rush",
           "SecondPine", "UpperPine")

hmwf_resp <- droplevels(hmwf_resp[hmwf_resp$sample %in% lakes, ])

hmwfresp <- aggregate(rate ~ sample + year, hmwf_resp, mean)

write.table(hmwf_resp, "../data/Respiration.txt", sep = "\t", quote=F)
