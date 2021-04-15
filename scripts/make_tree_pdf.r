#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)



library(igraph)
library(nem)  
dat<-read.csv(args[1],header=FALSE)
gc <- get.adjacency(graph.edgelist(as.matrix(dat), directed=TRUE))
gc2<-as.matrix(gc)
g<-transitive.reduction(gc2)
net<-graph_from_adjacency_matrix(g)





library(Cairo)
CairoPDF(file=paste(args[1], ".tree.pdf", sep=""), width = 10, height = 10)
plot.igraph(net, layout=layout_as_tree, vertex.size=5, edge.arrow.size=0.5, vertex.label.dist=0.5, vertex.label.degree=-pi/2)
dev.off()




write.table(get.edgelist(net),quote=FALSE, row.names=FALSE, col.names=FALSE, file=paste(args[1], ".edge_list", sep=""))
write.table(as.data.frame(as.table(t(distances(net)))),quote=FALSE, row.names=FALSE, col.names=FALSE, file=paste(args[1], ".pairwise", sep=""))