library(ggplot2)
library(reshape2)
library(dplyr)
library(reshape)
library(DMwR)

# Read data
fall13 <- read.csv("13Falla.csv", stringsAsFactors=FALSE)

# Treat 0 as a missing value
fall13[fall13==0] <- NA

# Find and remove any students with more than 50% missing
numNA <- function(x) {
 length(x[is.na(x)])
}
f13.na <- apply(fall13[,3:20], 1, numNA)
fall13 <- fall13[f13.na<9,]

# Impute missing values
fall13.nona <- knnImputation(fall13[,3:20], k=5, scale=F)
summary(fall13.nona) # Check that summary stats not too different
summary(fall13[,3:20])
fall13.nona <- data.frame(fall13[,1:2], fall13.nona)