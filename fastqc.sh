#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1500MB
#SBATCH --job-name=fastqc
#SBATCH --time=01:00:00
#SBATCH --mail-user=titaporn.janjumratsang@students.unibe.ch
#SBATCH --mail-type=begin,end

####

# input: fasta file(s)
# output: zip file(s)
# This script fastqc report, the script should be run with syntax: sbatch fastqc.sh "foldername" "path/to/directory/regex_doc"

####

source ./module.sh

# check if the number of arguments provided is not equal to 2
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide two arguments - output folder name and file regex pattern."
    echo "Usage: bash $0 <output_folder_name> <file_regex_pattern>"
    exit 1
fi


# Take inputs for output folder name and file regex pattern
output_folder=$1
file_pattern=$2

output_dir="./${output_folder}_fastqc"

# Create the output directory if it doesn't exist
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# List the files that match the provided regex pattern
echo "Files matching pattern ${file_pattern}:"
find . -type f -path "$file_pattern" -exec basename {} \;

# Run FastQC with the provided inputs
fastqc -o ./"${output_folder}_fastqc" -f fastq $(find . -type f -path "$file_pattern")

