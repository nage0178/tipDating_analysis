library(ape)

tree <- read.tree("~/tipDating_analysis/sim_tree.txt")
pdf("~/tipDating/figs/simulationTree.pdf", width=5, height=4)
tree$edge.length <-tree$edge.length
par(mar =c(5.1,4.1, 4.1, 2.1))
plot(tree, show.node.label =TRUE)
axisPhylo(1, las = 1)
#nodelabels(tree$node.label, adj = c(0, -.2), frame = "none", cex = 10)

dev.off()

tree <- read.tree("~/tipDating_analysis/sim_tree2.txt")
pdf("~/tipDating/figs/simulationTree2.pdf", width=5, height=4)
tree$edge.length <-tree$edge.length
par(mar =c(5.1,4.1, 4.1, 2.1))
plot(tree, show.node.label =TRUE)
axisPhylo(1, las = 1)
#nodelabels(tree$node.label, adj = c(0, -.2), frame = "none", cex = 10)

dev.off()

tree <- read.tree("~/tipDating_analysis/mammoth_tree.txt")
pdf("~/tipDating/figs/mammoth_tree.pdf", width=4, height=3.75)
par(mar =c(5.1,4.1, 4.1, 2.1))
plot(tree, show.node.label =TRUE)
#axisPhylo(1, las = 1)
dev.off()
