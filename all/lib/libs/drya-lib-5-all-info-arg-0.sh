#!/bin/bash
# Title: Detecting info about the argument 0 (about the running script)
# Description: By running this script, it will echo and store it's own name, absolute path, relative path from where you are callinh it, etc...

# uDev: we can use variable names like python at least for: __name__ __main__ 


# ------------------------------------------------------------------------
#  --+-- Functions Below: Copied from drya-lib-5-all-info-arg-0.sh --+--
# ------------------------------------------------------------------------


function f_0 {
   echo " -0- Title: All info about the Arg 0 (the running script):"
   echo "  >  Do not \`source\` this as a lib (some functions will not be accurate)"
   echo "  >  Copy the needed functions to your script instead"
   echo "  >  Try \`bash .../drya-lib-5*.sh/\` to test and get info of that script"
   echo
   echo
}

function f_1 {
   # Gives the terminal's current directory name (the directory from where, the user is calling a script. This script)

   v_pwd=$(pwd)
   v_pwd="$v_pwd/"

   echo " -1- Rel path: Prompt location \`pwd\` (Current working directory):"
   echo "  >  $v_pwd"
   echo
   echo
}

function f_2 {
   # Gives the argument number zero of the running script (The name of itself with the relative path)

   # Note: example on how to use `sed` recursively to remove the text ./ at the beginning of the line until it finds none
      # How to use:  sed ':a; s/pattern/substitution/; ta' file.txt
      # Example:     echo "./././example-script-name.sh" | sed ':a; s/^\.\///; ta'  
      # RESULT:      example-script-name.sh

   # Ensuring only 1x the text ./ appears at the beginning of the line
      v_name=$(echo "$0" | sed ':a; s/^\.\///; ta')
      v_name="./$v_name"

      #uDev: "Relative path" between what? 

      echo " -2- Rel path: Argument zero \`./\$0\`, given by the terminal"
      echo "     when running script:"
      echo "  >  $v_name"
      echo
      echo
}

function f_3 {
   # Gives working directory where the script is placed (without the name ib the end)

   # No matter from where we will execute this script $v_script_directory will indicate the correct directory where this script is located

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_script_directory="$v_script_directory/"

   echo " -3- Abs Path: working dir of running script:"; 
   echo "  >  $v_script_directory";
   echo
   echo
}


function f_4 {
   # Give only the name of the script itself without any path at all

   v_basename=$(basename $0)

   echo " -4- Abs Name \`basename\` of the running script:"
   echo "  >  $v_basename"
   echo
   echo
}

function f_5 {
   # Joining script directory name and basic last name

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_basename=$(basename $0)
   v_script=$v_script_directory/$v_basename

   echo " -5- Abs path: the running script:"
   echo "  >  $v_script"
   echo
   echo
}

function f_6 {
   echo " -6- Notes: "
   echo "  >  Number -5- is equal to -1- + -2-"
   echo "  >  Number -5- is equal to -3- + -4-"
   echo "  >  Number -3- is best used for instalation wizzards"
   echo "  >  Rel: Relative"
   echo "  >  Abs: Absolute"
   echo

}

function f_exec {
   # Joining all possibilities is a sequence
   # Comment all fx below that are not supposed to run

      clear

      f_0
      f_1
      f_2
      f_3
      f_4
      f_5
      f_6
}

f_exec  # On/Off to the ENTIRE file

# ------------------------------------------------------------------------
#  --+-- Functions Above: Copied from drya-lib-5-all-info-arg-0.sh --+--
# ------------------------------------------------------------------------

