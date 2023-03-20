args = commandArgs(trailingOnly = TRUE)
if(length(args) != 3) {
  stop("Incorrect number of arguements")
} else {
  inFile <- args[1] # csv file to read in
  outFile <- args[2]
  mutrate <- as.numeric(args[3])
}

dates <- read.table(inFile, header= FALSE)
dates[,2] <- dates[,2] / mutrate
write.table(format(dates, scientific = FALSE), outFile, col.names = FALSE, row.names = FALSE, quote = FALSE)
