load("../data/cleanGrades.Rda")

#libraries ------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(mclust)
library(fpc)

fall13 %>% 
  select(starts_with("Ch")) %>% 
  select(-Ch12, -Ch18, -Ch19) %>% #for prediction
  mutate_each(funs(scale(.)), everything()) %>% 
  data.matrix -> fall13.clust.dat

fall13.clust.dat %>%
  Mclust(G=1:36, 
         modelNames=c("EII", "VII", "EEE", "EEV", "VVV")) -> fall13.mc

#save(fall13.mc, fall13.clust.dat, file = "../data/mClust.rda")





