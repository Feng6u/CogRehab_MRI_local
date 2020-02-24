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

CR_HOME="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab"

/bin/bash $CR_HOME/Analyses/Shell_scripts/rsync_beh.sh $ID &&

/bin/bash $CR_HOME/Analyses/Shell_scripts/rsync_mri.sh $ID &&

echo "Success!"
