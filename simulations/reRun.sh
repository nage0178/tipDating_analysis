#!/bin/bash


./checkConvergence.sh &> outCheckConvergence 
Rscript checkConvergence.R &> notConverge


for dir in $(cat notConverge)
do
	mkdir -p NC/${dir}_1
	mkdir -p NC/${dir}_2
	cp  ${dir}_1/* NC/${dir}_1
	cp  ${dir}_2/* NC/${dir}_2
	
	sed -i 's/seed = /seed = 1/g' ${dir}_1/inference.ctl
	sed -i 's/seed = /seed = 2/g' ${dir}_2/inference.ctl

	sed -i 's/nsample = 400000/nsample = 600000/g' ${dir}_1/inference.ctl
	sed -i 's/nsample = 400000/nsample = 600000/g' ${dir}_2/inference.ctl
	
	echo checkpoint = 160000 400000 >> ${dir}_1/inference.ctl
	echo checkpoint = 160000 400000 >> ${dir}_2/inference.ctl

done


