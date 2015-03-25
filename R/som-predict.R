if(!exists("som.models")) load("../data/somModels.Rda")
if(!exists("fall14")) load("../data/cleanGrades.Rda")
require(kohonen)
require(dplyr)
require(tidyr)
require(ggplot2)


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
  select(semester, starts_with("Ch")) %>% 
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
      select(semester, starts_with("Ch"))) -> new_data

som.predict <- predict(object = chosen.som[[1]][[1]], 
                       newdata = new_data %>% filter(semester == "spring14") %>% select(-semester),
                       trainX = fall13 %>% select(starts_with("Ch")))
