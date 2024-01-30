#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000MB
#SBATCH --job-name=preprocessing_target_sequence
#SBATCH --time=02:00:00

####

# input: Homo_sapiens.GRCh38.dna.primary_assembly.fa
# output: Homo_sapiens.GRCh38.dna.primary_assembly.2bit
# This script convert FASTA file into TwoBit format

####

source ./module.sh
cd ./annotation/genome_annotation

faToTwoBit Homo_sapiens.GRCh38.dna.primary_assembly.fa Homo_sapiens.GRCh38.dna.primary_assembly.2bit
