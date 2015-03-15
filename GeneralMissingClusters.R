# This script reads in three semesters worth of student homework grades for Stat 101. For each semester, it separates the students into four groups. Group 1 contains students who missed all nine of the last half of homework assignments. Group 2 contains students (who were not in Group 1) and who missed at least half of all homework assignments. Group 3 contains students (who were not in Group 1 or 2) who missed at least one homework assignment. Group 4 contains students (who were not in Group 1, 2, or 3) who did not miss any homework assignments.

# Hence, this script produces the following 12 clusters (in data frame format):
# - Fall13_G1 (n=45) (Group 1 from Fall 13)
# - Fall13_G2 (n=24) (Group 2 from Fall 13)
# - Fall13_G3 (n=298) (Group 3 from Fall 13)
# - Fall13_G4 (n=216) (Group 4 from Fall 13)
# - Spring14_G1 (n=48) (Group 1 from Spring 14)
# - Spring14_G2 (n=23) (Group 2 from Spring 14)
# - Spring14_G3 (n=268) (Group 3 from Spring 14)
# - Spring14_G4 (n=338) (Group 4 from Spring 14)
# - Fall14_G1 (n=17) (Group 1 from Fall 14)
# - Fall14_G2 (n=20) (Group 2 from Fall 14)
# - Fall14_G3 (n=236) (Group 3 from Fall 14)
# - Fall14_G4 (n=314) (Group 4 from Fall 14)

Fall13 <- read.csv("13Falla.csv")
Fall14 <- read.csv("14Falla.csv")
Spring14 <- read.csv("14Springa.csv")

############################ FALL13 ############################

# Group 1 (Dropouts - Students who did not submit last half of assignments) : n=45
cols = 12:20
ind = which(apply(Fall13[cols],1,function(y)sum(!is.na(y))==0))
temp = Fall13[-ind,]
Fall13_G1 = Fall13[ind,]

# Group 2 (CommonMissers - Students not in the previous group, who did not submit any half of assignments): n=24
ind = which(rowSums(is.na(temp[, ]))>7)
temp = temp[-ind,]
Fall13_G2 = temp[ind,]

# Group 3 (RareMissers - Students not in the first two groups, who did not submit at least one assigment): n=298
ind = which(rowSums(is.na(temp[, ]))>0)
Fall13_G3 = temp[ind,]

# Group 4 (Always - Students not in the first three groups, who submitted every assignment): n=216
Fall13_G4 = temp[-ind,]

############################ SPRING14 ############################

# Group 1 (Dropouts - Students who did not submit last half of assignments) : n=48
cols = 14:22
ind = which(apply(Spring14[cols],1,function(y)sum(!is.na(y))==0))
temp = Spring14[-ind,]
Spring14_G1 = Spring14[ind,]

# Group 2 (CommonMissers - Students not in the previous group, who did not submit any half of assignments): n=23
ind = which(rowSums(is.na(temp[, ]))>7)
temp = temp[-ind,]
Spring14_G2 = temp[ind,]

# Group 3 (RareMissers - Students not in the first two groups, who did not submit at least one assigment): n=268
ind = which(rowSums(is.na(temp[, ]))>0)
Spring14_G3 = temp[ind,]

# Group 4 (Always - Students not in the first three groups, who submitted every assignment): n=338
Spring14_G4 = temp[-ind,]

############################ FALL14 ############################

# Group 1 (Dropouts - Students who did not submit last half of assignments) : n=17
cols = 10:18
ind = which(apply(Fall14[cols],1,function(y)sum(!is.na(y))==0))
temp = Fall14[-ind,]
Fall14_G1 = Fall14[ind,]

# Group 2 (CommonMissers - Students not in the previous group, who did not submit any half of assignments): n=20
ind = which(rowSums(is.na(temp[, ]))>7)
temp = temp[-ind,]
Fall14_G2 = temp[ind,]

# Group 3 (RareMissers - Students not in the first two groups, who did not submit at least one assigment): n=236
ind = which(rowSums(is.na(temp[, ]))>0)
Fall14_G3 = temp[ind,]

# Group 4 (Always - Students not in the first three groups, who submitted every assignment): n=314
Fall14_G4 = temp[-ind,]

############################# SAVE ALL CLUSTERS #############################
save(Fall13_G1, Fall13_G2, Fall13_G3, Fall13_G4, Spring14_G1, Spring14_G2, Spring14_G3, Spring14_G4, Fall14_G1, Fall14_G2, Fall14_G3, Fall14_G4, file="mainClusters.Rda")