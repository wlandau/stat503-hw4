# stat503-hw4
This file is a running record of general decisions and issues.

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

We could either weave code inline using <<>>=...@ or \`\`\`{r...}...\`\`\`, or we could use read_chunk("R/..."). If we use read_chunk, we may want to move the code out of the R folder for the purposes of handing it in. Also, we shouldn't set cache=T when using read_chunk, but this may not be a problem. (Small data hopefully means quick code and document compilation.)


