# TCR:
# Parser for extracting cdr3 seq, count and frequency from TCR seq files and converting to csv with sample name.

ls raw_data/TCR_Seq/ | cut -d "/" -f4 | awk -F ".tsv" '{print $1}' >TCR_samples.txt

while read line
do
	python scripts/tcr.seq.extract.py raw_data/TCR_Seq/${line}.tsv summary_data/original/TCR_Seq/${line}.extracted_TCR.csv

done<TCR_samples.txt

echo "Sample,CDR3,nReads" > summary_data/original/TCR_merged_extracted_features.csv
tail -n +2 -q summary_data/original/TCR_Seq/*.csv >> summary_data/original/TCR_merged_extracted_features.csv
