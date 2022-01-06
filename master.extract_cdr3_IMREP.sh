# IMREP:
# Parser for extracting cdr3 seq, count and frequency from IMREP output and converting to csv with sample name.
ls raw_data/75bp/IMREP | cut -d "/" -f4 | awk -F ".cdr3" '{print $1}' > IMREP_samples.txt

while read line
do
	python scripts/imrep.extract.py raw_data/75bp/IMREP/${line}.cdr3 summary_data/75bp/IMREP/TRB_extracted_features/${line}.extracted_IMREP.csv TRB

done<IMREP_samples.txt

echo "Sample,CDR3,nReads" > summary_data/75bp/IMREP_TRB_merged_extracted_features.csv
tail -n +2 -q summary_data/75bp/IMREP/TRB_extracted_features/*.csv >> summary_data/75bp/IMREP_TRB_merged_extracted_features.csv