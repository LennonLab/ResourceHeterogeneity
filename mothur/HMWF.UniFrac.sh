#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=12:00:00
#PBS -M mmuscare@indiana.edu
#PBS -m abe
#PBS -j oe
cd /N/dc2/projects/Lennon_Sequences/2016_ResourceHeterogeneity
module load gcc/4.9.2
module load mothur/1.36.1
mothur "#unifrac.weighted(tree=HMWF.bac.0.03.gg.tree, count=HMWF.final.0.03.count_table, random=t, processors=8, distance=lt)"
