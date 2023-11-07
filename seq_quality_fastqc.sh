#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000MB
#SBATCH --time=00:02:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

echo "start quality check"

mkdir fastqc_output

module load UHTS/Quality_control/fastqc/0.11.9

fastqc -o /data/users/tjanjumratsang/ribosome_profiling/fastqc_output *.fastq.gz
