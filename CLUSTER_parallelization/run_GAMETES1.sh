#!/bin/bash
#SBATCH --partition=urtgen_unlimit
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem-per-cpu=4500
#SBATCH --array=1-30 ## NUMBER OF ROWS in aa.txt




cd /massstorage/URT/GEN/BIO3/Federico/GENNADY_project_genNEt/Gametes_full_data/gametes_001
direct=`head -$SLURM_ARRAY_TASK_ID Full_Gametes_list.txt | tail -1 | cut -d " " -f1`
cd /massstorage/URT/GEN/BIO3/Federico/GENNADY_project_genNEt/Epiblaster_simulation
mkdir -p GAMETES_001

sbatch ./sbatch_file_epiblaster_multiples.sh $direct

mv Novel_Gametes_results_Gametes_simulation_* GAMETES_001/
