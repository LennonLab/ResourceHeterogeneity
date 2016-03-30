#!/bin/sh

# FastTree -nt ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.van.tree
# FastTree -nt -gtr ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.gtr.tree
# FastTree -nt -gamma ../data/HMWF.bac.final.0.03.fasta > HMWF.bac.0.03.gam.tree
rename.py ../HMWF.bac.final.0.03.fasta ../HMWF.bac.final.0.03.rename.fasta
FastTree -nt -gtr -gamma ../data/HMWF.bac.final.0.03.rename.fasta > HMWF.bac.0.03.gg.tree
