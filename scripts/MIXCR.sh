#!/bin/sh

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module purge
module load gcc/8.3.0
module load openjdk/11.0.2

ls *_1.fq | awk -F "_1.fq" '{print $1}' >sample_id.txt

while read sample_id
do

echo $sample_id

/project/mangul_341/keruipen/tools/mixcr-3.0.13/mixcr analyze shotgun \
    --species hs --starting-material rna \
    --assemble '-ObadQualityThreshold=0' \
    --assemble '-OaddReadsCountOnClustering=true' \
    ${sample_id}_1.fastq ${sample_id}_2.fastq ${sample_id}

done<sample_id.txt
