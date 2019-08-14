#!/bin/bash
shopt -s expand_aliases
source ~/.bash_profile
source startup.profile;
echo `pwd`;
PROC_PORT=${1}_PORT;
PROC_STARTUP=${1}_STARTUP;

if [ -z "$1" ] 
then 
	echo "Please specify the process you want to start"
	exit 0

elif [ -z "${!PROC_PORT}" ]
then
	echo "No port set for $1"
	exit 0

else 
	echo "Will use this port ${!PROC_PORT}"
	echo "Will use this profile ${!PROC_STARTUP}"
	eval "q ${!PROC_STARTUP} -p ${!PROC_PORT} &"
fi	
