#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000MB
#SBATCH --job-name=multiqc
#SBATCH --time=01:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

####

# input: 
# output: 
# 

####

source ./module.sh

cd ./preprocessing
multiqc *log.txt
