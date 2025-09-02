# Autoimmune Fine Mapping (Summer 2025 Project)
This repository contains all the required materials to replicate the FM work Max and I completed during summer 2025. Information on the repo contents, general workflow, and SUSIR/SUSIEX outlined below. 

## Repo Contents
Fine_Mapping_Trait_RMDs/**20250813_FM_Study_Script.Rmd**:  The main Markdown for the FM process. Contains all info to complete FM for a single study from scratch, including instructions on downloading 1K Genomes files. The Markdown is my best attempt at streamlining the FM process and was created with the hope that the only changes required would be replacing the Trait and GWAS info (trait, study, sample size, etc). 
  
install_tools/: Contains instructions on installing required tools in Posit. Contains instructions for vcftools and plink, which are required for SUSIER. Also contains instructions for installing **SuSiEX**.  

slurm_scripts/
- MungeSumstats_flipfrq_slurm.R: DESCRIPTION  
- MungeSumstats_flipfrq_slurm.sh: DESCRIPTION  
- MungeSumstats_slurm.R: DESCRIPTION  
- MungeSumstats_slurm.sh: DESCRIPTION  
- VCFS_plink_LD_slurm.sh: DESCRIPTION  
- getGWAS.sh: DESCRIPTION  
- subset_1000g_for_LD_check.sh: DESCRIPTION  
  
RUN_FM_TABLE: Subsetted metadata table for MPRA library. Contains information on 311 GWASs which we hope to FM. Columns include: (Trait, Study, Ancestry, N, Associations, N_Associations, GWAS_h_Link, Other_GWAS_Link). Progress log for FM these GWASs can be found HERE.

## Workflow


## Sample Directory
Example FM directory:
- fine_mapping
    - FM_Trait_RMDs
    - FM_results
    - 1000_genomes
        - 1000g_hg19
        - 1000h_hg38
    - install_tools

## Githubs
[SusieR](https://stephenslab.github.io/susieR/)  
[SusieX](https://github.com/getian107/SuSiEx)

