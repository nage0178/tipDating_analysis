#!/bin/bash
seed=1
for rep in 1 2 3 4 
do

	mkdir -p $rep
	sed "s/seed = 1/seed = ${rep}/g" mt.ctl >  $rep/mt.ctl
done
