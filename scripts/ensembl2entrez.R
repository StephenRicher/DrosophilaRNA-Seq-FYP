#!/usr/bin/env Rscript

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

list.of.packages <- c("org.Dm.eg.db")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) BiocManager::install("org.Dm.eg.db")

library("org.Dm.eg.db")

# Retrieve ensembl to entrez mapping
conversion = toTable(org.Dm.egENSEMBL)

# Write each ensemble to entrez as SED script file
script = paste('s/', conversion$ensembl_id, '/', conversion$gene_id, '/g', sep='')

# Save to file
write.table(script, row.names=FALSE, col.names=FALSE, quote=FALSE, file=stdout())
