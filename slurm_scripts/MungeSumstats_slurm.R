library(data.table)
library(MungeSumstats)

# Change each time
main.dir <- "~/fine_mapping/"
Trait <- "SLE"
Study <- "GCST003156"
Ancestry <- "EUR"
GWAS_build <- "GRCh38"


f_path <- paste0(main.dir, "GWAS_sumstats_G/", Trait, "_sumstats/", Trait, "_", Study, "_", Ancestry, "_sumstats_", GWAS_build, ".tsv.gz") #CHANGED THIS!!!!

log_path <- paste0(main.dir, "GWAS_sumstats_G/", Trait, "_sumstats/", Study, "_munge_logs/")
dir.create(log_path)

sink(paste0(main.dir, "GWAS_sumstats_G/", Trait, "_sumstats/", Study, "_munge_logs/", Study, "_munge_log.txt"))

reformatted <-
  MungeSumstats::format_sumstats(path=f_path,
                                 ref_genome=GWAS_build, indels=TRUE, log_folder = log_path, log_folder_ind
                                 = TRUE, log_mungesumstats_msgs = TRUE, bi_allelic_filter = FALSE)


file.copy(reformatted$sumstats, paste0(main.dir, "GWAS_sumstats_G/", Trait, "_sumstats/", Trait, "_", Study, "_", Ancestry, "_sumstats_", GWAS_build, "_MUNGED.tsv.gz"))

file.copy(reformatted$log_files$MungeSumstats_log_msg, log_path)

file.copy(reformatted$log_files$MungeSumstats_log_output, log_path)

sink()