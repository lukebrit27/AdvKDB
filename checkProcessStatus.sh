#!/bin/bash
shopt -s expand_aliases
source ~/.bash_profile
source startup.profile;
echo `pwd`;
PROC_PORT=${1}_PORT;
PROC_STARTUP=${1}_STARTUP;


if [ -z "$1" ]
then
        echo "Please specify the process you want to check"
        exit 0
fi

if [ -z "$PROC_PORT" ]
then
        echo "Process $1 does not exist"
        exit 0
fi


if [ -z "$(ps -ef|grep "${!PROC_STARTUP} -p ${!PROC_PORT}"|grep -v grep| awk '{print $2}')" ]
then
	echo "$1 is not running"

else
	echo "$1 is running on port ${!PROC_PORT}"
fi
