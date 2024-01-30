#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=prepare_indices
#SBATCH --time=03:00:00

source ./module.sh

cd ./annotation/undesired_RNA
bowtie-build GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb.fa GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb

cd ./../genome_annotation
bowtie-build GRCh38.dna.primary_assembly.fa GRCh38.dna.primary_assembly

cd ./../transcriptome_annotation
bowtie-build GRCh38_APPRIS_CDS_18.fa GRCh38_APPRIS_CDS_18

