# allInclusionMat.R

Generates ../data/allInclusionMat.csv.

Aggregates the 3 semesters by matching up topics, averaging some variables in the process (Ch1 matches T01, Ch2 matches T02 and T04, etc).  NA's are treated as zeroes, and an inclusion matrix is generated (intro_HANDIN, quantitative_HANDIN, etc). Each entry in the inclusion matrix is proportional to the number of turned-in assignments for the given student and topic. 


# Cook-imputation.R

Dr. Cook's original imputation code.

# GeneralMissingClusters.R

Divides each semester's students into 4 groups based on each student's number of missing assignments. See the comment at the head of the script for details.

# impute.R

Uses knn imputation to clean groups 3 and 4 (from GeneralMissingClusters.R). Produces data frames fall13, fall14, and spring14 in data/cleanGrades.Rda, ready for clustering.

# missing-vis.R

Plots pattenrs of missingness in data. Generates the plots for the "Missing values" section of the report.