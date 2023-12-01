#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=prepare indices
#SBATCH --time=01:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

source ./module.sh

cd /data/users/tjanjumratsang/ribosome_profiling/annotation/undesired_RNA
bowtie-build GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb.fa GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb

cd /data/users/tjanjumratsang/ribosome_profiling/annotation/genome_annotation
bowtie-build GRCh38.dna.primary_assembly.fa GRCh38.dna.primary_assembly

cd /data/users/tjanjumratsang/ribosome_profiling/annotation/transcriptome_annotation
bowtie-build GRCh38_APPRIS_CDS_18.fa GRCh38_APPRIS_CDS_18

