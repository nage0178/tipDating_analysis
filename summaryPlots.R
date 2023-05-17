library(ggplot2)
library( dplyr )
library( tidyr )
library(ggpubr)

nuclear3 <- read.csv("~/tipDating_analysis/simulations/nuclear.csv")
nuclear6 <- read.csv("~/tipDating_analysis/simulations/6samples/nuclear.csv")
nuclear6Sub <- nuclear6[as.logical((nuclear6$theta == 0.0001) * (nuclear6$dates == 50000) * (nuclear6$extinct == "twoExtinct")), ]

byLociTauABCD <- aggregate(nuclear6Sub$M_r_tau_5ABCD, list(nuclear6Sub$loci), FUN=mean)
byLociTauABCD <- cbind(byLociTauABCD, aggregate(nuclear6Sub$H_r_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABCD <- cbind(byLociTauABCD, "tau_ABCD")
byLociTauABCD <- cbind(byLociTauABCD, 10 ^7)


byLociTauAB <- aggregate(nuclear6Sub$M_r_tau_6AB, list(nuclear6Sub$loci), FUN=mean)
byLociTauAB <- cbind(byLociTauAB, aggregate(nuclear6Sub$H_r_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauAB <- cbind(byLociTauAB, "tau_AB")
byLociTauAB <- cbind(byLociTauAB, 7 * 10 ^ 6)


byLociTauCD <- aggregate(nuclear6Sub$M_r_tau_7CD, list(nuclear6Sub$loci), FUN=mean)
byLociTauCD <- cbind(byLociTauCD, aggregate(nuclear6Sub$H_r_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauCD<- cbind(byLociTauCD, "tau_CD")
byLociTauCD<- cbind(byLociTauCD, 4 * 10 ^ 6 )


byLociMu <- aggregate(nuclear6Sub$M_mu_bar, list(nuclear6Sub$loci), FUN=mean)
byLociMu <- cbind(byLociMu, aggregate(nuclear6Sub$H_mu_bar , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_mu_bar , list(nuclear6Sub$loci), FUN=mean)[,2])
colnames(byLociMu) <- c("loci", "mean", "H_HPD", "L_HPD")

colnames(byLociTauAB) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
byLoci <- rbind(byLociTauAB, byLociTauCD, byLociTauABCD)


byLociTauABCDE <- aggregate(nuclear6Sub$M_tau_5ABCD, list(nuclear6Sub$loci), FUN=mean)
byLociTauABCDE <- cbind(byLociTauABCDE, aggregate(nuclear6Sub$H_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABCDE <- cbind(byLociTauABCDE, "tau_ABCD")
byLociTauABCDE <- cbind(byLociTauABCDE, 10^7* 10 ^-9)


byLociTauABE <- aggregate(nuclear6Sub$M_tau_6AB, list(nuclear6Sub$loci), FUN=mean)
byLociTauABE <- cbind(byLociTauABE, aggregate(nuclear6Sub$H_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABE <- cbind(byLociTauABE, "tau_AB")
byLociTauABE <- cbind(byLociTauABE, 7 * 10 ^6* 10 ^-9)


byLociTauCDE <- aggregate(nuclear6Sub$M_tau_7CD, list(nuclear6Sub$loci), FUN=mean)
byLociTauCDE <- cbind(byLociTauCDE, aggregate(nuclear6Sub$H_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauCDE<- cbind(byLociTauCDE, "tau_CD")
byLociTauCDE<- cbind(byLociTauCDE, 4 * 10 ^6* 10 ^-9)

colnames(byLociTauABE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCDE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCDE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
byLociE <- rbind(byLociTauABE, byLociTauCDE, byLociTauABCDE)

# Story: Inferences of ages in real times improves with increasing numbers of loci, largely driven by the improvement in tau_E at lower number of loci, 
# but most by mu as the number of loci continues increasing
rTauLeg <- ggplot(byLoci, aes(y = mean, x = loci, color = node))  + geom_point() +
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic() + ylab(expression(paste(tau^Delta))) +  xlab("number of loci")  + theme(legend.position = "bottom", legend.title = element_blank())+ 
  scale_color_discrete(breaks = c("tau_ABCD", "tau_AB", "tau_CD"), labels = c(expression(tau[ABCD]), expression(tau[AB]), expression(tau[CD])))

rTau <- ggplot(byLoci, aes(y = mean, x = loci, color = node))  + geom_point()  + geom_line(aes(y = truth), lty= 2) + 
geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic() +  ylab(expression(paste( tau^Delta))) + xlab("") + theme(legend.position = "none")        

mu <- ggplot(byLociMu, aes(y = mean, x = loci))  + geom_point() +geom_line(aes(y = 10^-9), lty= 2) + 
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD))+ theme_classic() + ylab(expression(paste( mu))) + xlab("")     + theme(legend.position = "none")

tau <- ggplot(byLociE, aes(y = mean, x = loci, color = node))  + geom_point() +geom_line(aes(y = truth), lty= 2) + 
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD))+ theme_classic() + ylab(expression(paste( tau))) + xlab("")+ theme(legend.position = "none")

legend1 <- cowplot::get_legend(rTauLeg)
leg1 <- as_ggplot(legend1)


nuclear6D <- read.csv("~/tipDating_analysis/simulations/6samples/noDates/nuclear.csv")
nuclear6DSub <- nuclear6D[as.logical((nuclear6D$theta == 0.0001) * (nuclear6D$dates == 50000) * (nuclear6D$extinct == "twoExtinct")), ]
# taus are poorly estimated because there is no information in mu 
#nuclear6DSub$loci <- as.factor(nuclear6Sub$loci)

byLociTauABCD <- aggregate(nuclear6DSub$M_r_tau_5ABCD, list(nuclear6DSub$loci), FUN=mean)
byLociTauABCD <- cbind(byLociTauABCD, aggregate(nuclear6DSub$H_r_tau_5ABCD , list(nuclear6DSub$loci), FUN=mean)[,2], aggregate(nuclear6DSub$L_r_tau_5ABCD , list(nuclear6DSub$loci), FUN=mean)[,2])
byLociTauABCD <- cbind(byLociTauABCD, "tau_ABCD")
byLociTauABCD <- cbind(byLociTauABCD, 10^7)


byLociTauAB <- aggregate(nuclear6DSub$M_r_tau_6AB, list(nuclear6DSub$loci), FUN=mean)
byLociTauAB <- cbind(byLociTauAB, aggregate(nuclear6DSub$H_r_tau_6AB , list(nuclear6DSub$loci), FUN=mean)[,2], aggregate(nuclear6DSub$L_r_tau_6AB , list(nuclear6DSub$loci), FUN=mean)[,2])
byLociTauAB <- cbind(byLociTauAB, "tau_AB")
byLociTauAB <- cbind(byLociTauAB, 7 * 10 ^6)


byLociTauCD <- aggregate(nuclear6DSub$M_r_tau_7CD, list(nuclear6DSub$loci), FUN=mean)
byLociTauCD <- cbind(byLociTauCD, aggregate(nuclear6DSub$H_r_tau_7CD , list(nuclear6DSub$loci), FUN=mean)[,2], aggregate(nuclear6DSub$L_r_tau_7CD , list(nuclear6DSub$loci), FUN=mean)[,2])
byLociTauCD<- cbind(byLociTauCD, "tau_CD")
byLociTauCD<- cbind(byLociTauCD, 4 * 10 ^ 6)



colnames(byLociTauAB) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
byLoci <- rbind(byLociTauAB, byLociTauCD, byLociTauABCD)

tauNoDates <- ggplot(byLoci, aes(y = mean, x = loci, color = node))  + geom_point() +geom_line(aes(y = truth), lty= 2) +
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic() +  ylab(expression(paste( tau^Delta))) + xlab("number of loci")  + theme(legend.position = "none")   


figure <- ggarrange(rTau, tau, mu, tauNoDates, leg1, labels = c("a", "b", "c", "d", ""),
                    nrow =5, ncol = 1, heights = c(2, 2, 2, 2, .5))

pdf("~/tipDating/figs/realAge.pdf", width = 4, height = 9)
figure
dev.off()

#####
nuclear6Sub <- nuclear6[as.logical((nuclear6$theta == 0.001) * (nuclear6$dates == 50000) * (nuclear6$extinct == "twoExtinct")), ]

byLociTauABCD <- aggregate(nuclear6Sub$M_r_tau_5ABCD, list(nuclear6Sub$loci), FUN=mean)
byLociTauABCD <- cbind(byLociTauABCD, aggregate(nuclear6Sub$H_r_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABCD <- cbind(byLociTauABCD, "tau_ABCD")
byLociTauABCD <- cbind(byLociTauABCD, 10 ^7)


byLociTauAB <- aggregate(nuclear6Sub$M_r_tau_6AB, list(nuclear6Sub$loci), FUN=mean)
byLociTauAB <- cbind(byLociTauAB, aggregate(nuclear6Sub$H_r_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauAB <- cbind(byLociTauAB, "tau_AB")
byLociTauAB <- cbind(byLociTauAB, 7 * 10 ^ 6)


byLociTauCD <- aggregate(nuclear6Sub$M_r_tau_7CD, list(nuclear6Sub$loci), FUN=mean)
byLociTauCD <- cbind(byLociTauCD, aggregate(nuclear6Sub$H_r_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_r_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauCD<- cbind(byLociTauCD, "tau_CD")
byLociTauCD<- cbind(byLociTauCD, 4 * 10 ^ 6 )


byLociMu <- aggregate(nuclear6Sub$M_mu_bar, list(nuclear6Sub$loci), FUN=mean)
byLociMu <- cbind(byLociMu, aggregate(nuclear6Sub$H_mu_bar , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_mu_bar , list(nuclear6Sub$loci), FUN=mean)[,2])
colnames(byLociMu) <- c("loci", "mean", "H_HPD", "L_HPD")

colnames(byLociTauAB) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCD) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
byLoci <- rbind(byLociTauAB, byLociTauCD, byLociTauABCD)


byLociTauABCDE <- aggregate(nuclear6Sub$M_tau_5ABCD, list(nuclear6Sub$loci), FUN=mean)
byLociTauABCDE <- cbind(byLociTauABCDE, aggregate(nuclear6Sub$H_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_5ABCD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABCDE <- cbind(byLociTauABCDE, "tau_ABCD")
byLociTauABCDE <- cbind(byLociTauABCDE, 10^7* 10 ^-9)


byLociTauABE <- aggregate(nuclear6Sub$M_tau_6AB, list(nuclear6Sub$loci), FUN=mean)
byLociTauABE <- cbind(byLociTauABE, aggregate(nuclear6Sub$H_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_6AB , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauABE <- cbind(byLociTauABE, "tau_AB")
byLociTauABE <- cbind(byLociTauABE, 7 * 10 ^6* 10 ^-9)


byLociTauCDE <- aggregate(nuclear6Sub$M_tau_7CD, list(nuclear6Sub$loci), FUN=mean)
byLociTauCDE <- cbind(byLociTauCDE, aggregate(nuclear6Sub$H_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2], aggregate(nuclear6Sub$L_tau_7CD , list(nuclear6Sub$loci), FUN=mean)[,2])
byLociTauCDE<- cbind(byLociTauCDE, "tau_CD")
byLociTauCDE<- cbind(byLociTauCDE, 4 * 10 ^6* 10 ^-9)

colnames(byLociTauABE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCDE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCDE) <- c("loci", "mean", "H_HPD", "L_HPD", "node", "truth")
byLociE <- rbind(byLociTauABE, byLociTauCDE, byLociTauABCDE)

# Story: Inferences of ages in real times improves with increasing numbers of loci, largely driven by the improvement in tau_E at lower number of loci, 
# but most by mu as the number of loci continues increasing
rTauLeg <- ggplot(byLoci, aes(y = mean, x = loci, color = node))  + geom_point() +
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic() + ylab(expression(paste(tau^Delta))) +  xlab("number of loci")  + theme(legend.position = "bottom", legend.title = element_blank())+ 
  scale_color_discrete(breaks = c("tau_ABCD", "tau_AB", "tau_CD"), labels = c(expression(tau[ABCD]), expression(tau[AB]), expression(tau[CD])))

rTau <- ggplot(byLoci, aes(y = mean, x = loci, color = node))  + geom_point()  + geom_line(aes(y = truth), lty= 2) + 
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic() +  ylab(expression(paste( tau^Delta))) + xlab("") + theme(legend.position = "none")        

mu <- ggplot(byLociMu, aes(y = mean, x = loci))  + geom_point() +geom_line(aes(y = 10^-9), lty= 2) + 
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD))+ theme_classic() + ylab(expression(paste( mu))) + xlab("")     + theme(legend.position = "none")

tau <- ggplot(byLociE, aes(y = mean, x = loci, color = node))  + geom_point() +geom_line(aes(y = truth), lty= 2) + 
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD))+ theme_classic() + ylab(expression(paste( tau))) + xlab("")+ theme(legend.position = "none")

legend1 <- cowplot::get_legend(rTauLeg)
leg1 <- as_ggplot(legend1)


figure <- ggarrange(rTau, tau, mu,  leg1, labels = c("a", "b", "c", ""),
                    nrow =4, ncol = 1, heights = c(2, 2, 2, .5))

pdf("~/tipDating/figs/realAge_theta_sup.pdf", width = 4, height = 7)
figure
dev.off()
#
# Story: Larger dates, with more samples, and more extinct species improves the estimates of mu 

nuclear <- rbind(nuclear3, nuclear6)
nuclear <- cbind(nuclear, c(rep("3", dim(nuclear3)[1]), rep("6", dim(nuclear6)[1])))
colnames(nuclear)[dim(nuclear)[2]] <- "samples"
nuclearMu<- nuclear[as.logical((nuclear$theta == 0.0001) * (nuclear$loci == 2000)), ]
nuclearMuGroup <- aggregate(nuclearMu$M_mu_bar, list(nuclearMu$sample, nuclearMu$extinct, nuclearMu$dates), FUN=mean)
nuclearMuGroup <- cbind (nuclearMuGroup, aggregate(nuclearMu$H_mu_bar, list(nuclearMu$sample, nuclearMu$extinct, nuclearMu$dates), FUN=mean)[, 4], 
                         aggregate(nuclearMu$L_mu_bar, list(nuclearMu$sample, nuclearMu$extinct, nuclearMu$dates), FUN=mean)[, 4])

colnames(nuclearMuGroup) <- c("samples", "extinct", "dates", "means", "H_HPD", "L_HPD")
#nuclearMuGroup$samples <- as.factor(nuclearMuGroup$samples)
df1 <- nuclearMuGroup %>%  arrange(extinct)  %>% arrange(samples) %>% arrange(dates) 
df1<- cbind(df1, c(1:(dim(df1)[1])))
colnames(df1)[7] <- "group"
nuclearMuGroup <- df1

#nuclearMuGroup$group <- cbind(nuclearMuGroup, 1:8)
nuclearMuGroup$dates <- as.factor(nuclearMuGroup$dates)
nuclearMuGroup$samples <- as.factor(nuclearMuGroup$samples)
nuclearMuGroup$extinct <- as.factor(nuclearMuGroup$extinct)

mu_improve <- ggplot(nuclearMuGroup, aes(y = means, x = group, color = extinct, lty = dates, pch = samples))  + geom_point(stat='identity', size = 3) +
 geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD )) + theme_classic() +  geom_line(aes(y = 10^-9), lty= 2, col = 1) + 
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) + ylab(expression(paste( mu))) +scale_color_discrete(labels = c("A", "A + C")) + 
  scale_linetype_discrete(name = "upper bound\non ages") +scale_shape_discrete(name = "number of\nsamples")

pdf("~/tipDating/figs/mu.pdf", width = 5, height = 4)
mu_improve
dev.off()
###
# Without dates, theta is biased in the extinct species, especially as data increases
nuclear6D <- read.csv("~/tipDating_analysis/simulations/6samples/noDates/nuclear.csv")
nuclearComb <- rbind(nuclear6D, nuclear6)
nuclearComb <- cbind(nuclearComb, c(rep("zero", dim(nuclear6D)[1]), rep("true", dim(nuclear6)[1])))
colnames(nuclearComb)[dim(nuclearComb)[2]] <- "model"
nuclearComb$model <- as.factor(nuclearComb$model)
#nuclear6AllSub <- nuclearComb[as.logical((nuclearComb$theta == 0.0001) * (nuclearComb$dates == 50000) * (nuclearComb$extinct == "twoExtinct")), ]
nuclear6AllSub <- nuclearComb[as.logical((nuclearComb$theta == 0.0001) * (nuclearComb$dates == 50000) ), ]


byLociThetaA <- aggregate(nuclear6AllSub$M_theta_1A, list(nuclear6AllSub$loci, nuclear6AllSub$model), FUN=mean)
byLociThetaA <- cbind(byLociThetaA, aggregate(nuclear6AllSub$H_theta_1A, list(nuclear6AllSub$loci,  nuclear6AllSub$model), FUN=mean)[,3], aggregate(nuclear6AllSub$L_theta_1A , list(nuclear6AllSub$loci,  nuclear6AllSub$model), FUN=mean)[,3])
colnames(byLociThetaA) <- c( "loci", "model", "means", "H_HPD", "L_HPD")

theta <- ggplot(byLociThetaA, aes(y = means, x = loci)) + geom_point() + facet_grid(~model)+
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD )) + theme_classic() + geom_hline(yintercept=.0001, lty = 2) + ylab(expression(paste(theta[A])))

pdf("~/tipDating/figs/theta.pdf", width = 6, height = 4)
theta
dev.off()

######
pop <- read.csv("~/tipDating_analysis/simulations/popDiverg/pop.csv")
popNoD <- read.csv("~/tipDating_analysis/simulations/noDates/popDiverge/pop.csv")
allPop <- rbind(pop, popNoD)

allPop <- cbind(allPop, c(rep("true", dim(pop)[1]), rep("zero", dim(popNoD)[1])))
colnames(allPop)[dim(allPop)[2]] <- "model"
subPop <- allPop[allPop$theta == 0.0001,]

byLociTauABCD <- aggregate(subPop$M_r_tau_5ABCD, list(subPop$loci, subPop$model), FUN=mean)
byLociTauABCD <- cbind(byLociTauABCD, aggregate(subPop$H_r_tau_5ABCD , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_r_tau_5ABCD , list(subPop$loci,subPop$model), FUN=mean)[,3])
byLociTauABCD <- cbind(byLociTauABCD, "tau_ABCD")
byLociTauABCD <- cbind(byLociTauABCD, 20000)

byLociTauAB <- aggregate(subPop$M_r_tau_6AB, list(subPop$loci, subPop$model), FUN=mean)
byLociTauAB <- cbind(byLociTauAB, aggregate(subPop$H_r_tau_6AB , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_r_tau_6AB , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociTauAB <- cbind(byLociTauAB, "tau_AB")
byLociTauAB <- cbind(byLociTauAB, 7000)


byLociTauCD <- aggregate(subPop$M_r_tau_7CD, list(subPop$loci, subPop$model), FUN=mean)
byLociTauCD <- cbind(byLociTauCD, aggregate(subPop$H_r_tau_7CD , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_r_tau_7CD , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociTauCD<- cbind(byLociTauCD, "tau_CD")
byLociTauCD<- cbind(byLociTauCD, 13000)

colnames(byLociTauAB) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauCD) <- c("loci",  "model", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byLociTauABCD) <- c("loci",  "model", "mean", "H_HPD", "L_HPD", "node", "truth")
byLoci <- rbind(byLociTauAB, byLociTauCD, byLociTauABCD)

popPlot <- byLoci %>% 
  mutate(node = factor(node, levels = c("tau_ABCD","tau_CD", "tau_AB"), labels = c(expression(tau[ABCD]^Delta), expression(tau[CD]^Delta), expression(tau[AB]^Delta)) )) %>%
  ggplot( aes(y = mean, x = loci))  + geom_point() + facet_grid(factor(node)~factor(model), labeller = label_parsed)+
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic()  +geom_line(aes(y = truth), lty= 2) +ylab("node age") + xlab ("number of loci")

pdf("~/tipDating/figs/popTau.pdf", width = 5, height = 5)
popPlot
dev.off()

byLociThetaA <- aggregate(subPop$M_theta_1A, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaA <- cbind(byLociThetaA, aggregate(subPop$H_theta_1A , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_1A , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaA<- cbind(byLociThetaA, "theta_A")

byLociThetaB <- aggregate(subPop$M_theta_2B, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaB <- cbind(byLociThetaB, aggregate(subPop$H_theta_2B , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_2B , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaB<- cbind(byLociThetaB, "theta_B")

byLociThetaC <- aggregate(subPop$M_theta_3C, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaC <- cbind(byLociThetaC, aggregate(subPop$H_theta_3C , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_3C , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaC<- cbind(byLociThetaC, "theta_C")

byLociThetaD <- aggregate(subPop$M_theta_4D, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaD <- cbind(byLociThetaD, aggregate(subPop$H_theta_4D , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_4D , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaD <- cbind(byLociThetaD, "theta_D")

byLociThetaAB <- aggregate(subPop$M_theta_6AB, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaAB <- cbind(byLociThetaAB, aggregate(subPop$H_theta_6AB , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_6AB , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaAB <- cbind(byLociThetaAB, "theta_AB")

byLociThetaCD <- aggregate(subPop$M_theta_7CD, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaCD <- cbind(byLociThetaCD, aggregate(subPop$H_theta_7CD , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_7CD , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaCD <- cbind(byLociThetaCD, "theta_CD")

byLociThetaABCD <- aggregate(subPop$M_theta_5ABCD, list(subPop$loci, subPop$model), FUN=mean)
byLociThetaABCD <- cbind(byLociThetaABCD, aggregate(subPop$H_theta_5ABCD , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_theta_5ABCD , list(subPop$loci, subPop$model), FUN=mean)[,3])
byLociThetaABCD<- cbind(byLociThetaABCD, "theta_ABCD")

colnames(byLociThetaA) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaB) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaC) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaD) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaAB) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaCD) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")
colnames(byLociThetaABCD) <- c("loci", "model", "mean", "H_HPD", "L_HPD", "pop")

byLociTheta <- rbind(byLociThetaA, byLociThetaB, byLociThetaC, byLociThetaD, byLociThetaAB,
                     byLociThetaCD, byLociThetaABCD)
popPlotTheta <- byLociTheta %>% 
  mutate(node = factor(pop, levels = c("theta_ABCD","theta_CD", "theta_AB", "theta_A", "theta_B", "theta_C", "theta_D"), 
                       labels = c(expression(theta[ABCD]), expression(theta[CD]), expression(theta[AB]), expression(theta[A]),expression(theta[B]),expression(theta[C]),expression(theta[D]) ) )) %>%
  ggplot( aes(y = mean, x = loci))  + geom_point() + facet_grid(factor(node)~factor(model), labeller = label_parsed)+
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic()  +geom_line(y = .0001, lty= 2) +ylab(expression(theta)) + xlab ("number of loci")

pdf("~/tipDating/figs/popTheta.pdf", width = 5, height = 5)
popPlotTheta
dev.off()

byLociMu <- aggregate(subPop$M_mu_bar, list(subPop$loci, subPop$model), FUN=mean)
byLociMu <- cbind(byLociMu, aggregate(subPop$H_mu_bar , list(subPop$loci, subPop$model), FUN=mean)[,3], aggregate(subPop$L_mu_bar , list(subPop$loci, subPop$model), FUN=mean)[,3])
colnames(byLociMu) <- c("loci", "model", "mean", "H_HPD", "L_HPD")


muPop <- ggplot(byLociMu, aes(y = mean, x = loci))  + geom_point() + facet_wrap(~model) +
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD))+ theme_classic() + ylab(expression(paste( mu))) + xlab("") + xlab("loci") + geom_line(y= 10^-9, lty = 2)

pdf("~/tipDating/figs/popMu.pdf", width = 5, height = 5)
muPop
dev.off()


######
mtD <- read.csv("~/tipDating_analysis/simulations/mt.csv")
mtnD <- read.csv("~/tipDating_analysis/simulations/noDates/mt.csv")
allMt <- rbind(mtD, mtnD)

allMt <- cbind(allMt, c(rep("true", dim(mtD)[1]), rep("zero", dim(mtnD)[1])))
colnames(allMt)[dim(allMt)[2]] <- "model"
subMt <- allMt[as.logical((allMt$theta == 0.0001) * (allMt$extinct == "twoExtinct") * (allMt$dates == 50000)),]


byseqsTauABCD <- aggregate(subMt$M_r_tau_5ABCD, list(subMt$seqs, subMt$model), FUN=mean)
byseqsTauABCD <- cbind(byseqsTauABCD, aggregate(subMt$H_r_tau_5ABCD , list(subMt$seqs, subMt$model), FUN=mean)[,3], aggregate(subMt$L_r_tau_5ABCD , list(subMt$seqs,subMt$model), FUN=mean)[,3])
byseqsTauABCD <- cbind(byseqsTauABCD, "tau_ABCD")
byseqsTauABCD <- cbind(byseqsTauABCD, 10^7)


byseqsTauAB <- aggregate(subMt$M_r_tau_6AB, list(subMt$seqs, subMt$model), FUN=mean)
byseqsTauAB <- cbind(byseqsTauAB, aggregate(subMt$H_r_tau_6AB , list(subMt$seqs, subMt$model), FUN=mean)[,3], aggregate(subMt$L_r_tau_6AB , list(subMt$seqs, subMt$model), FUN=mean)[,3])
byseqsTauAB <- cbind(byseqsTauAB, "tau_AB")
byseqsTauAB <- cbind(byseqsTauAB, 7 * 10 ^6)


byseqsTauCD <- aggregate(subMt$M_r_tau_7CD, list(subMt$seqs, subMt$model), FUN=mean)
byseqsTauCD <- cbind(byseqsTauCD, aggregate(subMt$H_r_tau_7CD , list(subMt$seqs, subMt$model), FUN=mean)[,3], aggregate(subMt$L_r_tau_7CD , list(subMt$seqs, subMt$model), FUN=mean)[,3])
byseqsTauCD<- cbind(byseqsTauCD, "tau_CD")
byseqsTauCD<- cbind(byseqsTauCD, 4 * 10 ^ 6)

colnames(byseqsTauAB) <- c("seqs", "model", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byseqsTauCD) <- c("seqs",  "model", "mean", "H_HPD", "L_HPD", "node", "truth")
colnames(byseqsTauABCD) <- c("seqs",  "model", "mean", "H_HPD", "L_HPD", "node", "truth")
byseqs <- rbind(byseqsTauAB, byseqsTauCD, byseqsTauABCD)

mtPlot <- byseqs %>% 
  mutate(node = factor(node, levels = c("tau_ABCD", "tau_AB",  "tau_CD"), labels = c( expression(tau[ABCD]^Delta), expression(tau[AB]^Delta), expression(tau[CD]^Delta)) )) %>%
  ggplot( aes(y = mean, x = seqs))  + geom_point() + facet_grid(factor(node)~factor(model), labeller = label_parsed)+
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD)) +theme_classic()  +geom_line(aes(y = truth), lty= 2) +ylab("node age") + xlab ("number of samples")

pdf("~/tipDating/figs/mtTau.pdf", width = 5, height = 5)
mtPlot
dev.off()

#####
# Plotting effect of simulation design on mu for mt 

mtMu<- mtD[as.logical((mtD$theta == 0.0001)), ]
mtMuGroup <- aggregate(mtMu$M_mu_bar, list(mtMu$seqs, mtMu$extinct, mtMu$dates), FUN=mean)
mtMuGroup <- cbind (mtMuGroup, aggregate(mtMu$H_mu_bar, list(mtMu$seqs, mtMu$extinct, mtMu$dates), FUN=mean)[, 4], 
                         aggregate(mtMu$L_mu_bar, list(mtMu$seqs, mtMu$extinct, mtMu$dates), FUN=mean)[, 4])

colnames(mtMuGroup) <- c("samples", "extinct", "dates", "means", "H_HPD", "L_HPD")
#mtMuGroup$samples <- as.factor(mtMuGroup$samples)
df1 <- mtMuGroup %>%  arrange(extinct)  %>% arrange(samples) %>% arrange(dates) 
df1<- cbind(df1, c(1:(dim(df1)[1])))
colnames(df1)[7] <- "group"
mtMuGroup <- df1

#mtMuGroup$group <- as.factor(mtMuGroup$group)
mtMuGroup$dates <- as.factor(mtMuGroup$dates)
mtMuGroup$samples <- as.factor(mtMuGroup$samples)
mtMuGroup$extinct <- as.factor(mtMuGroup$extinct)

mu_improve <- ggplot(mtMuGroup, aes(y = means, x = group, color = extinct, lty = dates, pch = samples, group = 1))  + geom_point(stat='identity', size = 3) +
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD )) + theme_classic()  + geom_line(y =  10^-8, lty = 2, col = 1) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) + ylab(expression(paste( mu))) +scale_color_discrete(labels = c("A", "A + C")) + 
  scale_linetype_discrete(name = "upper bound\non ages") +scale_shape_discrete(name = "number of\nsamples")

pdf("~/tipDating/figs/muMt.pdf", width = 5, height = 4)
mu_improve
 dev.off()
######
mtSub<- allMt[as.logical((mtD$theta == 0.0001) * (mtD$dates = 50000)), ]

mtTheta <- aggregate(mtSub$M_theta_1A, list(mtSub$seqs, mtSub$model), FUN=mean)
mtTheta <- cbind (mtTheta, aggregate(mtSub$H_theta_1A, list(mtSub$seqs, mtSub$model), FUN=mean)[, 3], 
                    aggregate(mtSub$L_theta_1A, list(mtSub$seqs, mtSub$model), FUN=mean)[, 3])

colnames(mtTheta) <- c("samples", "model", "means", "H_HPD", "L_HPD")
thetaMt <- ggplot(mtTheta, aes(y = means, x = samples)) + geom_point() + facet_grid(~model)+
  geom_errorbar(aes (ymin=L_HPD, ymax =H_HPD )) + theme_classic() + geom_hline(yintercept=.00025, lty = 2) + ylab(expression(paste(theta[A])))


pdf("~/tipDating/figs/thetaMt.pdf", width = 5, height = 4)
thetaMt
dev.off()
