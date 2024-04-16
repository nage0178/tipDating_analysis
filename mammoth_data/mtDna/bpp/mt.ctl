seed = 1

seqfile = ../mtDna.fa
Imapfile = ../map_species.txt
outfile = out.txt
mcmcfile = mcmc.txt
datefile = ../sampleDates.txt

# fixed number of species/populations 
speciesdelimitation = 0

# fixed species tree
speciestree = 0

species&tree = 4  Elephas_maximus Mammuthus_primigenius Loxodonta_africana Loxodonta_cyclotis
                  5 69 6 14  
                  ((Elephas_maximus, Mammuthus_primigenius), (Loxodonta_africana, Loxodonta_cyclotis));

# unphased data for all 4 populations
phase =   0  0  0  0

model = HKY
# use sequence likelihood
usedata = 1
alphaprior = 1 1 4

nloci = 1

# do not remove sites with ambiguity data
cleandata = 0
locusrate = 3 10 1000000000

thetaprior = gamma 2 200 # gamma(a, b) for theta (estimate theta)
tauprior = gamma 45 1000 # gamma(a, b) for root tau & Dirichlet(a) for other tau's

# finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
finetune =  1: 5 0.001 0.001  0.001 0.3 0.33 1.0  

# MCMC samples, locusrate, heredityscalars, Genetrees
*print = 1 0 0 0   * 
print = 1 0 0 0 1
burnin = 160000
sampfreq = 4
nsample = 400000
