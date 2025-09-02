#!/bin/bash
#SBATCH --job-name=process_locus_LD_block
#SBATCH --output=slurm_logs/locus_%A_%a.out
#SBATCH --error=slurm_logs/locus_%A_%a.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --singularity-container default.sif
#SBATCH --time=01:00:00

main_directory="$HOME/fine_mapping/"
trait="Asthma"
study="GCST90086047"
ancestry="EUR"

cd ${main_directory}finished_loci/${trait}_${study}_${ancestry}

read rsid chr pos19 <<< $(sed -n "${SLURM_ARRAY_TASK_ID}p" "${main_directory}tables/${trait}_tables/Lead_SNPs_${study}.tsv")

vcftools \
  --gzvcf ${main_directory}1000_genome_files/hg19_1000g/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
  --chr ${chr} \
  --from-bp $((${pos19}-100000)) \
  --to-bp $((${pos19}+100000)) \
  --recode \
  --out ${main_directory}FM_results/${trait}/${trait}_${study}_${ancestry}/${rsid}/LD_block_check/${rsid}.1000g.region
  
  
#chmod +x ${main_directory}slurm_scripts/subset_1000g_for_LD_check.sh # Making sure slurm script is executable

#wc -l ${main_directory}tables/${Trait}_tables/Lead_SNPs_${Study}.tsv # How many rows in the positions tables

# 81. put this number in slurm array

#cd ${main_directory}FM_results/${Trait}/${Trait}_${Study}_${Ancestry}

#sbatch --array=1-3 ${main_directory}slurm_scripts/subset_1000g_for_LD_check.sh # Change the 1-X for number of rows

#scontrol show job 68642 # Check on job based on number
