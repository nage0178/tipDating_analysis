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
                  10 10 10 10 
		  ((A #0.0025, B #0.0025):.07 #0.0025, (C #0.0025, D #0.0025):.04 #.0025)#.0025:.1;


phase =   0 0 0 0


loci&length = 1 16000
clock = 1
locusrate =0
model = 0


