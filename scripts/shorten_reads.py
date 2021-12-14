import argparse
from Bio.SeqIO.QualityIO import FastqGeneralIterator

parser = argparse.ArgumentParser()
parser.add_argument('--input')
parser.add_argument('--output')
args=parser.parse_args()

file = open(args.output, "w")
with open(args.input) as in_handle:
	for title, seq, qual in FastqGeneralIterator(in_handle):
		file.write('>' + title + '_1\n')
		file.write(seq[:int(len(seq)/2)] + '\n')
		file.write('>' + title +'_2\n')
		file.write(seq[int(len(seq)/2):] + '\n')
