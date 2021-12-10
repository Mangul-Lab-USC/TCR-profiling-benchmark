#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=IMREP.job
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=48:00:00
#SBATCH --account=mangul_341

module purge
module load gcc/4.9.4
module load python/2.7.16

cd samples 

ls *.sorted.bam | awk -F ".sorted.bam" '{print $1}' >sample_id.txt

mv sample_id.txt /project/mangul_341/keruipen/tools/imrep

cd ..

filename='sample_id.txt'
n=1 

while read sample_id
do

echo $sample_id

python2 /project/mangul_341/keruipen/tools/imrep/imrep.py --extendedOutput --hg38 --bam --noOverlapStep --noCast samples/${sample_id}.sorted.bam samples/${sample_id}.cdr3

done<sample_id.txt
