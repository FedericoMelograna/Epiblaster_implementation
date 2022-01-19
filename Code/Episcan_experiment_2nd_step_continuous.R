
# Hilbert-Schmitt Independence Criterion (HSIC)

# Reference: https://amber0309.github.io/2017/01/13/hsic/

# CODE

# Reference: https://cran.r-project.org/web/packages/episcan/index.html


library(episcan)
library(dplyr)


# Parameters

args = commandArgs(trailingOnly=TRUE)
name = args[1]
base_dir = args[2]



complete_SNP_data <- read.delim(paste0(base_dir, name))
pheno = complete_SNP_data$Class
SNP_data = as.matrix(complete_SNP_data %>% select(-Class))


# str(SNP_data)
set.seed(123)

print("CONTINUOUS ANALYSIS ----")
# take a look at the result
res <- read.table("episcan_SORTED_filt.txt",
                  header = TRUE,
                  stringsAsFactors = FALSE)
# head(res)




dataset_results <- data.frame(SNP1=character(),
                              SNP2=character(),
                              Zscore = numeric(),
                              ZP = numeric(),
                              glm_score = numeric())

# Loop over every row in results - Not optimized
for (i in 1:nrow(res))
{
  riga = res[i,]
  c1 = complete_SNP_data %>% select(riga[1]$SNP1, riga[2]$SNP2)
  ris = glm(pheno ~ c1[,1] * c1[,2], family=gaussian() ) # LM (gaussian) for continuous
  if (!is.na(ris$coefficients[length(ris$coefficients)]) )
  {
    sum = summary(ris)
    sss = sum$coefficients[4,4]
    dataset_results = rbind(dataset_results, cbind(riga, glm_score = sss))
    # print(i)
  }
  else
  {
    dataset_results = rbind(dataset_results, cbind(riga, glm_score = NA))
  }
  if (i%%500 == 0) {
    print(i)
  }
  
}


write.table(dataset_results, file = "GLM_second_step_NOT_Corrected.txt",quote = F,sep = "\t",col.names = T)

# NA REMOVAL 

write.table(dataset_results[complete.cases(dataset_results),],file = "GLM_second_step_NA_elim.txt",quote = F,sep = "\t",col.names = T)
