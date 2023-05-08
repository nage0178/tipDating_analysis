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
 
	gsl_rng_set(r, 15);

	int reps = 20, ind = 80;
	double time;
	char fileName10[50];
	char fileName50[50];
	char repString[5];


	for (int j = 1; j <= reps; j ++) {
		sprintf(repString,"%d", j);

		strcpy(fileName10, "mtdates_10_100_");
		strcat(fileName10, repString);
		strcat(fileName10, ".txt");

		strcpy(fileName50, "mtdates_50_100_");
		strcat(fileName50, repString);
		strcat(fileName50, ".txt");


		FILE *dateFile10 = fopen(fileName10, "a+");
		if ( ! dateFile10) {
			printf("Error opening dates files\n");
			exit(1);
		}

		FILE *dateFile50 = fopen(fileName50, "a+");
		if ( ! dateFile50) {
			printf("Error opening dates files\n");
			exit(1);
		}

		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile10, "A %f\n", time * 5000 + 5000);
			fprintf(dateFile50, "A %f\n", time * 45000 + 5000);

		}


		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile10, "C %f\n", time * 5000 + 5000);
			fprintf(dateFile50, "C %f\n", time * 45000 + 5000);

		}


		fclose(dateFile10);
		fclose(dateFile50);

	}



}
