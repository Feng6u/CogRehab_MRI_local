#!/bin/bash

ID=$1

if [ -z $ID ]
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  '/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/CR_backup.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit

fi


M_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/MRI_scan_data/"
DIRS="T1 RESTING VM/VM_Encoding/Run1 VM/VM_Encoding/Run2 VM/VM_Recog EFN_BACK/Run1 EFN_BACK/Run2 FB/Run1 FB/Run2 NM"
TEMP="/home/cranilab/Desktop"

#MRI DATA BACKUP AND FORMAT CHANGING
mkdir $TEMP/$ID

tar -xvzf $TEMP/*.tar.gz -C $TEMP/$ID

for i in $DIRS
do 
	
mkdir -p $M_PATH/$i/$ID/dcm
mkdir -p $M_PATH/$i/$ID/nii

done

detox -r $TEMP/$ID/*/ #get rid of the space in the folder name "MEMPR RMS"


if [ ! -d $TEMP/$ID/*/[0-9][0-9]-MEMPRAGE_RMS/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR T1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_RestingState_mb3/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR RESTING STATE NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 2

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM ENCODING RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 3

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM ENCODING RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 4

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_recVM_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM RECOGNITION NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 5

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR EFN-BACK RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 6

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR EFN-BACK RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 7


elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR FALSE BELIEF RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 8

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR FALSE BELIEF RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 9

elif [ ! -d $TEMP/$ID/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR NEUROMELANIN SENSITIVITY NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 10

fi


cp -r $TEMP/$ID/*/[0-9][0-9]-MEMPRAGE_RMS/.  $M_PATH/T1/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_RestingState_mb3/.  $M_PATH/RESTING/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run1/.  $M_PATH/VM/VM_Encoding/Run1/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run2/.  $M_PATH/VM/VM_Encoding/Run2/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_recVM_run1/.  $M_PATH/VM/VM_Recog/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run1/.  $M_PATH/EFN_BACK/Run1/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run2/. $M_PATH/EFN_BACK/Run2/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run1/. $M_PATH/FB/Run1/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run2/. $M_PATH/FB/Run2/$ID/dcm
cp -r $TEMP/$ID/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/. $M_PATH/NM/$ID/dcm

T1=$(ls $TEMP/$ID/*/[0-9][0-9]-MEMPRAGE_RMS/ | sort -n | head -1)
RESTING=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_RestingState_mb3/ | sort -n | head -1)
VM_RUN1=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run1/ | sort -n | head -1)
VM_RUN2=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run2/ | sort -n | head -1)
RECOG=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_recVM_run1/ | sort -n | head -1)
EFN_RUN1=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run1/ | sort -n | head -1)
EFN_RUN2=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run2/ | sort -n | head -1)
FB_RUN1=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run1/ | sort -n | head -1)
FB_RUN2=$(ls $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run2/ | sort -n | head -1)
NM=$(ls $TEMP/$ID/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/ | sort -n | head -1)

mri_convert $TEMP/$ID/*/[0-9][0-9]-MEMPRAGE_RMS/$T1 $M_PATH/T1/$ID/nii/T1.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_RestingState_mb3/$RESTING $M_PATH/RESTING/$ID/nii/resting.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run1/$VM_RUN1 $M_PATH/VM/VM_Encoding/Run1/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_VM_run2/$VM_RUN2 $M_PATH/VM/VM_Encoding/Run2/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_recVM_run1/$RECOG $M_PATH/VM/VM_Recog/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run1/$EFN_RUN1 $M_PATH/EFN_BACK/Run1/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_EFN_run2/$EFN_RUN2 $M_PATH/EFN_BACK/Run2/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run1/$FB_RUN1 $M_PATH/FB/Run1/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-fMRI_FB_run2/$FB_RUN2 $M_PATH/FB/Run2/$ID/nii/f.nii
mri_convert $TEMP/$ID/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/$NM $M_PATH/NM/$ID/nii/f.nii

rm -r $TEMP/$ID
rm -r $TEMP/*.tar.gz

#QC 
fsleyes $M_PATH/T1/$ID/nii/T1.nii
