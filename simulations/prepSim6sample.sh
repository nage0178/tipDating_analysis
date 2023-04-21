#!/bin/bash

seed=1
maxReps=20
cd 6samples

for tree in oneExtinct twoExtinct
do

	cd $tree
	#cp ../6simulate.ctl simulate.ctl 
	#cp ../6inference.ctl inference.ctl

	./drawDatesExtinct

	for ((reps=1;reps<=${maxReps};reps++));
	do 
		cat ../../${tree}/dates_10_${reps}.txt >> dates_10_${reps}.txt
		cat ../../${tree}/dates_50_${reps}.txt >> dates_50_${reps}.txt
	
		Rscript ../../../Bayesian_sim/convertDates.R dates_10_${reps}.txt datesSub_10000_${reps}.txt .000000001
		Rscript ../../../Bayesian_sim/convertDates.R dates_50_${reps}.txt datesSub_50000_${reps}.txt .000000001
	done
	
	for dir in 10000 50000
	do
	
		mkdir -p  $dir
		cd $dir 
	
		for loci in 10 100 500 2000
		do 
			for theta in 0.001 0.0001
			do
				mkdir -p ${loci}_${theta}
				cd ${loci}_${theta}
	
				for ((reps=1;reps<=${maxReps};reps++));
				do 
					mkdir -p ${reps}_1
					mkdir -p ${reps}_2
	
					# Simulation files
					cd ${reps}_1

					#ls 
					#ls ../../../../
					#exit
					sed "s/seed = 1/seed = ${seed}/g" ../../../../6simulate.ctl > simulate.ctl
					sed -i "s/loci = 1/loci = ${loci}/g" simulate.ctl
					sed -i "s/dates.txt/..\/..\/..\/datesSub_${dir}_${reps}.txt/g" simulate.ctl

					if [ "$theta" == "0.0001" ];
					then
	
						sed -i "s/\.001/\.0001/g" simulate.ctl
					fi

					if [ "$tree" == "twoExtinct" ];
					then
	
						sed -i "s/12 6 6 6/12 6 12 6/g" simulate.ctl
					fi


					~/bpp/src/bpp --simulate simulate.ctl  &> simOutput 
	
					# Convert dates to real time
					pwd
					ls      ../../../../../../
					Rscript ../../../../../../Bayesian_sim/convertDatesToRealTime.R seqDates.txt realTimeDates.txt .000000001
	
					# Inference files
					sed "s/loci = 1/loci = ${loci}/g" ../../../../6inference.ctl > inference.ctl
					sed -i "s/seed = 1/seed = ${seed}/g" inference.ctl 
	
					if [ "$theta" == "0.0001" ];
					then
	
						sed -i "s/thetaprior = gamma 2 2000/thetaprior = gamma 2 20000/g" inference.ctl
					fi

					if [ "$tree" == "twoExtinct" ];
					then
	
						sed -i "s/12 6 6 6/12 6 12 6/g" inference.ctl
					fi

					# Inference files run2
					cd ../${reps}_2

					seedOld=$(echo ${seed})
					((seed=seed+1))

					sed "s/seed = ${seedOld}/seed = ${seed}/g" ../${reps}_1/inference.ctl > inference.ctl
					sed -i "s/simple.Imap.txt/..\/${reps}_1\/simple.Imap.txt/g" inference.ctl
					sed -i "s/simulate.txt/..\/${reps}_1\/simulate.txt/g" inference.ctl
					sed -i "s/realTimeDates.txt/..\/${reps}_1\/realTimeDates.txt/g" inference.ctl


					 ((seed=seed+1))

					cd ../
				done
				cd ../
			done
	
		done
		cd ../

	done
	cd ../
done
