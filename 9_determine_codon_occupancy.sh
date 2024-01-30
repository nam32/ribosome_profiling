#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=determine_codon_occupancy
#SBATCH --time=02:00:00

####

# input: Codon_occupancy_cal.sh, GRCh38_APPRIS_CDS_18_SingleLine.fa, RPF_*_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_APPRIS_CDS.sam
# output: *_Codon_occupancy.txt
# Determine codon occupancy

####

source ./module.sh
chmod ug+x Codon_occupancy_cal.sh

cd ./annotation/transcriptome_annotation
awk '/^>/ { if(NR>1) print "";  printf("%s\n",$0); next; } { printf("%s",$0);}  END {printf("\n");}' < GRCh38_APPRIS_CDS_18.fa > GRCh38_APPRIS_CDS_18_SingleLine.fa
cd ../..

./Codon_occupancy_cal.sh \
./annotation/transcriptome_annotation/GRCh38_APPRIS_CDS_18_SingleLine.fa \
./preprocessing/RPF_KO_Rep1_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_APPRIS_CDS.sam

mv ./Codon_occupancy.txt ./preprocessing/RPF_KO_Rep1_Codon_occupancy.txt

./Codon_occupancy_cal.sh \
./annotation/transcriptome_annotation/GRCh38_APPRIS_CDS_18_SingleLine.fa \
./preprocessing/RPF_KO_Rep2_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_APPRIS_CDS.sam

mv ./Codon_occupancy.txt ./preprocessing/RPF_KO_Rep2_Codon_occupancy.txt

./Codon_occupancy_cal.sh \
./annotation/transcriptome_annotation/GRCh38_APPRIS_CDS_18_SingleLine.fa \
./preprocessing/RPF_WT_Rep1_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_APPRIS_CDS.sam

mv ./Codon_occupancy.txt ./preprocessing/RPF_WT_Rep1_Codon_occupancy.txt

./Codon_occupancy_cal.sh \
./annotation/transcriptome_annotation/GRCh38_APPRIS_CDS_18_SingleLine.fa \
./preprocessing/RPF_WT_Rep2_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_APPRIS_CDS.sam

mv ./Codon_occupancy.txt ./preprocessing/RPF_WT_Rep2_Codon_occupancy.txt
