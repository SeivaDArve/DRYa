#!/bin/bash
# Title: Script to echo/store the name of the running script

function f_1 {
   # Gives the terminal's current directory name (the directory from where, the user is calling a script. This script)

   v_pwd=$(pwd)
   v_pwd="$v_pwd/"

   echo "Current working directory:"
   echo " > $v_pwd"
   echo
}

function f_2 {
   # Gives working directory where the script is placed (without the name ib the end)

   # No matter from where we will execute this script
   #   $SCRIPT_DIR will indicate the correct directory 
   #   where this script is located

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_script_directory="$v_script_directory/"

   echo "Path only: to the working dir of running script:"; 
   echo " > $v_script_directory";
   echo
}

function f_3 {
   # Gives the argument number zero of the running script (The name of itself with the relative path)

   # Note: example on how to use `sed` recursively to remove the text ./ at the beginning of the line until it finds none
      # How to use:  sed ':a; s/pattern/substitution/; ta' file.txt
      # Example:     echo "./././example-script-name.sh" | sed ':a; s/^\.\///; ta'  
      # RESULT:      example-script-name.sh

   # Ensuring only 1x the text ./ appears at the beginning of the line
      v_name=$(echo "$0" | sed ':a; s/^\.\///; ta')
      v_name="./$v_name"

      echo "Arg 0, given at the terminal as the running script (relative path):"
      echo " > $v_name"
      echo
}

function f_4 {
   # Give only the name of the script itself without any path at all

   v_basename=$(basename $0)

   echo "Basename only: of the running script:"
   echo " > $v_basename"
   echo
}

function f_5 {
   # Joining script directory name and basic last name

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_basename=$(basename $0)
   v_script=$v_script_directory/$v_basename

   echo "Absolute path to the running script:"
   echo " > $v_script"
   echo
}

function f_exec {
   # Joining all possibilities is a sequence

   # Comment all not supposes to run
   clear

   f_1
   f_2
   f_3
   f_4
   f_5
}
f_exec

