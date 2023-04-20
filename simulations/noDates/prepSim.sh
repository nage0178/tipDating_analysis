#!/bin/bash

maxReps=20
for tree in oneExtinct twoExtinct
do

	mkdir $tree
	cd $tree

	
	for dir in 10000 50000
	do
	
		mkdir $dir
		cd $dir 
	
		for loci in 10 100 500 2000
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

					cp  ../../../../../${tree}/${dir}/${loci}_${theta}/${reps}_1/inference.ctl . 
					sed -i "s/simulate.txt/..\/..\/..\/..\/..\/${tree}\/${dir}\/${loci}_${theta}\/${reps}_1\/simulate.txt/g" inference.ctl
					sed -i "s/simple.Imap.txt/..\/..\/..\/..\/..\/${tree}\/${dir}\/${loci}_${theta}\/${reps}_1\/simple.Imap.txt/g" inference.ctl
					sed -i "s/seed = /seed = 1/g" inference.ctl
					awk '{print $1 " 0.0"}'  ../../../../../${tree}/${dir}/${loci}_${theta}/${reps}_1/realTimeDates.txt > realTimeDates.txt

					cd ../${reps}_2
					sed "s/seed = 1/seed = 2/g" ../${reps}_1/inference.ctl > inference.ctl
					sed -i "s/realTimeDates.txt/..\/${reps}_1\/realTimeDates.txt/g" inference.ctl
					cd ../
				done
				cd ../
			done
	
		done
		cd ../

	done
	cd ../
done
