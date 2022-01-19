#!/bin/bash

# Parameters
base_dir=($1)
result_dir=($2)
code_dir=($3)
phenotype=($4)



mkdir -p $result_dir
cd $result_dir

for el in ${base_dir}/*.txt
do
if [[ $el != *"2D"* ]]; then
 # echo "It's there!"
 echo $el
 ${code_dir}/script_with_parameter.sh "${el##*/}" ${base_dir} ${code_dir} ${phenotype}

fi

done
