#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=250gb,walltime=24:00:00
#PBS -M mmuscare@indiana.edu
#PBS -m abe
#PBS -j oe
cd /N/dc2/projects/Lennon_Sequences/ResourceHeterogeneity
module load gcc/4.9.2
module load mothur/1.36.1
mothur HMWF.Bacteria_A.Batch
qsub HMWF.Bacteria_B.sh
qsub HMWF.Euks.sh
qsub HMWF.Cyano.sh
