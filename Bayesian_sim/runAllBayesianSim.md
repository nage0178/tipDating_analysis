# Running Bayesian Simulations
1. Make the rejection simulation files. The make system and the gcc compiler must be installed on your machine. 
Navigate to the rejection simulation directory. 
Then make the executable.
	Navigate back to the Bayesian simulation directory
```
	cd ../rejection_sim
	make
	cd ../Bayesain_sim
```
2. Run the script to prepare the simulation files. 
	The bpp directory must in the home directory and bpp must be compiled. If bpp is located elsewhere, update the path to bpp in the file `prepBayesSim.sh`. R must also be installed
``` 
	./prepBayesSim.sh
```
3. Run all of the MCMCs. 
	This can be accomplished by running the following command in every directory`{1-3000}_{1-2}`.
	If the bpp directory is not located in the home directory, modify the path accordingly.
```
	~/bpp/src/bpp --cfile simpleInference.ctl &> output & 
```
4. Check convergence of the MCMCs and prepare to re-run MCMCs that did not converge. 
```
	./rerunNotConverge.sh
```
5. Repeat step 3 for every replicate that is in the notConverged file.
6. Check convergence and combine the results across all simulations that converged. 
	
```
	./combineMCMC.sh
```

7. Figures can be made with the scripts `tauABCD.R` and `BS_individual.R`. Please note these use a lot of memory and may cause R to be killed on a personal computer.
