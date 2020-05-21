#!/bin/bash

#This shell script copies behavioral data files for a specific participant at a specific time point from local computer to the BIC server (to Feng's BIC folders, as backup). 
#Created by Feng Gu in September 2019. Modified by Feng Gu in May 2020. 


####################################################### SETTING UP ############################################

ID=$1   #take the first argument as the variable ID
TP=$2   #take the second argument as the variable TP


if [ -z ${ID} ] #if user forgets to input ID: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR001') should be supplied as the first argument.
Example:  "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/rsync_beh.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ -z ${TP} ]  #if user forgets to input TP: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Time point was not supplied. The time point (e.g., '1' or '2') should be supplied as the second argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/rsync_beh.sh CR001 1"
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


####################################################### DEFINING VARIABLES ############################################

B_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/fMRI_behavioral_data/"  #defines B_PATH as the folder for behavoiral data on local computer
FENG_PATH="/group/guimond_CogReh/feng/CogRehab/" #defines FENG_PATH as the Feng's BIC folder on the server



####################################################### SENDING DATA TO SERVER ############################################

rsync $B_PATH/VM/VM_Encoding/${ID}_TP${TP}/* feng@10.156.156.23:$FENG_PATH/fMRI_behavioral_data/VM/VM_Encoding/${ID}_TP${TP}/  #sends all VM_Encoding data to server
rsync $B_PATH/VM/VM_Recog/${ID}_TP${TP}/* feng@10.156.156.23:$FENG_PATH/fMRI_behavioral_data/VM/VM_Recog/${ID}_TP${TP}/  #sends all VM_Recog data to server
rsync $B_PATH/EFN_BACK/${ID}_TP${TP}/* feng@10.156.156.23:$FENG_PATH/fMRI_behavioral_data/EFN_BACK/${ID}_TP${TP}/   #sends all EFN_BACK data to server
rsync $B_PATH/FB/${ID}_TP${TP}/* feng@10.156.156.23:$FENG_PATH/fMRI_behavioral_data/FB/${ID}_TP${TP}/  #sends all FB data to server


