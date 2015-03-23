library(ggplot2)
library(reshape2)
library(dplyr)
library(reshape)
library(DMwR)
library(GGally)
library(randomForest)
setwd("~/Dropbox/Stat 503/Homework4/firsttry2")

# Fall13
fall13 <- read.csv("13Falla.csv", stringsAsFactors=FALSE)

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
fall13.nona$average <- apply(fall13.nona[,3:20],1,mean)
df<-fall13.nona




# Hierarchical clustering
df.dist <- dist(df[,3:20])
df.hc <- hclust(df.dist, method="ward.D")
df.hc <- hclust(df.dist, method="ward.D2")
df.hc <- hclust(df.dist, method="single")
df.hc <- hclust(df.dist, method="complete")
df.hc <- hclust(df.dist, method="average")
df.hc <- hclust(df.dist, method="centroid")
plot(df.hc)
df$cl <- factor(cutree(df.hc, 3))
#cluster.stats(dist(df[,3:20]), df.hc$cl5)$wb.ratio
ggparcoord(df, columns=3:20, groupColumn=22,scale="globalminmax", boxplot=TRUE, 
           showPoints=FALSE, alphaLines=0.05) + 
  xlab("") + ylab("PctCorrect") + theme_bw()


##average for each chapter, each cluster 
df.ex <- df %>%
  group_by(cl) %>%
  mutate(average.cl=mean(average))%>%
  mutate(st.cl=sd(average))%>%
  mutate(ave.1=mean(Ch1))%>%
  mutate(ave.2=mean(Ch2))%>%
  mutate(ave.3=mean(Ch3))%>%
  mutate(ave.4=mean(Ch4))%>%
  mutate(ave.5=mean(Ch5))%>%
  mutate(ave.6=mean(Ch6))%>%
  mutate(ave.78=mean(Ch7.8))%>%
  mutate(ave.9=mean(Ch9))%>%
  mutate(ave.10=mean(Ch10))%>%
  mutate(ave.11=mean(Ch11))%>%
  mutate(ave.12=mean(Ch12))%>%
  mutate(ave.151=mean(Ch15I))%>%
  mutate(ave.152=mean(Ch15II))%>%
  mutate(ave.16=mean(Ch16))%>%
  mutate(ave.17=mean(Ch17))%>%
  mutate(ave.18=mean(Ch18))%>%
  mutate(ave.19=mean(Ch19))%>%
  mutate(ave.20=mean(Ch20))%>%
  select(22:42)%>%
  distinct

df.1<- df[df$cl==1,]  
ggparcoord(df.1, columns=3:20,scale="globalminmax", boxplot=TRUE, 
           showPoints=FALSE, alphaLines=0.05) + 
  xlab("") + ylab("PctCorrect") + theme_bw()

df.2<- df[df$cl==2,]  
ggparcoord(df.2, columns=3:20,scale="globalminmax", boxplot=TRUE, 
           showPoints=FALSE, alphaLines=0.05) + 
  xlab("") + ylab("PctCorrect") + theme_bw()

df.3<- df[df$cl==3,]  
ggparcoord(df.3, columns=3:20,scale="globalminmax", boxplot=TRUE, 
           showPoints=FALSE, alphaLines=0.05) + 
  xlab("") + ylab("PctCorrect") + theme_bw()

######
# Fall14
fall14 <- read.csv("14Falla.csv", stringsAsFactors=FALSE)
fall14 <- fall14[,-6]
colnames(fall14) <- c("Username", "Section","Ch1","Ch2","Ch3","Ch4","Ch5","Ch6","Ch7.8","Ch10","Ch11","Ch9","Ch15I","Ch16","Ch17","Ch15II","Ch20","average")


# Find and remove any students with more than 50% missing
numNA <- function(x) {
  length(x[is.na(x)])
}
f14.na <- apply(fall14[,3:17], 1, numNA)
fall14 <- fall14[f14.na<7,]

# Impute missing values
fall14.nona <- knnImputation(fall14[,3:17], k=5, scale=F)
summary(fall14.nona) # Check that summary stats not too different
summary(fall14[,3:17])
fall14.nona <- data.frame(fall14[,1:2], fall14.nona)
fall14.nona$average <- apply(fall14.nona[,3:17],1,mean)
df14<-fall14.nona

# Hierarchical clustering
df.dist <- dist(df14[,3:17])
df.hc <- hclust(df.dist, method="ward.D")
df.hc <- hclust(df.dist, method="ward.D2")
df.hc <- hclust(df.dist, method="single")
df.hc <- hclust(df.dist, method="complete")
df.hc <- hclust(df.dist, method="average")
df.hc <- hclust(df.dist, method="centroid")
plot(df.hc)
df14$cl <- factor(cutree(df.hc, 3))

ggparcoord(df14, columns=3:17, groupColumn=19,scale="globalminmax", boxplot=TRUE, 
           showPoints=FALSE, alphaLines=0.05) + 
  xlab("") + ylab("PctCorrect") + theme_bw()


df.ex14 <- df14 %>%
  group_by(cl) %>%
  mutate(average.cl=mean(average))%>%
  mutate(st.cl=sd(average))%>%
  mutate(ave.1=mean(Ch1))%>%
  mutate(ave.2=mean(Ch2))%>%
  mutate(ave.3=mean(Ch3))%>%
  mutate(ave.4=mean(Ch4))%>%
  mutate(ave.5=mean(Ch5))%>%
  mutate(ave.6=mean(Ch6))%>%
  mutate(ave.78=mean(Ch7.8))%>%
  mutate(ave.9=mean(Ch9))%>%
  mutate(ave.10=mean(Ch10))%>%
  mutate(ave.11=mean(Ch11))%>%
  
  mutate(ave.151=mean(Ch15I))%>%
  mutate(ave.152=mean(Ch15II))%>%
  mutate(ave.16=mean(Ch16))%>%
  mutate(ave.17=mean(Ch17))%>%
 
  mutate(ave.20=mean(Ch20))%>%
  select(19:36)%>%
  distinct

##Random forest, 14spring does not have Ch12, Ch18, Ch19
train<- df[,c(3:12,14:17,20,22)]
test<-df14[,c(3:17,19)]
test$cl<-rep("NA",nrow(test))

cl <- as.factor(train[,16])
train<-train[,-16]
test<-test[,-16]

rf <- randomForest(train, cl, xtest=test, ntree=1000)
rf$importance 
predictions <- levels(cl)[rf$test$predicted]

predictions<-as.numeric(predictions)

results<-cbind(df14[,19],predictions)

diff<-results[,1]-results[,2]

diff[diff==0] <- NA
diff<-data.frame(diff)
diff.num <- apply(diff, 2,numNA)

error<-1-diff.num/nrow(diff)
error

