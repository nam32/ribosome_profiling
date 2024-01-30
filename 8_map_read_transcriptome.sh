#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=map_transcriptome
#SBATCH --time=02:00:00

####

# input: GRCh38_APPRIS_CDS_18.fa, *RNA.fastq
# output: GRCh38_APPRIS_CDS_18_SingleLine.fa, *RNA.fastq, example_RNA_GRCh38_APPRIS_CDS.sam, example_RNA_GRCh38_APPRIS_CDS_log.txt
# This script maps reads to transcriptome

####

source ./module.sh

cd ./annotation/transcriptome_annotation

awk '/^>/ { if(NR>1) print "";  printf("%s\n",$0); next; } { printf("%s",$0);}  END {printf("\n");}' < GRCh38_APPRIS_CDS_18.fa > GRCh38_APPRIS_CDS_18_SingleLine.fa

cd ./preprocessing

for x in $(ls -d *RNA.fastq); \
do echo ${x}; \
bowtie \
-t \
-p 4 \
-v 1 \
-m 1 \
--best \
--strata \
--norc \
./../annotation/transcriptome_annotation/GRCh38_APPRIS_CDS_18 \
-q ${x} \
-S $(basename ${x} .fastq)_GRCh38_APPRIS_CDS.sam 2> $(basename ${x} .fastq)_GRCh38_APPRIS_CDS_log.txt; done


