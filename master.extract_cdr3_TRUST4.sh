# TRUST:
# Parser for extracting cdr3 seq, count and frequency from TRUST output and converting to csv with sample name.
ls raw_data/75bp/TRUST4/ | cut -d "/" -f4 | awk -F ".tsv" '{print $1}' >TRUST_samples.txt

while read line
do
	python scripts/TRUST4.extract.py raw_data/75bp/TRUST4/${line}.tsv summary_data/75bp/TRUST4/TRB_extracted_features/${line}.extracted_TRUST4.csv TRB

done<TRUST_samples.txt

echo "Sample,CDR3,nReads" > summary_data/75bp/TRUST4_TRB_merged_extracted_features.csv
tail -n +2 -q summary_data/75bp/TRUST4/TRB_extracted_features/*.csv >> summary_data/75bp/TRUST4_TRB_merged_extracted_features.csv



