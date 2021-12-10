import csv
import argparse
import sys

#============================
ap = argparse.ArgumentParser()
ap.add_argument('input', help='<TRUST4_report.tsv>')
ap.add_argument('out_prefix', help='name of outfile and save location')
ap.add_argument('chain', help='TCR/IG chain')
args = ap.parse_args()

set_cdr3=set()
cdr3_hash={}

#get all CDR3s
file=open(args.input)
reader=csv.reader(file, delimiter='\t')
next(reader,None)
for line in reader:
    cdr3=line[3]
    chain = line[7]
    if cdr3[0] == "C" and cdr3[len(cdr3) - 1] == "F" and args.chain in chain:
        set_cdr3.add(cdr3)
file.close()

print ("Nummber CDR3s",len(set_cdr3))

#create dictionary from every unique element 
for cdr3 in set_cdr3:
    cdr3_hash[cdr3]=0

#get number of reads for each unique cdr3 seq in set
file=open(args.input)
reader=csv.reader(file, delimiter='\t')
next(reader,None)
for line in reader:
    cdr3=line[3]
    chain = line[7]
    count = int(line[0])
    if cdr3[0]=="C" and cdr3[len(cdr3)-1]=="F" and args.chain in chain:
        cdr3_hash[cdr3]+= count
file.close()

print(cdr3_hash)

total_reads=float(sum(cdr3_hash.values()))
print(total_reads)

#write the hash to a csv file

fileOut=open(args.out_prefix+".cdr3.csv","w")
fileOut.write("Sample,CDR3,nReads")
fileOut.write("\n")

sample_name = args.input.split("/")[-1].split(".")[0]
print(sample_name)

for key, value in cdr3_hash.items():
    fileOut.write(sample_name+","+key+","+str(value))
    fileOut.write("\n")

fileOut.close()
