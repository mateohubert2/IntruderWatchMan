#!/bin/bash
#Ask the user for an IP_address
read -p " Please provide the Target IP : " IP_address
#Check if the host is up
echo " Looking if the host is up"
ping -c 6 $IP_address > ping_tmp
up=$(grep -c "bytes" ping_tmp)
if [[ $up -ge 6 ]]
then
	echo -e " The Host is up \n"
	rm ping_tmp
else
	echo -e " The Host is unreachable \n"
	rm ping_tmp
	exit 1
fi

#Ask for the LHOST IP
read -p " Please provide your own IP address : " IP_local

#Ask for a non use port
read -p " Please provide a free port on your machine :" port

#Ask the user for a name
read -p " Please provide a Target name : " machine

#Check if a folder for the machine already exist
if [ -d $machine ]
then
	echo -e " Everything is set, the program can start \n"
	cd $machine
	#Erase all precedent files
	rm ssh_users
	rm target_usr
	rm wordlists_$machine
else
	mkdir $machine
	echo -e " Everything is set, the program can start \n"
	cd $machine
fi

#Display parameters:
echo " Parameters :"
echo -e " Target IP: $IP_address"
echo -e " Working directory : $(pwd)"
working_directory=$(pwd)
cd ..
echo $working_directory > path
cd $working_directory
echo  $IP_address > IP_address
echo $IP_local > IP_local
echo  $port > port
echo $machine > machine
