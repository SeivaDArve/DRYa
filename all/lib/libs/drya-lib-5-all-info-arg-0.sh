#!/bin/bash
# Title: Detecting info about the argument 0 (about the running script)
# Description: By running this script, it will echo and store it's own name, absolute path, relative path from where you are callinh it, etc...
# Note: we could use variable names like python at least for: __name__ __main__ 

#
#
#
# Use: Copy entire file to your code. 
#      Delete unwanted functions (instead of sourcing as a lib).
#      Make sure each function is solo, to avoid depending on each other, 
#      allowing the dev to delete the remaining unwanted functions
#
#
#      You may copy from:
#        # --------------------------- 
#        #  --+-- Functions Below: 
#        # ---------------------------
#
#      To:
#        # --------------------------- 
#        #  --+-- Functions Above: 
#        # ---------------------------
#
#      And then, in the f_exec you comment with # the unwanted verbose fx or even delete
#


# uDev: "Relative paths" between what? 





# ------------------------------------------------------------------------
#  --+-- Functions Below: Copied from drya-lib-5-all-info-arg-0.sh --+--
# ------------------------------------------------------------------------


function f_0 {
   # The sole purpose of this f_0 function is to avoid Hard Coded names on f_0_verbose function
   v_basename=$(basename $0)  # Same line of code as f_6
}

function f_0_verbose {
   echo " -0- Title: All info about the Arg 0 (the running script):"
   echo "  >  Do not \`source\` this as a lib (some functions will not be accurate)"
   echo "  >  Copy the needed functions to your script instead"
   echo "  >  Try \`bash .../$v_basename\` as a test to get info of that script"
   echo
   echo
}

function f_1 {
   # Gives the terminal's current directory name (the directory from where, the user is calling a script. This script)

   # Mostrar sem sufixo
   v_pwd=$(pwd)

}
function f_1_verbose {
   echo " -1- Rel path: Prompt location \`pwd\` (Current CLI working directory, without sufix / ):"
   echo "  >  $v_pwd"
   echo
   echo
}

function f_2 {
   # Mostrar com sufixo
   v_pwd=$(pwd)
   v_pwd="$v_pwd/"
}
function f_2_verbose {
   echo " -2- Rel path: Prompt location \`pwd\` (Current CLI working directory with sufix / ):"
   echo "  >  $v_pwd"
   echo
   echo
}

function f_3 {
   # Without ensuring text the text ./
      v_Name=$0
}
function f_3_verbose {
      echo " -3- Rel path: Between the current prompt ./ and script name \$0 without prefix './' :"
      echo "  >  $v_Name"
      echo
      echo
}

function f_4 {
   # Gives the argument number zero of the running script (The name of itself with the relative path)

   # Note: example on how to use `sed` recursively to remove the text ./ at the beginning of the line until it finds none
      # How to use:  sed ':a; s/pattern/substitution/; ta' file.txt
      # Example:     echo "./././example-script-name.sh" | sed ':a; s/^\.\///; ta'  
      # RESULT:      example-script-name.sh

   # Ensuring only 1x the text ./ appears at the beginning of the line
      v_name=$(echo "$0" | sed ':a; s/^\.\///; ta')
      v_name="./$v_name"

}
function f_4_verbose {
      echo " -4- Rel path: Between the current prompt ./ and script name \$0 with prefix './' :"
      echo "  >  $v_name"
      echo
      echo
}

function f_5 {
   # Gives working directory where the script is placed (without the name ib the end)

   # No matter from where we will execute this script $v_script_directory will indicate the correct directory where this script is located

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_script_directory="$v_script_directory/"


   v_basename=$(basename $0)  # Same line of code as f_6
}
function f_5_verbose {
   echo " -5- Abs Path: working dir of running script \"$v_basename\":"; 
   echo "  >  $v_script_directory";
   echo
   echo
}


function f_6 {
   # Give only the name of the script itself without any path at all

   v_basename=$(basename $0)

}
function f_6_verbose {
   echo " -6- Abs Name: \`basename \$0\` when running the script:"
   echo "  >  $v_basename"
   echo
   echo
}

function f_7 {
   # Joining script directory name and basic last name

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_basename=$(basename $0)
   v_script=$v_script_directory/$v_basename

}
function f_7_verbose {
   echo " -7- Abs path: the running script:"
   echo "  >  $v_script"
   echo
   echo
}

function f_8_verbose {
   echo " -8- Notes: "
   echo "  >  Number -1- and -2- are the same, but -2- adds more text"
   echo "  >  Number -3- and -4- are the same, but -4- adds more text"
   echo "  >  Number -5- is best used for instalation wizzards"
   echo "  >  Number -6- is similar to __name__ in python"
   echo "  >  Number -7- is equal to -1- + -4-"
   echo "  >  Number -7- is equal to -2- + -3-"
   echo '  >  "Rel" = Relative'
   echo '  >  "Abs" = Absolute'
   echo
}

function f_exec {
   # Joining all possibilities is a sequence. Comment all fx below that are not supposed to run

   clear

   f_0
   f_0_verbose 

   f_1
   f_1_verbose

   f_2
   f_2_verbose

   f_3
   f_3_verbose

   f_4
   f_4_verbose

   f_5
   f_5_verbose

   f_6
   f_6_verbose

   f_7
   f_7_verbose

   f_8_verbose
}

f_exec  # On/Off to the ENTIRE file

# ------------------------------------------------------------------------
#  --+-- Functions Above: Copied from drya-lib-5-all-info-arg-0.sh --+--
# ------------------------------------------------------------------------

