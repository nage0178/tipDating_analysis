#!/bin/bash

maxReps=3000

echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD > means
for ((reps=1;reps<=${maxReps};reps++));
do 
	mean1=$(grep mean ${reps}_1/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	mean2=$(grep mean ${reps}_2/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	#echo $mean1
	echo $reps $mean1 $mean2 >> means
done


echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD > variance
for ((reps=1;reps<=${maxReps};reps++));
do 
	mean1=$(grep 'S.D' ${reps}_1/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	mean2=$(grep 'S.D' ${reps}_2/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	echo $reps $mean1 $mean2 >> variance
done

echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD > ESS
for ((reps=1;reps<=${maxReps};reps++));
do 
	mean1=$(grep ESS ${reps}_1/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	mean2=$(grep ESS ${reps}_2/output | tail -n 1 | awk '{for(i=2;i<=11;i++) printf $i" "; print ""}' )
	#echo $mean1
	echo $reps $mean1 $mean2 >> ESS
done
