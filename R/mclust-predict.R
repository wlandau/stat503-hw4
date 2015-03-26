if(!exists("fall13.mc")) load("../data/mClust.rda")
if(!exists("fall14")) load("../data/cleanGrades.Rda")

#libraries ------------------------
require(dplyr)
require(tidyr)
require(ggplot2)
require(mclust)
require(fpc)


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
         Ch15II = T18) %>%
  mutate(Ch2 = (T02 + T04)/2,
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
             semester = "fall14") %>%
      select(semester, starts_with("Ch"), Username)) -> new_data

mc.pred <- predict(fall13.mc, newdata = new_data %>% select(-semester, -Username) %>% mutate_each(funs(scale(.)), everything()) %>% data.frame)

new_data %>%
  cbind(classify = mc.pred$classification) %>%
  ungroup() %>%
  gather(variable, value, -classify, -Username, -semester) %>% 
  ggplot() +
  geom_line(aes(variable, value, group = Username, colour = semester), alpha = .3) +
  facet_wrap(~classify) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = "bottom") -> mc.plot.parcoord.predict

new_data %>%
  cbind(classify = mc.pred$classification) %>%
  dplyr::group_by(classify, semester) %>%
  dplyr::summarise_each(funs(mean), -Username) %>%
  data.frame %>%
  tidyr::gather(variable, value, -classify, -semester) %>%
  ggplot() +
  geom_line(aes(variable, value, group = classify, colour = factor(classify))) +
  facet_wrap(~semester) -> mclust.plot.mean.parcoord.predict


mc.predict.wb.ratio <- cluster.stats(dist(new_data %>% select(-semester, -Username) %>% data.matrix()), mc.pred$classification)$wb.ratio

pred.dat <- new_data %>% select(-semester, -Username) %>% mutate_each(funs(scale(.)), everything()) %>% data.matrix
pred.dat %*% svd(t(pred.dat) %*% pred.dat/nrow(pred.dat))$u[,1:2] %>%
  cbind(classify = mc.pred$classification) %>%
  data.frame(semester = new_data$semester) %>% 
  ggplot() +
  geom_point(aes(V1, V2, colour = factor(classify))) +
  facet_wrap(~semester) -> mclust.plot.pca.pred
