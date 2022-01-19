#!/bin/bash


# Parameters parsing

file=($1)
base_dir=($2)
code_dir=($3)
phenotype=($4)

# Directories 

# echo $file
dirs="${file%%.*}"
# echo $dirs
mkdir -p $dirs
cd ./$dirs


# First step (sudo needed in the git bash original script)

if [ "$phenotype" == "case_control" ]; then
    sudo Rscript ${code_dir}/Episcan_experiment_case_control.R $file $base_dir
    echo "Case control analysis"
else
    sudo Rscript ${code_dir}/Episcan_experiment_continuous.R $file $base_dir
    echo "Continuous analysis"
fi


# Filtering. 4.5 the suggested one in the paper

awk '$3 > 3.5 || $3 < -3.5' episcan_notcorrected.txt  > filter_episcan_1geno_threshold3_5.txt
awk '$3 > 4.5 || $3 < -4.5' episcan_notcorrected.txt  > filter_episcan_1geno_threshold4_5.txt
awk '$3 > 2.5 || $3 < -2.5' episcan_notcorrected.txt  > filter_episcan_1geno_threshold2_5.txt


result_dim25=$(wc -c filter_episcan_1geno_threshold2_5.txt | awk '{print $1}')
result_dim35=$(wc -c filter_episcan_1geno_threshold3_5.txt | awk '{print $1}')


# use different threhsolds based on the dimension > 500 kb --> stricter threhsold
if [[ "$result_dim35" -gt "500000" ]]; then 
 (head -n 1 filter_episcan_1geno_threshold4_5.txt && tail -n +2 filter_episcan_1geno_threshold4_5.txt | sort -g -k4,4 ) > episcan_SORTED_filt.txt  

elif [[ "$result_dim25" -gt "500000" ]]; then
 (head -n 1 filter_episcan_1geno_threshold3_5.txt && tail -n +2 filter_episcan_1geno_threshold3_5.txt | sort -g -k4,4 ) > episcan_SORTED_filt.txt  

else
 (head -n 1 filter_episcan_1geno_threshold2_5.txt && tail -n +2 filter_episcan_1geno_threshold2_5.txt | sort -g -k4,4 ) > episcan_SORTED_filt.txt  

fi


# check if the resulting file is not empty (only names )

file_dim=$(wc -c episcan_SORTED_filt.txt | awk '{print $1}')
echo "File dimension"
echo $file_dim

# if dim < 40 --> no interesting interacting pairs detected

if [[ "$file_dim" -gt "40" ]]; then
  # second step: the GLM/LM procedure

 if [ "$phenotype" == "case_control" ]; then
    sudo Rscript  ${code_dir}/Episcan_experiment_2nd_step_case_control.R $file $base_dir
    echo "Case control 2nd step analysis"
 else
    sudo Rscript  ${code_dir}/Episcan_experiment_2nd_step_continuous.R $file $base_dir
    echo "Continuous analysis"
 fi 
 (head -n 1 GLM_second_step_NA_elim.txt && tail -n +2 GLM_second_step_NA_elim.txt | sort -g -k6,6 ) > episcan_GLM_second_SORTED.txt  

fi

cd ..
