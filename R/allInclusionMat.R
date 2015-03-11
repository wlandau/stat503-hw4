# Tweak each semester's data so that we can rbind everything together.

msng = function(v){
  100*!is.na(v)
}

avg.by.content = function(x, semester){

  out = data.frame(
    student = x$Username,
    semester = rep(semester, dim(x)[1]),
    section = paste(semester, x$Section, sep="_")
  )

  if(semester == "13Fall"){
      out$intro = x$Ch1
      out$categorical = x$Ch2
      out$quantitative = x$Ch3
      out$distributions = x$Ch4
      out$normality = x$Ch5
      out$scatterplots = x$Ch6
      out$regression = x$Ch7.8
      out$randomness = x$Ch9
      out$surveys = x$Ch10
      out$experiments = x$Ch11
      out$probability = x$Ch12
      out$proportions = x$Ch15I
      out$ci_proportions = x$Ch16
      out$hyp_proportions = x$Ch17
      out$sampling = x$Ch15II
      out$inference_means = x$Ch18
      out$more_intervals = x$Ch19
      out$compare_groups = x$Ch20

      out$average_score = x$AvgCrtPct

      out$intro_HANDIN = msng(x$Ch1)
      out$categorical_HANDIN = msng(x$Ch2)
      out$quantitative_HANDIN = msng(x$Ch3)
      out$distributions_HANDIN = msng(x$Ch4)
      out$normality_HANDIN = msng(x$Ch5)
      out$scatterplots_HANDIN = msng(x$Ch6)
      out$regression_HANDIN = msng(x$Ch7.8)
      out$randomness_HANDIN = msng(x$Ch9)
      out$surveys_HANDIN = msng(x$Ch10)
      out$experiments_HANDIN = msng(x$Ch11)
      out$probability_HANDIN = msng(x$Ch12)
      out$proportions_HANDIN = msng(x$Ch15I)
      out$ci_proportions_HANDIN = msng(x$Ch16)
      out$hyp_proportions_HANDIN = msng(x$Ch17)
      out$sampling_HANDIN = msng(x$Ch15II)
      out$inference_means_HANDIN = msng(x$Ch18)
      out$more_intervals_HANDIN = msng(x$Ch19)
      out$compare_groups_HANDIN = msng(x$Ch20)

  } else {
      out$intro = x$T01

      m = cbind(x$T02, x$T04)
      m[is.na(m)] = 0
      out$categorical = rowMeans(m)

      out$quantitative = x$T03
      out$distributions = x$T05
      out$normality = x$T06
      out$scatterplots = x$T07
      out$regression = x$T08
      out$randomness = x$T11
      out$surveys = x$T09
      out$experiments = x$T10
      out$probability = rep(0, dim(x)[1])
      out$proportions = x$T15
      out$ci_proportions = x$T16
      out$hyp_proportions = x$T17
      out$sampling = x$T18

      if(is.null(x$T19)){
        out$inference_means = rep(0, dim(x)[1])
        out$more_intervals = rep(0, dim(x)[1])
        out$compare_groups = x$T23
      } else {
        out$inference_means = x$T19
        out$more_intervals = x$T20

        m = cbind(x$T21, x$T22, x$T23)
        m[is.na(m)] = 0
        out$compare_groups = rowMeans(m)
      }

      out$average_score = x$AvgCrtPct

      out$intro_HANDIN = msng(x$T01)
      out$categorical_HANDIN = rowMeans(cbind(msng(x$T02), msng(x$T04)))
      out$quantitative_HANDIN = msng(x$T03)
      out$distributions_HANDIN = msng(x$T05)
      out$normality_HANDIN = msng(x$T06)
      out$scatterplots_HANDIN = msng(x$T07)
      out$regression_HANDIN = msng(x$T08)
      out$randomness_HANDIN = msng(x$T11)
      out$surveys_HANDIN = msng(x$T09)
      out$experiments_HANDIN = msng(x$T10)
      out$probability_HANDIN = rep(0, dim(x)[1])
      out$proportions_HANDIN = msng(x$T15)
      out$ci_proportions_HANDIN = msng(x$T16)
      out$hyp_proportions_HANDIN = msng(x$T17)
      out$sampling_HANDIN = msng(x$T18)

      if(is.null(x$T19)){
        out$inference_means_HANDIN = rep(0, dim(x)[1])
        out$more_intervals_HANDIN = rep(0, dim(x)[1])
        out$compare_groups_HANDIN = msng(x$T23)
      } else {
        out$inference_means_HANDIN = msng(x$T19)
        out$more_intervals_HANDIN = msng(x$T20)
        out$compare_groups_HANDIN = rowMeans(cbind(msng(x$T21), msng(x$T22), msng(x$T23)))
      }
  }
  
  as.data.frame(lapply(out, function(v){
    if(is.numeric(v)) 
      v[is.na(v)] = 0; 
    v
  }))
}

# Collect and preprocess all semester data

semesters = c("13Fall", "14Fall", "14Spring")
.data = list()
for(semester in semesters)
  .data[[semester]] = avg.by.content(read.csv(paste("../data/", semester, "a.csv", sep="")), semester)

write.csv(do.call("rbind", .data), "../data/allInclusionMat.csv", row.names = F)