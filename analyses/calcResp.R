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

# HMWF Respiration Analyses
# HMWF 2011 Day 1
input  <-  "../data/PreSens/HMWF2011_Day1_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day1_BR.txt"
in.name <- c("F.Ives", "F.Howe", "F.Rush", "F.NPony", "F.Pony", "Empty",
             rep("Empty", 6),
             "UF.Ives", "UF.Howe", "UF.Rush", "UF.NPony", "UF.Pony", "Empty",
             rep("Empty", 6))
PreSens.Respiration2(infile = input, outfile = output, start = 20,
                     end = 25, name.in = in.name)

# HMWF 2011 Day 2
input  <-  "../data/PreSens/HMWF2011_Day2_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day2_BR.txt"
in.name <- c("F.UpperPine", "F.SecondPine", "F.Mountain", "F.Lily", rep("Empty", 2),
             "UF.UpperPine", "UF.SecondPine", "UF.Mountain", "UF.Lily", rep("Empty", 2),
             rep("Empty", 6),
             rep("Empty", 6))
PreSens.Respiration2(infile = input, outfile = output, start = 20,
                     end = 25, name.in = in.name)

# HMWF 2011 Day 3
input  <-  "../data/PreSens/HMWF2011_Day2_Oxygen.txt"
output <-  "../data/PreSens/HMWF2011_Day3_BR.txt"
in.name <- c(rep("Empty", 6),
             rep("Empty", 6),
             "F.Ann", "F.Canyon", rep("Empty", 4),
             "UF.Ann", "UF.Canyon", rep("Empty", 4))
PreSens.Respiration2(infile = input, outfile = output, start = 43,
                     end = 53, name.in = in.name)

# HMWF 2012 Set 1 Day 1
input  <-  "../data/PreSens/HMWF2012_171_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day1_BR.txt"
in.name <- c("Canyon", "Canyon", "Canyon", rep("Empty", 21))
PreSens.Respiration2(infile = input, outfile = output, start = 10,
                     end = 60, name.in = in.name)

# HMWF 2012 Set 1 Day 2
input  <-  "../data/PreSens/HMWF2012_171_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day2_BR.txt"
in.name <- c(rep("Empty", 3), rep("SecondPine", 3),
             rep("Empty", 3), rep("UpperPine", 3),
             rep("Empty", 3), rep("Ann", 3),
             rep("Empty", 3), rep("Mountain", 3))
PreSens.Respiration2(infile = input, outfile = output, start = 50,
                     end = 110, name.in = in.name)

# HMWF 2012 Set 2 Day 1
input  <-  "../data/PreSens/HMWF2012_189_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day3_BR.txt"
in.name <- c(rep("Howe", 3), rep("Empty", 3),
             rep("Rush", 3), rep("Empty", 3),
             rep("Pony", 3), rep("Empty", 3),
             rep("Empty", 3), rep("Empty", 3))
PreSens.Respiration2(infile = input, outfile = output, start = 60,
                     end = 120, name.in = in.name)

# HMWF 2012 Set 2 Day 1
input  <-  "../data/PreSens/HMWF2012_189_Oxygen.txt"
output <-  "../data/PreSens/HMWF2012_Day4_BR.txt"
in.name <- c(rep("Empty", 3), rep("Ives", 3),
             rep("Empty", 3), rep("Lily", 3),
             rep("Empty", 3), rep("Empty", 3),
             rep("Empty", 3), rep("Empty", 3))
PreSens.Respiration2(infile = input, outfile = output, start = 80,
                     end = 140, name.in = in.name)


