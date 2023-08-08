#!/bin/bash


./checkConvergence.sh &> outCheckConvergence 
Rscript checkConvergence2.R &> notConverge2

grep -v pop notConverge2 | grep -v mt > notConverge2Re

for dir in $(cat notConverge2Re)
do
	echo $dir
	mkdir -p NC2/${dir}_1
	mkdir -p NC2/${dir}_2
	cp  ${dir}_1/* NC2/${dir}_1
	cp  ${dir}_2/* NC2/${dir}_2
	
	sed -i 's/seed = /seed = 1/g' ${dir}_1/inference.ctl
	sed -i 's/seed = /seed = 2/g' ${dir}_2/inference.ctl

	sed -i 's/nsample = 600000/nsample = 1200000/g' ${dir}_1/inference.ctl
	sed -i 's/nsample = 600000/nsample = 1200000/g' ${dir}_2/inference.ctl
	
	echo threads = 5 >> ${dir}_1/inference.ctl
	echo threads = 5 >> ${dir}_2/inference.ctl

	sed -i 's/threads = 5/threads = 4/g' ${dir}_2/inference.ctl
done


