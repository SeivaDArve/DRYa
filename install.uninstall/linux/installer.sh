#!/bin/bash
# Title: Local installer for drya
# Use: copies files from local drya repo which is under development (or which is a fresh download) and pastes it on the system to run imediatly
# This script is not supposed to be destructive or to uninstall anything.
# README at the bottom of the page to describe the process and the logic

#uDev: All these functions will be merged in the future with drya.sh

function f_greet {
<<<<<<< Updated upstream
	figlet "DRYa" 2>/dev/null || echo "DRYa: greetings ;)" 
}

funtion f_export_variables {
	# uDev: Ask where the user wants drya to be installed and export the variable $drya-REPOS-dir
=======
   #uDev: Because f_greet starts before the question "do you want to install dependencies?"
      # then copy the ascii art from it at least tmfor this time

   echo "Hi, this is DRYa;)"
   echo " > Don't Repeat Yourself (app)"
	echo "This sotware will run smoothly by only invoking .../DRYa/all/drya.sh"
	echo "This installer is an extra to add .desktop entries and all that"
>>>>>>> Stashed changes
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

# Copy drya.desktop to...

# Copy the man page to...

# Export a variable to acess the possibility of editing drya
# Fix: it is included at .dryarc sourced by .bashrc

function f_export_DRYa_repo-location {
   #uDev: this function simply finds where the user wants DRYa's repo to settle
      # Then finds its '$ pwd' and then exports it.
      # that Variable $REPOS will be the variable
      # used by the master-bashrc.
      # The binary that masters .bashrc will send to ~/.bashrc the correct
      # DRYa location

}

function f_exec {
	f_greet
	#f_export_updated_dryarc
	#f_add_drya_to_bashrc
   #f_drya-to-desktop ##uDev: must be created
	source ~/.bashrc && echo "sourced"
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
