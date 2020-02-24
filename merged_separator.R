args = commandArgs(trailingOnly=TRUE)

BEH_DIR <- "/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/fMRI_behavioral_data/"

id <- args[1]

merged <- read.delim(file.path(paste0(BEH_DIR, '/Merged/', id,'/merged_', id, '.txt')), stringsAsFactors=FALSE)

merged <- tail(merged, -2) #remove first two rows 

colnames(merged) <- as.character(unlist(merged[1,])) #rename columns using the first row of data 

merged <- tail(merged, -1) #remove first row

attach(merged)

vm_run1 <- subset(merged, merged$ExperimentName == "VM_encoding_TP1_ R1")
vm_run1[vm_run1 == "NULL"] <- NA
vm_run1 <- vm_run1[, colSums(is.na(vm_run1)) != nrow(vm_run1)]

vm_run2 <- subset(merged, merged$ExperimentName == "VM_encoding_TP1_R2")
vm_run2[vm_run2 == "NULL"] <- NA
vm_run2 <- vm_run2[, colSums(is.na(vm_run2)) != nrow(vm_run2)]

recog <- subset(merged, merged$ExperimentName == "VM_recog_TP1")
recog[recog == "NULL"] <- NA
recog <- recog[, colSums(is.na(recog)) != nrow(recog)]

efn_run1 <- subset(merged, merged$ExperimentName == "EFNBACK _ Run1")
efn_run1[efn_run1 == "NULL"] <- NA
efn_run1 <- efn_run1[, colSums(is.na(efn_run1)) != nrow(efn_run1)]

efn_run2 <- subset(merged, merged$ExperimentName == "EFNBACK _ Run2")
efn_run2[efn_run2 == "NULL"] <- NA
efn_run2 <- efn_run2[, colSums(is.na(efn_run2)) != nrow(efn_run2)]

fb_run1 <- subset(merged, merged$ExperimentName == "FalseBelief_TP1_R1")
fb_run1[fb_run1 == "NULL"] <- NA
fb_run1 <- fb_run1[, colSums(is.na(fb_run1)) != nrow(fb_run1)]

fb_run2 <- subset(merged, merged$ExperimentName == "FalseBelief_TP1_R2")
fb_run2[fb_run2 == "NULL"] <- NA
fb_run2 <- fb_run2[, colSums(is.na(fb_run2)) != nrow(fb_run2)]

detach(merged)

write.table(vm_run1, file.path(paste0(BEH_DIR, '/VM/VM_Encoding/', id,'/vm_run1_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(vm_run2, file.path(paste0(BEH_DIR, '/VM/VM_Encoding/', id,'/vm_run2_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(recog, file.path(paste0(BEH_DIR, '/VM/VM_Recog/', id, '/recog_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(efn_run1, file.path(paste0(BEH_DIR, '/EFN_BACK/', id, '/efn_run1_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(efn_run2, file.path(paste0(BEH_DIR, '/EFN_BACK/', id, '/efn_run2_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(fb_run1, file.path(paste0(BEH_DIR, '/FB/', id, '/fb_run1_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")
write.table(fb_run2, file.path(paste0(BEH_DIR, '/FB/', id, '/fb_run2_', id, '.txt')), row.names=FALSE, col.names = TRUE, sep = "\t")

