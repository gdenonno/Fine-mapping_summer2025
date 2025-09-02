#!/bin/bash
#SBATCH --job-name=process_locus
#SBATCH --output=slurm_logs/locus_makevcf_%A_%a.out
#SBATCH --error=slurm_logs/locus_makevcf_%A_%a.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --singularity-container default.sif
#SBATCH --time=01:00:00

main_directory="$HOME/fine_mapping/"
trait="Asthma"
study="GCST90086047"
ancestry="EUR"

cd ${main_directory}FM_results/${trait}_${study}_${ancestry}

read rsid chr pos19 <<< $(sed -n "${SLURM_ARRAY_TASK_ID}p" "${main_directory}tables/${trait}_tables/${study}_lead_SNPs_filtered_by_LD.tsv")

vcftools \
  --gzvcf ${main_directory}1000_genome_files/hg19_1000g/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
  --positions ${rsid}/${rsid}_gwas_snps_hg19.txt \
  --out ${rsid}/${rsid}.locus.${ancestry} \
  --recode \
  --maf 0.01\
  --keep-INFO-all


#Execution: 

#cd ${main_directory}FM_results/${Trait}/${Trait}_${Study}_${Ancestry}

#chmod +x ${main_directory}slurm_scripts/VCFS_plink_LD_slurm.sh # Making sure slurm script is executable

#wc -l ${main_directory}tables/${Trait}_tables/${Study}_lead_SNPs_filtered_by_LD.tsv # How many rows in the positions tables

# 19. put this number in slurm array

#sbatch --array=1-3 ${main_directory}slurm_scripts/VCFS_plink_LD_slurm.sh # Change the 1-X for number of rows

#scontrol show job 68657 # Check on job based on number
