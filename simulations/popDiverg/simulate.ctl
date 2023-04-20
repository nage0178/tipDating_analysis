seed = 1

seqfile = simulate.txt
treefile=simulate_trees.txt
Imapfile = simple.Imap.txt
datefile = dates.txt
seqDates = seqDates.txt

# fixed number of species/populations 
*speciesdelimitation = 0

# fixed species tree

species&tree = 4  A B C D
                  6  6 6 6
		  ((A #0.001, B #0.001):0.000005 #0.001, (C #0.001, D #0.001):.000013 #.001):.00002 #0.001;


phase =  0 0 0 0


loci&length = 500 1000
clock = 1
locusrate =0
model = 0


