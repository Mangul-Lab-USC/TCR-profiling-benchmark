# MIXCR:
# Parser for extracting cdr3 seq, count and frequency from MIXCR output and converting to csv with sample name.

ls raw_data/original/MIXCR | cut -d "/" -f4 | awk -F ".txt" '{print $1}' > MIXCR_samples.txt

while read line
do
	python scripts/mixcr.extract.py raw_data/original/MIXCR/${line}.txt summary_data/original/MIXCR/TRA_extracted_features/${line}.extracted_MIXCR.csv TRA

done<MIXCR_samples.txt

echo "Sample,CDR3,nReads" > summary_data/original/MIXCR_TRA_merged_extracted_features.csv
tail -n +2 -q summary_data/original/MIXCR/TRA_extracted_features/*.csv >> summary_data/original/MIXCR_TRA_merged_extracted_features.csv