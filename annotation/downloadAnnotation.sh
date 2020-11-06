#!/usr/bin/env bash

# Download BDGP6.28 genes
wget ftp://ftp.ensembl.org/pub/release-101/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP6.28.101.gtf.gz -O DrosophilaMelanogaster-BDGP6.28.gtf.gz

# Make SED script file of ensembl to entrex
Rscript ../scripts/ensembl2entrez.R > ensembleEntrez.txt

# Convert ENSEMBL ids to entrez for edgeR GO analysis
sed -f ensembleEntrez.txt <(zcat DrosophilaMelanogaster-BDGP6.28.gtf.gz) | gzip > DrosophilaMelanogaster-BDGP6.28-entrez.gtf.gz

# Download blacklist
wget https://github.com/Boyle-Lab/Blacklist/blob/master/lists/dm6-blacklist.v2.bed.gz?raw=true -O DrosophilaMelanogaster-DM6-blacklist.bed
