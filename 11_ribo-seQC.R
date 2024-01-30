# Install packages
install.packages("devtools")
#install_github(repo = "ohlerlab/RiboseQC")

# Load packages
# NOTE: for RiboseQC package:
# Download the fork of RiboseQC either by git clone or direct download of zip file.
# Comment out line 2283 (genome_sequence<-get(library(GTF_annotation$genome,character.only = TRUE)))
# Edit line 2694 from n_transcripts = length(unique(gtfdata$transcript_id)) to n_transcripts = length(unique(na.omit(gtfdata$transcript_id)))
# Press Cmd/Ctrl + Shift + 0 or Session > Restart R
# remove.packages("RiboseQC") if it was installed before
# In the terminal, navigate to the directory which contains correct RiboseQC code, Issue the command R CMD build RiboseQC/ which should make RiboseQC_0.99.0.tar.gz
# Open RStudio and install.packages("/path/to/RiboseQC_0.99.0.tar.gz", repos = NULL, type="source")

library(devtools)
library(RiboseQC)

# input file: GRCh38.dna.primary_assembly.2bit, Homo_sapiens.GRCh38.108.gtf, RPF_*_Rep*_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam
# output file: RPF_samples_QC.html

###### Analysis part ######
# Prepare genome file (to be done only once!!!)
prepare_annotation_files(annotation_directory = ".",
                         twobit_file = "GRCh38.dna.primary_assembly.2bit",
                         gtf_file = "Homo_sapiens.GRCh38.108.gtf",
                         scientific_name = "Homo.sapiens",
                         annotation_name = "GRCh38",
                         export_bed_tables_TxDb = F,
                         forge_BSgenome = T,
                         create_TxDb = T)


# Genome mapped sorted-BAM files

genome_bam <- c("RPF_WT_Rep1_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam",
                "RPF_WT_Rep2_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam",
                "RPF_KO_Rep1_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam",
                "RPF_KO_Rep2_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam")

load_annotation("Homo_sapiens.GRCh38.108.gtf_Rannot")

###### QC plots ######

RiboseQC_analysis(annotation_file ="Homo_sapiens.GRCh38.108.gtf_Rannot",
                  bam_files = genome_bam,
                  fast_mode = T,
                  report_file = "RPF_samples_QC.html",
                  sample_names = c("WT_Rep1", "WT_Rep2",
                                   "KO_Rep1", "KO_Rep2"),
                  dest_names = c("WT_Rep1", "WT_Rep2",
                                 "KO_Rep1", "KO_Rep2"),
                  write_tmp_files = F)
