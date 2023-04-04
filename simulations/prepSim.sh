#!/bin/bash

maxReps=2
for tree in oneExtinct twoExtinct
do

	cd $tree
	cp ../simulate.ctl . 
	cp ../inference.ctl . 

	./drawDatesExtinct

	for ((reps=1;reps<=${maxReps};reps++));
	do 
	
		Rscript ../../Bayesian_sim/convertDates.R dates_10_${reps}.txt datesSub_10000_${reps}.txt .000000001
		Rscript ../../Bayesian_sim/convertDates.R dates_50_${reps}.txt datesSub_50000_${reps}.txt .000000001
	done
	
	for dir in 10000 50000
	do
	
		mkdir $dir
		cd $dir 
	
		for loci in 10 100 500
		do 
			for theta in 0.001 0.0001
			do
				mkdir ${loci}_${theta}
				cd ${loci}_${theta}
	
				for ((reps=1;reps<=${maxReps};reps++));
				do 
					mkdir ${reps}_1
					mkdir ${reps}_2
	
					# Simulation files
					cd ${reps}_1

					sed "s/seed = 1/seed = ${reps}/g" ../../../../simulate.ctl > simulate.ctl
					sed -i "s/loci = 1/loci = ${loci}/g" simulate.ctl
					sed -i "s/dates.txt/..\/..\/..\/datesSub_${dir}_${reps}.txt/g" simulate.ctl

					if [ "$theta" == "0.0001" ];
					then
	
						sed -i "s/\.001/\.0001/g" simulate.ctl
					fi

					~/bpp/src/bpp --simulate simulate.ctl  &> simOutput 
	
					# Convert dates to real time
					Rscript ../../../../../Bayesian_sim/convertDatesToRealTime.R seqDates.txt realTimeDates.txt .000000001
	
					# Inference files
					sed "s/loci = 1/loci = ${loci}/g" ../../../../inference.ctl > inference.ctl
	
					# Inference files run2
					cd ../${reps}_2

					sed "s/seed = 1/seed = 2/g" ../${reps}_1/inference.ctl > inference.ctl
					sed -i "s/simple.Imap.txt/..\/${reps}_1\/simple.Imap.txt/g" inference.ctl
					sed -i "s/simulate.txt/..\/${reps}_1\/simulate.txt/g" inference.ctl
					sed -i "s/realTimeDates.txt/..\/${reps}_1\/realTimeDates.txt/g" inference.ctl

					if [ "$theta" == "0.0001" ];
					then
	
						sed -i "s/thetaprior = gamma 2 20000/thetaprior = gamma 2 200000/g" inference.ctl
					fi

					cd ../
				done
				cd ../
			done
	
		done
		cd ../

	done
	cd ../
done
