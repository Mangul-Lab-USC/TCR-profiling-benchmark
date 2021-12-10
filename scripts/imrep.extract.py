import csv
import argparse
from math import log as ln
import sys

#============================
ap = argparse.ArgumentParser()
ap.add_argument('input', help='<imrep cdr3 output ...sort.cdr3.txt>')
ap.add_argument('out_prefix', help='name of outfile and save location')
ap.add_argument('chain', help = 'chain of antibody or TCR')
args = ap.parse_args()

set_cdr3=set()
cdr3_hash={}

#get all CDR3s
file=open(args.input)
reader=csv.reader(file)
next(reader,None)
for line in reader:
    cdr3=line[0]
    if line[1] == args.chain and cdr3[0] == "C" and cdr3[len(cdr3) - 1] == "F":
        set_cdr3.add(cdr3)
file.close()

print ("Number CDR3s",len(set_cdr3))

#create dictionary from every unique element 
for cdr3 in set_cdr3:
	cdr3_hash[cdr3]=0

#get number of reads for each unique cdr3 seq in set
file=open(args.input)
reader=csv.reader(file)
next(reader,None)
for line in reader:
    cdr3=line[0]
    count = int(line[2])
    if line[1] == args.chain and cdr3[0]=="C" and cdr3[len(cdr3)-1]=="F":
    	cdr3_hash[cdr3] += count
file.close()

print(cdr3_hash)

total_reads=float(sum(cdr3_hash.values()))
print(total_reads)

#write the hash to a csv file
fileOut=open(args.out_prefix+".cdr3.csv","w")
fileOut.write("Sample,CDR3,nReads")
fileOut.write("\n")

sample_name = args.input.split("/")[-1].split(".")[0]

for key, value in cdr3_hash.items():
    fileOut.write(sample_name+","+key+","+str(value))
    fileOut.write("\n")

fileOut.close()
