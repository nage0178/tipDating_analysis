#!/bin/bash



maxReps=20
mkdir popDiverge
cd  popDiverge
for loci in 10 100 500 2000
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

			#ls ../../../../popDiverg
			cp  ../../../../popDiverg/${loci}/${reps}_${theta}_1/inference.ctl . 
			sed -i "s/simulate.txt/..\/..\/..\/..\/popDiverg\/${loci}\/${reps}_${theta}_1\/simulate.txt/g" inference.ctl
			sed -i "s/simple.Imap.txt/..\/..\/..\/..\/popDiverg\/${loci}\/${reps}_${theta}_1\\/simple.Imap.txt/g" inference.ctl
			sed -i "s/seed = /seed = 1/g" inference.ctl
			awk '{print $1 " 0.0"}'  ../../../../popDiverg/${loci}/${reps}_${theta}_1/realTimeDates.txt > realTimeDates.txt

			cd ../${reps}_${theta}_2
			sed "s/seed = 1/seed = 2/g" ../${name}/inference.ctl > inference.ctl
			sed -i "s/realTimeDates.txt/..\/${name}\/realTimeDates.txt/g" inference.ctl
			cd ../

		done
	done
	cd ../

done




