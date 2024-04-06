#!/bin/bash

path=$(cat path)
cd $path
IP_address=$(cat IP_address)
machine=$(cat machine)
ftp_true=$(grep -c "ftp" scan_nmap_"$machine"_grep)
if [ $ftp_true -gt 0 ]
then
	ftp_name=$(cat scan_nmap_"$machine" | grep "allowed" | cut -d " " -f3)
	ftp_file=$(cat scan_nmap_"$machine" | grep -E ".txt" | awk '{print $NF}')
	wget ftp://$ftp_name@$IP_address/$ftp_file
	tr '\n' ' ' < $(echo $ftp_file) | tr -s ' ' | awk '!a[$0]++' >> wordlists_$machine
fi
