#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=samtools.job
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module load gcc/8.3.0

ls *_1.fastq | awk -F "_1.fastq" '{print $1}' >sample_id.txt

while read sample_id
do

echo $sample_id
samtools view -f -bS -h ${sample_id}.sam > ${sample_id}.bam
samtools sort ${sample_id}.bam -o ${sample_id}.sorted.bam
samtools index ${sample_id}.sorted.bam

done<sample_id.txt
echo "Conversion is finished!"