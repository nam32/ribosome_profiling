#!/bin/bash

source ./module.sh

mkdir -p ./annotation/{genome_annotation, undesired_RNA, transcriptome_annotation}
mkdir dataset
mkdir results

cd ./annotation/undesired_RNA

wget -O undesired_rRNA_snRNA_snoRNA.fa 'http://www.ensembl.org/biomart/martservice?query=<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query><Query  virtualSchemaName = "default" formatter = "FASTA" header = "0" uniqueRows = "0" count = "" datasetConfigVersion = "0.6" ><Dataset name = "hsapiens_gene_ensembl" interface = "default" ><Filter name = "transcript_biotype" value = "rRNA,snoRNA,snRNA"/><Attribute name = "ensembl_gene_id" /><Attribute name = "ensembl_gene_id_version" /><Attribute name = "ensembl_transcript_id" /><Attribute name = "ensembl_transcript_id_version" /><Attribute name = "gene_exon_intron" /></Dataset></Query>'

wget -O undesired_tRNA.fa http://gtrnadb.ucsc.edu/genomes/eukaryota/Hsapi38/hg38-tRNAs.fa

esearch -db nuccore -query 'biomol_rRNA[prop] AND "Homo sapiens"[Organism]' | efetch -format fasta > undesired_GRCh38_rRNA_NCBI.fa

cat undesired_rRNA_snRNA_snoRNA.fa undesired_tRNA.fa undesired_GRCh38_rRNA_NCBI.fa  > GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb.fa

cd ../genome_annotation

wget https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-108/gtf/homo_sapiens/Homo_sapiens.GRCh38.108.gtf.gz
gunzip *

cd ../transcriptome_annotation

wget -O GRCh38_APPRIS_CDS_18.fa 'http://www.ensembl.org/biomart/martservice?query=<Dataset name = "hsapiens_gene_ensembl" interface = "default" ><Filter name = "downstream_flank" value = "18"/><Filter name = "upstream_flank" value = "18"/><Filter name = "transcript_biotype" value = "protein_coding"/><Filter name = "transcript_appris" excluded = "0"/><Attribute name = "ensembl_gene_id" /><Attribute name = "ensembl_gene_id_version" /><Attribute name = "ensembl_transcript_id" /><Attribute name = "ensembl_transcript_id_version" /><Attribute name = "coding" /><Attribute name = "external_gene_name" /></Dataset></Query>
