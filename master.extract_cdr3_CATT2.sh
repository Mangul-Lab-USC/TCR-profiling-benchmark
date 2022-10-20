# CATT_TRA:
# Parser for extracting cdr3 seq, count and frequency from CATT output and converting to csv with sample name.
ls raw_data/original/CATT_TRA | cut -d "/" -f4 | awk -F ".csv" '{print $1}' > CATT_samples.txt

while read line
do
	python scripts/CATT.extract2.py raw_data/original/CATT_TRA/${line}.csv summary_data/original/CATT/TRA_extracted_features/${line}.extracted_CATT.csv

done<CATT_samples.txt

echo "Sample,CDR3,nReads" > summary_data/original/CATT_TRA_merged_extracted_features.csv
tail -n +2 -q summary_data/original/CATT/TRA_extracted_features/*.csv >> summary_data/original/CATT_TRA_merged_extracted_features.csv