#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000MB
#SBATCH --job-name=mapping_to_genome
#SBATCH --time=02:00:00

####

# input: *RNA.fastq, Homo_sapiens.GRCh38.dna.primary_assembly
# output: *_sorted.bam
# This script performs RNA sequence alignment using Bowtie to Homo_sapiens.GRCh38.dna.primary_assembly, sort the BAM files and create sorted BAM files

####

source ./module.sh
cd ./results/

for x in $(ls -d *RNA.fastq); do
    echo ${x}
    bowtie -S -t -p 4 -v 1 -m 1 --best --strata \
    ../annotation/genome_annotation/Homo_sapiens.GRCh38.dna.primary_assembly \
    -q ${x} 2> $(basename ${x} .fastq)_GRCh38_log.txt > $(basename ${x} .fastq)_GRCh38.sam
    
    samtools view -h -F 4 -b -@ 4 $(basename ${x} .fastq)_GRCh38.sam \
    > $(basename ${x} .fastq)_GRCh38.bam
    
    rm $(basename ${x} .fastq)_GRCh38.sam
done

# Sort the BAM file
for x in $(ls -d *.bam); \
do echo ${x}; \
samtools sort \
-@ 4 \
${x} \
-o $(basename ${x} .bam)_sorted.bam; done

# Remove the unsorted BAM file
rm *GRCh38.bam
