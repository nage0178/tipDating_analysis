library(ape)

inFile <- "~/tipDating_analysis/mammoth_data/mtDna/mtDnaAligned.fa"
outFile <- "~/tipDating_analysis/mammoth_data/mtDna/mtDnaAlignedGapStrip.fa"

seq <- read.dna(inFile, format="fasta", as.matrix = TRUE, as.character = TRUE )

for (i in 1:dim(seq)[1]) {
  noCall <- which(seq[i,] == "n")
  seq[i, noCall] <-  "-"
}

percGap <- .25
rmSeq <- c()
for(i in 1:dim(seq)[2]){
  seqTab<- table(seq[, i])
  if((is.na(seqTab["-"]) == FALSE) && (seqTab["-"] >= percGap * dim(seq)[1])) {
    rmSeq <- cbind(rmSeq, i)
  }
}

colnames(rmSeq) <- NULL
seqShort <- seq[, -rmSeq]

write.dna(seqShort, colsep = "", file = outFile, format = "fasta")
