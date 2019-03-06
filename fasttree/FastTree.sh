#!/bin/sh

# FastTree -nt ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.van.tree
# FastTree -nt -gtr ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.gtr.tree
# FastTree -nt -gamma ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.gam.tree
rename.py ./HMWF.final.opti.fasta ./HMWF.final.opti.rename.fasta
FastTree -nt -gtr -gamma ./HMWF.final.opti.rename.fasta > HMWF.opti.tree
FastTree -nt -gtr -gamma ./HMWF.final.opti.fasta > HMWF.opti.ori.tree
