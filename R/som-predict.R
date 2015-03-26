if(!exists("som.models")) load("../data/somModels.Rda")
if(!exists("fall14")) load("../data/cleanGrades.Rda")
require(kohonen)
require(dplyr)
require(tidyr)
require(ggplot2)
library(fpc)


spring14 %>%
  rename(Ch1 = T01,
         Ch3 = T03,
         Ch4 = T05,
         Ch5 = T06,
         Ch7.8 = T08,
         Ch9 = T11,
         Ch10 = T09,
         Ch11 = T10,
         Ch15I = T15,
         Ch16 = T16,
         Ch17 = T17,
         Ch15II = T18,
         Ch18 = T19,
         Ch19 = T20) %>%
  mutate(Ch2 = (T02 + T04)/2,
         Ch12 = NA,
         Ch20 = (T21 + T22 + T23)/3,
         semester = "spring14") %>%
  select(semester, starts_with("Ch"), Username) %>% 
  rbind(
    fall14 %>%
      rename(Ch1 = T01,
             Ch3 = T03,
             Ch4 = T05,
             Ch5 = T06,
             Ch7.8 = T08,
             Ch9 = T11,
             Ch10 = T09,
             Ch11 = T10,
             Ch15I = T15,
             Ch16 = T16,
             Ch17 = T17,
             Ch15II = T18,
             Ch20 = T23
             ) %>%
      mutate(Ch2 = (T02 + T04)/2,
             Ch12 = NA,
             Ch18 = NA,
             Ch19 = NA,
             semester = "fall14") %>%
      select(semester, starts_with("Ch"), Username)) -> new_data

fall13 %>%
  select(starts_with("Ch")) %>%
  select(-Ch12, -Ch18, -Ch19) %>%
  dplyr::mutate_each(funs(scale), everything()) %>% #standardize!
  data.matrix() -> fall13.no_missing

som.no_missing <- som(fall13.no_missing, grid=somgrid(xdim = 6, ydim = 6), rlen = 2000)

som.map <- map(x = som.no_missing, 
               newdata = new_data %>% 
                 select(-semester, -Username, -Ch12, -Ch18, -Ch19) %>% 
                 dplyr::mutate_each(funs(scale), everything()) %>%
                 data.matrix)


new_data %>% select(-Ch12, -Ch18, -Ch19) %>%
  cbind(classify = som.map$unit.classif) %>%
  ungroup() %>%
  gather(variable, value, -classify, -Username, -semester) %>% 
  ggplot() +
  geom_line(aes(variable, value, group = Username, colour = semester), alpha = .3) +
  facet_wrap(~classify) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = "bottom") -> som.plot.parcoord.predict


som.predict.wb.ratio <- cluster.stats(dist(new_data %>% select(-semester, -Username, -Ch12, -Ch18, -Ch19) %>% data.matrix()), som.map$unit.classif)$wb.ratio
