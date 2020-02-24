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
FENG_PATH="/group/guimond_CogReh/feng/CogRehab/"

#sync with BIC server

rsync -r $M_PATH/T1/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/T1/$ID/
rsync -r $M_PATH/RESTING/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/RESTING/$ID/
rsync -r $M_PATH/VM/VM_Encoding/Run1/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/VM/VM_Encoding/Run1/$ID/
rsync -r $M_PATH/VM/VM_Encoding/Run2/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/VM/VM_Encoding/Run2/$ID/
rsync -r $M_PATH/VM/VM_Recog/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/VM/VM_Recog/$ID/
rsync -r $M_PATH/EFN_BACK/Run1/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/EFN_BACK/Run1/$ID/
rsync -r $M_PATH/EFN_BACK/Run2/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/EFN_BACK/Run2/$ID/
rsync -r $M_PATH/FB/Run1/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/FB/Run1/$ID/
rsync -r $M_PATH/FB/Run2/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/FB/Run2/$ID/
rsync -r $M_PATH/NM/$ID/* feng@10.156.156.24:$FENG_PATH/MRI_scan_data/NM/$ID/


