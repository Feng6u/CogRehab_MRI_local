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

B_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/fMRI_behavioral_data/"
FENG_PATH="/group/guimond_CogReh/feng/CogRehab/"

#sync with BIC server

rsync $B_PATH/VM/VM_Encoding/$ID/* feng@10.156.156.24:$FENG_PATH/fMRI_behavioral_data/VM/VM_Encoding/$ID/
rsync $B_PATH/VM/VM_Recog/$ID/* feng@10.156.156.24:$FENG_PATH/fMRI_behavioral_data/VM/VM_Recog/$ID/
rsync $B_PATH/EFN_BACK/$ID/* feng@10.156.156.24:$FENG_PATH/fMRI_behavioral_data/EFN_BACK/$ID/
rsync $B_PATH/FB/$ID/* feng@10.156.156.24:$FENG_PATH/fMRI_behavioral_data/FB/$ID/


