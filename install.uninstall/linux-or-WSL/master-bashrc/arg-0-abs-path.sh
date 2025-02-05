#!/bin/bash
# Title: Script to echo/store the name of the running script

function f_1 {
   # This does not work, it is subjective to change. it depends from where you ryn the script
      v_pwd=$(pwd)
      echo "Current working directory:"
      echo " > $v_pwd/"
      echo
}

function f_2 {
   # no matter from where we will execute this script
   #   $SCRIPT_DIR will indicate the correct directory 
   #   where this script is located

      v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
      echo "Path only: to the working dir of running script:"; 
      echo " > $v_script_directory/";
      echo
}

function f_3 {
   # This does not work, it is subjective to change. it depends from where you ryn the script
      echo "Full name only: of the running script:"
      echo " > ./$0"
      echo
}

function f_4 {
   # This does not work, it is subjective to change. it depends from where you ryn the script
      echo "Basename only: of the running script:"
      v_basename=$(basename $0)
      echo " > $v_basename"
      echo
}

function f_5 {
   # Joining script path and name
      v_basename=$(basename $0)
      v_script=$v_script_directory/$v_basename
      echo "Absolute path to the running script:"
      echo " > $v_script"
      echo
}

function f_exec {
   # Comment all not supposes to run

   clear
   f_1
   f_2
   f_3
   f_4
   f_5
}
f_exec

