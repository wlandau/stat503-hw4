library(reshape2)
library(gridExtra)
library(GGally)
library(vegan)

# load("../data/cleanGrades.Rda")




histplot.part = function(.data, semester){
  dlong = melt(.data, id.vars = c("Username", "Section"))
  dlong$Semester = semester

  ggplot(dlong) +
    geom_histogram(aes(x = value), binwidth = 8) + 
    facet_wrap(~variable) +
    labs(title = semester)
}

histplot = function(){
  histplot.part(fall13, "fall13")
#  pl1 = histplot.part(fall13, "fall13")
#  pl2 = histplot.part(fall14, "fall14")
#  pl3 = histplot.part(spring14, "spring14")
#  grid.arrange(pl1, pl2, pl3, ncol = 2)
}

pairsplot = function(){
  pairs(fall13[, 3:13], pch = ".")
}

pcaplot = function(){
  d = rbind(
    data.frame(svd(fall13[, -(1:2)])$u[,1:2], Semester = "fall13"),
    data.frame(svd(fall14[, -(1:2)])$u[,1:2], Semester = "fall14"),
    data.frame(svd(spring14[, -(1:2)])$u[,1:2], Semester = "spring14")
  )
  colnames(d) = c("PC1", "PC2", "Semester")
  ggplot(d) + geom_point(aes(PC1, PC2)) + facet_wrap(~Semester)
}

mds.dat = function(.data, semester){
  x = .data[,-(1:2)]  x.mds<-metaMDS(dist(x), k=2)  colnames(x.mds$points)<-c("MDS1", "MDS2")
  df = as.data.frame(x.mds$points)
  df$Semester = semester
  df
}

mds.plot = function(){
  f = "../data/mds.rds"
  if(file.exists(f)){
    df = readRDS(f)
  } else {
    df = rbind(mds.dat(fall13, "fall13"), mds.dat(fall14, "fall14"), mds.dat(spring14, "spring14"))
    saveRDS(df, f)
  }
  qplot(MDS1, MDS2, data=df) +
    theme(aspect.ratio=1) +
    facet_wrap(~Semester)
}
