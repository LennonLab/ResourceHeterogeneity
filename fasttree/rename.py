#!/usr/bin/python

###############################################################################
# Python Script to Rename FASTA Sequences (Rep Seqs) From Mothur
###############################################################################
# Written by Mario Muscarella
# Last Update 30 March 2016

# Directions:

from Bio import SeqIO
import sys
import glob
import re

inputfile = sys.argv[1]
outputfile = sys.argv[2]

# Input Original Multi-Fasta File

original_seqs = SeqIO.parse(inputfile, "fasta")

output_handle = open(outputfile, "w")

for seq_record in original_seqs:
    original_name = seq_record.description
    OTU_info = re.split(r"\t", original_name)
    OTU = re.split(r"\|", OTU_info[1])
    seq_record.id = OTU[0]
    print(seq_record.id)
    count = SeqIO.write(seq_record, output_handle, "fasta")


output_handle.close()

print("Complete")





# change these numbers
#start = 0
#end = 250

#def trim_positions(records, start, end):
#	for record in records:
#		yield record[start:end]

#files = glob.glob("*R1_001.fastq")

#for x in files:
#	original_seqs = SeqIO.parse(x, "fastq")
#	trimmed_seqs = trim_positions(original_seqs, start, end)
#	output_handle = open(x.replace(".fastq","")+".trim.fastq", "w")
#	count = SeqIO.write(trimmed_seqs, output_handle, "fastq")
#	output_handle.close()
#	print "Trimmed %i reads in %s" % (count, x)
