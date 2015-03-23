library(ggplot2)
library(reshape2)
library(dplyr)
library(reshape)
library(DMwR)

f = "../data/mainClusters.Rda"
if(file.exists(f))
  load(f)

numNA <- function(x){
  length(x[is.na(x)])
}

# Only students with at least half of assignments turned in
trimmed_grades = list(
  fall13 = rbind(Fall13_G3, Fall13_G4),
  fall14 = rbind(Fall14_G3, Fall14_G4),
  spring14 = rbind(Spring14_G3, Spring14_G4)
)

# NA's are input as zeroes
zeroed_grades = lapply(trimmed_grades, function(x){
  x[is.na(x)] = 0
  x
})

# NA's are imputed with knn imputation
clean_grades = lapply(trimmed_grades, function(x){
  data.frame(x[,1:2], knnImputation(x[,-(1:2)], k=5, scale=F))
})

names(clean_grades) <- names(zeroed_grades) <- names(trimmed_grades)
attach(clean_grades)
#save(fall13, fall14, spring14, file = "../data/cleanGrades.Rda")