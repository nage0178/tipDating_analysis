#!/bin/bash

maxReps=3000
./checkConvergence.sh &> outConvergence 
Rscript checkConvergence.R > notConverged

seed=3
for ((reps=1;reps<=${maxReps};reps++));
do 
	if   grep -q -w $reps notConverged 
	then
		mkdir -p NC_${reps}_1
		mkdir -p NC_${reps}_2
		cp  ${reps}_1/* NC_${reps}_1/*
		cp  ${reps}_2/* NC_${reps}_2/*

		sed -i "s/seed = 1/seed = ${seed}/g" ${reps}_1/simpleInference.ctl
		((seed=seed+1))

		sed -i "s/seed = 2/seed = ${seed}/g" ${reps}_2/simpleInference.ctl
		((seed=seed+1))

		sed -i "s/burnin = 80000/burnin = 200000/g" ${reps}_1/simpleInference.ctl
		sed -i "s/burnin = 80000/burnin = 200000/g" ${reps}_2/simpleInference.ctl

	fi
done
