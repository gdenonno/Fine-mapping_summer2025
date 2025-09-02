#!/bin/bash
#SBATCH --job-name=munge_sumstats
#SBATCH --output=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/slurm_logs/locus_%A_%a.out # Must have a logs folder. Must specify full path.
#SBATCH --error=/nfs/gdenonno/fine_mapping/GWAS_sumstats_G/slurm_logs/locus_%A_%a.err # Must have a logs folder
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G # Increase this as needed for MungeSumstats
#SBATCH --singularity-container stg-default.sif
#SBATCH --time=01:00:00

# Load R and run the script
Rscript ~/fine_mapping/slurm_scripts/MungeSumstats_slurm.R

# Run slurm 
# sbatch ~/finemapping_with_susieR/20250728_what_GWAS_are_good/MungeSumstats_slurm.sh
# Check on job
# scontrol show job 59594









