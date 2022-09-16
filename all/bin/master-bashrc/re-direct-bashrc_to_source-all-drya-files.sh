#!/bin/bash

# Title: Insert entry to load DRYa inside ~/.bashrc
# Description: In order for ~/.bashrc not to have duplicate entries, this script relies on the brother script (brother in terms of directory location) to delete any previous entries and only then it pastes a new entry into ~/.bashrc
# Use: Decide in this file the path for "souce-all-drya-files"


# Using the brother script to search and reset ~/.bashrc
bash ./delete-drya_from_bashrc

# Pasting a new entry inside ~/.bashrc
echo ""
echo '# Run DRYa files (one file that loads all others)' >> ~/.bashrc
echo 'bash ~/Repositories/DRYa/all/source-all-drya-files' >> ~/.bashrc
 
