#!/bin/bash

#This shell script is a master backup script for a specific participant at a specific time point. This is the only script that needs to be run for backing up all data on computer and on server. 

#It does the following things in order: 
#	1. Creates MRI data folders on CRANI desktop for ID_TP
#	2. Copies DICOM data files downloaded from server to participant's folder 
#	3. Changes scan data format from DICOM to NIFTI
#	4. Copies NIFTI data files to participant's folder
#	5. Quality control of T1 (needs user's inspection)
#	6. Creates behavoiral data folders on CRANI desktop for ID_TP
#	7. Copies edat3 files (E-prime original output) for each run of each fMRI task from the CogRehab USB disk into the behavoiral data folders created on CRANI desktop
#	8. Copies the merged txt file (created using E-Merge and then exported using E-Data) from the CogRehab USB disk into the participant's folder on CRANI desktop
#	9. Separates the merged txt file into 7 text files, 1 file for each run of each task
#	10. Sends behavorial data files for ID_TP from local computer to the BIC server (to Feng's BIC folders, as backup)
#	11. Sends MRI data files for ID_TP from local computer to the BIC server (to Feng's BIC folders, as backup)
#	12. Transfers user to the BIC server to proceed to the analysis on the server 


#Created by Feng Gu in September 2019. Last modified by Feng Gu in December 2020. 


####################################################### SETTING UP ############################################

if [ ! -d /media/cranilab/KINGSTON/ ]  #Because beh_back.sh requires data from the CogRehab USB disk, it is important to plug in the USB disk before proceeding. This if condition reminds user to insert the USB. 

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Please insert the USB stick with CogRehab E-prime output data to start. 
---------------------------------------------------------------------------------------------------------"

exit

fi


echo "Please enter participant's ID (e.g., CR001) and press [ENTER]:"  #Ask user to input particiapnt's ID

read ID  #Take user's input as the particiapnt's ID

if [ ${#ID} -ne 5 ]  #Make sure the input has the length of 5 characters

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001) 
---------------------------------------------------------------------------------------------------------"

exit

fi


echo "Please enter the time point for ${ID} (e.g., 1) and press [ENTER]:" #Ask user to input time point

read TP #Take user's input as the time point

if [ ${#TP} -ne 1 ]  #Make sure the input has the length of 1 character

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Do not include the letters (e.g., 1) 
---------------------------------------------------------------------------------------------------------"

exit

fi


echo "Please press [ENTER] to confirm this is correct: ${ID}_TP${TP}. If incorrect, please type "N" to exit." #Give user a chance to check and change input

read confirmation

if [ "$confirmation" == "N" ] #If user enters "N", exit this program

then 
	echo "---------------------------------------------------------------------------------------------------------
Please rerun this script.
---------------------------------------------------------------------------------------------------------"

exit

else			#If user confirms the ID and TP are correct, then show this on the screen and then proceed

	echo "---------------------------------------------------------------------------------------------------------
Thank you!! Now backing up data for ${ID}_TP${TP}....						
---------------------------------------------------------------------------------------------------------" 

fi


####################################################### DEFINING VARIABLES ############################################

SCRIPTS_HOME="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/MRI_local/"  #defines SCRIPTS_HOME as the folder for CogRehab analysis scripts


####################################################### RUNNING SCRIPTS ############################################

/bin/bash $SCRIPTS_HOME/mri_backup.sh $ID $TP
mri=$?
if [ $mri -ne 0 ]
then mri_msg="mri_backup.sh was NOT executed successfully :("
fi

/bin/bash $SCRIPTS_HOME/beh_backup.sh $ID $TP
beh=$?
if [ $beh -ne 0 ]
then beh_msg="beh_backup.sh was NOT executed successfully :("
fi

/bin/bash $SCRIPTS_HOME/rsync.sh $ID $TP
rsync_all=$?
if [ $rsync_all -ne 0 ]
then rsync_msg="rsync.sh was NOT executed successfully :("
fi


####################################################### ENDING ############################################

if [ ${#mri_msg} -eq 0 ] && [ ${#beh_msg} -eq 0 ] && [ ${#rsync_msg} -eq 0 ]

then
echo "---------------------------------------------------------------------------------------------------------
Successfully backed up data for ${ID}_TP${TP}!
---------------------------------------------------------------------------------------------------------"

else

echo "
----------------------------------------------------------------------------------------------------------------
$mri_msg $beh_msg $rsync_msg
-------------------------------------------------------------------------------------------------------------"

fi

####################################################### MOVING TO SERVER ############################################
ssh feng@10.156.156.23  #SSH to BIC server
