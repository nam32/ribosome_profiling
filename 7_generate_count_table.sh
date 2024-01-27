#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000MB
#SBATCH --job-name=differential_expression_analysis
#SBATCH --time=02:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

####

# input: Homo_sapiens.GRCh38.108.gtf, *_GRCh38_sorted.bam
# output: biotype_counts_processed.txt, biotype_counts_rawfile.txt
# This script generate count table

####

source ./module.sh

featureCounts \
-T 8 \
-t CDS \
-g gene_id \
-a ./annotation/genome_annotation/Homo_sapiens.GRCh38.108.gtf \
-o ./results/CDS_counts_rawfile.txt ./results/*_GRCh38_sorted.bam

# Extract GeneID and Sample columns

cut -f 1,7-10 ./results/CDS_counts_rawfile.txt > ./results/CDS_counts_processed.txt

featureCounts \
-T 8 \
-t exon \
-g gene_biotype \
-a ./annotation/genome_annotation/Homo_sapiens.GRCh38.108.gtf \
-o ./results/biotype_counts_rawfile.txt ./results/*_GRCh38_sorted.bam

# Extract Biotype and Sample columns

cut -f 1,7-10 ./results/biotype_counts_rawfile.txt > ./results/biotype_counts_processed.txt
