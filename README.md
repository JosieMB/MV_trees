# MV_trees


Perl (tested on Perl 5.16)
R (tested on version 3.4.2)

in R:
install.packages("dbscan")
install.packages("igraph")
install.packages("Cairo")

source("https://bioconductor.org/biocLite.R")
biocLite("nem")



Input:

Allele frequencies where each column is a different sample (or time point) and each row is a SNP. The first column contains the SNP id. Example data (sample_data) is provided.


Usage:

(1) Work out appropriate eps value by generating knndistplot and determining elbow:
knndistplot.r sample_data

(2) Update pipeline.sh with path to scripts directory and run pipeline
pipeline.sh sample_data eps_val


Output:
*des: clustered SNPs. Each corresponds to a different SNP cluster, except for c0 which is a list of unclustered singleton SNPs.
*tree.pdf : final tree of inferred subclonal relationships
*edge_list : final list of inferred subclonal relationships
