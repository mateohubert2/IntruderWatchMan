#!/bin/bash
path=$(cat path)
cd $path
IP_address=$(cat IP_address)
machine=$(cat machine)
echo $machine
#Looking for SMB
smb_true=$(grep -c "Samba" scan_nmap_"$machine"_grep)
if [ $smb_true -gt 0 ]
#Gathering information
then
	echo -e "\n Starting enum4linux on $machine"
	enum4linux $IP_address > enum4linux_$machine
	grep -iE "(User|Workgroup|Mapping)" enum4linux_$machine > enum4linux_"$machine"_grep
	cat enum4linux_"$machine"_grep
	
	#Users
	users=$(grep -o 'User\\[^ ]*' "enum4linux_"$machine"_grep" | cut -d '\' -f2)
	echo $users > users
fi
