#!/bin/bash


#This shell script creates behavioral data directories for a specific participant at a specific time point, and backs up all behavioral data from USB disk to these directories. 
#Created by Feng Gu in September 2019. Modified by Feng Gu in May 2020. 



####################################################### SETTING UP ############################################

ID=$1   #take the first argument as the variable ID
TP=$2   #take the second argument as the variable TP


if [ ! -d /media/cranilab/KINGSTON/ ] #if the USB stick with E-prime data is not plugged in: 

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Please insert the USB stick with CogRehab E-prime output data to start. 
---------------------------------------------------------------------------------------------------------"

exit 1


elif [ -z ${ID} ]    #if user forgets to input ID: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Subject ID was not supplied. The subject ID (e.g., 'CR001') should be supplied as the first argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/beh_backup.sh CR001 1"

---------------------------------------------------------------------------------------------------------"

exit 2


elif [ -z ${TP} ]  #if user forgets to input TP: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Time point was not supplied. The time point (e.g., '1' or '2') should be supplied as the second argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/beh_backup.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 3


elif [ ${#ID} -ne 5 ]  #if user enters ID incorrectly (i.e., length of ID is not equal to 5 characters): 

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001).
---------------------------------------------------------------------------------------------------------"

exit 4


elif [ ${#TP} -ne 1 ]  #if user enters TP incorrectly (i.e., length of TP is not equal to 1 character):

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Do not include the letters (e.g., 1).
---------------------------------------------------------------------------------------------------------"

exit 5

fi



############################################ DEFINING VARIABLES #########################################################

B_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/fMRI_behavioral_data/" #defines B_PATH as the folder where all CogRehab behavioral data are saved



########################################## BEHAVIORAL DATA BACKUP #########################################################

#create a folder in the format of ID_TP in the folder of each fMRI task and then copy edat3 files for each task into the created folder 

mkdir $B_PATH/VM/VM_Encoding/${ID}_TP${TP}; cp /media/cranilab/KINGSTON/CogRehab_data/${ID}_TP${TP}/VM_encoding*.edat3 $B_PATH/VM/VM_Encoding/${ID}_TP${TP}/ 
mkdir $B_PATH/VM/VM_Recog/${ID}_TP${TP}; cp /media/cranilab/KINGSTON/CogRehab_data/${ID}_TP${TP}/VM_recog*.edat3 $B_PATH/VM/VM_Recog/${ID}_TP${TP}/
mkdir $B_PATH/EFN_BACK/${ID}_TP${TP}; cp /media/cranilab/KINGSTON/CogRehab_data/${ID}_TP${TP}/EFNBACK*.edat3 $B_PATH/EFN_BACK/${ID}_TP${TP}/
mkdir $B_PATH/FB/${ID}_TP${TP}; cp /media/cranilab/KINGSTON/CogRehab_data/${ID}_TP${TP}/FalseBelief*.edat3 $B_PATH/FB/${ID}_TP${TP}/

#create a folder in the format of ID_TP in Merged folder and then copy the merged txt file into the created folder (merged txt file is first created using E-Merge and then exported using E-Data)
mkdir $B_PATH/Merged/${ID}_TP${TP}; cp /media/cranilab/KINGSTON/CogRehab_data/${ID}_TP${TP}/merged_${ID}_TP${TP}.txt $B_PATH/Merged/${ID}_TP${TP}/ &&

#run merged_separator.R with variables ID and TP as input to separate the merged txt file into 7 txt files, 1 file for each run of each task
cd /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/; Rscript merged_separator.R $ID $TP
