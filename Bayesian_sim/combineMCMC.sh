#!/bin/bash

maxReps=3000
./checkConvergence.sh
Rscript checkConvergence.R > notConverged

cat 1_1/mcmc.txt > allMCMC.txt

for ((reps=1;reps<=${maxReps};reps++));
do 
	if  ! grep -q -w $reps notConverged 
	then

		tail -n+2 ${reps}_1/mcmc.txt >> allMCMC.txt
	fi
done
head -1 1_1/mcmc.txt > outputFileSmall
awk 'NR % 15 == 0' allMCMC.txt >> outputFileSmall
awk '{$1=""; print NR "\t" $0}' outputFileSmall  > outputFile
sed -i 's/ /\t/g' outputFile
sed -i 's/\t\t/\t/g' outputFile

for ((i=2; i<=12; i++))
do
	fileName=$(head -1 1_1/mcmc.txt |awk -v i=$i '{print $i}')

	awk -v i=$i '{print $1"\t"$i}' outputFile > ${fileName}.txt
	
done
