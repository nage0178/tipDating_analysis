means <- read.table("~/tipDating_analysis/simulations/means", header =TRUE)
stdev <- read.table("~/tipDating_analysis/simulations/sd", header =TRUE)
ESS <- read.table("~/tipDating_analysis/simulations/ESS", header =TRUE)

numVar <- 14
t <- matrix(0, nrow = dim(means)[1], ncol = numVar)
N <- 200
for (i in 2:15) {
  denom <- (stdev[,i]^2 + stdev[,i+numVar]^2)/2
  t[,i - 1] <-  (means[,i] - means[,i+numVar]) / (denom^(1/2) * (2 /N)^(1/2))
  i = i + 1
}

cutOff <- qt(p = .05/2, df = 2*N -2, lower.tail= FALSE)
converge <- rep(0, dim(means)[1])
for (i in 1:dim(means)[1]) {
  converge[i] <-  all(t[i, c(-6,-7,-8,-9, -11) ] < cutOff)
}

convergeESS <- rep(0, dim(ESS)[1])
ESS <- ESS[,c(-6,-7,-8,-9, -22)]
for (i in 1:dim(ESS)[1]) {
  convergeESS[i] <-  all(ESS[i, 2:(dim(ESS)[2])] > 200)
}

cat(means[which(converge*convergeESS == 0),1], sep = "\n")
 
