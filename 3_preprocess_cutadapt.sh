#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=preprocessing_target_sequence
#SBATCH --time=01:00:00

####

# input: *.fastq.gz
# output: *.fastq.gz, *_log.txt
# This script preprocess data by clipping adapters and quality trimming

####

source ./module.sh

mkdir results

cd /data/users/tjanjumratsang/ribosome_profiling/dataset

# Clip 3' adapter
for x in $(ls -d *.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-a CTGTAGGCACCATCAAT \
-q 25 \
--minimum-length 25 \
--discard-untrimmed \
-o ../results/$(basename ${x} .fastq.gz)_clpd.fastq.gz \
${x} 1> ../results/$(basename ${x} .fastq.gz)_clpd_log.txt; done

cd ../results
# Trim 4 nt (randomized bases) from the 3' end
for x in $(ls -d *_clpd.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-q 25 \
--cut -4 \
--minimum-length 25 \
-o $(basename ${x} .fastq.gz)_tr.fastq.gz \
${x} 1> $(basename ${x} .fastq.gz)_tr_log.txt; done
