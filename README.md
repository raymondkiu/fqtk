# fqtk
FASTQ toolkit: A program written in Bash to perform common task on FASTQ reads including renaming identifiers, printing FASTQ statistics and converting FASTQ to FASTA.

## Usage
'''
This program provides several scripts to perform common tasks on sequences in standard FASTQ format

For user manual please go to: https://github.com/raymondkiu/fqtk

Usage: fqtk [options] FASTQ

Options:
 -a Rename FASTQ identifier for FASTQ reads. Optionally with /1 or /2. Usage: ./fqtk -a R1.FASTQ NEWIDENTIFIER /1
 -q Print FASTQ stats
 -t Convert FASTQ to FASTA. Usage: ./fqtk -t FASTQ > NEWFILENAME
 -r Print FASTQ stats in tabular format
 -h Print usage and exit
 -v Print version and exit

Version 1.0 (2022)
Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk
'''
