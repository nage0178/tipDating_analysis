#!/bin/bash

../rejection_sim/testPrior_4_tip_symmetric


awk '{print "((A #"$6" ,B #"$7"):"$4" # "$10",(C #"$8",D #"$9"):"$5" #"$11"):"$3" # "$12";"}' parameters.txt > trees.txt

maxReps=3000
for ((reps=1;reps<=${maxReps};reps++));
do 
	
	mkdir ${reps}_1
	mu=$(head -n $(( ${reps} + 1 )) parameters.txt |tail -n 1 |awk '{print $2}')
	tree=$(head -n $(( ${reps} + 1 )) trees.txt |tail -n 1 )

 	Rscript convertDates.R realTimeDates.txt ${reps}_1/dates.txt ${mu}

	sed "s/newickTree/${tree}/g" simple.ctl > ${reps}_1/simple.ctl

	cd ${reps}_1
	~/bpp/src/bpp --simulate simple.ctl  &> simOutput & 

	# Still need to convert dates so you have the unique sequence id
	Rscript ../convertDatesToRealTime.R seqDates.txt realTimeDates.txt $mu

	cp ../simpleInference.ctl .

	mkdir ../${reps}_2
	sed "s/seed = 1/seed = 2/g" simpleInference.ctl > ../${reps}_2/simpleInference.ctl
	sed -i "s/simple.Imap.txt/..\/${reps}_1\/simple.Imap.txt/g"  ../${reps}_2/simpleInference.ctl
	sed -i "s/simulate.txt/..\/${reps}_1\/simulate.txt/g"  ../${reps}_2/simpleInference.ctl
	sed -i "s/realTimeDates.txt/..\/${reps}_1\/realTimeDates.txt/g"  ../${reps}_2/simpleInference.ctl
	cd ../

done

