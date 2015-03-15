# stat503-hw4
This file is a general record of decisions, issues, and logicstics.

# Division of labor

We might use this section to write down what we're doing so we don't step on each other's toes.

### Andee

### Will

- Visually analyze patterns of missingness for each semester, and use the insight to  offer suggestions about a preliminary clustering/imputation strategy.

- Preprocessing the data with the inclusion matrix, NAs-as-zeroes imputation method (data/allInclusionMat.csv).

### Fangge

### Lindsay

- Cluster the data into four groups for each semester
  - 1) Group 1: Drop outs (Students who miss last consecutive half of assignments) 
  - 2) Group 2: Common missings (Students not from Group 1 who miss at least half of assignments)
  - 3) Group 3: Sporadic missings (Students not from Group 1 or 2 who miss at least one assignment)
  - 4) Group 4: Never missings (Students who never miss any assignments)
- Perform nearest neighbor analysis on Group 3 students

# The report

### Choice of markup language

We could write the report in either knitR-LaTeX or knitR-Rmarkdown. Both LaTeX and Rmarkdown support symbolic references for figures and tables, and Rmarkdown is often cleaner and more convenient.

### Weaving R code

We could either weave code inline using <<>>=...@ or \`\`\`{r...}...\`\`\`, or we could use read_chunk("R/..."). If we use read_chunk, we may want to move the code out of the R folder for the purposes of handing it in (though we could hand it in however we want if all we send Blackboard is a link to this repo). Also, we shouldn't set cache=T when using read_chunk, but this may not be a problem. (Small data hopefully means quick code and document compilation.)

# Handing in our work

We could upload the report (and separate R code files, if needed) of we could just send Blackboard a link to this GitHub repo. Maintianing a well-documented, self-sufficient GitHub repo is an acceptable form of reproducibility.
