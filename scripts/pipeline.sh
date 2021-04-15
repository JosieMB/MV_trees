#!/bin/bash

# requirements: perl, r modules igraph and nem and dbscan
# input = allele_freq_file prefix eps_value
# need to run knndistplot.r script to run before this to produce graph so know appropriate eps val 

PATH_TO_INSTALL=.

#cluster allele frequencies
$PATH_TO_INSTALL/clustering.r $1 $2

#parse output to list variants associated with each cluster. c0 is unclustered
$PATH_TO_INSTALL/sort_des.pl $1.des 

#identify clusters where >20% of variants are within 150bp and remove
$PATH_TO_INSTALL/filter_clusters.pl $1.des.sort $1.clustered > $1.clustered_filtered.csv

#iterative removal of noisy nodes
$PATH_TO_INSTALL/better_iterative_noise_script.pl $1.clustered_filtered.csv $1.des.size 

# construct tree
$PATH_TO_INSTALL/make_tree_pdf.r $1.clustered_filtered.csv.relationships.csv

