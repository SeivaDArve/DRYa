#!/bin/bash
# Title: install jarve at your home folder (~/.jarve)
# Description: Installing means copy files to ~/.bashrc. In the future you can run it on windows, android and ios
# Mothod: Prompting a menu to choose
# Displaying ASCII logo for jarve. running jarve.
cat ../all/.jarve/all/img/CLI/jarve-icon.txt
# Also in future: display whoami, and give a special ID for the MACHINE, so that it can be listed on jarve-subPocket. the machine, username and id numer, as well as jarve-icon.txt should run at the level of .bashrc"

# Menu
function Menu {
clear
cat << heredoc-menu
 _____   _____  __     __       
|  __ \ |  __ \ \ \   / /       
| |  | || |__) | \ \_/ /   __ _ 
| |  | ||  _  /   \   /   / _` |
| |__| || | \ \    | |   | (_| |
|_____/ |_|  \_\   |_|    \__,_|
                                
Hi, This is the menu for DRYa (Don't Repeat Yourself app)
heredoc-menu


# Asking user: Do you want to Intall, Re-install or Remove?
}
