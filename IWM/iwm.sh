#!/bin/bash

#Get the working directory
pathfunction=$(pwd)

#Display the overlay
$pathfunction/overlay.sh

#Setting all parameters
$pathfunction/options.sh

#nmap
$pathfunction/nmap.sh

#Looking for ftp
$pathfunction/ftp.sh

#Looking for an http server
#Looking for all web pages
$pathfunction/webpages.sh

#Looking for SMB
$pathfunction/smb.sh

#Looking for ssh
$pathfunction/sshgathering.sh

#Testing brutforce for all users
$pathfunction/sshforce.sh

#Connecting to the user
$pathfunction/connectusers.sh

#Linepeas check
$pathfunction/exploitlinpeas.sh

#Looking for SUID exploit
$pathfunction/exploitSUID.sh
