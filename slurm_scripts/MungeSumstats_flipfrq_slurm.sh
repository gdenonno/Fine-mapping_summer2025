#!/bin/bash
#SBATCH --job-name=munge_sumstats
#SBATCH --output=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/slurm_logs/locus_%A_%a.out # Must have a logs folder. Must specify full path.
#SBATCH --error=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/slurm_logs/locus_%A_%a.err # Must have a logs folder
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G# Increase this as needed for MungeSumstats
#SBATCH --singularity-container stg-default.sif
#SBATCH --time=01:00:00

set -euo pipefail

main_directory="$HOME/fine_mapping/"

#LINE=${SLURM_ARRAY_TASK_ID}
LINE=53

IFS=$'\t' read -r trait study ancestry h_link <<< "$(sed -n "${LINE}p" "$HOME/fine_mapping/RUN_FM_TABLE_download_GWAS.tsv")"

cd ${main_directory}/GWAS_sumstats_G/${trait}_sumstats

if [ -s "${trait}_${study}_${ancestry}_sumstats_GRCh38.tsv.gz" ]; then

  if [ ! -s "${trait}_${study}_${ancestry}_sumstats_GRCh38_MUNGED.tsv.gz" ]; then

      MAX_SIZE=$((1024 * 1024 * 1024))
      FILE_SIZE=$(stat -c%s "${trait}_${study}_${ancestry}_sumstats_GRCh38.tsv.gz")
        
      if [ "$FILE_SIZE" -lt "$MAX_SIZE" ]; then
        
        mkdir -p ${study}_munge_logs

        # Load R and run the script
        Rscript ~/fine_mapping/slurm_scripts/MungeSumstats_flipfrq_slurm.R "$trait" "$study" "$ancestry"
      
      else 
        echo "skipping bc file is too large"
      fi

  else 
      echo "skipping bc munge file alr. exists"
  fi
  
else 
  echo "skipping because sumstats file does not exist"
fi



#chmod +x $HOME/fine_mapping/slurm_scripts/MungeSumstats_flipfrq_slurm.sh

#wc -l $HOME/fine_mapping/RUN_FM_TABLE_download_GWAS.tsv # How many rows in the positions tables

# 81. put this number in slurm array

#cd $HOME/fine_mapping/GWAS_sumstats_G

#sbatch --array=21-30%2 $HOME/fine_mapping/slurm_scripts/MungeSumstats_flipfrq_slurm.sh # Change the 1-X for number of rows

#sbatch $HOME/fine_mapping/slurm_scripts/MungeSumstats_flipfrq_slurm.sh # Change the 1-X for number of rows

#scontrol show job 68636 # Check on job based on number









