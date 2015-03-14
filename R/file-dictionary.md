# allInclusionMat.R

Generates ../data/allInclusionMat.csv.

Aggregates the 3 semesters by matching up topics, averaging some variables in the process (Ch1 matches T01, Ch2 matches T02 and T04, etc).  NA's are treated as zeroes, and an inclusion matrix is generated (intro_HANDIN, quantitative_HANDIN, etc). Each entry in the inclusion matrix is proportional to the number of turned-in assignments for the given student and topic. 

# omission-vis.R

Plots pattenrs of omission in data. Generates the plots for the "Missing values" section of the report.