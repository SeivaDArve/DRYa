#!/bin/bash
# Title: Horizontal Line according to terminal window
# Use: 1. This script is meant to be sourced and it's variables to be exported
#      2. At the terminal you can type "echo $v_line" for longer version of line
#      3. At the terminal you can type "echo $v_line2" for shorter version of line
#      4. You can navigate to this dir and command "bash f_horizontal_line -s"
#      5. You can navigate to this dir and command "bash f_horizontal_line -short"

alias line0="f_horizontal_line"  # Alternative to '$ f_horizontal_line' that recalculates line size
alias line1="echo \$v_line"      # Alternative to '$ echo $v_line'
alias line2="echo \$v_line2"     # Alternative to '$ echo $v_line2'

function f_horizontal_line {
   # This function calculates the amount of line present in the terminal window for the current zoom and creates an horizontal line across the screen

   # Detecting how many columns there are currently in the terminal screen
      #v_cols="$COLUMNS"                     ## Method 1 (some linux distros have this environment variable)   
      v_cols=$(stty size | cut -d" " -f 2)  ## Method 2
      #v_cols=$(tput cols)                   ## Method 3 (tput needs to be installed)

   # Subtracticting 4 to this variable
      v_cols2=$(expr $v_cols - 4)

   # Debug: 
      #echo -e "There are currently $v_cols columns in the screen \n and from that number, $v_cols is the\n number of dashes '-' that the menu will have "; read

   # You may choose the apropriate symbol here
      v_underscore="-"

   # Store in a var, how many dashes can be replaced by empty spaces (according to the specific amount of available columns)
      v_underscoreCount=""

    for e in $(seq 1 $v_cols); do
      v_underscoreCount="${v_underscoreCount}${v_underscore}"
    done

   # The result is an horizontal line
      v_line=$v_underscoreCount

      # Debug:
         #echo "var '$v_line' is $v_underscoreCount" ; read

   # Removing last 4 characters from v_line. This way it can be used in SELECT menus
      v_line2=${v_line::-4}

      export v_line
      export v_line2

}


# uDev: After calculating the horizontal line amount of dots, if the user inputs a second argument $1 then the effect is immediatly applylies in the choosen way... otherwise, by running this script, the user only stores the variables

   f_horizontal_line

   if [ -z $1 ]; then
      echo "Nothing needs to be done, variables were stored" 1>/dev/null

   elif [ $1 == "-f" ] || [ $1 == "full" ]; then 
      echo $v_line

   elif [ $1 == "-s" ] || [ $1 == "short" ]; then 
      echo $v_line2

   elif [ $1 == "-v" ] || [ $1 == "verbose" ]; then 
      echo "Simply tell how many lines and columns there are currently in the terminal screen"
      echo
      echo "There are currently $v_cols columns in the screen"
      echo "Symbol to be repeated: $v_underscore"
      echo 
      echo "Variable 'v_line'  is used with 'echo' and 'cat' commands"
      echo " > Will be reteated (times): $v_cols"
      echo
      echo "Variable 'v_line2' is used with 'select' menus (subtracted -4) symbols"
      echo " > Will be reteated (times): $v_cols2"
      echo
      echo "Symbol '$v_underscore' will be repeated $v_cols times with arg: -f"
      echo "Symbol '$v_underscore' will be repeated $v_cols2 times with arg: -s"
   fi
