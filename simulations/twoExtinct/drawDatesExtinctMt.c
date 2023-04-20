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
 
	gsl_rng_set(r, 1);

	int reps = 20, ind = 10, ind2 =20;
	double time;
	char fileName10[50];
	char fileName50[50];
	char fileName10_20[50];
	char fileName50_20[50];
	char repString[5];
	char pop[3]="BD";


	for (int j = 1; j <= reps; j ++) {
		sprintf(repString,"%d", j);

		strcpy(fileName10, "mtdates_10_10_");
		strcat(fileName10, repString);
		strcat(fileName10, ".txt");

		strcpy(fileName50, "mtdates_50_10_");
		strcat(fileName50, repString);
		strcat(fileName50, ".txt");

		strcpy(fileName10_20, "mtdates_10_20_");
		strcat(fileName10_20, repString);
		strcat(fileName10_20, ".txt");

		strcpy(fileName50_20, "mtdates_50_20_");
		strcat(fileName50_20, repString);
		strcat(fileName50_20, ".txt");

		FILE *dateFile10 = fopen(fileName10, "w");
		if ( ! dateFile10) {
			printf("Error opening dates files\n");
			exit(1);
		}

		FILE *dateFile50 = fopen(fileName50, "w");
		if ( ! dateFile50) {
			printf("Error opening dates files\n");
			exit(1);
		}

		FILE *dateFile10_20 = fopen(fileName10_20, "w");
		if ( ! dateFile10_20) {
			printf("Error opening dates files\n");
			exit(1);
		}

		FILE *dateFile50_20 = fopen(fileName50_20, "w");
		if ( ! dateFile50_20) {
			printf("Error opening dates files\n");
			exit(1);
		}
		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile10, "A %f\n", time * 5000 + 5000);
			fprintf(dateFile50, "A %f\n", time * 45000 + 5000);

			fprintf(dateFile10_20, "A %f\n", time * 5000 + 5000);
			fprintf(dateFile50_20, "A %f\n", time * 45000 + 5000);
		}

		for (int i = ind ; i < ind2; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);

			fprintf(dateFile10_20, "A %f\n", time * 5000 + 5000);
			fprintf(dateFile50_20, "A %f\n", time * 45000 + 5000);
		}

		for (int i = 0; i < ind; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);
			fprintf(dateFile10, "C %f\n", time * 5000 + 5000);
			fprintf(dateFile50, "C %f\n", time * 45000 + 5000);

			fprintf(dateFile10_20, "C %f\n", time * 5000 + 5000);
			fprintf(dateFile50_20, "C %f\n", time * 45000 + 5000);
		}

		for (int i = ind ; i < ind2; i++) {
			/* Draw dates */
			time = gsl_rng_uniform(r);

			fprintf(dateFile10_20, "C %f\n", time * 5000 + 5000);
			fprintf(dateFile50_20, "C %f\n", time * 45000 + 5000);
		}

		for (int k = 0; k < 2; k++) {
			for (int i = 0; i < ind ; i++) {
				/* Dates for contemporary sequences*/
				time = gsl_rng_uniform(r);
				fprintf(dateFile10, "%c %d\n", pop[k], 0);
				fprintf(dateFile50, "%c %d\n", pop[k], 0);

				fprintf(dateFile10_20, "%c %d\n", pop[k], 0);
				fprintf(dateFile50_20, "%c %d\n", pop[k], 0);
			}
		}

		fclose(dateFile10);
		fclose(dateFile50);

		fclose(dateFile10_20);
		fclose(dateFile50_20);
	}



}
