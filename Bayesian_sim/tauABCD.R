library(ggpubr)
library(ggplot2)
rejSim <- read.table("~/tipDating_analysis/rejection_sim/parameters.txt", header =TRUE, sep = "\t")

fileNames = c("~/tipDating_analysis/Bayesian_sim/mu_bar.txt",
              "~/tipDating_analysis/Bayesian_sim/tau_5ABCD.txt", 
              "~/tipDating_analysis/Bayesian_sim/tau_6AB.txt", 
              "~/tipDating_analysis/Bayesian_sim/tau_7CD.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_1A.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_2B.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_3C.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_4D.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_6AB.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_7CD.txt",
              "~/tipDating_analysis/Bayesian_sim/theta_5ABCD.txt")


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


smoothing <- 1
plots[[1]] <- ggplot(data=BS[[1]], aes(x=mu_bar), environment = environment()) + geom_density(col = 2, adjust = smoothing)+ 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(mu)) +
              theme1 + geom_density(data =rejSim, aes(x=rejSim[,1+1]), lty = 2)

plots[[2]] <- ggplot(data=BS[[2]], aes(x=tau_5ABCD), environment = environment()) +
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(tau[ABCD])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,2+1]), lty = 2) 

plots[[3]] <- ggplot(data=BS[[3]], aes(x=tau_6AB), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(tau[AB])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,3+1]), lty = 2)

plots[[4]] <- ggplot(data=BS[[4]], aes(x=tau_7CD), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(tau[CD])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,4+1]), lty = 2)

plots[[5]] <- ggplot(data=BS[[5]], aes(x=theta_1A), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[A])) +
              theme1 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,5+1]), lty = 2)

plots[[6]] <- ggplot(data=BS[[6]], aes(x=theta_2B), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[B])) +
	            theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,6+1]), lty = 2)

plots[[7]] <- ggplot(data=BS[[7]], aes(x=theta_3C), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[C])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,7+1]), lty = 2)

plots[[8]] <- ggplot(data=BS[[8]], aes(x=theta_4D), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[D])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,8+1]), lty = 2)

plots[[9]] <- ggplot(data=BS[[9]], aes(x=theta_6AB), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[AB])) +
              theme1 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,9+1]), lty = 2)

plots[[10]] <- ggplot(data=BS[[10]], aes(x=theta_7CD), environment = environment()) +
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[CD])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,10+1]), lty = 2)

plots[[11]] <- ggplot(data=BS[[11]], aes(x=theta_5ABCD), environment = environment()) + 
              scale_x_continuous(n.breaks=numBreak) + scale_y_continuous(n.breaks=numBreak) + 
	      xlab(expression(theta[ABCD])) +
              theme2 + geom_density(col = 2, adjust = smoothing) + geom_density(data =rejSim, aes(x=rejSim[,11+1]), lty = 2)



figure <- ggarrange(plotlist = plots, 
        nrow =3, ncol = 4)
pdf("~/tipDating_analysis/Bayesian_sim/BS_smooth1.pdf", width = 10, height = 4 )
figure
dev.off()
