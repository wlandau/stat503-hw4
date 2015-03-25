if(!exists("som.models")) load("../data/somModels.Rda")
if(!exists("fall14")) load("../data/cleanGrades.Rda")
require(kohonen)
require(dplyr)
require(tidyr)
require(ggplot2)


max_node <- 15
expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  dplyr::filter(!(xdim == 1 & ydim == 1)) %>%
  cbind(som.wbs) %>% 
  tidyr::gather(semester, wb.ratio, -xdim, -ydim) %>% 
  ggplot() +
  geom_tile(aes(x = xdim, y = ydim, fill = wb.ratio)) +
  facet_wrap(~semester) +
  scale_fill_continuous(high = "white", low = "red") +
  theme(aspect.ratio = 1) -> som.plot.wb.ratio

expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  filter(!(xdim == 1 & ydim == 1)) %>%
  cbind(som.wbs) %>% 
  dplyr::mutate(num_clust = xdim*ydim) %>% 
  gather(semester, wb.ratio, -xdim, -ydim, -num_clust) %>% 
  ggplot() +
  geom_line(aes(x = num_clust, y = wb.ratio, colour = semester)) -> som.plot.wb.ratio.line

#Perhaps 6x6 som is best based on wb.ratio

som.models %>%
  filter(xdim == 6 & ydim == 6) %>%
  dplyr::select(fall13.som) -> chosen.som

data.frame(fall13, classify = chosen.som[[1]][[1]]$unit.classif) %>%
  dplyr::group_by(classify) %>%
  dplyr::summarise_each(funs(mean), -Username, -Section, -AvgCrtPct) %>%
  data.frame %>%
  tidyr::gather(variable, value, -classify) %>%
  ggplot() +
  geom_line(aes(variable, value, group = classify, colour = factor(classify))) -> som.plot.mean.parcoord


data.frame(fall13, classify = chosen.som[[1]][[1]]$unit.classif) %>%
  group_by(classify) %>%
  dplyr::select(-Section, -AvgCrtPct) %>%
  data.frame() %>%
  gather(variable, value, -classify, -Username) %>%
  ggplot() +
  geom_line(aes(variable, value, group = Username), alpha = .3) +
  facet_wrap(~classify) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) -> som.plot.parcoord
  
