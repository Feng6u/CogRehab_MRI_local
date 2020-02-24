#!/bin/bash

ID=$1

if [ -z $ID ]
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  '/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/CR_backup.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ ! -d /media/cranilab/KINGSTON/]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Please insert the USB stick with CogRehab E-prime output data to start. 
---------------------------------------------------------------------------------------------------------"

exit 2

fi


B_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/fMRI_behavioral_data/"

#BEHAVIORAL DATA BACKUP

mkdir $B_PATH/VM/VM_Encoding/$ID; cp /media/cranilab/KINGSTON/CogRehab_data/$ID/VM_encoding*.edat3 $B_PATH/VM/VM_Encoding/$ID/
mkdir $B_PATH/VM/VM_Recog/$ID; cp /media/cranilab/KINGSTON/CogRehab_data/$ID/VM_recog*.edat3 $B_PATH/VM/VM_Recog/$ID/
mkdir $B_PATH/EFN_BACK/$ID; cp /media/cranilab/KINGSTON/CogRehab_data/$ID/EFNBACK*.edat3 $B_PATH/EFN_BACK/$ID/
mkdir $B_PATH/FB/$ID; cp /media/cranilab/KINGSTON/CogRehab_data/$ID/FalseBelief*.edat3 $B_PATH/FB/$ID/

mkdir $B_PATH/Merged/$ID; cp /media/cranilab/KINGSTON/CogRehab_data/$ID/merged_${ID}.txt $B_PATH/Merged/$ID/ &&

cd /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/; Rscript merged_separator.R $ID 
