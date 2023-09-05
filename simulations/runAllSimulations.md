1. Make all of the times to simulate dates. The make system and gcc must be installed on your machine. 
```
cd twoExtinct
make drawDatesExtinct
make drawDatesExtinctMt
make drawDatesExtinct100

cd ../oneExtinct
make drawDatesExtinct
make drawDatesExtinctMt
make drawDatesExtinct100

cd ../popDiverg
make drawDatesPop

cd ../6samples/oneExtinct
make 

cd ../6samples/twoExtinct
make
```
2. Prepare files for inference. R must be installed. The bpp directory must be located in the home directory and bpp must be compile. If it is located elsewhere, change the path name accordingly.
```
	./prepSim.sh
	./prepMt.sh
	./prepSim6sample.sh
	./prepSimMt100.sh

	cd popDiverg
	./prepSim.sh

	cd ../noDates
	./prepSim.sh
	./prepSimMt.sh
	./prepSimPopDiverge.sh
	
	cd ../6samples/noDates
	./prepSim.sh
```
3. Run inference program for every simulated dataset. This is very computationally intensive. The jobs were originally run on a high performance computing cluster. Each MCMC can be run with the following command. As before, the path to bpp should be modified if it is not located in the home directory.
```
~/bpp/src/bpp --cfile inference.ctl --theta-move=slide &> output &
``` 

A few of the datasets, particularly the mitochondrial datasets need the line 
```
echo scaling = 1
```
added to the control file. If the jobs is not run in the backgroun (without the & at the end up the bpp command above), then an error message will appear on the screen about setting the scaling. 
f the job is run in the background, it will terminate before the MCMC starts.

4. Check convergence and prepare files to run longer. This requires R.
```
./reRun.sh
```

5. Re-run MCMCs. For every pair of MCMCs in the noConverged file, repeat step 3. 

6. Check convergence of the MCMCs again and prepare file to run longer again. Note that none of the mitochondrial or recent population divergence inferences were re-run in this step since more than half of every combination of parameters converged for these simulations. 
```
./reRun2.sh
```


7. Re-run MCMCs that did not converge, which are listed in notConverge2Re, following step 3. Note that these control files use multiple threads. 


8. Create files to summarize results
```
./summary_nuclear.sh
./summary_mt.sh

cd noDates
./summary_nuclear.sh
./summary_mt.sh

cd ../popDiverge 
./summary_pop.sh

cd ../6samples

./summary_nuclear.sh

cd noDates
./summary_nuclear.sh
 
cd ../../
```

9. Produce plots. Note the path names to the output graphics will need to be changed. The plots are directed to a directory tipDating/figs.
```
cd ../
Rscript summaryPlots.R
