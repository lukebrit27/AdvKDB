#!/bin/bash
shopt -s expand_aliases
source ~/.bash_profile
source startup.profile;
echo `pwd`;
PROC_PORT=${1}_PORT;
PROC_STARTUP=${1}_STARTUP;

if [ -z "$1" ] 
then 
	q tick.q schemas tp_p -p ${tp_p_PORT} &
	q rdb_1.q :${tp_p_PORT} rdb_1 :9012 -p ${rdb_1_PORT} &
	q rdb_2.q :${tp_p_PORT} rdb_2 :9012 -p ${rdb_2_PORT} &
	q feed/feed.q :${tp_p_PORT} feed_p -p ${feed_p_PORT} &
	q rte_1.q :${tp_p_PORT} rte_1 :9012 -p ${rte_1_PORT} &
	#\q tick.q schemas tp_p -p 9010

elif [ -z "$PROC_PORT" ]
then
	echo "No port set for $1"
	exit 0

else 
	echo "Will use this port ${!PROC_PORT}"
	echo "Will use this profile ${!PROC_STARTUP}"
	eval "q ${!PROC_STARTUP} -p ${!PROC_PORT} &"
fi	
