# Title: Describing this directory's contents for git usage

# This directory contains:
  > README.txt        (file. This file)
  > .netrc            (file: to enable automatic autentication when pushing or pulling content for github using the terminal)
  > current-stroken   (file: to store a personal access token mispelled)
  > .gitconfig        (file: to store git configs and to be placed at ~)
  > bin/              (directory to...)

# About the file: current-stroken
  > A file that contains a github's access token but with a bug for safety, only the user know how to correct it. The token should not be written in plain text
  > You can edit this file manually or with the command '$ drya edit stroken' (edits the file: .../DRYa/all/dot-files/git-github/current-stroken)
    > The new edition should be copied to .../DRYa/install.uninstall/stroken for new users who are not aware of the directory tree

# About the file: .gitconfig
  > A file you can edit manually and make it to use by copyung it to ~
  > The app "ezGIT" should have an option to automatically do this

# About the file: .netrc 
  > It contains the example text syntax to use at github webpage
  > ~/.netrc stores one written line of code that allows the git command to read the current github token and use it when pushing or pulling content
  > This github token is used for authentication

# About the directory: bin/
  > It is a directory to help the user beeing faster to setup the file .netrc for git usage
  > It contains: create-netrc-from-stroken.sh that sets almost everything up automatically, and describes what to do next

# Making use of .netrc:
  # Manually: 
     1 > Copy ./.netrc to ~/.netrc
     2 > Open the file ~/.netrc
     3 > Edit it's place_holders with correct info
     4 > Save the file and use git normally (won't prompt for autentication anymore)

  # Automatically:
     1 > open directory: ./bin/
     2 > run: '$ bash bin/create-netrc-from-stroken.sh
         or:  '$ drya install stroken'

# Enjoy!
