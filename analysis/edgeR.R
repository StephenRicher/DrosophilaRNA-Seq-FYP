library(edgeR)

setwd('~/phd/teaching/Drosophila-RNA-Seq/analysis/')

# Set up design matrix
diet = factor(c(rep('Control', 18), rep('DR', 18)))
diet = relevel(diet, ref='Control')
tissue = factor(rep(c(rep('Body', 6), rep('Head', 6), rep('Ovary', 6)), 2))
group = factor(paste(diet, tissue, sep='.'))

design = model.matrix(~0+group)
colnames(design) <- levels(group)

my.contrasts = makeContrasts(
  Body.DRvsControl = DR.Body - Control.Body,
  Head.DRvsControl = DR.Head - Control.Head,
  Ovary.DRvsControl = DR.Ovary - Control.Ovary,
  Control.BodyvsHead = Control.Body - Control.Head,
  levels=design
)

# Load count matrix
countMatrix = read.csv('countMatrix-merged.txt', row.names=1)

# Load counts
y <- DGEList(counts=countMatrix, group=diet)

# Filter
keep <- filterByExpr(y)
y <- y[keep, , keep.lib.sizes=FALSE]

# Normalise using TMM
y <- calcNormFactors(y)

# Estimate dispersions
y <- estimateDisp(y, design, robust=TRUE)

# Estimate dispersions
fit <- glmQLFit(y, design, robust=TRUE)

qlf <- glmQLFTest(fit, contrast=my.contrasts[,c("Body.DRvsControl")])


go = goana(qlf, species='Dm')
topGO(go, sort="up")
keg = kegga(qlf, species='Dm', convert=TRUE)
g = topKEGG(keg, sort='up')









qlf <- glmQLFTest(fit, contrast=my.contrasts[,c("Control.BodyvsHead")])






