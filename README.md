# Fine Mapping of Autoimmune Traits Using SuSiE (Summer 2025 Project)
This repository contains all the required materials to replicate the FM work Max and I completed during Summer 2025. Information on the repo contents, general workflow, and SUSIER/SUSIEX outlined below. 

## Contents
**Fine_Mapping_Trait_RMDs/20250813_FM_Study_Script.Rmd**:  The main Markdown for the FM process. Contains all info to complete FM for a single study from scratch, including instructions on downloading 1K Genomes files. The Markdown is my best attempt at streamlining the FM process and was created with the hope that the only changes required would be replacing the Trait and GWAS info (trait, study, sample size, etc). 
  
**install_tools/**: Contains instructions on installing required tools in Posit. Contains instructions for vcftools and plink, which are required for SUSIER. Also contains instructions for installing **SuSiEX**.  

**slurm_scripts/**
- MungeSumstats_flipfrq_slurm.R: Munge R Script that is run by shell script of the same name.   
- MungeSumstats_flipfrq_slurm.sh: Run Munge R script in Slurm for one study. Attempted to Munge multiple GWASs at once using Slurm. Wasn't super successful because of GWAS variation and memory/time constraints, but the code is there.   
- MungeSumstats_slurm.R: Original/basic Munge R Script.  
- MungeSumstats_slurm.sh: Original/basic run of Munge R Script.   
- VCFS_plink_LD_slurm.sh: Slurm script for creating VCFs in Step 7a. Creates VCFs of only GWAS positions around each lead loci in parallel. 
- getGWAS.sh: Slurm script for downloading all harmonized GWASs in the RUN_FM_TABLE.tsv in parallel.  
- subset_1000g_for_LD_check.sh: Slurm script for creating VCFs in Step 6a. Creates VCFs for each area around the lead loci in parallel.   
  
**RUN_FM_TABLE.tsv**: Subsetted metadata table for MPRA library. Contains information on 311 GWASs which we hope to FM. Columns include: (Trait, Study, Ancestry, N, Associations, N_Associations, GWAS_h_Link, Other_GWAS_Link). Progress log for FM these GWASs can be found [here](https://bri.box.com/s/rt9p2f02ka2jgmayx4onhnp8vae1an4g). Original table created by LeAnn Nguyen can be found [here](https://bri.box.com/s/9tf23s7hxsaz5lzaimc6jd08o81g64xt). 

## Workflow
### If starting from beginning:
1. **Download 1000 genome files.** Instructions in 20250813_FM_Study_Script.Rmd.
2. **Subset EUR and EAS 1000 genome sample IDs.** Instructions in 20250813_FM_Study_Script.Rmd.
3. **Install plink.** Instructions in install_tools/intall_plink.
4. **Install vcftools.** Instructions in install_tools/install_vcftools.
5. **Install required packages.** Instructions: [SusieR](https://github.com/stephenslab/susieR), [MungeSumstats](https://www.bioconductor.org/packages/release/bioc/html/MungeSumstats.html), [Munge dbSNP GRCh packages](https://www.bioconductor.org/packages/devel/bioc/vignettes/MungeSumstats/inst/doc/MungeSumstats.html), [SusieX](https://github.com/getian107/SuSiEx)
6. **Download RUN_FM_TABLE.tsv.** In the repo.
7. **(SusieX) Create 1000 genomes plink files.** Instructions in IN PROGRESS:

### (SusieR) If starting with a new study: 
1. **Choose which study to FM** from RUN_FM_TABLE.tsv. Get following info: Trait, Study, GWAS link, genome build (if possible).
   
2. **Download the GWAS** from GWAS catalog using GWAS link and wget.
   
3. **Munge the GWAS** in Slurm using MungeSumstats_flipfrq_slurm.R/.sh. Ensure Munge was completed successfully and sumstats have > ~1 million rows and proper columns (B/SE/OR/Z). Munge run info can be found in log file: file*_log_msg.txt.

     3a. **Liftover the GWAS** (if needed) using Munge. Done in original Rmd.
  
4. **Create associations table** using RUN_FM_TABLE and the Associations column. Grab information for each association from the sumstats and compile table of SNP, CHR, BP POS.
   
5. **Subset the GWAS** to mapped positions 100,000 BP around each lead SNP. Save those positions in a file for each lead SNP. This will act as the "locus" for FM.
    
6. Check if **all SNPs in high LD with lead SNP are present**. Cut lead SNPs that are missing high LD variants.
    
     6a. **Subset the 1K Genomes files** to 100,000 BP around each lead SNP. Done in slurm: subset_1000g_for_LD_check.sh
  
     6b. **Make PLINK files** for the subsetted 1K Genomes files. Done in original Rmd/locally.  
       Note: There is some reformatting of the bim file that occurs here. Done to make sure filtering occurs by chr:pos, not rsid.  
       
     6c. Create files that contain **all variants that have r<sup>2</sup> of 0.6 or greater**. 
   
     6d. **Check if all high LD variants are present** in the sumstats (with the exception of high LD variants that are indels). Cut all lead SNPs that are missing high LD variants.
  
7. **Make LD matrix** of the SNPs in each GWAS subset
   
     7a. **Subset the 1K Genomes** files to all positions written in the GWAS subset files. Done in Slurm: VCFS_plink_LD_slurm.sh
    
     7b. **Make PLINK files** for the subsetted 1K Genome files. Done in original Rmd/locally.   
   
     7c. **Create the LD matrix**.
   
     7d. **Get frequency files**/minor allele frequency (MAF) for each SNP.
  
8. **Align the GWAS subsets with the bim files** produced in step 7b. Eliminates dimensional errors with LD matrix when running SuSiE. Collect information on all SNPs.
9. **Run SuSiE and QC checks.** Use the LD matrix, N, z-scores (or beta and SE/OR) to run SuSiE and QC checks. Collect information: beta plots, locus lots, SuSiE plot, QC plot, all PIPs (posterior inclusion probabilities) and CSs (Credible Sets), lambda (metric of LD alignment with summary stats).
10. (Optional) **Fix QC flags**. IN PROGRESS


### (SusieX) If starting with a new study: 


## Sample Directory
Example FM directory:
- fine_mapping
    - FM_Trait_RMDs
    - SUSIEX_RMDs
    - FM_results
    - SUSIEX_results
    - GWAS_sumstats
    - 1000_genomes
        - 1000g_hg19
        - 1000h_hg38
    - GWAS_associations_tables
    - install_tools

## Githubs
[SusieR](https://stephenslab.github.io/susieR/)  
[SusieX](https://github.com/getian107/SuSiEx)

## Helpful Tools
[dbSNP](https://www.ncbi.nlm.nih.gov/): Database of SNPs used as reference by MungeSumstats.  
[Open Targets Platform](https://platform.opentargets.org/): Ton of information on traits, studies, SNPs, etc. Also have their own FM results for many studies/SNPs, so good comparison/checking tool.  
[HaploReg](https://pubs.broadinstitute.org/mammals/haploreg/haploreg.php): SNP LD info.  
[UCSC Liftover](https://genome.ucsc.edu/cgi-bin/hgLiftOver?token=0.zrAmUDayAsc1DcvcmQlXuKGIxV5A5CYFuLMq2JX9ECYKfw5-nCBr8rwwbFbNZ-m6Tp8srjtl6zir6HaXd3hM-X3HgVc_4ZCHNRfarKfJw40u-ayplIUPDgjPxAOjUnbfKpVMBgNUi9hqqWu0ORg9nf8oP5fXYUuScESJub85Pygt573teGAWJ966psuuOYkajkP7oDSIM6o_GW3rssvLiQyLifSJRslKVAi6Xx5dtCctiMspYpCG-_k5nghWv70EnkUlrxPdIZH7y94yJeRZocczJBpyoacExNRdDmQAeDWWjVmT_EcISic_rtlfvYerKlHScIklFD1ZfEj-EKwJ4dVIhDdVsTAKUkNIizYq2i-TIWSZC6WKxVuqCO3UnTLT53StGplhjygg_LIbFj0-3fKIO4IYxf28vpiJDirWEHCepq44T2Qo6RXmwQqgmtpgdIVxitEk92hUEdS9DV4id-Rzf6J7gpkGzVp4vMIJujyoYBqyeONhrCIKwHSbb5h0HCnESfCksqeZFak_-t00K35DZTuCoKQYpUjpZ1fnLeVqYor7F5kxDR8yn9uveBrT8hLqk1ED2MIHzybcFssfrhAtonuKrJBabQ6CLVPFkBGPLyM5BFdQaCQZNw73O50ufcmgIhDYdL6oljRFLhrsdY18tfoBc4Dgyh4U8ddMruP0BX01ykq2eroyc2noTHnk9zEt_2JNs8IQT7c5lfz6iGuB8ehuHJwQASKhWjDeNZJrExsPgwnJhu8A6YI11UDBcDQRVt1GP96ReRNiWUKRX9XUMfpRgOBOQeAb5cbjOp1EOljShoYq4wnQ1rw9TRDBtJLDVUndQC_3hGtFBUhUSHnDnCJp-QYlJFrQAoEzhjoftoxVpG0PIY3h5rXVwevqRDBMJo-NQucmgnf8wFGipuoBuwfY-aRUuIDf7xR4F0E.hJGbjUncBY3irS5s3_iBEw.ca2174b980accb6b78e6f0bbac715f0cf7c9eebb8a56b334cf1fa94358f806f5): For lifting between genome builds.  
