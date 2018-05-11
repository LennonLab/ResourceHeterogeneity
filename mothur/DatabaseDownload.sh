#!/bin/bash

wget https://mothur.org/w/images/3/32/Silva.nr_v132.tgz
tar -xzvf Silva.nr_v132.tgz

wget https://mothur.org/w/images/c/c3/Trainset16_022016.pds.tgz
tar -xzvf  Trainset16_022016.pds.tgz

# module load gcc/4.9.2
# module load boost/1.52.0
# module load mothur/1.39.0

mothur "#pcr.seqs(fasta=silva.nr_v132.align, start=11894, end=25319, keepdots=F, processors=1)"
mv silva.nr_v132.pcr.align silva.v4.fasta

