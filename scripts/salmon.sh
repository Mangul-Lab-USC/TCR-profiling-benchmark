#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=Salmon.job
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module purge
module load gcc/11.2.0
module load conda
eval "$(conda shell.bash hook)"
conda activate salmon

filename='sample_id.txt'
n=1 

while read sample_id
do

echo $sample_id

salmon quant -i homo_index -l A \
         -1 ${sample_id}_1.fq.gz \
         -2 ${sample_id}_2.fq.gz \
         -p 8 --validateMappings -o quants/${sample_id}_quant
done<sample_id.txt