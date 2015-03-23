load("../data/cleanGrades.Rda")

#libraries ------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(kohonen)
library(fpc)

#som models ------------------------
semester.som <- function(semester, xdim, ydim, rlen = 2000) {
  dat <- semester %>% 
    dplyr::select(-Username, -Section, -AvgCrtPct) %>% 
    dplyr::mutate_each(funs(scale), everything()) %>% #standardize!
    data.matrix()
  
  som(data = dat, 
      grid = somgrid(xdim = xdim, ydim = ydim), rlen = rlen)
}

max_node <- 15

expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  mutate(rlen = 2000) %>%
  filter(!(xdim == 1 & ydim == 1)) %>%
  group_by(xdim, ydim, rlen) %>%
  do(fall13.som = semester.som(fall13, .$xdim, .$ydim, .$rlen), 
     spring14.som = semester.som(spring14, .$xdim, .$ydim, .$rlen), 
     fall14.som = semester.som(fall14, .$xdim, .$ydim, .$rlen)) -> som.models

som.wbs <- data.frame()
for(i in 1:nrow(som.models)) {
  res <- data.frame(fall13 = cluster.stats(dist(fall13 %>% dplyr::select(-Username, -Section, -AvgCrtPct) %>% data.matrix()), som.models$fall13.som[[i]]$unit.classif)$wb.ratio,
                    spring14 = cluster.stats(dist(spring14 %>% dplyr::select(-Username, -Section, -AvgCrtPct)), som.models$spring14.som[[i]]$unit.classif)$wb.ratio,
                    fall14 = cluster.stats(dist(fall14 %>% dplyr::select(-Username, -Section, -AvgCrtPct)), som.models$fall14.som[[i]]$unit.classif)$wb.ratio)
  som.wbs <- rbind(som.wbs, res)
}

save(som.models, som.wbs, file="../data/somModels.Rda")

expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  filter(!(xdim == 1 & ydim == 1)) %>%
  cbind(som.wbs) %>% 
  gather(semester, wb.ratio, -xdim, -ydim) %>% 
  ggplot() +
  geom_tile(aes(x = xdim, y = ydim, fill = wb.ratio)) +
  facet_wrap(~semester) +
  scale_fill_continuous(high = "white", low = "red") +
  theme(aspect.ratio = 1) -> plot.wb.ratio

