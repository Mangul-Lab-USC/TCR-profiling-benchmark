# TRUST:
# Parser for extracting cdr3 seq, count and frequency from TRUST output and converting to csv with sample name.
ls raw_data/original/TRUST4/ | cut -d "/" -f4 | awk -F ".tsv" '{print $1}' >TRUST_samples.txt

while read line
do
	python scripts/TRUST4.extract.py raw_data/original/TRUST4/${line}.tsv summary_data/original/TRUST4/TRA_extracted_features/${line}.extracted_TRUST4.csv TRA

done<TRUST_samples.txt

echo "Sample,CDR3,nReads" > summary_data/original/TRUST4_TRA_merged_extracted_features.csv
tail -n +2 -q summary_data/original/TRUST4/TRA_extracted_features/*.csv >> summary_data/original/TRUST4_TRA_merged_extracted_features.csv




