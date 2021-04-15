#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)



#need to work out appropriate eps by identifyng elbow in plot 
library(dbscan)
x<-read.delim(args[1],header=FALSE,row.names=1)
plot<-kNNdistplot(x, k = 2)

pdf(file=paste(args[1], "_knndistplot.pdf", sep=""))
kNNdistplot(x, k = 2)
dev.off()