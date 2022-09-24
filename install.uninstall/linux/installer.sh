#!/bin/bash
# Title: Local installer for drya
# Use: copies files from local drya repo which is under development (or which is a fresh download) and pastes it on the system to run imediatly
# This script is not supposed to be destructive or to uninstall anything.
# README at the bottom of the page to describe the process and the logic

function f_greet {
	echo "This sotware will run smoothly by only invoking .../DRYa/all/drya.sh"
	echo "This installer is an extra to add .desktop entries and all that"
}

function f_export_updated_dryarc {
	# Replace ~/.config/h.h/.dryarc for this updated file: ./dryarc
	mkdir -p ~/.config/h.h/drya
	cp ./future-dryarc ~/.config/h.h/.dryarcdrya
}

function f_add_dryarc_to_bashrc {
   # Add .dryarc to .bashrc
   bash ~/Repositories/DRYa/all/bin/re-direct-drya-to-bashrc
}

# Copy drya.desktop to...

# Copy the man page to...

# Export a variable to acess the possibility of editing drya
# Fix: it is included at .dryarc sourced by .bashrc


function f_exec {
	f_greet
	f_export_updated_dryarc
	f_add_dryarc_to_bashrc
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
