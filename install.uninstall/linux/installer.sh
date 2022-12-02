#!/bin/bash
# Title: Local installer for drya
# Use: copies files from local drya repo which is under development (or which is a fresh download) and pastes it on the system to run imediatly
# This script is not supposed to be destructive or to uninstall anything.
# README at the bottom of the page to describe the process and the logic

#uDev: All these functions will be merged in the future with drya.sh

function f_greet {
	figlet "DRYa" 2>/dev/null || echo "DRYa: greetings ;)" 
}

function f_find_source-all-drya-files 
{
	# uDev: Process of instalation:
		# 1. Must know the full location from where this script is running from (script installer.sh)
		# 2. Must Ask where the user wants the script to be installed
			# 2.1 Either from ~
			# 2.2 Or from .
			# 2.3 Or from /bin
			# 2.4 Or give a location
				# If another location is mentioned, there are 2 otpions:
				# 2.4.1 Give the full path to it
				# 2.4.2 Allow interactive navigation with '$ cd' command	
		# 3. After the current file location is found, must know the location of source-all-drya-files
		# 4. Must run the script (or import the sscript) that places that 
			# file "source-all-drya-files" into ~/.bashrc












	# The file "source-all-drya-files" must be found for installation because 
		# it is the one that is mentioned at the ~/.bashrc
	
	# uDev: Find a recursive way to find this file without using the command '$ tree'
		# The command '$ tree' gives us a search combined with the path of the file that was found
		# but it is just one more dependency and it is not always installed on the machine
		# The recursive solution that we should find to replace '$ tree' may start every
		# search at "DRYa/all" because while it is under development it may change for some reason
	
	# hard coded version of the search for the file: "source-all-drya-files":
		v_file="source-all-drya-files"
		v_file_relative="../../all/source-all-drya-files"
		echo "DRYa: Linux Installer: My script name is: ./$0"
		echo "DRYa: Linux Installer: My relative dir path is: ./$(dirname $0)"

		v_here=$(pwd); v_me=$0; v_full_me="${v_here}/${v_me}"
		echo "DRYa: Linux Installer: My full path is: $v_full_me"

		echo "Now lets cut last fild of last outputed path (similar to '$ cd ..'): "
		echo " > $(dirname v_full_me)"

		echo
		echo "Current dir: $(pwd)"
		echo "DRYa: Linux Installer: The file to be sourced for DRYa is: ${v_here}/$v_file"

		read
		less ${v_here}/$v_file_relative

		[ -f v_file ] && echo "file found" 
}

function f_export_variables {
	# uDev: Ask where the user wants drya to be installed and export the variable $drya-REPOS-dir
   	#uDev: Because f_greet starts before the question "do you want to install dependencies?"
      		# then copy the ascii art from it at least tmfor this time

	#uDev: needs to find the pwd where the script is running
	basename $0
	pwd

   	#echo "Hi, this is DRYa;)"
   	#echo " > Don't Repeat Yourself (app)"
	#echo "This sotware will run smoothly by only invoking .../DRYa/all/drya.sh"
	echo "This installer is an extra to add .desktop entries and all that"
}

function f_export_updated_dryarc {
	# Replace ~/.config/h.h/.dryarc for this updated file: ./dryarc
	   mkdir -p ~/.config/h.h/drya
	   cp ./future-dryarc ~/.config/h.h/.dryarcdrya
}

function f_add_drya_to_bashrc {
   #Add file "source-all-drya-files" to ~/.bashrc
      # which is the first file and only file
      # inside ~/.bashrc that re-directs to all others

      # uDev: Ask permission to continue first
      bash ~/Repositories/DRYa/all/bin/re-direct-bashrc_to_source-all-drya-files.sh

}

function f_list_github_public_repositories {
   # This function is a web scraper
      clear
      curl https://github.com/SeivaDArve?tab=repositories | grep codeReposi > ~/.tmp_file
      sed -i 's#<a href="/SeivaDArve/##g' ~/.tmp_file 
      sed -i 's/" itemprop="name codeRepository" >//g' ~/.tmp_file
      sed -i 's/ //g' ~/.tmp_file
      cat ~/.tmp_file
      #rm ~/.tmp_file
      vim ~/.tmp_file

   # uDev: create a '$ select' menu to enable the user to install any repo available
}

# Copy drya.desktop to...

# Copy the man page to...

# Export a variable to acess the possibility of editing drya

function f_export_DRYa_repo-location {
   #uDev: this function simply finds where the user wants DRYa's repo to settle
      # Then finds its '$ pwd' and then exports it.
      # that Variable $REPOS will be the variable
      # used by the master-bashrc.
      # The binary that masters .bashrc will send to ~/.bashrc the correct
      # DRYa location
      echo

}

function f_exec {
	#f_greet
f_list_github_public_repositories
	#f_find_source-all-drya-files	
	#f_export_variables
	#f_export_updated_dryarc
	#f_add_drya_to_bashrc
   	#f_drya-to-desktop ##uDev: must be created
	#source ~/.bashrc && echo "sourced"
}

f_exec

# README:
# This installer does several things:
# 1. Creates a directory at ~/.config/h.h if it does not exist already
# 2. Creates a file .dryarc ~/.config/h.h/drya (for temporary DRYa configs
# 3. Reads the file ~/.bashrc to see it it has a shebang
#	3.1. If if doesn't than adds it
# 4. Reads the file ~/.bashrc again to see if it recognizes ~/Repositories/DRYa/all/source-all-drya-files 
# 	4.1 If it doesn't than adds it
# 5. Sources ~/.bashrc to apply the changes done manually
# 6. Ask if user want to add the GUI layer to DRYa
#	6.1 if yes: add icon .desktop to it's correct place according to the distro
# 7. Copies drya man page to it's destination
