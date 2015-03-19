# Plots pattenrs of missingness in data. Generates the plots for the "Missing values" section of the report.

## ---- missingVisSetup

library(ggplot2)
library(gridExtra)
library(plyr)
library(reshape2)

.data = list(
  fall13 = read.csv("../data/13Falla.csv"),
  fall14 = read.csv("../data/14Falla.csv"),
  spring14 = read.csv("../data/14Springa.csv")
)

for(d in names(.data))
  .data[[d]]$Section =  as.factor(.data[[d]]$Section)

missing = lapply(.data, function(d){
  cbind(d[,1:2], is.na(d[,-c(1, 2, dim(d)[2])]))
})

num_missing =  lapply(missing, function(d){
  data.frame(Username = d$Username, Section = d$Section, Number_missing = apply(d[,-(1:2)], 1, sum))
})

Semester = rep(names(missing), times = sapply(missing, function(d){dim(d)[1]}))
num_missing = as.data.frame(cbind(Semester, do.call("rbind", num_missing)))

missingHist = function(){
  pl1 = ggplot(num_missing) + 
    geom_histogram(aes(x = Number_missing), binwidth = 1)

  pl2 = ggplot(num_missing) + 
    geom_histogram(aes(x = Number_missing), binwidth = 1) +
    facet_grid(Semester~.)

  pl3 = ggplot(num_missing) + 
    geom_histogram(aes(x = Number_missing), binwidth = 1) +
    facet_grid(Section~Semester)

  grid.arrange(pl1, pl2, pl3, ncol = 2)
}

missingByAssign = function(){
num_missing =  lapply(missing, function(D){
  n = colnames(D[,-(1:2)])
  ddply(D, "Section", function(d){
  data.frame(Topic = ordered(n, n), 
                    Topicn = 1:length(n),
                    Number_missing = apply(d[,-(1:2)], 2, sum))})
})

pl1 = ggplot(num_missing[[1]]) + 
  geom_line(aes(x = Topicn, y = Number_missing, group = Section, color = Section)) +
  scale_x_continuous(breaks=num_missing[[1]]$Topicn, labels=num_missing[[1]]$Topic) +
   xlab("Topic") + 
   labs(title = "Fall 2013") +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 6))

pl2 = ggplot(num_missing[[2]]) + 
  geom_line(aes(x = Topicn, y = Number_missing, group = Section, color = Section)) +
  scale_x_continuous(breaks=num_missing[[2]]$Topicn, labels=num_missing[[2]]$Topic) +
  xlab("Topic") + 
   labs(title = "Fall 2014") +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 6))

pl3 = ggplot(num_missing[[3]]) + 
  geom_line(aes(x = Topicn, y = Number_missing, group = Section, color = Section)) +
  scale_x_continuous(breaks=num_missing[[3]]$Topicn, labels=num_missing[[3]]$Topic) +
  xlab("Topic") + 
   labs(title = "Spring 2014") +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 6))

grid.arrange(pl1, pl2, pl3, ncol = 2)
}


## ---- missingBarcodesSetup

missing_long = lapply(missing, function(d){
  x = melt(d, id.vars = c("Username", "Section"))
  colnames(x) = c("Username", "Section", "Homework", "Missing")
  x$Missing = factor(x$Missing, levels = c(TRUE, FALSE), labels = c("Missing", "Turned-in"))
  x$Homework = ordered(x$Homework, levels = unique(x$Homework))
  uuname = unique(x$Username)
  x$Username = ordered(x$Username, uuname[sample.int(length(uuname), replace = F)])
  x
})

missing_barcodes = function(.data, .title){
  pl = ggplot(data = .data) + 
    geom_tile(aes(x = Homework, y = Username, fill=Missing)) +
    scale_fill_manual(values = c("black", "LightGray"), name = "Missing",
                                 breaks = c("Missing", "Turned-in")) +
    facet_wrap(~Section, scales = "free") +
    labs(title = .title) + 
    theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5),
               axis.text.y = element_blank(), 
               axis.ticks.y = element_blank(), 
               panel.background = element_blank(),
               panel.grid.major = element_blank(), 
               panel.grid.minor = element_blank())
    return(pl)
}

## ---- missingBarcodesFall13

missingBarcodesFall13 = function(){
  missing_barcodes(missing_long[[1]], "Fall 2013")
}

## ---- missingBarcodesFall14

missingBarcodesFall14 = function(){
  missing_barcodes(missing_long[[2]], "Fall 2014")
}

## ---- missingBarcodesSpring14

missingBarcodesSpring14 = function(){
  missing_barcodes(missing_long[[3]], "Spring 2014")
}