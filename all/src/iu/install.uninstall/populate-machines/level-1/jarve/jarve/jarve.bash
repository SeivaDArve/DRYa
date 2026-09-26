#/bin/bash
# Title: install jarve at your home folder (~/.jarve)
# Description: Installing means copy files to ~/.bashrc. In the future you can run it on windows, android and ios
# Mothod: Prompting a menu to choose
# Also in future: display whoami, and give a special ID for the MACHINE, so that it can be listed on jarve-subPocket. the machine, username and id numer, as well as jarve-icon.txt should run at the level of .bashrc"

# Menu
function menu {
clear
echo " 
 _____   _____  __     __       
|  __ \ |  __ \ \ \   / /       
| |  | || |__) | \ \_/ /   __ _ 
| |  | ||  _  /   \   /   / _\` |
| |__| || | \ \    | |   | (_| |
|_____/ |_|  \_\   |_|    \__,_|
                                
(Don't Repeat Yourself app) - Menu

Asking user: Do you want to:
1) Install	|
2) Re-install	| Software
3) Remove	|
4) Track	|

5) Instructions
6) Exit
"
read answer
}



menu
