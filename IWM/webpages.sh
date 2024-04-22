#!/bin/bash
path=$(cat path)
cd $path
IP_address=$(cat IP_address)
machine=$(cat machine)
http_true=$(grep -c "http" scan_nmap_"$machine"_grep)
if [ $http_true -gt 0 ]
then
	echo -e "\n Starting feroxbuster on $machine"
	feroxbuster -u http://$IP_address --depth 5 --wordlist /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt > feroxbuster_$machine
	cat feroxbuster_$machine
	urls=$(grep -Eo 'http://[^ ]*/$' feroxbuster_$machine)
	echo "URL : $urls"

	#Retrieves the contents of all web pages
	IFS=$'\n' read -rd '' -a url_array<<<$urls
	for url in ${url_array[@]}
	do
		page_content=$(curl -s $url)
		#Text files
		file_urls=$(echo "$page_content" | grep -oE "href=\"[^\"]+\.txt\"" | cut -d'"' -f2)
		echo -e "\n url of the downloading txt files availables on : $url"
		echo $file_urls
		IFS=$'\n' read -rd '' -a file_array <<< $file_urls
		for file in ${file_array[@]}
		do
			echo -e "\n Contenu de $file : "
			echo "------------------------------"
			curl -s $url$file
			echo "------------------------------"
		done
		image_file=$(echo "$page_content" | grep -oE "[^\"]*\.jpg")
		IFS=$'\n' read -rd '' -a image_array <<< $image_file
		for img in ${image_array[@]}
		do
			wget $url/$img
			echo -e "\n Downloading $img"
			jp2a --color --width=50 $img
			
		#Looking for steganography
		name=$(echo $img | cut -d "." -f1)
		stegseek $img 1>> stegseek_$name 2>&1
		cat $(echo $(grep "Extracting" stegseek_$name | grep -oE "[^\"]*\.out")) > cat_$name
		cat cat_$name
		tr '\n' ' ' < cat_$name | tr -s ' ' | awk '!a[$0]++' > tmp_wordlists_$machine
		tr 'A-Z' 'a-z' < tmp_wordlists_$machine >> wordlists_$machine
		done
	done
fi
