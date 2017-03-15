#!/bin/bash

# requirements: perl, r modules igraph and nem and dbscan
# input = allele_freq_file prefix eps_value
# need to make r script to run before this to produce graph so know appropriate eps val 

PATH_TO_SCRIPT_FILE=/Users/josephinebryant/Documents/new_mab_het_stuff/pipeline

$PATH_TO_SCRIPT_FILE/clustering.r $1 $3

sed -i.bak '/^$/d' $1.des 

$PATH_TO_SCRIPT_FILE/sort_des.pl $1.des > $2.des.sort

$PATH_TO_SCRIPT_FILE/filter_clusters.pl $2.des.sort > $2.to_remove

grep -wvf $2.to_remove $1.clustered | sed $'s/\t/,/g' | sed $'s/,/\t/' > $2.data_clustered_filtered.csv

grep -wvf $2.to_remove $2.des.sort > $2.des.sort.filtered

awk '{print $1}' $2.des.sort.filtered | uniq -c | awk '{print $2,$1}' > $2.size

$PATH_TO_SCRIPT_FILE/removing_noise_iterative_consider_clustersize.pl $2.data_clustered_filtered.csv $2.size $PATH_TO_SCRIPT_FILE

cat $2.data_clustered_filtered.csv.final.out | tr ' ' ',' > $2.relationships.csv

$PATH_TO_SCRIPT_FILE/make_tree_pdf.r $2.relationships.csv

