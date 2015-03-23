load("../data/somModels.Rda")

max_node <- 15
expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  filter(!(xdim == 1 & ydim == 1)) %>%
  cbind(som.wbs) %>% 
  gather(semester, wb.ratio, -xdim, -ydim) %>% 
  ggplot() +
  geom_tile(aes(x = xdim, y = ydim, fill = wb.ratio)) +
  facet_wrap(~semester) +
  scale_fill_continuous(high = "white", low = "red") +
  theme(aspect.ratio = 1) -> plot.wb.ratio

expand.grid(xdim = 1:max_node, ydim = 1:max_node) %>%
  filter(!(xdim == 1 & ydim == 1)) %>%
  cbind(som.wbs) %>% 
  mutate(num_clust = xdim*ydim) %>%
  gather(semester, wb.ratio, -xdim, -ydim, -num_clust) %>% 
  ggplot() +
  geom_line(aes(x = num_clust, y = wb.ratio, colour = semester)) -> plot.wb.ratio.line