#!/bin/bash

# Title: News Displayer
# Description: Do you have an extra screen? (one tablet, TV with raspberry pi, Laptop etc..). If you have, then this script goes on using such screen to present to you the News that exist Around DRYa like: Moedaz tasks; TODO lists; Results of Web scrapping apps; Domotics status etc...
# Use: Run this script and it will clear your screen and goes on presenting from 10s to 10s new data around DRYa activities

# Loading commum configs ----------------------

# Defining variables:
   # time between presentations
      v_presenting_time=6
   # Display one frame at a time according by number
      v_frame_n=0  ## Starting with frame number 0
   # Color 
      function f_cor {
         tput setaf 1
      }

   # Turn each available frame On/Off (On == 1; Off == 0;)
      # Frame: moedaz --todo-list
         v_frame_moedaz_todo=1
      # Frame: moedaz --current-fixed-pay ----------------------
         v_frame_moedaz_fixed_pay=1
      # Frame: moedaz --list-car-fix-list ----------------------
         v_frame_moedaz_avaria_car=1
      # Frame: shiva-sutras --random ----------------------
         v_frame_SS_random=1
      # Frame: web-scrape-diario-republica
         #v_frame...
      # Frame: drya-irc-client
      # To tell all other users that one user created a dedicated irc chat room for drya users to comunicate

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

function f_horizontal_line_red {
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

         tput setaf 1
         echo $v_underscoreCount
         tput sgr0
}



while true
   do
      
   # Lists:
   # moedaz: burocratic toDos; 
   #         shopping list
   # source ${v_REPOS_CENTER}/moedaz/all/source-all-moedaz-files

   # Standard message
      clear
      f_cor; figlet Reminders; tput sgr0
      echo "DRYa: currently displaying NEWS, ToDo lists and REMINDERs"
      echo " > [ Any key ] to Pause/Play"
      echo " > [ Ctrl-C  ] to Stop"
      echo " > [ H ] for configurations, options and help"
               # echo " > [ ${v_presenting_time}s ] time set for each page"
      echo " > [ $ drya edit news ] to edit this script"
      f_horizontal_line_red
      echo

   # Alternation between frames
      v_frame_n=$(($v_frame_n+1))
      echo "######### $v_frame_n (number of v_frame_n)"
      #[ $v_frame_n == "1" ]; cat ${v_REPOS_CENTER}/moedaz/all/var/com.todo-lista-de-tarefas.org
      echo "######### $v_frame_n (number of v_frame_n)"
      [ $v_frame_n == "2" ]; bash ${v_REPOS_CENTER}/112-Shiva-Sutras/ss.sh -R
      #echo "######### $v_frame_n (number of v_frame_n)"
      [ $v_frame_n == "3" ]; v_frame_n=0 


   # At each frame, wait for X seconds and display the countdown
      #uDev
      read -s -n 1 -t $v_presenting_time v_play_pause

   v_play_pause=$(echo $v_play_pause || sed -i 's/ /a/g')

   if [ -z $v_play_pause ]; then
      echo "var empty, proceed"; sleep 0.5;

   elif [ $v_play_pause == "p" ]; then
      echo "Var is \"p\" pausing"
      read -s -n 1
   else 
      echo "var not empty, pause"; sleep 0.5; 
      read -s -n 1
  fi

done


# Frame 1: moedaz --toDo-list ----------------------
   cat ${v_REPOS_CENTER}/moedaz/all/var/com.todo-lista-de-tarefas.org

# Frame 2: moedaz --current-fixed-pay ----------------------

# Frame 3: shiva-sutras --random ----------------------
   bash ${v_REPOS_CENTER}/112-Shiva-Sutras/ss.sh -R

