if(!exists("fall13.mc")) load("../data/mClust.rda")
if(!exists("fall14")) load("../data/cleanGrades.Rda")

#libraries ------------------------
require(dplyr)
require(tidyr)
require(ggplot2)
require(mclust)
require(fpc)

mclust.select.plot <- function() 
  plot(fall13.mc, what="BIC")

#plot(fall13.mc, what="classification") 
#too many variables in plot

cluster.stats(dist(fall13.clust.dat), fall13.mc$classification)$wb.ratio -> mclust.wb.ratio

data.frame(fall13, classify = fall13.mc$classification) %>%
  group_by(classify) %>%
  dplyr::select(-Section, -AvgCrtPct) %>%
  data.frame() %>%
  gather(variable, value, -classify, -Username) %>%
  ggplot() +
  geom_line(aes(variable, value, group = Username), alpha = .3) +
  facet_wrap(~classify) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) -> mclust.plot.parcoord

data.frame(fall13, classify = fall13.mc$classification) %>%
  dplyr::group_by(classify) %>%
  dplyr::summarise_each(funs(mean), -Username, -Section, -AvgCrtPct) %>%
  data.frame %>%
  tidyr::gather(variable, value, -classify) %>%
  ggplot() +
  geom_line(aes(variable, value, group = classify, colour = factor(classify))) -> mclust.plot.mean.parcoord


fall13.clust.dat %*% svd(t(fall13.clust.dat) %*% fall13.clust.dat/nrow(fall13.clust.dat))$u[,1:2] %>%
  cbind(classify = fall13.mc$classification) %>%
  data.frame() %>% 
  ggplot() +
  geom_point(aes(V1, V2, colour = factor(classify))) -> mclust.plot.pca

