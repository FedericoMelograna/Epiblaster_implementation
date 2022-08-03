#!/bin/bash
#SBATCH --ntasks=1 #each job has one task
#SBATCH --cpus-per-task=2 # each task uses 1 cpu
#SBATCH --partition=urtgen_unlimit
#SBATCH --mem-per-cpu=30000 #8GB

source /home/u/f058977/miniconda3/etc/profile.d/conda.sh
conda activate r_env

cd /massstorage/URT/GEN/BIO3/Federico/GENNADY_project_genNEt/

echo $1
filepath=`pwd`
mkdir Epiblaster_simulation/Novel_Gametes_results_$1

Epiblaster_simulation/Code/iterator_on_files.sh $filepath/Gametes_full_data/gametes_001/$1/ $filepath/Epiblaster_simulation/Novel_Gametes_results_$1/ $filepath/Epiblaster_simulation/Code case_control
