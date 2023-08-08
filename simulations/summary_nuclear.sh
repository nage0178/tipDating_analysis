#!/bin/bash

maxReps=20
meanslab=M_theta_1A,M_theta_2B,M_theta_3C,M_theta_4D,M_theta_5ABCD,M_theta_6AB,M_theta_7CD,M_tau_5ABCD,M_tau_6AB,M_tau_7CD,M_mu_bar,M_r_tau_5ABCD,M_r_tau_6AB,M_r_tau_7CD
lowlab=L_theta_1A,L_theta_2B,L_theta_3C,L_theta_4D,L_theta_5ABCD,L_theta_6AB,L_theta_7CD,L_tau_5ABCD,L_tau_6AB,L_tau_7CD,L_mu_bar,L_r_tau_5ABCD,L_r_tau_6AB,L_r_tau_7CD
highlab=H_theta_1A,H_theta_2B,H_theta_3C,H_theta_4D,H_theta_5ABCD,H_theta_6AB,H_theta_7CD,H_tau_5ABCD,H_tau_6AB,H_tau_7CD,H_mu_bar,H_r_tau_5ABCD,H_r_tau_6AB,H_r_tau_7CD
echo extinct,dates,loci,theta,rep,${meanslab},${lowlab},${highlab} > nuclear.csv

for tree in oneExtinct twoExtinct
do

        cd $tree

        for dir in 10000 50000
        do

                cd $dir

                for loci in 10 100 500 2000
                do
                        for theta in 0.001 0.0001
                        do
                                cd ${loci}_${theta}

                                for ((reps=1;reps<=${maxReps};reps++));
                                do

                                        # Simulation files
                                        cd ${reps}_1

                                        cur=$(pwd)
                                        cur2=${cur::-2}
                                        found=$(grep -w $cur2 ~/tipDating_analysis/simulations/notConvergeFullPath)
                                        #echo $cur $cur2 $found
                                        if [ -z $found ]
                                        then

                                                means=$(grep mean output | tail -n 1 |awk '{$1=""; $NF=""}1'|sed 's/ /,/g'| sed 's/,$//')
                                                HPDlow=$(grep HPD output | head -1 |awk '{$1=""; $NF=""}1'|sed 's/ /,/g'| sed 's/,$//')
                                                HPDhigh=$(grep HPD output | tail -n 1 |awk '{$1=""; $NF=""}1'|sed 's/ /,/g'| sed 's/,$//')
                                                echo ${tree},${dir},${loci},${theta},${reps}${means}${HPDlow}${HPDhigh} >> ../../../../nuclear.csv
                                        fi

                                        cd ../
                                done
                                cd ../
                        done

                done
                cd ../

        done
        cd ../
done

