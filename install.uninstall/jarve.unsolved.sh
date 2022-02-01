#!/bin/bash

clear
echo {{start: jarve.sh

#--Colors-------------------------------------------------
RED="\e[31m"
GREEN="\e[32m"
BOLDGREEN="\e[1;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

echo -e "${RED}This is some red text, ${ENDCOLOR}"
#echo -e "${GREEN}And this is some green text${ENDCOLOR}"
#echo -e "${BOLDGREEN}Behold! Bold, green text.${ENDCOLOR}"
#echo -e "${ITALICRED}Italian italics${ENDCOLOR}"
#----------------------------------------------------------
cat ./all/About/intro/intro.txt

echo "juicyDRYgeek-repo"
echo "--juicy-> multiboot"
echo "--DRY---> Don't Repeat Yourself"
echo "--geek--> Omnipresent settings"
echo ""
echo "key-juicyDRYgeek"
echo "--> all machine variables - encripted"
echo ""

echo "\"home\" belongs to this OS"
echo "\"home.home\" links to -> partition /home"
echo
echo "[wanna make some changes??;)]"
#read -p "create home.home @~ and copy jarvis into it?"

#read [s/n]
#clear
echo "this script looks for setup configurations EVERY TIME and sends you to the normal jarve at ./all/jarve"
#set browser home page to jarve
#Force_git--global_at_all_OSs


echo "do you want to read jarve-instructions? [S/n]"
read varSelector
if [ $varSelector == s ]; then
	xdg-open ./all/About/index.html
fi

echo "#############"
echo "the only file .bashrc needs to load, is this one 'jarve.sh' and it will redirect to var folder"
echo "#############"



e~/..cho }}end: jarve.sh; bash ./all/jarve/jarve-linux.sh

# Jarve must run read all dates of all files and rm all outdated, replacing of updates
