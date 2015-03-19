library(fpc)
library(ggplot2)

# load("../data/cleanGrades.Rda")

# taken directly from Dr. Cook's code from class
wb.df = function(.data, semester = "fall13", max.k = 15){
  .data = .data[,-(1:2)]
  df.dist <- dist(.data)
  ncl <- NULL

  for(i in 2:max.k){
    df.km <- kmeans(.data, i)
    ncl <- rbind(ncl, data.frame(k = i, 
                                                wb.ratio = cluster.stats(df.dist, df.km$cluster)$wb.ratio, 
                                                method = "kmeans"))
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

wb.ratio = rbind(wb.df(fall13, "fall13"), wb.df(fall14, "fall14"), wb.df(spring14, "spring14"))
saveRDS(wb.ratio, "../data/wb-ratio.rds")

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
