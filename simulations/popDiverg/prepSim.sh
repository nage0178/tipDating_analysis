#!/bin/bash


./drawDatesPop

maxReps=20
seed=1
for ((reps=1;reps<=${maxReps};reps++));
do 

	Rscript ../../Bayesian_sim/convertDates.R dates_${reps}.txt datesSub_${reps}.txt .000000001
done

for loci in 10 100 500
do 
	mkdir $loci
	cd $loci

	for ((reps=1;reps<=${maxReps};reps++));
	do 
		for theta in 0.001 0.0001
		do
			mkdir ${reps}_${theta}_1
			mkdir ${reps}_${theta}_2
			name=$(echo ${reps}_${theta}_1)

			# Simulation files
			cd ${reps}_${theta}_1
			sed "s/seed = 1/seed = ${seed}/g" ../../../simulate.ctl > simulate.ctl
			sed -i "s/loci = 1/loci = ${loci}/g" simulate.ctl
			sed -i "s/dates.txt/..\/..\/datesSub_${reps}.txt/g" simulate.ctl

			# Change theta
			if [ "$theta" == "0.0001" ];
				then
					sed -i "s/\.001/\.0001/g" simulate.ctl
				fi


			~/bpp/src/bpp --simulate simulate.ctl  &> simOutput 

			# Convert dates to real time
			Rscript ../../../../Bayesian_sim/convertDatesToRealTime.R seqDates.txt realTimeDates.txt .000000001

			# Inference files
			sed "s/loci = 1/loci = ${loci}/g" ../../inference.ctl > inference.ctl
			sed -i "s/seed = 1/seed = ${seed}/g" inference.ctl 

			seedOld=$(echo ${seed})
			((seed=seed+1))

			# Inference files run2
			cd ../${reps}_${theta}_2
			sed "s/seed = ${seedOld}/seed = ${seed}/g" ../${name}/inference.ctl > inference.ctl
			sed -i "s/simple.Imap.txt/..\/${name}\/simple.Imap.txt/g" inference.ctl
			sed -i "s/simulate.txt/..\/${name}\/simulate.txt/g" inference.ctl
			sed -i "s/realTimeDates.txt/..\/${name}\/realTimeDates.txt/g" inference.ctl

			# Change theta prior
			if [ "$theta" == "0.0001" ];
			then

				sed -i "s/thetaprior = gamma 2 20000/thetaprior = gamma 2 200000/g" inference.ctl
			fi

			seedOld=$(echo ${seed})

			cd ../
		done
	done
	cd ../

done




