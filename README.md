# Ribosome Profiling Data Analysis

Ribosome Profiling data analysis pipeline including preprocessing, differential expression analysis, GO analysis and codon occupancy analysis based on Dr. Puneet Sharma workflow.

****Annotations downloads**** (as written by Dr. Puneet Sharma)

**“Undesired RNA” annotation** (3 sources were used to obtain sno-, sn- and r-RNA; tRNA; and rRNA):

FASTA file containing rRNA, snRNA and snoRNA sequences can be generated from Ensembl biomart:
1.  Database: Ensembl Genes (Version)
2.  Dataset: Human genes (Version)
3.  Click “Filters”
4.  Expand the “Gene” tab
5.  Select Transcript type: rRNA, snRNA, snoRNA
6.  Click “Attributes”
7.  Select “Sequences” (Radio button) and expand the “Sequences” tab
8.  Select “Unspliced (gene)”
9.  Expand the “Header information” tab
10. Select “Gene stable ID”
11. Click “Count”
12. Click “Results”
13. Download the FASTA file

tRNA FASTA sequences can be obtained from Genomic tRNA database:
1. Under “Links to Most Viewed Genomes”, select “Homo sapiens (GRCh38/hg38)”
2. On the left hand side, select “FASTA Seqs”
3. Download “High confidence tRNA sequences: hg38-tRNAs.fa”

NCBI Nucleotide module to procure 45S, 28S, 18S, 5.8S, 5S rRNA sequences.
1. Search: biomol_rRNA[prop] AND “Homo sapiens”[Organism].
2. On the top right, click “Send to”
3. Select “File”
4. Select Format: FASTA
5. Click “Create File”

Concatenate the 3 files into a single FASTA file to form undesired RNA file.

**Genome annotation**
The reference genome annotation can be procured from Ensembl by clicking on the DNA(FASTA) of Homo sapiens. Upon clicking the link you will be redirected to the Ensembl FTP server where you will encounter a bunch of files. The file you are interested in will be named “Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz” (called GRCh38.dna.primary_assembly.fa in the solution below)

Also download the relevant GTF file from Ensembl under “Gene sets” named Homo_sapiens.GRCh38.108.gtf.gz (at the time of writing).

**Transcriptome annotation**
A FASTA file containing sequences of principle splice isoforms that are extended by 18 nt in 5’- and 3’- ends can be generated from Ensembl biomart by clicking-on/selecting the following options in order:

1. Database: Ensembl Genes (Version)
2.  Dataset: Human genes (Version)
3.  Click “Filters”
4.  Expand the “Gene” tab
5.  Select Transcript type: protein_coding
6.  Check APPRIS annotation
7.  Click “Attributes”
8.  Select “Sequences” (Radio button) and expand the “Sequences” tab
9.  Select “Coding sequence”
10. Check Upstream flank and provide the value “18”
11. Check the Downstream flank and provide the value “18”
12. Expand the “Header information” tab
13. Select “Transcript stable ID” and “Gene name”
14. Click “Count”
15. Click “Results”
16. Download the FASTA file (called GRCh38_APPRIS_CDS_18.fa in this module)
