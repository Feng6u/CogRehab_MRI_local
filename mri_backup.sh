#!/bin/bash

#This shell script creates MRI scan data directories for a specific participant at a specific time point, changes format of scans, and backs up all scan data from server to these directories. 
#Created by Feng Gu in September 2019. Modified by Feng Gu in May 2020. 


###################### SETTING UP ###########################

ID=$1   #take the first argument as the variable ID
TP=$2   #take the second argument as the variable TP

if [ -z ${ID} ]    #if user forgets to input ID: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Subject ID was not supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/mri_backup.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 1


elif [ -z ${TP} ]  #if user forgets to input TP: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Time point was not supplied. The time point (e.g., '1' or '2') should be supplied as the second argument.
Example: "/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Shell_scripts/mri_backup.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 2


elif [ ${#ID} -ne 5 ]  #if user enters ID incorrectly (length of ID is not equal to 5 characters): 

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001) 
---------------------------------------------------------------------------------------------------------"

exit 3


elif [ ${#TP} -ne 1 ]  #if user enters TP incorrectly (length of TP is not equal to 1 characters):

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Please do not include the letters (e.g., 1) 
---------------------------------------------------------------------------------------------------------"

exit 4


fi



#################### DEFINING VARIABLES #########################


M_PATH="/home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Data/MRI_data/MRI_scan_data/"  #define the path where MRI data are stored as M_PATH

ONE_RUN="T1 RESTING VM/VM_Recog NM"  #these 4 tasks have 1 run each. Define them as ONE_RUN

TWO_RUNS="VM/VM_Encoding EFN_BACK FB" #these 3 tasks have 2 runs each. Define them as TWO_RUNS

RUNS="Run1 Run2" #define RUNS as Run1 and Run2. Will be used to name folders

TEMP="/home/cranilab/Desktop" #use the desktop as a temporary folder for data to be downloaded (will be deleted at the end)




###################### CREATING FOLDERS #######################


mkdir $TEMP/${ID}_TP${TP}  #create a folder on desktop in the format of ID_TP


#unzip the content in the zip file downloaded from the BIC server into ID_TP created on Desktop (important to name the zip file in the format of ID_TP when downloading):
tar -xvzf $TEMP/${ID}_TP${TP}.tar.gz -C $TEMP/${ID}_TP${TP}  



#for all the tasks that have one run (defined as ONE_RUN), create a folder for each ID_TP, and then a folder for dcm and nii respectively under the participant's folder: 
for i in $ONE_RUN 
do 
	
	mkdir -p $M_PATH/$i/${ID}_TP${TP}/dcm
	mkdir -p $M_PATH/$i/${ID}_TP${TP}/nii

done



#for all the tasks that have two runs (defined as TWO_RUNS), create a fodler for each ID_TP for each run, and then a folder for dcm and nii respectively:
for i in $TWO_RUNS
do
	for o in $RUNS
	do

		mkdir -p $M_PATH/$i/${ID}_TP${TP}/$o/dcm
		mkdir -p $M_PATH/$i/${ID}_TP${TP}/$o/nii

	done
done




######################### BACKING UP DATA ##########################

detox -r $TEMP/${ID}_TP${TP}/*/  #get rid of the space in folder names (this step is just for the folder "MEMPR RMS")


#to make sure all required scans are downloaded from the server. If a specific scan is not found, an error message will inform the user:
#(please note that wildcards for numbers (e.g., [0-9][0-9]) are used here because the two-digit numbers are not always the same when downloaded from the server)
if [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-MEMPRAGE_RMS/ ]   

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR T1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_RestingState_mb3/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR RESTING STATE NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 2

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM ENCODING RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 3

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM ENCODING RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 4

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_recVM_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR VM RECOGNITION NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 5

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR EFN-BACK RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 6

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR EFN-BACK RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 7


elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run1/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR FALSE BELIEF RUN1 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 8

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run2/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR FALSE BELIEF RUN2 NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 9

elif [ ! -d $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/ ]

then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: SCAN FOR NEUROMELANIN SENSITIVITY NOT FOUND!!
---------------------------------------------------------------------------------------------------------"

exit 10

fi



cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-MEMPRAGE_RMS/.  $M_PATH/T1/${ID}_TP${TP}/dcm  
#copy dcm files of T1 downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_RestingState_mb3/.  $M_PATH/RESTING/${ID}_TP${TP}/dcm
#copy dcm files of resting state downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run1/.  $M_PATH/VM/VM_Encoding/${ID}_TP${TP}/Run1/dcm 
#copy dcm files of run1 of VM downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run2/.  $M_PATH/VM/VM_Encoding/${ID}_TP${TP}/Run2/dcm 
#copy dcm files of run2 of VM downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_recVM_run1/.  $M_PATH/VM/VM_Recog/${ID}_TP${TP}/dcm 
#copy dcm files of recognition task downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run1/.  $M_PATH/EFN_BACK/${ID}_TP${TP}/Run1/dcm 
#copy dcm files of run1 of EFN downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run2/. $M_PATH/EFN_BACK/${ID}_TP${TP}/Run2/dcm 
#copy dcm files of run1 of EFN downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run1/. $M_PATH/FB/${ID}_TP${TP}/Run1/dcm
#copy dcm files of run1 of FB downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run2/. $M_PATH/FB/${ID}_TP${TP}/Run2/dcm 
#copy dcm files of run2 of FB downloaded from server into the folder setup in the CogRehab folder as backup

cp -r $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/. $M_PATH/NM/${ID}_TP${TP}/dcm 
#copy dcm files of NM downloaded from server into the folder setup in the CogRehab folder as backup




############################ CHANGING FORMAT ############################

T1=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-MEMPRAGE_RMS/ | sort -n | head -1)  
#define T1 as the file name of the first dcm file in the T1 folder (to prepare for mri_convert) 

RESTING=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_RestingState_mb3/ | sort -n | head -1)
#define RESTING as the file name of the first dcm file in the resting state folder (to prepare for mri_convert) 

VM_RUN1=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run1/ | sort -n | head -1)
#define VM_RUN1 as the file name of the first dcm file in the VM_run1 folder (to prepare for mri_convert) 

VM_RUN2=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run2/ | sort -n | head -1)
#define VM_RUN2 as the file name of the first dcm file in the VM_run2 folder (to prepare for mri_convert) 

RECOG=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_recVM_run1/ | sort -n | head -1)
#define RECOG as the file name of the first dcm file in the VM_recog folder (to prepare for mri_convert) 

EFN_RUN1=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run1/ | sort -n | head -1)
#define EFN_RUN1 as the file name of the first dcm file in the EFN_run1 folder (to prepare for mri_convert) 

EFN_RUN2=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run2/ | sort -n | head -1)
#define EFN_RUN2 as the file name of the first dcm file in the EFN_run2 folder (to prepare for mri_convert) 

FB_RUN1=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run1/ | sort -n | head -1)
#define FB_RUN1 as the file name of the first dcm file in the FB_run1 folder (to prepare for mri_convert) 

FB_RUN2=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run2/ | sort -n | head -1)
#define FB_RUN2 as the file name of the first dcm file in the FB_run2 folder (to prepare for mri_convert) 

NM=$(ls $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/ | sort -n | head -1)
#define NM as the file name of the first dcm file in the NM folder (to prepare for mri_convert) 



#using mri_convert to convert DICOM files to NIFTI files with the names that FreeSurfer likes and save into each respective folder in the CogRehab folder:
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-MEMPRAGE_RMS/$T1 $M_PATH/T1/${ID}_TP${TP}/nii/T1.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_RestingState_mb3/$RESTING $M_PATH/RESTING/${ID}_TP${TP}/nii/resting.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run1/$VM_RUN1 $M_PATH/VM/VM_Encoding/${ID}_TP${TP}/Run1/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_VM_run2/$VM_RUN2 $M_PATH/VM/VM_Encoding/${ID}_TP${TP}/Run2/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_recVM_run1/$RECOG $M_PATH/VM/VM_Recog/${ID}_TP${TP}/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run1/$EFN_RUN1 $M_PATH/EFN_BACK/${ID}_TP${TP}/Run1/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_EFN_run2/$EFN_RUN2 $M_PATH/EFN_BACK/${ID}_TP${TP}/Run2/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run1/$FB_RUN1 $M_PATH/FB/${ID}_TP${TP}/Run1/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-fMRI_FB_run2/$FB_RUN2 $M_PATH/FB/${ID}_TP${TP}/Run2/nii/f.nii
mri_convert $TEMP/${ID}_TP${TP}/*/[0-9][0-9]-goldStar_NM_ref36_phOS20/$NM $M_PATH/NM/${ID}_TP${TP}/nii/nm.nii




##################################### CLEANING UP #############################

#remove the temporary folders created on Desktop 
rm -r $TEMP/${ID}_TP${TP}
rm -r $TEMP/${ID}_TP${TP}.tar.gz



###################################### QC ##############################################################
fsleyes $M_PATH/T1/${ID}_TP${TP}/nii/T1.nii #using fsleyes for QC of T1 (e.g., check for movement) 

