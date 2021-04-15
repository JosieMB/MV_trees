#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)



#need to work out appropriate eps using below
#library(dbscan)
#x<-read.delim(args[1],header=FALSE,row.names=1)
#kNNdistplot(x, k = 2)

library(dbscan)
x<-read.delim(args[1],header=FALSE,row.names=1)
dbx<-dbscan(x,eps = args[2], minPts = 2)

#freq = ''
#for (x in 1:length(unique(dbx$cluster))){freq<-c(freq,paste(",c",x,sep=""))}
#colnames(freq) = c(colMeans(x[dbx$cluster==1,]))
freq<-c(colMeans(x[dbx$cluster==1,]))

for (cluster in 2:(length(unique(dbx$cluster))-1)){ freq<-cbind(freq,colMeans(x[dbx$cluster==cluster,]))}
colnames(freq) <- NULL
ncol <- dim(freq)[2]
nrow <- dim(freq)[1]
colnames(freq) <- paste0('c', 1:ncol)

mrca = 1
for (j in 2:nrow){mrca <- c(mrca,1)}
#mrca
freq<-cbind(as.data.frame(mrca),freq)
#freqy<-t(freq)

freqy<-rbind(t(freq), x[dbx$cluster==0,])
#c_names<-''
#for (x in 1:length(unique(dbx$cluster))){c_names<-c(c_names,x)}
#freq<-cbind(freqy,c_names)

write.table(freqy,quote=FALSE,sep=",",col.names=FALSE,row.names=TRUE,file=paste(args[1], ".clustered", sep=""))

des=''
for (cluster in 0:(length(unique(dbx$cluster))-1)) {des<-c(des,toString(row.names(x[dbx$cluster==cluster,])))}


#write.table(x[dbx$cluster==0,],quote=FALSE,sep=",",file=paste(args[1], ".unclus", sep=""))

write.table(des,quote=FALSE,sep=",",col.names=FALSE,row.names=FALSE,file=paste(args[1], ".des", sep=""))

