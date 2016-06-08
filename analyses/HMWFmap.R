################################################################################
#                                                                              #
# System Map and Area Calculations for HMWF Projec                             #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Created: 19 Apr 2016                                                         #
#                                                                              #
# Last update: 19 Apr 2016                                                     #
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

# Required Packages
require("RgoogleMaps")
library("maps")
library("mapdata")
require("maptools")

# Water Body Physical Information
## Imorted because we will add area from the map files

lake.data <- read.csv("../data/lake_data.txt", row.names=1)
colnames(lake.data) <- c("lat", "long", "area", "pH", "DO1", "DO2", "Temp1", "Temp2")
lake.data$area <- rep(NA, dim(lake.data)[1])


# Study System Map
# Shape file source: http://www.mcgi.state.mi.us/mgdl/?rel=ext&action=sext

shape <- readShapePoly("../data/lake_polygons_200403/lake_polygons_200403.shp", 
                       IDvar = "UNIQUE_ID")

# Extract Areas
grp.opt <- shape$COUNTY == "Marquette" & shape$FMU == "LSW"
lake.data$area[1] <- shape$AREA[which(shape$NAME == "Lake Ann" & grp.opt)]
lake.data$area[2] <- shape$AREA[which(shape$NAME == "Canyon Lake" & grp.opt)]
lake.data$area[3] <- shape$AREA[which(shape$NAME == "Howe Lake" & grp.opt)]
lake.data$area[4] <- shape$AREA[which(shape$NAME == "Ives Lake" & grp.opt)]
lake.data$area[5] <- shape$AREA[which(shape$NAME == "Lily Pond" & grp.opt)]
lake.data$area[6] <- shape$AREA[which(shape$NAME == "Mountain Lake" & grp.opt)]
lake.data$area[7] <- 2000 # estimate...smallest and not in GIS dataset
lake.data$area[8] <- shape$AREA[which(shape$NAME == "Rush Lake" & grp.opt)]
lake.data$area[9] <- shape$AREA[which(shape$NAME == "Second Lake" & grp.opt)]
lake.data$area[10] <- shape$AREA[which(shape$NAME == "Third Lake" & grp.opt)]

# Convert sq m to sq km
lake.data$area <- lake.data$area / 1000000

# Area in ha
lake.data$area
lake.data$area * 100

# Wriate data table
write.csv(lake.data, file = "../data/lake_data2.txt", row.names=T)

# Notes on how to get shapefile info
# str(shape, max.level=4)
# Attempt to find Pony
# plot(shape[which(shape$LAKE_NAME == "no name" & 
# shape$COUNTY == "Marquette" & shape$FMU == "LSW"), ])

# Plot from shapefile (just to check)
#  grp.opts <- shape$COUNTY == "Marquette" & shape$FMU == "LSW"
#  plot(shape[c(
#   which(shape$NAME == "Ives Lake" & grp.opts),
#   which(shape$NAME == "Mountain Lake" & grp.opts),
#   which(shape$NAME == "Howe Lake" & grp.opts),
#   which(shape$NAME == "Rush Lake" & grp.opts),
#   which(shape$NAME == "Lake Ann" & grp.opts),
#   which(shape$NAME == "Canyon Lake" & grp.opts),
#   which(shape$NAME == "Lily Pond" & grp.opts),
#   which(shape$NAME == "Second Lake" & grp.opts),
#   which(shape$NAME == "Third Lake" & grp.opts)),])

## Figure 1: Study System Map
png(filename="../figures/Supp1.png",
    width = 1800, height = 900, res = 96*2)
par(opar)
par(mfrow = c(1,1), mar = c(0, 0, 0, 0), oma = c(0, 0, 0, 0) + 0.5)

newmap1 <- GetMap(center = c(46.86, -87.93), zoom = 13, 
                  maptype = "terrain", GRAYSCALE = TRUE, frame = FALSE,
                  path = "&style=feature:all|element:labels|visibility:off")
newmap2 <- GetMap(center = c(46.86, -87.82), zoom = 13, 
                  maptype = "terrain", GRAYSCALE = TRUE, frame = FALSE,
                  path = "&style=feature:all|element:labels|visibility:off")

layout( matrix(c(1,1,1,1,2,2,2,2,
                 1,1,1,1,2,2,2,2,
                 1,1,1,1,2,2,3,3,
                 1,1,1,1,2,2,3,3), 4, 8, byrow = TRUE),
        widths = rep(2, 8), heights = rep(2, 8))
layout.show(3)

# Left Side
PlotOnStaticMap(newmap1, zoom = 13, cex = 2, col = "blue")
text(-120, 270, "Howe", col="red", cex=1.2)
text(100, 255, "Rush", col="red", cex=1.2)
text(105, 55, "Mountain", col="red", cex=1.2)
arrows(10, 100, x1 = -10, y1 = 100, length=0.05, col = "red", lwd = 2, code = 1)
text(-36, 100, "Ann", col="red", cex=1.2)
arrows(60, 230, x1 = 40, y1 = 230, length=0.05, col = "red", lwd = 2, code = 1)
text(8, 230, "Pony", col="red", cex=1.2)
arrows(55, -230, x1 = 75, y1 = -230, length=0.05, col = "red", lwd = 2, code = 1)
text(120, -230, "Canyon", col="red", cex=1.2)

# Right Side
PlotOnStaticMap(newmap2, zoom = 13, cex = 2, col = "blue")
text(-180, -90, "Ives", col="red", cex=1.2)
arrows(-160, 20, x1 = -140, y1 = 20, length = 0.05, col = "red", lwd = 2, code = 1)
text(-75, 20, "Upper Pine", col="red", cex = 1.2)
arrows(-220, 80, x1 = -200, y1 = 80, length = 0.05, col = "red", lwd = 2, code = 1)
text(-125, 80, "Second Pine", col="red", cex = 1.2)
arrows(-55, -105, x1 = -35, y1 = -105, length = 0.05, col = "red", lwd = 2, code = 1)
text(-12, -105, "Lily", col="red", cex=1.2)

# Compass Arrow
arrows(280, 280, 280, 240, length = 0.1, col = "black", lwd = 3, code = 1)
text(280, 220, "N", col = "black", cex = 1.5)

# Inset
map("state", "Michigan", col = "gray80", fill = TRUE, 
    xlim = c(-92,-82), ylim = c(41, 48))
points(-87.89, 46.8, pch = 20, col = "red")

dev.off() # this writes plot to folder
graphics.off() # shuts down open devices 


