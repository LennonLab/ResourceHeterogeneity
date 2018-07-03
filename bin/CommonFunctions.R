################################################################################
#                                                                              #
# HMWF Project Functions                                                       #
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

# Summary Functions
se <- function(x, ...){sd(x, na.rm = TRUE)/sqrt(length(na.omit(x)))}
CV <- function(x, ...){(sd(x, na.rm = TRUE)/mean(x, na.rm = TRUE))*100}

# Confidence Hulls
add.hull <- function(model = "", pred.frame = ""){
  CI.U <- predict(model, interval = "c", newdata=pred.frame)[, "upr"]
  CI.L <- predict(model, interval = "c", newdata=pred.frame)[, "lwr"]
  pred.frame2 <- unlist(pred.frame)
  X.Vec <- c(pred.frame2, tail(pred.frame2, 1), rev(pred.frame2),
             head(pred.frame2, 1))
  Y.Vec <- c(CI.U, tail(CI.L, 1), rev(CI.L), head(CI.U,1))
  polygon(X.Vec, Y.Vec, col = "gray90", border = NA)
}

# Diversity Functions
goods <- function(x = ""){
  1 - (sum(x == 1) / rowSums(x))
}

SimpE <- function(x = ""){
  x <- as.data.frame(x)
  D <- vegan::diversity(x, "inv")
  S <- sum((x > 0) * 1) 
  E <- (D)/S 
  return(E)
}

H <- function(x = ""){
  x <- x[x>0]
  H = 0
  for (n_i in x){
    p = n_i / sum(x)
    H = H - p*log(p) 
  }
  return(H)
}

beta.w <- function(site1 = "", site2 = ""){
  site1 = subset(site1, select = site1 > 0)               # Removes absences
  site2 = subset(site2, select = site2 > 0)               # Removes absences
  gamma = union(colnames(site1), colnames(site2))         # Gamma species pool
  s     = length(gamma)                                   # Gamma richness
  a.bar = mean(c(specnumber(site1), specnumber(site2)))   # Mean sample richness
  b.w   = round(s/a.bar - 1, 3)
  return(b.w)
}

