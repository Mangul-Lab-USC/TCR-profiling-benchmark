# MIXCR:
# Parser for extracting cdr3 seq, count and frequency from MIXCR output and converting to csv with sample name.

ls raw_data/75bp/MIXCR | cut -d "/" -f4 | awk -F ".txt" '{print $1}' > MIXCR_samples.txt

while read line
do
	python scripts/mixcr.extract.py raw_data/75bp/MIXCR/${line}.txt summary_data/75bp/MIXCR/TRB_extracted_features/${line}.extracted_MIXCR.csv TRB

done<MIXCR_samples.txt

echo "Sample,CDR3,nReads" > summary_data/75bp/MIXCR_TRB_merged_extracted_features.csv
tail -n +2 -q summary_data/75bp/MIXCR/TRB_extracted_features/*.csv >> summary_data/75bp/MIXCR_TRB_merged_extracted_features.csv