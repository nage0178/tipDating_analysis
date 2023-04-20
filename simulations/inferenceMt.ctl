seed = 1

seqfile = simulate.txt
Imapfile = simple.Imap.txt
outfile = out.txt
mcmcfile = mcmc.txt
datefile = realTimeDates.txt

# fixed number of species/populations 
speciesdelimitation = 0

# fixed species tree


species&tree = 4  A B C D
                  10 10 10 10 
		  ((A, B), (C, D));

# phased data for population
phase =   0 0 0 0

# use sequence likelihood
usedata = 1

nloci = 1
clock = 1

# invgamma(a, b) for root tau & Dirichlet(a) for other tau's
tauprior = gamma 10  1000

thetaprior = gamma 2.5 1000 # gamma(a, b) for theta (estimate theta)

locusrate = 3 10 1000000000

# finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
finetune =  1: 5 0.001 0.001  0.001 0.3 0.33 1.0  

# MCMC samples, locusrate, heredityscalars, Genetrees
print = 1 0 0 0   * 
burnin = 160000
sampfreq = 4
nsample = 400000
