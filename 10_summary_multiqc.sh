#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=multiqc
#SBATCH --time=01:00:00

####

# input: log files
# output: multiqc html report
# This script generates multiqc report

####

source ./module.sh

cd ./preprocessing
multiqc *log.txt
