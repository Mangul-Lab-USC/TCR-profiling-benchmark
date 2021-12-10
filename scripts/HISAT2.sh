#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=hisat2_alignment.job
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module load gcc/8.3.0

ls *_1.fastq | awk -F "_1.fastq" '{print $1}' >sample_id.txt

while read sample_id
do

echo $sample_id
hisat2 -q -x /project/mangul_341/keruipen/alignment/grch38/genome -1 $s{ample_id}_1.fastq -2 ${sample_id}_2.fastq -S ${sample_id}.sam

done<sample_id.txt
echo "Alignment is finished!"