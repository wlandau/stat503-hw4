# stat503-hw4
This file is a general record of decisions, issues, and logicstics.

# Division of labor

We might use this section to write down what we're doing so we don't step on each other's toes.

### Andee

### Will

- Preprocessing the data with the inclusion matrix, NAs-as-zeroes imputation method (data/allInclusionMat.csv).

### Fangge

### Lindsay

# The report

### Choice of markup language

We could write the report in either knitR-LaTeX or knitR-Rmarkdown. LaTeX supports symbolic references for figures and tables and is recommended over Rmarkdown for serious scholarly work, but Rmarkdown is often cleaner and more convenient.

### Weaving R code

We could either weave code inline using <<>>=...@ or \`\`\`{r...}...\`\`\`, or we could use read_chunk("R/..."). If we use read_chunk, we may want to move the code out of the R folder for the purposes of handing it in (though we could hand it in however we want if all we send Blackboard is a link to this repo). Also, we shouldn't set cache=T when using read_chunk, but this may not be a problem. (Small data hopefully means quick code and document compilation.)

# Handing in our work

We could upload the report (and separate R code files, if needed) of we could just send Blackboard a link to this GitHub repo. Maintianing a well-documented, self-sufficient GitHub repo is an acceptable form of reproducibility.
