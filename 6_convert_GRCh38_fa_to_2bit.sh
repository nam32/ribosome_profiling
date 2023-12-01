#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000MB
#SBATCH --job-name=preprocessing_target_sequence
#SBATCH --time=02:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

####

# input: Homo_sapiens.GRCh38.108.gtf, *_GRCh38_sorted.bam
# output: biotype_counts_processed.txt, biotype_counts_rawfile.txt
# This script generate count table

####

source ./module.sh
cd ./annotation/genome_annotation

faToTwoBit Homo_sapiens.GRCh38.dna.primary_assembly.fa Homo_sapiens.GRCh38.dna.primary_assembly.2bit
