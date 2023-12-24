#!/bin/bash
#Path to the menu image
image_path="rabbit.png"

#Check if the image exist
if [ ! -f $image_path ]
then
	echo "The image doesn't exist"
	exit 1
fi

#Converts the image to ASCII and displays it
jp2a --color --width=50 $image_path

#Display the program name and informations
cat << "EOF"
 _____       _                  _        __          __   _       _     __  __             
|_   _|     | |                | |       \ \        / /  | |     | |   |  \/  |            
  | |  _ __ | |_ _ __ _   _  __| | ___ _ _\ \  /\  / /_ _| |_ ___| |__ | \  / | __ _ _ __  
  | | | '_ \| __| '__| | | |/ _` |/ _ \ '__\ \/  \/ / _` | __/ __| '_ \| |\/| |/ _` | '_ \ 
 _| |_| | | | |_| |  | |_| | (_| |  __/ |   \  /\  / (_| | || (__| | | | |  | | (_| | | | |
|_____|_| |_|\__|_|   \__,_|\__,_|\___|_|    \/  \/ \__,_|\__\___|_| |_|_|  |_|\__,_|_| |_|
EOF

echo -e "\n\n Welcome to IntruderWatchMan, an automated pentesting program. \n\n Please use this program only for machines \n on which you are authorized to operate. \n\n Creators: HUBERT Matéo, BOUQUILLON Erwan, SOULAIROL Lilian. \n\n mateo_hubert@etu.u-bourgogne.fr \n erwan_bouquillon@etu.u-bougogne.fr\n lilian_soulairol@etu.u-bourgogne.fr \n"
