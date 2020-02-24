#!/bin/bash

ID=$1

if [ -z $ID ]
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  '/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/CR_backup.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ $ID == "CR000" ]
then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Participant CR000 does not exist. Please modify the participant ID. 
---------------------------------------------------------------------------------------------------------"

exit 2

elif [ ! -d /media/cranilab/USB\ DISK/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Please insert the USB stick with CogRehab E-prime output data to start. 
---------------------------------------------------------------------------------------------------------"

exit 3

fi




CR_HOME="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab"

/bin/bash $CR_HOME/Analyses/Shell_scripts/mri_backup.sh $ID &&

/bin/bash $CR_HOME/Analyses/Shell_scripts/beh_backup.sh $ID &&

/bin/bash $CR_HOME/Analyses/Shell_scripts/rsync.sh $ID &&

ssh feng@10.156.156.24
