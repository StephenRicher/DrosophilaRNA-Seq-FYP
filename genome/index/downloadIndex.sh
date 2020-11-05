#!/usr/bin/env bash

# Download bdgp6 hisat2 genome index
wget https://genome-idx.s3.amazonaws.com/hisat/bdgp6_tran.tar.gz

# Unpack archive
tar -xzf bdgp6_tran.tar.gz

# Delete archive
rm bdgp6_tran.tar.gz

# Move upackaged contents to current directory
mv bdgp6_tran/* .
# Remove empty directory
rmdir bdgp6_tran

# Rename index files
for file in genome_tran*ht2; do
  mv "${file}" "${file/genome_tran/bdgp6_tran}"
done
