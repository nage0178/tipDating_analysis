means <- read.table("~/tipDating_analysis/Bayesian_sim/means", header =TRUE)
stdev <- read.table("~/tipDating_analysis/Bayesian_sim/variance", header =TRUE)
ESS <- read.table("~/tipDating_analysis/Bayesian_sim/ESS", header =TRUE)

numVar <- 10
t <- matrix(0, nrow = dim(means)[1], ncol = numVar)
N <- 10000
for (i in 2:11) {
  denom <- (stdev[,i]^2 + stdev[,i+numVar]^2)/2
  t[,i - 1] <-  (means[,i] - means[,i+numVar]) / (denom^(1/2) * (2 /N)^(1/2))
  i = i + 1
}

cutOff <- qt(p = .05/2, df = 2*N -2, lower.tail= FALSE)
converge <- rep(0, dim(means)[1])
for (i in 1:dim(means)[1]) {
  converge[i] <-  all(t[i, ] < cutOff)
}

convergeESS <- rep(0, dim(ESS)[1])
for (i in 1:dim(ESS)[1]) {
  convergeESS[i] <-  all(ESS[i, 2:(dim(ESS)[2])] > 200)
}
# exclude <- which(converge*convergeESS == 0)
# 
#  for (i in 2:11) {
#   par(pty="s")
#   plot(means[-exclude,i], means[-exclude,i+11], asp=1, pch =20, main = colnames(means)[i], xlab = "run1", ylab = "run2")
#   lines(0:10, 0:10)
# }

cat(which(converge*convergeESS == 0))
