means <- read.table("~/tipDating_analysis/simulations/means", header =TRUE)
stdev <- read.table("~/tipDating_analysis/simulations/sd", header =TRUE)
ESS <- read.table("~/tipDating_analysis/simulations/ESS", header =TRUE)

numVar <- 14
t <- matrix(0, nrow = dim(means)[1], ncol = numVar)
N <- 2000
for (i in 2:15) {
  denom <- (stdev[,i]^2 + stdev[,i+numVar]^2)/2
  t[,i - 1] <-  (means[,i] - means[,i+numVar]) / (denom^(1/2) * (2 /N)^(1/2))
  i = i + 1
}

cutOff <- qt(p = .05/2, df = 2*N -2, lower.tail= FALSE)
converge <- rep(0, dim(means)[1])
for (i in 1:dim(means)[1]) {
  converge[i] <-  all(t[i, -11 ] < cutOff)
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

cat(means[which(converge*convergeESS == 0),1], sep = "\n")
# 
