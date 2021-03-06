library(amap)
library(fpc)
library(ggplot2)
library(cluster)
library(reshape2)

# load("../data/cleanGrades.Rda")

# taken directly from Dr. Cook's code from class
wb.df = function(.data, semester = "fall13", max.k = 20){
  .data = scale(.data[,-(1:2)])
  df.dist <- dist(.data)
  ncl <- NULL

  for(i in 2:max.k){
    df.km <- kmeans(.data, centers = i, iter.max = 20)
    ncl <- rbind(ncl, data.frame(k = i, 
                                                wb.ratio = cluster.stats(df.dist, df.km$cluster)$wb.ratio, 
                                                method = "kmeans-euclidian"))

    df.corr = Kmeans(.data, centers = i, iter.max = 40, method = "correlation")
    ncl <- rbind(ncl, data.frame(k = i, 
                                                wb.ratio = cluster.stats(df.dist, df.corr$cluster)$wb.ratio, 
                                                method = "kmeans-correlation"))

  }

  for(method in c("ward.D", "ward.D2", "single", "complete", "average", "centroid")){
    hc <- hclust(df.dist, method = method)
    for (i in 2:max.k) {
      cluster = cutree(hc, i)
      ncl <- rbind(ncl, data.frame(k = i, 
                                                  wb.ratio = cluster.stats(df.dist, cluster)$wb.ratio, 
                                                  method = method))
    }
  }

  ncl$semester = semester
  ncl
}

#wb.ratio = rbind(wb.df(fall13, "fall13"), wb.df(fall14, "fall14"), wb.df(spring14, "spring14"))
#saveRDS(wb.ratio, "../data/wb-ratio.rds")

wb.ratio.plot = function(){
  f = "../data/wb-ratio.rds"
  if(file.exists(f)){
    wb.ratio = readRDS(f)
  } else {
    wb.ratio = rbind(wb.df(fall13, "fall13"), wb.df(fall14, "fall14"), wb.df(spring14, "spring14"))
    saveRDS(wb.ratio, "../data/wb-ratio.rds")
  }
    
  ggplot(wb.ratio) + 
    geom_line(aes(x = k, y = wb.ratio, color = semester)) +
    facet_wrap(~method)
}

dendros = function(){
  par(mfrow = c(2, 3)) 
  for(method in c("ward.D", "ward.D2", "single", "complete", "average", "centroid")){
    .data = scale(spring14[,-(1:2)])
    df.dist <- dist(.data)
    hc = hclust(df.dist, method = method)
    plot(hc, main = method, xlab = "")
  }
  par(mfrow = c(1, 1)) 
}

ward.parcoord = function(){
  d = spring14
  .data = scale(d[,-(1:2)])
  df.dist <- dist(.data)
  d$Cluster = cutree(hclust(df.dist, method = "ward.D"), 3)
  dlong = melt(d, id.vars = c("Username", "Section", "Cluster"))
  ggplot(dlong) + 
    geom_line(aes(x = variable, y = value, group = Username), alpha = .1) + facet_grid(Cluster~.) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}