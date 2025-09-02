# Autoimmune Fine Mapping Using SuSiE (Summer 2025 Project)
This repository contains all the required materials to replicate the FM work Max and I completed during summer 2025. Information on the repo contents, general workflow, and SUSIR/SUSIEX outlined below. 

## Repo Contents
**Fine_Mapping_Trait_RMDs/20250813_FM_Study_Script.Rmd**:  The main Markdown for the FM process. Contains all info to complete FM for a single study from scratch, including instructions on downloading 1K Genomes files. The Markdown is my best attempt at streamlining the FM process and was created with the hope that the only changes required would be replacing the Trait and GWAS info (trait, study, sample size, etc). 
  
install_tools/: Contains instructions on installing required tools in Posit. Contains instructions for vcftools and plink, which are required for SUSIER. Also contains instructions for installing **SuSiEX**.  

slurm_scripts/
- MungeSumstats_flipfrq_slurm.R: Munge R Script that is run by shell script of the same name.   
- MungeSumstats_flipfrq_slurm.sh: Run Munge R script in Slurm for one study. Attempted to Munge multiple GWASs at once using Slurm. Wasn't super successful because of GWAS variation and memory/time constraints, but the code is there.   
- MungeSumstats_slurm.R: DESCRIPTION  
- MungeSumstats_slurm.sh: DESCRIPTION  
- VCFS_plink_LD_slurm.sh: Slurm script for creating VCFs in Step BLANK. Creates VCFs of only GWAS positions around each lead loci in parallel. 
- getGWAS.sh: Slurm script for downloading all harmonized GWASs in the RUN_FM_TABLE.tsv in parallel.  
- subset_1000g_for_LD_check.sh: Slurm script for creating VCFs in Step BLANK. Creates VCFs for each area around the lead loci in parallel.   
  
RUN_FM_TABLE: Subsetted metadata table for MPRA library. Contains information on 311 GWASs which we hope to FM. Columns include: (Trait, Study, Ancestry, N, Associations, N_Associations, GWAS_h_Link, Other_GWAS_Link). Progress log for FM these GWASs can be found HERE. Original table created by LeAnn Nguyen can be found [here](https://bri.box.com/s/9tf23s7hxsaz5lzaimc6jd08o81g64xt). 

## Workflow
### If starting from beginning:
1. **Download 1000 genome files.** Instructions in 20250813_FM_Study_Script.Rmd.
2. **Subset EUR and EAS 1000 genome sample IDs.** Instructions in 20250813_FM_Study_Script.Rmd.
3. **Install plink.** Instructions in install_tools/intall_plink.
4. **Install vcftools.** Instructions in install_tools/install_vcftools.
5. **Install required packages.** Instructions: [SusieR](https://github.com/stephenslab/susieR), [MungeSumstats](https://www.bioconductor.org/packages/release/bioc/html/MungeSumstats.html), [Munge dbSNP GRCh packages](https://www.bioconductor.org/packages/devel/bioc/vignettes/MungeSumstats/inst/doc/MungeSumstats.html), [SusieX](https://github.com/getian107/SuSiEx)
6. **Download RUN_FM_TABLE.tsv.** In the repo.
7. **(SusieX) Create 1000 genomes plink files.** Instructions in BLANK:

### (SusieR) If starting with a new study: 
1. Choose which study to FM from RUN_FM_TABLE.tsv. Get following info: Trait, Study, GWAS link, genome build (if possible).
2. Download the GWAS from GWAS catalog
3. Munge the GWAS
4. Liftover the GWAS (if needed)
5. Create associations table
6. 

### (SusieX) If starting with a new study: 


## Sample Directory
Example FM directory:
- fine_mapping
    - FM_Trait_RMDs
    - FM_results
    - GWAS_sumstats
    - 1000_genomes
        - 1000g_hg19
        - 1000h_hg38
    - install_tools

## Githubs
[SusieR](https://stephenslab.github.io/susieR/)  
[SusieX](https://github.com/getian107/SuSiEx)

