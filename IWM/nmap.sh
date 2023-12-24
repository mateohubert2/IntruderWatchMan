#!/bin/bash

#nmap
path=$(cat path)
cd $path
IP_address=$(cat $path/IP_address)
echo $IP_address
machine=$(cat $path/machine)
echo -e "\n Starting nmap scan \n"
nmap -A -v $IP_address > scan_nmap_$machine
grep -E ^[0-9] scan_nmap_$machine | grep "open" > scan_nmap_"$machine"_grep
cat scan_nmap_"$machine"_grep
