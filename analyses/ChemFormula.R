setwd("~/Desktop/")
AnnotationSummary <- read.csv("./lake-water-annotationSummary.csv")
template <- data.frame(matrix(0, nrow = dim(AnnotationSummary)[1], ncol = 7))
colnames(template) <- c("inferred.formula",	"C",	"H",	"N",	"O",	"P",	"S")

dim(AnnotationSummary)[1] == dim(template)[1]

for(i in 1:dim(template)[1]){
  test.formula <- as.character(AnnotationSummary$inferred.formula[i])
  if(!is.na(test.formula)){
    test.long <- gsub("([C|H|N|O|P|S])(?=[C|H|N|O|P|S])","\\11",test.formula,perl=TRUE)
    test.long <- gsub("([C|H|N|O|P|S]$)","\\11",test.long,perl=TRUE)
    test.split <- unlist(strsplit(test.long, "(?=[C|H|N|O|P|S])(?<=[0-9])", perl = T)) 
    if(!is.na(test.split[1])){
      for(j in 1:length(test.split)){
        test.mol <- unlist(strsplit(test.split[j], "(?<=[A-Za-z])(?=[0-9])", perl = T))
        template[i, 1] <- test.formula
        template[i, match(test.mol[1], colnames(template))] <- as.numeric(test.mol[2])
      }
    }
  }
}


write.csv(template, "./annotationSummary_MFconversion_output.csv")
