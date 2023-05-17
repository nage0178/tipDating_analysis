library(ggplot2)
library( dplyr )
library( tidyr )

nuclear3 <- read.csv("~/tipDating_analysis/simulations/nuclear.csv")
nuclear3D <- read.csv("~/tipDating_analysis/simulations/noDates/nuclear.csv")

nuclear6 <- read.csv("~/tipDating_analysis/simulations/6samples/nuclear_clean.csv")
nuclear6D <- read.csv("~/tipDating_analysis/simulations/6samples/noDates/nuclear_clean.csv")

nuclear <- rbind(nuclear3D, nuclear6D)
nuclear <- cbind(nuclear, c(rep("3", dim(nuclear3D)[1]), rep("6", dim(nuclear6D)[1])))

nuclear <- rbind(nuclear3, nuclear6)
nuclear <- cbind(nuclear, c(rep("3", dim(nuclear3)[1]), rep("6", dim(nuclear6)[1])))

colnames(nuclear)[dim(nuclear)[2]] <- "samples"

df1 <- nuclear %>%  arrange(extinct)  %>% arrange(samples) %>% arrange(dates) %>% arrange(theta)
df1<- cbind(c(1:(dim(df1)[1])), df1)
colnames(df1)[1] <- "run"

# 
# oneExtinct <- which(nuclear$extinct == "oneExtinct")
#  ggplot(nuclear, aes(y = M_tau_5ABCD, x=factor(run),  color = theta)) +geom_point(position = "dodge") + 
#    geom_errorbar(aes (ymin=L_tau_5ABCD, ymax =H_tau_5ABCD))+ 
#    facet_grid(extinct~factor(loci))#+ geom_boxplot() 
#  

df1$theta <- as.factor(df1$theta)
df1$extinct <- as.factor(df1$extinct)
df1$dates <- as.factor(df1$dates)
df1$samples <- as.factor(df1$samples)

 ggplot(df1, aes(y = M_tau_5ABCD, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_tau_5ABCD, ymax =H_tau_5ABCD))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=.01)
 
 
 ggplot(df1, aes(y = M_tau_6AB, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_tau_6AB, ymax =H_tau_6AB))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=.007)
 
 ggplot(df1, aes(y = M_tau_7CD, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_tau_7CD, ymax =H_tau_7CD))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=.004)
 
 
 ggplot(df1, aes(y = M_mu_bar, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_mu_bar, ymax =H_mu_bar))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=10^(-9))
 
 ggplot(df1, aes(y = M_theta_5ABCD, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_theta_5ABCD, ymax =H_theta_5ABCD))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("") #+ geom_hline(yintercept=.00)
 ggplot(df1, aes(y = M_theta_1A, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_theta_1A, ymax =H_theta_1A))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("") + geom_hline(yintercept=.0001)+ geom_hline(yintercept=.001)
 
 ggplot(df1, aes(y = M_theta_3C, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_theta_3C, ymax =H_theta_3C))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("") + geom_hline(yintercept=.0001)  
 
 ggplot(df1, aes(y = M_r_tau_5ABCD, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_r_tau_5ABCD, ymax =H_r_tau_5ABCD))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=10^7)
 
 ggplot(df1, aes(y = M_r_tau_6AB, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_r_tau_6AB, ymax =H_r_tau_6AB))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=7 * 10^6)
 
 ggplot(df1, aes(y = M_r_tau_7CD, x=factor(run),  color = theta:dates:samples:extinct)) +geom_point() + 
   geom_errorbar(aes (ymin=L_r_tau_7CD, ymax =H_r_tau_7CD))+ 
   facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()) +
   xlab ("")+ geom_hline(yintercept=4 * 10^6)
 
 
mtD <- read.csv("~/tipDating_analysis/simulations/mt.csv")
mtnD <- read.csv("~/tipDating_analysis/simulations/noDates/mt.csv")

mt <- rbind(mtD, mtnD)
mt <- cbind(mt, c(rep("correct", dim(mtD)[1]), rep("incorrect", dim(mtnD)[1])))
colnames(mt)[dim(mt)[2]] <- "model"

#mt <- mt[1:dim(mtD)[1],]
mt$theta <- as.factor(mt$theta)
mt$dates<- as.factor(mt$dates)
mt$extinct <- as.factor(mt$extinct)
mt$seqs <- as.factor(mt$seqs)
mt$model <- as.factor(mt$model)


mt <- mt %>% arrange(model) %>% arrange(seqs)  %>% arrange(dates) %>% arrange(extinct)
mt<- cbind(c(1:dim(mt)[1]), mt)
colnames(mt)[1] <- "run"

ggplot(mt, aes(y = M_tau_5ABCD, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_tau_5ABCD, ymax =H_tau_5ABCD))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("")+ geom_hline(yintercept=.1)

ggplot(mt, aes(y = M_tau_6AB, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_tau_6AB, ymax =H_tau_6AB))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("")+ geom_hline(yintercept=.07)

ggplot(mt, aes(y = M_r_tau_6AB, x=factor(run),  color = extinct:dates:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_r_tau_6AB, ymax =H_r_tau_6AB))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("")+ geom_hline(yintercept=.07)

ggplot(mt, aes(y = M_theta_5ABCD, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_theta_5ABCD, ymax =H_theta_5ABCD))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("")
ggplot(mt, aes(y = M_theta_1A, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_theta_1A, ymax =H_theta_1A))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("")

ggplot(mt, aes(y = M_mu_bar, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_mu_bar, ymax =H_mu_bar))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=10^-8)

ggplot(mt, aes(y = M_theta_1A, x=factor(run),  color = extinct:dates:seqs:model)) +geom_point() + 
  geom_errorbar(aes (ymin=L_theta_1A, ymax =H_theta_1A))+ 
  facet_grid(factor(theta)~factor(seqs), scales = "free", space = "free") +
  theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=.0025)  + geom_hline(yintercept=.00025)  
 
pop <- read.csv("~/tipDating_analysis/simulations/popDiverg/pop.csv")
pop <- read.csv("~/tipDating_analysis/simulations/noDates/popDiverge/pop.csv")

df2 <- pop %>% arrange(theta)
df2 <- cbind(c(1:dim(df2)[1]), df2)
colnames(df2)[1] <- "run"
df2$theta <- as.factor(df2$theta)
ggplot(df2, aes(y = M_tau_5ABCD, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_tau_5ABCD, ymax =H_tau_5ABCD))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=10^(-9) *20000)

ggplot(df2, aes(y = M_tau_6AB, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_tau_6AB, ymax =H_tau_6AB))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=10^(-9) *5000) 

ggplot(df2, aes(y = M_tau_7CD, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_tau_7CD, ymax =H_tau_7CD))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=10^(-9) *13000)

ggplot(df2, aes(y = M_theta_5ABCD, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_theta_5ABCD, ymax =H_theta_5ABCD))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=0.001)+ geom_hline(yintercept=0.0001)

ggplot(df2, aes(y = M_theta_1A, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_theta_1A, ymax =H_theta_1A))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=0.001)+ geom_hline(yintercept=0.0001)

ggplot(df2, aes(y = M_mu_bar, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_mu_bar, ymax =H_mu_bar))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=10^(-9))

ggplot(df2, aes(y = M_r_tau_5ABCD, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_r_tau_5ABCD, ymax =H_r_tau_5ABCD))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=20000)



ggplot(df2, aes(y = M_r_tau_6AB, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_r_tau_6AB, ymax =H_r_tau_6AB))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=5000) 

ggplot(df2, aes(y = M_r_tau_7CD, x=factor(run),  color = theta)) +geom_point() + 
  geom_errorbar(aes (ymin=L_r_tau_7CD, ymax =H_r_tau_7CD))+ 
  facet_grid(~factor(loci), scales = "free", space = "free") + theme_classic() + theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()) +
  xlab ("") + geom_hline(yintercept=13000)

