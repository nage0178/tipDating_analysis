#!/bin/bash


echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	mu_bar	tau_r_5ABCD	tau_r_6AB	tau_r_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD mu_bar	tau_r_5ABCD	tau_r_6AB	tau_r_7CD > means

echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	mu_bar	tau_r_5ABCD	tau_r_6AB	tau_r_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD mu_bar	tau_r_5ABCD	tau_r_6AB	tau_r_7CD > sd


echo rep	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD	tau_r_5ABCD	tau_r_6AB	tau_r_7CD	theta_1A	theta_2B	theta_3C	theta_4D	theta_5ABCD	theta_6AB	theta_7CD	tau_5ABCD	tau_6AB	tau_7CD tau_r_5ABCD	tau_r_6AB	tau_r_7CD > ESS

for dir in {,6samples/}{,noDates/}{oneExtinct,twoExtinct}/{10000,50000}/{10,100,500,2000}_{0.001,0.0001}/{1..20} {popDiverg/,noDates/popDiverge/}{10,100,500,2000}/{1..20}_{0.001,0.0001} {,noDates/}{oneExtinct,twoExtinct}/{10000,50000}/mtDna/{10,20,100}_{1..20}_{0.001,0.0001}
do
	echo $dir
	mean1=$(grep mean ${dir}_1/output | tail -n 1 | awk '{for(i=2;i<=15;i++) printf $i" "; print ""}' )
	mean2=$(grep mean ${dir}_2/output | tail -n 1 | awk '{for(i=2;i<=15;i++) printf $i" "; print ""}' )
	echo $dir $mean1 $mean2 >> means

	mean1=$(grep 'S.D' ${dir}_1/output | tail -n 1 | awk '{for(i=2;i<=15;i++) printf $i" "; print ""}' )
	mean2=$(grep 'S.D' ${dir}_2/output | tail -n 1 | awk '{for(i=2;i<=15;i++) printf $i" "; print ""}' )
	echo $dir $mean1 $mean2 >> sd

	mean1=$(grep ESS ${dir}_1/output | tail -n 1 | awk '{$12=""; for(i=2;i<=15;i++) printf $i" "; print ""}' )
	mean2=$(grep ESS ${dir}_2/output | tail -n 1 | awk '{$12=""; for(i=2;i<=15;i++) printf $i" "; print ""}' )
	echo $dir $mean1 $mean2 >> ESS
done


