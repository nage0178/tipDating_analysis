library(ggpubr)
library(ggplot2)


rejSim <- read.table("~/tipDating_analysis/rejection_sim/parameters.txt", header =TRUE, sep = "\t")
fileNames = c("~/tipDating_analysis/Bayesian_sim/1_1/mcmc.txt",
              "~/tipDating_analysis/Bayesian_sim/2_1/mcmc.txt", 
              "~/tipDating_analysis/Bayesian_sim/3_1/mcmc.txt",
              "~/tipDating_analysis/Bayesian_sim/4_1/mcmc.txt",
              "~/tipDating_analysis/Bayesian_sim/5_1/mcmc.txt" )


plots <- list()
BS <- list()
for (i in 1:length(fileNames)) {
  BS[[i]] <- read.table(fileNames[i], header =TRUE, sep = "\t")
}

theme1 <- theme(strip.background = element_rect(color = "black"),
                panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black")
                
) 

theme2 <- theme(axis.title.y=element_blank(),
                #axis.ticks.x=element_blank(),
                strip.background = element_rect(color = "black"),
                panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black")
                
) 

numBreak = 4


plots[[1]] <- ggplot(data=BS[[1]], aes(x=mu_bar), environment = environment()) + geom_density(col = 2)+ 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme1 + xlab(expression(mu)) +
	     # geom_density(data =BS[[2]], aes(x=mu_bar), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=mu_bar), col = 4) + 
	     # geom_density(data =BS[[4]], aes(x=mu_bar), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=mu_bar), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+1]), lty = 2)

plots[[2]] <- ggplot(data=BS[[1]], aes(x=tau_5ABCD), environment = environment()) +
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	     # geom_density(data =BS[[2]], aes(x=tau_5ABCD), col = 3) +
	      geom_density(data =BS[[3]], aes(x=tau_5ABCD), col = 4) + 
	     # geom_density(data =BS[[4]], aes(x=tau_5ABCD), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=tau_5ABCD), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+2]), lty = 2)

plots[[3]] <- ggplot(data=BS[[1]], aes(x=tau_6AB), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	     # geom_density(data =BS[[2]], aes(x=tau_6AB), col = 3) +
	      geom_density(data =BS[[3]], aes(x=tau_6AB), col = 4) +
	     # geom_density(data =BS[[4]], aes(x=tau_6AB), col = 5) +
	      geom_density(data =BS[[5]], aes(x=tau_6AB), col = 6) +
	      geom_density(data =rejSim, aes(x=rejSim[,1+3]), lty = 2)

plots[[4]] <- ggplot(data=BS[[1]], aes(x=tau_7CD), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=tau_7CD), col = 3) +
	      geom_density(data =BS[[3]], aes(x=tau_7CD), col = 4) +
	      #geom_density(data =BS[[4]], aes(x=tau_7CD), col = 5) +
	      geom_density(data =BS[[5]], aes(x=tau_7CD), col = 6) +
	      geom_density(data =rejSim, aes(x=rejSim[,1+4]), lty = 2)

plots[[5]] <- ggplot(data=BS[[1]], aes(x=theta_1A), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=theta_1A), col = 3) +
	      geom_density(data =BS[[3]], aes(x=theta_1A), col = 4) + 
	      #geom_density(data =BS[[4]], aes(x=theta_1A), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=theta_1A), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+5]), lty = 2)

plots[[6]] <- ggplot(data=BS[[1]], aes(x=theta_2B), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=theta_2B), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=theta_2B), col = 4) +
	      #geom_density(data =BS[[4]], aes(x=theta_2B), col = 5) +
	      geom_density(data =BS[[5]], aes(x=theta_2B), col = 6) +
	      geom_density(data =rejSim, aes(x=rejSim[,1+6]), lty = 2)

plots[[7]] <- ggplot(data=BS[[1]], aes(x=theta_3C), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=theta_3C), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=theta_3C), col = 4) + 
	      #geom_density(data =BS[[4]], aes(x=theta_3C), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=theta_3C), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+7]), lty = 2)

plots[[8]] <- ggplot(data=BS[[1]], aes(x=theta_4D), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=theta_4D), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=theta_4D), col = 4) + 
	      #geom_density(data =BS[[4]], aes(x=theta_4D), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=theta_4D), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+8]), lty = 2)

plots[[9]] <- ggplot(data=BS[[1]], aes(x=theta_6AB), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	      #geom_density(data =BS[[2]], aes(x=theta_6AB), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=theta_6AB), col = 4) + 
	      #geom_density(data =BS[[4]], aes(x=theta_6AB), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=theta_6AB), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+9]), lty = 2)

plots[[10]] <- ggplot(data=BS[[1]], aes(x=theta_7CD), environment = environment()) +
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	     # geom_density(data =BS[[2]], aes(x=theta_7CD), col = 3) + 
	      geom_density(data =BS[[3]], aes(x=theta_7CD), col = 4) + 
	     # geom_density(data =BS[[4]], aes(x=theta_7CD), col = 5) + 
	      geom_density(data =BS[[5]], aes(x=theta_7CD), col = 6) + 
	      geom_density(data =rejSim, aes(x=rejSim[,1+10]), lty = 2)

plots[[11]] <- ggplot(data=BS[[1]], aes(x=theta_5ABCD), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
              theme2 + geom_density(col = 2) + 
	     # geom_density(data =BS[[2]], aes(x=theta_5ABCD), col = 3) +
	      geom_density(data =BS[[3]], aes(x=theta_5ABCD), col = 4) +
	     # geom_density(data =BS[[4]], aes(x=theta_5ABCD), col = 5) +
	      geom_density(data =BS[[5]], aes(x=theta_5ABCD), col = 6) +
	      geom_density(data =rejSim, aes(x=rejSim[,1+11]), lty = 2)



figure <- ggarrange(plotlist = plots, 
        nrow =2, ncol = 6)
pdf("~/tipDating_analysis/Bayesian_sim/BS_singleRun.pdf", width = 14, height = 2 )
figure
dev.off()
