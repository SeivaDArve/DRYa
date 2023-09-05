#!/bin/bash

# Title: News Displayer
# Description: Do you have an extra screen? (one tablet, TV with raspberry pi, Laptop etc..). If you have, then this script goes on using such screen to present to you the News that exist Around DRYa like: Moedaz tasks; TODO lists; Results of Web scrapping apps; Domotics status etc...
# Use: Run this script and it will clear your screen and goes on presenting from 10s to 10s new data around DRYa activities

# Defining time between presentations
   v_presenting_time=6

# uDev: Downloading single files from github as a cloud storage, instead of downloading full repos
   # Tutorial: https://www.howtogeek.com/devops/how-to-download-single-files-from-a-github-repository/

function f_horizontal_line {
   # This function calculates the amount of line present in the terminal window for the current zoom and creates an horizontal line across the screen

         v_count="$COLUMNS"
            #echo -e "There are currently $v_cols columns in the screen \n and from that number, $v_count is the\n number of dashes '-' that the menu will have "
            #read

         # You may choose the apropriate symbol here
            v_underscore="-"

         # Store in a var, how many dashes can be replaced by empty spaces (according to the specific amount of available columns)
            v_underscoreCount=""

            for e in $(seq $v_count); do 
               v_underscoreCount="$v_underscoreCount$v_underscore"
            done

         # The result is an horizontal line
            #echo "var is $v_underscoreCount"
            #read
            v_line=$v_underscoreCount

            # removing last 4 characters from v_line. This way it can be used in SELECT menus
               v_line2=${v_line::-4}

            echo $v_underscoreCount
}



while true; do
# source ${v_REPOS_CENTER}/moedaz/all/source-all-moedaz-files

clear
figlet News
echo "drya: currently displaying NEWS"
echo " > [ Any key ] to Pause/Play"
echo " > [ Ctrl-C  ] to Stop"
echo 
echo " Time set for each page: $v_presenting_time"
echo " Type: '$ drya edit-news' on the terminal to edit this script"
f_horizontal_line
echo
read -s -n 1 -t $v_presenting_time v_play_pause

if [ -z $v_play_pause ]; then 
   echo "var empty, proceed"; sleep 0.5;

else 
   echo "var not empty, pause"; sleep 0.5; 
   read -s -n 1
fi

done
