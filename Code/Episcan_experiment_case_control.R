# install.packages("episcan")
library(episcan)
library(dplyr)

# wsl.exe for open bash ---------------------------------------------------


args = commandArgs(trailingOnly=TRUE)
name = args[1]

base_dir = args[2]


complete_SNP_data <- read.delim(paste0(base_dir, name))

pheno = complete_SNP_data$Class
SNP_data = as.matrix(complete_SNP_data %>% select(-Class))



str(SNP_data)
SNP_data = apply(SNP_data, 2, as.numeric)

set.seed(123)
# one genotype with case-control phenotype
episcan(geno1 = SNP_data,
        geno2 = NULL,
        pheno = pheno,
        phetype = "case-control",
        outfile = "episcan_notcorrected",
        suffix = ".txt",
        zpthres = 0.9,
        chunksize = 1000,
        scale = TRUE)
# take a look at the result

res <- read.table("episcan_notcorrected.txt",
                  header = TRUE,
                  stringsAsFactors = FALSE)
# head(res)
