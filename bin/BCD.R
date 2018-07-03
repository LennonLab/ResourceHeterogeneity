
#                                 Appendix 5, R function
#
# An R function to find the best exponent for Box-Cox transformation to normality.


#' Box-Cox transformation: find the best exponent to reach multivariate normality.
#'
#' Box-Cox-Dagnelie (BCD) method – Transform the data using different exponents. 
#' Default: exponents in the [0,1] interval by steps of 0.1. Test the multivariate 
#' normality of the data after each transformation using function dagnelie.test() 
#' from package ade4.
#' Note: the Dagnelie test requires that n > (rank+1) where 'n' is the number of 
#' obsevations and 'rank' is the rank of the covariance matrix.
#'
#' Arguments --
#' @param mat  Multivariate data table (object class: matrix or data.frame).
#' @param bc.exp  vector of exponents from the Box-Cox series for transformation, 
#'    for example bc.exp = c(0,0.1,0.2,0.25,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
#'    Positive and negative exponents are allowed by the function, although 
#'    it is recommended to use exponent values in the range [0,1].
#' @param chord  Chord-transform the data and recompute the Dagnelie test of 
#'    normality. Default: chord=TRUE; if chord=FALSE, do not transform data and 
#'    do not recompute the test.
#'
#' Value --
#' A table showing the Box-Cox exponent in the first column of each row. In 
#' columns 2 and 3, one finds the Shapiro-Wilk W statistic (BC_W) of the Dagnelie 
#' test of multivariate normality and the associated p-value (BC_p-val) after the 
#' exponent has been applied to the original data. Columns 4 and 5 show the same  
#' statistics(BC.chord_W and BC.chord_p-val) after the chord transformation has    
#' been applied to the Box-Cox transformed data.
#' 
#' References --
#'  Dagnelie, P. 1975. L'analyse statistique a plusieurs variables. 
#'  Les Presses agronomiques de Gembloux, Gembloux, Belgium.
#'
#'  Legendre, P. and L. Legendre. 2012. Numerical ecology, 3rd English
#'  edition. Elsevier Science BV, Amsterdam, The Netherlands.
#'
#' Author  Pierre Legendre
#' License GPL (>=2)

BCD <- 
	function(mat, 
             bc.exp=c(0,0.1,0.2,0.25,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1), 
             chord=TRUE)
{
# Internal function
vec.norm <- function(vec)  sqrt(sum(vec^2))
#
require(ade4)
epsilon <- sqrt(.Machine$double.eps)
mat <- as.matrix(mat)
n <- nrow(mat)
p <- ncol(mat)
n.exp <- length(bc.exp)
#
if(chord) {
	res <- matrix(NA,n.exp,5)
	colnames(res) <- c("BC.exp","BC_W","BC_p-val","BC.chord_W","BC.chord_p-val")
	} else {
	res <- matrix(NA,n.exp,3)
	colnames(res) <- c("BC.exp", "BC_W", "BC_p-val")	
	}
res[,1] <- bc.exp
#
if(any(mat < 0)) stop("Negative values not allowed in community data", 
	call. = FALSE)

chck1 <- apply(mat, 1, sum)
if(any(chck1 == 0)) stop("One or several rows of 'mat' sum to 0", 
	call. = FALSE)

chck2 <- apply(mat, 2, var)
keep.spec <- which(chck2 > epsilon)
if(length(keep.spec) < p) {
	cat(length(keep.spec),"species have variances > 0 and were kept\n")
	cat("Species",which(chck2 <= epsilon)," were excluded\n")
	mat2 <- mat[,keep.spec] 
	} else { mat2 <- mat }
#
for(k in 1:n.exp) {
	if(bc.exp[k]==0) {
		# If BC exponent = 0, compute log(x+1)
		# Add 1 to the data before log transformation
		tmp <- log(mat2+1)                
		# Add 1 to the data before applying a negative exponent
		} else if(bc.exp[k]<0) { tmp <- (mat2+1)^bc.exp[k]
		# No transformation when bc.exp=1
		} else if(bc.exp[k]==1) { tmp <- mat2
		# Apply the exponent to the data
		} else { tmp <- mat2^bc.exp[k] }
#
	tmp2 <- dagnelie.test(tmp)
	if((max(tmp2$D)-min(tmp2$D)) < epsilon)
		stop("All D values are equal, Dagnelie's test cannot be computed. ",
		"Check the data.", call. = FALSE)
	res[k,2] <- tmp2$Shapiro.Wilk$statistic
	res[k,3] <- tmp2$Shapiro.Wilk$p.value
	if(chord) {
		# Apply the chord transformation to matrix "tmp"
		row.norms <- apply(tmp, 1, vec.norm)
		mat3 <- sweep(tmp, 1, row.norms, "/")
		tmp2 <- dagnelie.test(mat3)
		res[k,4] <- tmp2$Shapiro.Wilk$statistic
		res[k,5] <- tmp2$Shapiro.Wilk$p.value
		}
	}
res
}
