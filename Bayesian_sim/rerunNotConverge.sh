#!/bin/bash

maxReps=3000
Rscript checkConvergence.R > notConverged


seed = 3
for ((reps=1;reps<=${maxReps};reps++));
do 
	if   grep -q -w $reps notConverged 
	then
		cp -r  ${reps}_1 NC_${reps}_1
		cp -r  ${reps}_2 NC_${reps}_2

		sed -i "s/seed = 1/seed = ${seed}/g" ${reps}_1/inference.ctl
		((seed=seed+1))

		sed -i "s/seed = 2/seed = ${seed}/g" ${reps}_2/inference.ctl
		((seed=seed+1))


	fi
done
