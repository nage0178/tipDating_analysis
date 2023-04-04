#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <time.h>
#include <assert.h>

int main (int argc, char **argv) {
	/* Tree shape ((A,B)AB,(C,D)CD)ABCD */


	/* Set up random number generator */
	gsl_rng * r;
	const gsl_rng_type * T;
	gsl_rng_env_setup();
	T = gsl_rng_default;
	r = gsl_rng_alloc(T);
 
	gsl_rng_set(r, 1);

	int i, j;
	double AB_max = 0, CD_max = 0 , ABCD_max = 0; 
	double times[5][4];

	FILE *dateFile = fopen("realTimeDates.txt", "w");
	if ( ! dateFile) {
		printf("Error opening dates files\n");
		exit(1);
	}

	FILE *paramFile = fopen("parameters.txt", "w");
	if ( ! paramFile) {
		printf("Error opening parameters files\n");
		exit(1);
	}

	for (j = 0; j < 4; j ++) {
		for (i = 0; i < 5; i++) {
			/* Draw dates */
			times[i][j] = gsl_rng_uniform(r) * 50000;

			if (j < 2 && times[i][j] > AB_max) {
				AB_max = times[i][j];
			} else if (j >1 && times[i][j] > CD_max) {
				CD_max = times[i][j];
			}

			/* Print dates to file */
			if (j == 0 )
				fprintf(dateFile, "A %f\n", times[i][j]);	
			else if (j == 1 )
				fprintf(dateFile, "B %f\n", times[i][j]);	
			else if (j == 2 )
				fprintf(dateFile, "C %f\n", times[i][j]);	
			else if (j == 3 )
				fprintf(dateFile, "D %f\n", times[i][j]);	
		}
	}

	fclose(dateFile);

	ABCD_max = (AB_max > CD_max) ? AB_max : CD_max;

	double mu_alpha = 10, mu_beta = 100000000; 
	double tau_alpha = 10, tau_beta = 100; 
	double theta_alpha = 8, theta_beta = 2000; 
	double tau_root, tau_AB, tau_CD, mu; 

	double ** samples; 
	long int reps = 5000;

	samples = malloc(sizeof(double *) * 11);
	/* Mu, theta_a, theta_b, coal_a, coal_b*/
	for (i = 0; i < 11; i++) {
		samples[i] = malloc(sizeof(double) * reps);
	}

	i = 0;

	fprintf(paramFile, "rep\tmu\ttau_ABCD\ttau_AB\ttau_CD\ttheta_A\ttheta_B\ttheta_C\ttheta_D\ttheta_AB\ttheta_CD\ttheta_ABCD\n");

	while (i < reps) {
		mu = gsl_ran_gamma(r, mu_alpha, 1/mu_beta);

		tau_root = gsl_ran_gamma(r, tau_alpha, 1/tau_beta);
		tau_AB = gsl_ran_flat(r,0, tau_root);
		tau_CD = gsl_ran_flat(r,0, tau_root);

		if ((AB_max * mu > tau_AB) || (CD_max * mu > tau_CD) || 
				(ABCD_max * mu > tau_root)) {
			continue;
		} 
			samples[0][i] = mu;
			samples[1][i] = tau_root;
			samples[2][i] = tau_AB;
			samples[3][i] = tau_CD;

			for (j = 4; j < 11; j ++) {
				samples[j][i] = gsl_ran_gamma(r, theta_alpha, 1/theta_beta);
			}

			fprintf(paramFile, "%d\t", i);
			for (j = 0; j < 11; j++) {
				if (j == 10)
					fprintf(paramFile, "%.12f\n", samples[j][i]);
				else
			
					fprintf(paramFile, "%.12f\t", samples[j][i]);
			}

		i++;
	}

	fclose(paramFile);

}
