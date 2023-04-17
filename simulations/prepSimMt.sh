#!/bin/bash

seed=1
maxReps=20
for tree in oneExtinct twoExtinct
do

	cd $tree
	./drawDatesExtinctMt
	
	for ((reps=1;reps<=${maxReps};reps++));
	do 
	
		Rscript ../../Bayesian_sim/convertDates.R mtdates_10_${reps}.txt datesSubMt_10000_${reps}.txt .00000001
		Rscript ../../Bayesian_sim/convertDates.R mtdates_50_${reps}.txt datesSubMt_50000_${reps}.txt .00000001
	done

	for dir in 10000 50000
	do
	
		cd $dir 

		mkdir -p  mtDna
		cd mtDna

		for ((reps=1;reps<=${maxReps};reps++));
		do

			for theta in 0.001 0.0001
			do 
				mkdir -p ${reps}_${theta}_1
				mkdir -p ${reps}_${theta}_2
	
				# Simulation files
				cd ${reps}_${theta}_1
				name=$(echo ${reps}_${theta}_1)

				sed "s/seed = 1/seed = ${seed}/g" ../../../../simulateMt.ctl > simulate.ctl
				sed -i "s/dates.txt/..\/..\/..\/datesSubMt_${dir}_${reps}.txt/g" simulate.ctl
				sed -i "s/length = 1000 1000/length = 1 18000/g" simulate.ctl

				if [ "$theta" == "0.0001" ];
				then

					sed -i "s/\.0025/\.00025/g" simulate.ctl
				fi
	
				~/bpp/src/bpp --simulate simulate.ctl  &> simOutput 
	
				# Convert dates to real time
				Rscript ../../../../../Bayesian_sim/convertDatesToRealTime.R seqDates.txt realTimeDates.txt .00000001

				# Inference files
				cp ../../../../inferenceMt.ctl inference.ctl
				sed -i "s/seed = 1/seed = ${seed}/g" inference.ctl 


				if [ "$theta" == "0.0001" ];
				then
	
					sed -i "s/thetaprior = gamma 2.5 1000/thetaprior = gamma 2.5 10000/g" inference.ctl
				fi

				# Inference files run2
				cd ../${reps}_${theta}_2

				seedOld=$(echo ${seed})
				((seed=seed+1))

				sed "s/seed = ${seedOld}/seed = ${seed}/g" ../${name}/inference.ctl > inference.ctl
				sed -i "s/simple.Imap.txt/..\/${name}\/simple.Imap.txt/g" inference.ctl
				sed -i "s/simulate.txt/..\/${name}\/simulate.txt/g" inference.ctl
				sed -i "s/realTimeDates.txt/..\/${name}\/realTimeDates.txt/g" inference.ctl
				((seed=seed+1))

				cd ../
			done
		done
		cd ../../
	
	done
	cd ../
done
