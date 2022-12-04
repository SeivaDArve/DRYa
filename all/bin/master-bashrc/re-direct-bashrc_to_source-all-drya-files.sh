#!/bin/bash

# Title: Insert entry to load DRYa inside ~/.bashrc
# Description: In order for ~/.bashrc not to have duplicate entries, this script relies on the brother script (brother in terms of directory location) to delete any previous entries and only then it pastes a new entry into ~/.bashrc
# Use: Decide in this file the path for "souce-all-drya-files"

# uDev: First determine where to install

# Using the brother script to search and reset ~/.bashrc
   bash ./delete-drya_from_bashrc

# Pasting a new entry inside ~/.bashrc
   #uDev: at the root of this repo
      # There will be a dir called "install.uninstall"
      # path: $DRYa/install.uninstall/linux/instaler.sh
      # that contains a function f_export_DRYa_repo-location
      # that exports the location where the user wants drya to settle
      # and that variable $REPOS is what this file will
      # send to ~/.bashrc
   echo ""
   echo '# Run DRYa files (one file that loads all others)' >> ~/.bashrc
   echo '   source ~/Repositories/DRYa/all/source-all-drya-files' >> ~/.bashrc


 
# uDev: At ~/.bashrc this is what needs to appear:
#      # Run DRYa files (one file that loads all others)
#         DRYa_PATH="/mnt/c/Repositories/"; export DRYa_PATH
#         source ${DRYa_PATH}DRYa/all/source-all-drya-files
