#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=BAMtoFASTQ.job
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module load gcc/8.3.0

ls *.bam | awk -F ".bam" '{print $1}' >sample_id.txt

while read sample_id
do

echo $sample_id

samtools view -uf64 ${sample_id}.bam |samtools bam2fq - |gzip >${sample_id}_1.fq.gz

samtools view -uf128 ${sample_id}.bam |samtools bam2fq - |gzip >${sample_id}_2.fq.gz

done<sample_id.txt
echo "Conversion is finished!"