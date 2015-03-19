# stat503-hw4
This file is a general record of decisions, issues, and logicstics.

# Division of labor

We might use this section to write down what we're doing so we don't step on each other's toes.

### Andee

Apply methods of clustering to the clean data. Apply to one semester and use model to predict clustering for other semesters, as suggested by Dr. Cook. Methods to apply:

 - Self organizing map for groups 3 & 4 (together or separate?)
 - Model based clustering for groups 3 & 4 (together or separate?)

### Will

- Visually analyze patterns of missingness for each semester, and use the insight to  offer suggestions about a preliminary clustering/imputation strategy.

- Applied Dr. Cook's knn imputation method to groups 3 and 4 from Lindsay's method for each semester. Data in data/cleanGrades.Rda is ready for clustering.

### Fangge

### Lindsay

- Cluster the data into four groups for each semester
  - 1) Group 1: Drop outs (Students who miss last consecutive half of assignments) 
  - 2) Group 2: Common missings (Students not from Group 1 who miss at least half of assignments)
  - 3) Group 3: Sporadic missings (Students not from Group 1 or 2 who miss at least one assignment)
  - 4) Group 4: Never missings (Students who never miss any assignments)
- Perform nearest neighbor analysis on Group 3 students

# Imputation and NA's

Now that we have Dr. Cook's imputation code and Lindsay's code for getting rid of problem students, do we really need to implement multiple imputation strategies?

# The report

### Choice of markup language

It seems like the choice is Rmarkdown.

### Weaving R code

We could either weave code inline using \`\`\`{r...}...\`\`\`, but that gets messy and cumbersome. We could use read_chunk("../R/..."), but then we can't set cache=T, so compile time is really long. A better option  might be to use source("../R/...") to load code from the R folder into the report. This enables caching, keeps inline code out of the report so that we can concentrate on prose, and helps minimize the volume of repeat code we have to write.


# Handing in our work

We could upload the report (and separate R code files, if needed) or we could just make the GitHub repo public and send Blackboard a link to it. Maintianing a well-documented, self-sufficient GitHub repo is an acceptable form of reproducibility.
