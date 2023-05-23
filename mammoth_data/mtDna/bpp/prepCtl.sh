#!/bin/bash
seed=1
for rep in 1 2
do

	mkdir -p $rep
	sed "s/seed = 1/seed = ${seed}/g" mt.ctl >  $rep/mt.ctl
	((seed=seed+1))
done
