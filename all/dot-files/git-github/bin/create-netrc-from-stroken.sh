#!/bin/bash
# Title: Automatic setup for file: .netrc
# Description: We can avoid repetitive manual autentication for git by using a file .netrc at ~ and at this file, a token must be written. This sript sends the current stroken (token with a mispelled bug) to the correct file. Afterwards prompts the user to correct the bug

clear
figlet DRYa

echo "Installing Stroken as ~/.netrc"
echo
echo "Job to be done:"
echo " > echo \$stroken > ~/.netrc"
echo " > edit ~/.netrc"
echo
echo "Explanation: This script will install github's personal access token in this machine located at ~/.netrc but with a bug (also called stroken). In the end, this script will also open the file for edition and for manual correction of the token by the user."
echo
echo "Do you want to continue?"
echo " > Press [Any key] to continue"
echo " > Press Ctrl-C to exit"
read -s -n 1
echo


# If DRYa is installed on ~/.bashrc then:
  # Everytime the terminal is initiated, DRYa will apply new changes to ~/.config/h.h/drya/current-stroken
  # Set an alias "stroken" to read such file

  # We need that stroken message in these 2 variables: 
    v_username=$(cat ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/current-stroken | head -n 1)
    v_token=$(cat ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/current-stroken | tail -n 1)

# Creating a file ~/.netrc with our new stroken info
   echo "machine github.com login $v_username password $v_token" > ~/.netrc
   echo "File created "
   echo " > with stroken instead of a token (still contains a bug)"
   echo " > Press [Any key] to continue and to edit..."
   read -s -n 1
   echo

# Opening the file to edit
   echo "Opening the file ~/.netrc"
   echo " > (3 seconds to cancel with Ctrl-C)"
   read -s -n 1 -t 3
   vim ~/.netrc
   echo "Done!"
