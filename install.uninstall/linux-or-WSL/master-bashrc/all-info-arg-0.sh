#!/bin/bash
# Title: Detecting info about the argument 0
# Description: By running this script, it will echo and store it's own name, absolute path, relative path from where you are callinh it, etc...

function f_create_file_to_save_all_vars {
   # After creating this file, it can be sourced and used by other scripts

   v_dir=~/tmp && mkdir -p $v_dir

   v_name="drya-to-source.sh"
   v_file=$v_dir/$v_name

   echo "#!/bin/bash"  > $v_file
   echo "           " >> $v_file
}

function f_1 {
   # Gives the terminal's current directory name (the directory from where, the user is calling a script. This script)

   v_pwd=$(pwd)
   v_pwd="$v_pwd/"

   v_mensagem1=' 1. Location of the Prompt: Current working directory (`pwd`):'
   v_mensagem2="    > $v_pwd"

   # Verbose no terminal
      echo "$v_mensagem1"
      echo "$v_mensagem2"
      echo

   # Verbose no ficheor arg-zero.sh
      echo "#$v_mensagem1" >> $v_file
      echo "v_1=$v_pwd"     >> $v_file
      echo                  >> $v_file
}

function f_2 {
   # Gives working directory where the script is placed (without the name ib the end)

   # No matter from where we will execute this script
   #   $SCRIPT_DIR will indicate the correct directory 
   #   where this script is located

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_script_directory="$v_script_directory/"

   v_mensagem1=" 2. Absolute Path: only to the directory of running script:"
   v_mensagem2="    > $v_script_directory"

   # Verbose no terminal
      echo "$v_mensagem1"
      echo "$v_mensagem2"
      echo

   # Verbose no ficheor arg-zero.sh
      echo "#$v_mensagem1"           >> $v_file
      echo "v_2=$v_script_directory" >> $v_file
      echo                           >> $v_file
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

      v_mensagem1=" 3. Relative Path: Arg 0. Prompt given to run the script:"
      v_mensagem2="    > $v_name"

   # Verbose no terminal
      echo "$v_mensagem1"
      echo "$v_mensagem2"
      echo

   # Verbose no ficheor arg-zero.sh
      echo "#$v_mensagem1"           >> $v_file
      echo "v_3=$v_name" >> $v_file
      echo                           >> $v_file
}

function f_4 {
   # Give only the name of the script itself without any path at all

   v_basename=$(basename $0)

   v_mensagem1=" 4. Basename only of the running script:"
   v_mensagem2="    > $v_basename"

   # Verbose no terminal
      echo "$v_mensagem1"
      echo "$v_mensagem2"
      echo

   # Verbose no ficheor arg-zero.sh
      echo "#$v_mensagem1"           >> $v_file
      echo "v_4=$v_basename" >> $v_file
      echo                           >> $v_file
}

function f_5 {
   # Joining script directory name and basic last name

   v_script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
   v_basename=$(basename $0)
   v_script=$v_script_directory/$v_basename

   v_mensagem1=" 5. Absolute path of the running script:"
   v_mensagem2="    > $v_script"

   # Verbose no terminal
      echo "$v_mensagem1"
      echo "$v_mensagem2"
      echo

   # Verbose no ficheor arg-zero.sh
      echo "#$v_mensagem1"           >> $v_file
      echo "v_5=$v_script" >> $v_file
      echo                           >> $v_file
}

function f_exec {
   # Joining all possibilities is a sequence

   # Comment all not supposes to run
   clear
	
   f_create_file_to_save_all_vars

   echo "# Title: all-info-arg-o.sh"
   echo
   echo "Demonstration of habilities:"
   f_1
   f_2
   f_3
   f_4
   f_5
}
f_exec

# detecting also arguments
   echo " 6. Detecting also arguments:"
 
   if [ -z $1 ]; then 
      echo "    > No argument was given at the prompt"

   else
      for i in $*
      do
         echo "    > $i"
      done
   fi


# Mentioning the name of the temporary file where all demonstrated variables where put
   echo 
   echo 
   echo "All demonstrated variables were put in a temporary file at:"
   echo " > $v_file"

# After the display of power, a temporary file will be created so that each variable may be used
   echo
   echo
   echo "How to use:"
   echo " 1. By running this script from ANYWHERE, a file is created at ~/tmp/arg-zero.sh"
   echo " 2. The file contains valid BASH syntax, and has a copy of the verbose ouptup given here"
   echo ' 3. For any script that needs these values, type `source ~/tmp/arg-zero.sh` at the beginning of the file'
   echo ' 4. The file has verbose output, but after running it, a command `clear` can be added'
   echo ' 5. variables like $v_1 $v_2 $v_3 can now be used on your script'
   echo 
   echo ' 6. In the case of DRYa: all-info-arg-0.sh is a file placed side-by-side with other important DRYa scripts that need the `pwd` for such directory'

   less $v_file
