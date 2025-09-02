#!/bin/bash
#SBATCH --job-name=get_gwases
#SBATCH --output=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/get_GWASs_log/locus_%A_%a.out # Must have a logs folder. Must specify full path.
#SBATCH --error=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/get_GWASs_log/locus_%A_%a.err # Must have a logs folder
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G # Increase this as needed for MungeSumstats
#SBATCH --singularity-container stg-default.sif
#SBATCH --time=01:00:00

cd ~/fine_mapping/GWAS_sumstats_G

IFS=$'\t' read -r trait study ancestry h_link <<< "$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$HOME/fine_mapping/GWAS_sumstats_G/missing_GWASs.tsv")"

mkdir -p ${trait}_sumstats
cd ${trait}_sumstats

if [[ "$h_link" != "NA" ]]; then
  if [ ! -s "${trait}_${study}_${ancestry}_sumstats_GRCh38.tsv.gz" ]; then
    wget "${h_link}" -O ${trait}_${study}_${ancestry}_sumstats_GRCh38.tsv.gz
  else
    echo "Skipping because file alr. exists"
  fi
else
    echo "Skipping because my_var is NA"
fi


#chmod +x $HOME/fine_mapping/slurm_scripts/getGWAS.sh

#wc -l $HOME/fine_mapping/GWAS_sumstats_G/missing_GWASs.tsv # How many rows in the positions tables

# 81. put this number in slurm array

#cd $HOME/fine_mapping/GWAS_sumstats_G

#sbatch --array=1-141%5 $HOME/fine_mapping/slurm_scripts/getGWAS.sh # Change the 1-X for number of rows

#scontrol show job 68159 # Check on job based on number
