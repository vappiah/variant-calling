#!/bin/bash

mkdir data
mkdir data/fastq
mkdir data/fastq/raw_reads
fastqdir=data/fastq/raw_reads

wget -c -O ${fastqdir}/normal_r1.fastq.gz https://zenodo.org/record/2582555/files/SLGFSK-N_231335_r1_chr5_12_17.fastq.gz
wget -c -O  ${fastqdir}/normal_r2.fastq.gz https://zenodo.org/record/2582555/files/SLGFSK-N_231335_r2_chr5_12_17.fastq.gz
wget -c -O  ${fastqdir}/tumor_r1.fastq.gz https://zenodo.org/record/2582555/files/SLGFSK-T_231336_r1_chr5_12_17.fastq.gz
wget -c -O  ${fastqdir}/tumor_r2.fastq.gz https://zenodo.org/record/2582555/files/SLGFSK-T_231336_r2_chr5_12_17.fastq.gz



mkdir data/ref
wget -c -O data/ref/hg19.chr5_12_17.fa.gz https://zenodo.org/record/2582555/files/hg19.chr5_12_17.fa.gz
gunzip data/ref/hg19.chr5_12_17.fa.gz
wget -c -P data https://raw.githubusercontent.com/timflutre/trimmomatic/master/adapters/TruSeq3-PE.fa

