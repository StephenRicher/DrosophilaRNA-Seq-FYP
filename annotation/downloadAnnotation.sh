#!/usr/bin/env bash

# Download BDGP6.28 genes
wget ftp://ftp.ensembl.org/pub/release-101/gff3/drosophila_melanogaster/Drosophila_melanogaster.BDGP6.28.101.gff3.gz -O DrosophilaMelanogaster-BDGP6.28.gff3.gz
gunzip DrosophilaMelanogaster-BDGP6.28.gff3.gz

# Make SED script file of ensembl to entrex
Rscript ../scripts/ensembl2entrez.R > ensembleEntrez.txt

# Convert ENSEMBL ids to entrez for edgeR GO analysis
sed -f ensembleEntrez.txt DrosophilaMelanogaster-BDGP6.28.gff3 > DrosophilaMelanogaster-BDGP6.28-entrez.gff3

# Download blacklist
wget https://github.com/Boyle-Lab/Blacklist/blob/master/lists/dm6-blacklist.v2.bed.gz?raw=true -O DrosophilaMelanogaster-DM6-blacklist.bed
