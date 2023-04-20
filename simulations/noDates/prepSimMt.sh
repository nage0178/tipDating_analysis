#!/bin/bash


maxReps=20
for tree in oneExtinct twoExtinct
do

	cd $tree

	for dir in 10000 50000
	do
	
		cd $dir 

		mkdir -p  mtDna
		cd mtDna

		for ((reps=1;reps<=${maxReps};reps++));
		do

			for seq in 10 20
			do

			for theta in 0.001 0.0001
			do 
				mkdir -p ${seq}_${reps}_${theta}_1
				mkdir -p ${seq}_${reps}_${theta}_2
	
				# Simulation files
				cd ${seq}_${reps}_${theta}_1
				name=$(echo ${seq}_${reps}_${theta}_1)

				cp  ../../../../../${tree}/${dir}/mtDna/${name}/inference.ctl . 
				sed -i "s/simulate.txt/..\/..\/..\/..\/..\/${tree}\/${dir}\/mtDna\/${name}\/simulate.txt/g" inference.ctl
				sed -i "s/simple.Imap.txt/..\/..\/..\/..\/..\/${tree}\/${dir}\/mtDna\/${name}\/simple.Imap.txt/g" inference.ctl
				sed -i "s/seed = /seed = 1/g" inference.ctl
				awk '{print $1 " 0.0"}'  ../../../../../${tree}/${dir}/mtDna/${name}/realTimeDates.txt > realTimeDates.txt

				cd ../${seq}_${reps}_${theta}_2
				sed "s/seed = 1/seed = 2/g" ../${name}/inference.ctl > inference.ctl
				sed -i "s/realTimeDates.txt/..\/${name}\/realTimeDates.txt/g" inference.ctl
				cd ../

			done
		done
		done
		cd ../../
	
	done
	cd ../
done
