setwd("~/GitHub/ResourceHeterogeneity/")
AnnotationSummary <- read.csv("./data/annotationSummary.csv")
template <- data.frame(matrix(0, nrow = dim(AnnotationSummary)[1], ncol = 10))
colnames(template) <- c("Cmpd", "rt", "inferred.mass", "inferred.formula",	"C",	"H",	"N",	"O",	"P",	"S")

dim(AnnotationSummary)[1] == dim(template)[1]

template$Cmpd <- AnnotationSummary$cmpd
template$rt <- AnnotationSummary$rt
template$inferred.mass <- AnnotationSummary$inferred.M

for(i in 1:dim(template)[1]){
  test.formula <- as.character(AnnotationSummary$inferred.formula[i])
  if(!is.na(test.formula)){
    test.long <- gsub("([C|H|N|O|P|S])(?=[C|H|N|O|P|S])","\\11",test.formula,perl=TRUE)
    test.long <- gsub("([C|H|N|O|P|S]$)","\\11",test.long,perl=TRUE)
    test.split <- unlist(strsplit(test.long, "(?=[C|H|N|O|P|S])(?<=[0-9])", perl = T)) 
    if(!is.na(test.split[1])){
      for(j in 1:length(test.split)){
        test.mol <- unlist(strsplit(test.split[j], "(?<=[A-Za-z])(?=[0-9])", perl = T))
        template[i, 4] <- test.formula
        template[i, match(test.mol[1], colnames(template))] <- as.numeric(test.mol[2])
      }
    }
  }
}

template$"C:N:P"<- apply(cbind(template$C, template$N, template$P), 1, paste, collapse = ":")
template$"H/C" <- template$H / template$C
template$"O/C" <- template$O / template$C
template$"N/C" <- template$N / template$C 
template$"CHO_index" <- (2 * template$O - template$H)/template$C 
template$"NOSC" <- -((4 * template$C + template$H - 
                        3 * template$N - 2 * template$O + 
                        5 * template$P - 2 * template$S) / template$C) + 4
template$"DBE" <- (template$C - 0.5 * template$H + 0.5 * template$N + 1)
template$"DBE-O" <- (template$C - 0.5 * template$H + 0.5 * template$N + 1) - template$O
template$Annotation <- AnnotationSummary$annotation
template$Kingdon <- AnnotationSummary$kingdom
template$Superclass <- AnnotationSummary$superclass
template$class<- AnnotationSummary$class
template$subclass <- AnnotationSummary$subclass
template$parent <- AnnotationSummary$parent
template$pubchem.url  <- AnnotationSummary$pubchem.url

write.csv(template, "./data/annotationSummary_MFconversion_output.csv", row.names = F)
