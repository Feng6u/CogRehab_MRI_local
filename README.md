# CogRehab_MRI_local
Shell ahd R scripts used locally for organization of scans before uploading them to the BIC server for MRI analyses.

1. mri_backup.sh
	- creates relavant MRI diretories for the participant on CRANI computer
	- converts dcm to nii
	- save MRI files (both DCM and NII) in the correct directories on the CRANI computer
	- QC of T1 with fsleyes

2. merged_separator.R
	- separates merged e-prime output text file for the participant into 7 text files for 7 tasks 	(vm_encoding_run1, vm_encoding_run2, vm_recog, efn_run1, efn_run2, fb_run1, fb_run2) and 	saves the output files into the approriate folders on the CRANI computer 

3. beh_backup.sh
	- creates relavant fMRI behavioral diretories for the participant
	- saves E-prime output edat3 for the participant in the appropriate directories on the computer
	- runs merged_separator.R

4. rsync_mri
	- sends all scan data (dcm and nii files) for the participant to the BIC server as backup (to  	/group/	guimond_cogreh/feng/CogRehab/MRI_Data)

5. rsync_beh
	- sends all behavioral data (edat3 and txt files) for the participant to the BIC server as backup 	(to  /group/guimond_cogreh/feng/CogRehab/MRI_Data)

6. rsync.sh
	- combines rsync_mri and rsync_beh and sends all data to the BIC server as backup

7. bic
	- SSH to BIC server

8. CR_backup.sh
	- combines steps 1, 3, 6 and 7 together
