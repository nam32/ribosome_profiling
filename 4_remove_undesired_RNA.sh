#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000MB
#SBATCH --job-name=remove_undesired_RNA
#SBATCH --time=02:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

source ./module.sh
cd ./results/

####

# input:*_clpd_tr.fastq.gz, GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb indices 
# output:RPF_KO_Rep1_clpd_tr_no_r_t_sno_sn_RNA_log.txt, RPF_KO_Rep2_clpd_tr_no_r_t_sno_sn_RNA_log.txt, RPF_WT_Rep1_clpd_tr_no_r_t_sno_sn_RNA_log.txt, RPF_WT_Rep2_clpd_tr_no_r_t_sno_sn_RNA_log.txt 
# 
#Remove undesired RNA altered as bowtie cannot read the gunzip using piping

####

#input files:
#gunzip RPF_KO_Rep1_clpd_tr.fastq.gz
#gunzip RPF_KO_Rep2_clpd_tr.fastq.gz
#gunzip RPF_WT_Rep1_clpd_tr.fastq.gz
#gunzip RPF_WT_Rep2_clpd_tr.fastq.gz

for file in *_clpd_tr.fastq.gz; do
    gunzip "$file"
done

for x in *tr.fastq; do
    echo ${x}
    bowtie \
        -S \
        -t \
        -p 4 \
        ../annotation/undesired_RNA/GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb \
        ${x} \
        --un $(basename ${x} .fastq)_no_r_t_sno_sn_RNA.fastq 2> $(basename ${x} .fastq)_no_r_t_sno_sn_RNA_log.txt > /dev/null
done
