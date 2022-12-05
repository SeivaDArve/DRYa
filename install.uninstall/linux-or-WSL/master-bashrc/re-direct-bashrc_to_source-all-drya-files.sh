#!/bin/bash

# Title: Insert an entry at ~/.bashrc to load DRYa
# Description: In order for ~/.bashrc not to have duplicate entries, this script relies on the brother script (brother in terms of directory location) to delete any previous entries and only then it pastes a new entry into ~/.bashrc
# Use: Decide in this file the path for "souce-all-drya-files"

# uDev: First determine where to install
   clear 
   figlet DRYa

   echo "Welcome to DRYa"
   echo " > Don't Repeat Yoursel (app)"
   sleep 0.5
   echo 
   echo "This script runnig is meant to install DRYa"
   echo " > Please choose one centralized directory"
   echo "   where DRYa and all other Seiva's Software"
   echo "   can be installed (e.g. /home/Repositories)"
   #echo " > You should prefer absolute paths instead of relative paths"
   #echo " > In order go cross platform"
   echo
   sleep 0.5
   echo "Instalation - Step 1 - by sourcing this file:"
   echo " > Issue the command '$ source <name-of-this-file>' and then"
   echo "   travel to the directory you want the software to be installed in"
   echo "   and from there, invoke this script with the command '$ DRYa-install-me-here' " 
   echo 
   sleep 0.5
   echo "Instalation - Step 2 - Move the DRYa repo into the dir you choose"
   echo " > If you were able to source this file, you must have a copy of DRYa"
   echo "   and that copy (this copy) should be moved into the directory in which"
   echo "   you did invoke DRYa-install-me-here"
   echo "   uDev: create a function that automatically moves the directory"
   echo 
   sleep 0.5
   echo "After instalation:"
   echo " > You cat unload the function that was sourced for instalation"
   echo "   you loaded: DRYa-install-me-here that exports the variable \$DRYa_PATH"
   echo "   Now, if the place for instalation is how you like, you can prevent it from changing"
   echo "   by invoking: unset-DRYa-installer"
   echo

function DRYa-install-me-here {
   DRYa_PATH=$(pwd)
   export DRYa_PATH
   echo " > DRYa: Installing at: $DRYa_PATH"
   read
   read
}

function unset-DRYa-instaler {
   unset DRYa-install-me-here
   echo " > DRYa: environment variable \$DRYa_PATH was unset"
}

#     # Using the brother script to search and reset ~/.bashrc
#        bash ./delete-drya_from_bashrc
#     
#     # Pasting a new entry inside ~/.bashrc
#        #uDev: at the root of this repo
#           # There will be a dir called "install.uninstall"
#           # path: $DRYa/install.uninstall/linux/instaler.sh
#           # that contains a function f_export_DRYa_repo-location
#           # that exports the location where the user wants drya to settle
#           # and that variable $REPOS is what this file will
#           # send to ~/.bashrc
#        echo ""
#        echo '# Run DRYa files (one file that loads all others)' >> ~/.bashrc
#        echo '   source ~/Repositories/DRYa/all/source-all-drya-files' >> ~/.bashrc
#     
#     
#      
#     # uDev: At ~/.bashrc this is what needs to appear:
#     #      # Run DRYa files (one file that loads all others)
#     #         source ${DRYa_PATH}DRYa/all/source-all-drya-files
