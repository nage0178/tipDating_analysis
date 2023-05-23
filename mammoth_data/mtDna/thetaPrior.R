library(ape)
inFile <- "~/mammoth_data/mtDna/mtDnaAlignedGapStrip.fa"

seq <- read.dna(inFile, format="fasta", as.matrix = TRUE, as.character = TRUE )
species <- read.table("~/mammoth_data/mtDna/contemporary.txt")
rownames(seq) <- sapply(strsplit(rownames(seq), " "), "[[", 1)

E_M <- species[which(species[,2] == "E_M"), 1]
L_A <- species[which(species[,2] == "L_A"), 1]
L_C <- species[which(species[,2] == "L_C"), 1]

data_E_M <- seq[rownames(seq) %in% E_M, ]
data_L_A <- seq[rownames(seq) %in% L_A, ]
data_L_C <- seq[rownames(seq) %in% L_C, ]


pairwiseDifference <- function (seqData) {
  total <- 0
  
  for (seq1 in 2:dim(seqData)[1]) {
    for (seq2 in 1:(seq1 - 1)) {
      gap1 <- which(seqData[seq1,] == "-")
      gap2 <- which(seqData[seq2,] == "-")
      sitesRm <- union(gap1, gap2)
      
      sitesDifferent <- (which(seqData[seq1, -sitesRm] != seqData[seq2, -sitesRm]))
      compareLen <- dim(seqData)[2] - length(sitesRm)
      total <- total + (length(sitesDifferent) / compareLen)
      #print(paste(seq1, seq2, length(sitesDifferent), compareLen, sep = " "))
    }
  }
  return (total)
}
  
combinations <- function (seqData) {
  n <- dim(seqData)[1] - 1
  comb <- n * (n + 1) / 2
  return (comb)
}


pairwiseDifference(data_L_C) / combinations(data_L_C)
pairwiseDifference(data_L_A) / combinations(data_L_A)
pairwiseDifference(data_E_M) / combinations(data_E_M)

write.dna(data_L_A, colsep = "", file = "~/mammoth_data/mtDna/L_A_testing.fa", format = "fasta")
write.dna(data_L_C, colsep = "", file = "~/mammoth_data/mtDna/L_C_testing.fa", format = "fasta")
write.dna(data_E_M, colsep = "", file = "~/mammoth_data/mtDna/E_M_testing.fa", format = "fasta")

speciesDifference <- function (seqData1, seqData2) {
  total <- 0
  
  for (seq1 in 1:dim(seqData1)[1]) {
    for (seq2 in 1:dim(seqData2)[1]) {
      gap1 <- which(seqData1[seq1,] == "-")
      gap2 <- which(seqData2[seq2,] == "-")
      sitesRm <- union(gap1, gap2)
      
      sitesDifferent <- (which(seqData1[seq1, -sitesRm] != seqData2[seq2, -sitesRm]))
      compareLen <- dim(seqData1)[2] - length(sitesRm)
      total <- total + (length(sitesDifferent) / compareLen)
      #print(paste(seq1, seq2, length(sitesDifferent), compareLen, sep = " "))
    }
  }
  print(total)
  print((dim(seqData1)[1] * dim(seqData2)[1]))
  return (total / (dim(seqData1)[1] * dim(seqData2)[1]) )
}

data_African <- rbind(data_L_A, data_L_C)
speciesDifference(data_African, data_E_M)
speciesDifference(data_L_A, data_E_M)
speciesDifference(data_L_C, data_E_M)
