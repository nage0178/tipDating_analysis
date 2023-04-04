#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <time.h>
#include <assert.h>

int main (int argc, char **argv) {


	/* Set up random number generator */
	gsl_rng * r;
	const gsl_rng_type * T;
	gsl_rng_env_setup();
	T = gsl_rng_default;
	r = gsl_rng_alloc(T);
 
	gsl_rng_set(r, 5);

	int reps = 20, ind = 3;
	double time;
	char fileName[50];
	char repString[5];
	double AB_bound = 5000, CD_bound = 13000;

	for (int j = 1; j <= reps; j ++) {
		sprintf(repString,"%d", j);

		strcpy(fileName, "dates_");
		strcat(fileName, repString);
		strcat(fileName, ".txt");

		FILE *dateFile = fopen(fileName, "w");
		if ( ! dateFile) {
			printf("Error opening dates files\n");
			exit(1);
		}


		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile, "A %f\n", time * AB_bound);
			fprintf(dateFile, "A %f\n", time * AB_bound);
		}


		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile, "B %f\n", time * AB_bound);
			fprintf(dateFile, "B %f\n", time * AB_bound);
		}
		

		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile, "C %f\n", time * CD_bound);
			fprintf(dateFile, "C %f\n", time * CD_bound);
		}


		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile, "D %f\n", time * CD_bound);
			fprintf(dateFile, "D %f\n", time * CD_bound);
		}

		fclose(dateFile);

	}


}
