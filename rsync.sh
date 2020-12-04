#!/bin/bash

#This shell script copies behavioral and MRI data files for a specific participant at a specific time point from local computer to the BIC server (to Feng's BIC folders, as backup). 
#Created by Feng Gu in September 2019. Last modified by Feng Gu in December 2020. 


####################################################### SETTING UP ############################################

ID=$1   #take the first argument as the variable ID
TP=$2   #take the second argument as the variable TP


if [ -z ${ID} ] #if user forgets to input ID: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/rsync.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ -z ${TP} ]  #if user forgets to input TP: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Time point was not supplied. The time point (e.g., '1' or '2') should be supplied as the second argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/rsync.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 2

elif [ ${#ID} -ne 5 ]  #if user enters ID incorrectly (i.e., length of ID is not equal to 5 characters): 
then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001).
---------------------------------------------------------------------------------------------------------"

exit 3


elif [ ${#TP} -ne 1 ]  #if user enters TP incorrectly (i.e., length of TP is not equal to 1 character):
then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Do not include the letters (e.g., 1).
---------------------------------------------------------------------------------------------------------"

exit 4

fi

####################################################### DEFINING VARIABLES ##############################################

SCRIPTS_HOME="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/MRI_local/"  #defines SCRIPTS_HOME as the folder for rsync_beh.sh and rsync_mri.sh


####################################################### SENDING DATA TO SERVER ############################################

echo "---------------------------------------------------------------------------------------------------------
Sending data to server. This should take about 30 seconds. Please be patient... 
---------------------------------------------------------------------------------------------------------"
#Because the rsync interface is essentially a black screen, show this message to user so that they know everything is still working fine :) 


/bin/bash $SCRIPTS_HOME/rsync_beh.sh $ID $TP &&   #runs rsync_beh.sh, with variables ID and TP supplied as two arguments

/bin/bash $SCRIPTS_HOME/rsync_mri.sh $ID $TP&&  #runs rsync_mri.sh, with variables ID and TP supplied as two arguments


####################################################### ENDING ############################################


echo "---------------------------------------------------------------------------------------------------------
SUCCESS!! 
---------------------------------------------------------------------------------------------------------"
#show this message to user if everything works well 
