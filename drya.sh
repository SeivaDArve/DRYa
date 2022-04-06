#!/bin/bash

# Max Cols: 56; Max lines: 28 (to aprox match smartphone screen)

# Decide 2 sliders, one Horizontal and one Vertical
_V=0
_H=0
	
function f_slideVup {
	((_V=_V+1))
	#echo $_V
}
		
function f_slideHup {
	((_H=_H+1))
	#echo $_H
}

function f_slideVdw {
	((_V=_V-1))
	#echo $_V
}
		
function f_slideHdw {
	((_H=_H-1))
	#echo $_H
}

function f_horizline {
	_count=$(tput cols)
	for i in $(seq $_count); do
   	echo -ne "-" 
	done
}

function f_replaceRead {
	echo "First line..."
	tput sc
	read -p "Press any key to overwrite this line... " -n1 -s
	tput rc 1; tput el
	echo "Second line. read replaced."
}

function f_wiki {
	cat << heredoc
info:
To undo "tput rev" use "tput sgr0"

info:
"read -rsn1 input": Expect only one letter (and don't wait for submitting) and be silent (don't write that letter back).
heredoc
}

function f_detectOS {
	echo "whoami: 	$(whoami)"
	echo "OS type: 	${OSTYPE}"
	echo "uname:		$(uname)"
	echo "uname -a: 	$(uname -a)"
}

function f_readKeystroke {
	while true
		do

		# If you run f_exec for the first time, this if statment will break the while loop allowing f_mainmenu to run for the first time without asking for any keystroke or changes
		if [ ${_H} = 0 ] && [ ${_V} = 0 ]; then
			#echo "no keystroke is asked"
			_H=1
			_V=1
			break
		fi
			
		read -rsn1 input
		if [ "$input" = "s" ]; then
    			#echo "key pressed: s"
			#echo $_V
			f_slideVdw
			
		fi

		if [ "$input" = "b" ]; then
    			echo "key pressed: b"
		fi

		if [ "$input" = "S" ]; then
			# Exit the while loop
			break
		fi

		# Next it needs to recognize:
		# -Arrow Keys
		# -Enter

		f_menu1
	done
}

function f_entryA1 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 1 ]; then tput rev; fi

	tput cup 2 4
	echo "Entry 1"

	# Reset text format (if any)
	tput sgr0
}

function f_entryA2 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 2 ]; then tput rev; fi

	tput cup 3 4
	echo "Entry 2"

	# Reset text format (if any)
	tput sgr0
}

function f_reset_PS1 {
	# Add bottom horizontal line again
	tput cup 25 0; f_horizline
	# Just change position
	tput cup 23 0
}

function f_footer {

	tput rev

	tput cup 23 11
	echo Stop: S

	tput cup 23 25
	echo Detect OS: D

	tput cup 23 35
	echo Detect OS: D

	f_arrows

	tput sgr0
}

function f_menu1 {
	f_entryA1
	f_entryA2
	#f_entryA3
}

#function f_menu2 {
#	#f_entryB1
#	#f_entryB2
#	#f_entryB3
#}

function f_mainmenu {
	tput clear
	tput home; f_horizline; 
	tput cup 25 0; f_horizline
	
	tput cup 0 3
	echo " Menu DRYa "

	f_footer
	#f_menu1
	#f_menu2

	#f_readKeystroke
	f_reset_PS1
}

function f_arrows {
	tput cup 22 2
	echo "< ^ v >"
	tput cup 23 2
	echo "a w s d"
}

function f_detect_dir_or_file {
	# To check if a directory exists side by side with DRYa repo:

	f_get_script_current_abs_path
	cd $_SCRIPT_DIR
	echo pwd: $(pwd)

	echo "What are you looking for?"
	echo "(1) jarve repo?"
	echo "(2) upK repo?"
	echo -e "(3) .vimrc file?\n"

	read _ans

	function f_detect_dir {
		if [ -d $_DIR_NAME ]; then
			echo $_DIR_NAME exists
			# Control will enter here if $DIRECTORY exists.
		else
			echo not found
		fi
	}

	function f_detect_file {
		if [ -f $_FILE_NAME ]; then
			echo $_FILE_NAME exists
			# Control will enter here if $DIRECTORY exists.
		else
			echo not found
		fi
	}

	if [ $_ans -eq 1 ]; then
		_DIR_NAME=../jarve
		f_detect_dir 
	elif [ $_ans -eq 2 ]; then
		_DIR_NAME=../upK
		f_detect_dir 
	elif [ $_ans -eq 3 ]; then
		_FILE_NAME=../jarve/jrv/etc/.vimrc
		f_detect_file

		echo -e "\ndo you want that file to replace the current ~/.vimrc? (y/n)\n"
		read _ans

		if [ $_ans == "y" ]; then
			cp $_FILE_NAME ~
			echo ".vimrc copied to ~"
		elif [ $_ans == "n" ]; then
			echo it was not copied
		else
			echo your input did nothing
		fi
	else
		"Please enter one of the options below"
	fi

}
	
function f_get_script_current_abs_path {

	# no matter from where we will execute this script, $SCRIPT_DIR will indicate the correct directory where this script is located
	_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
	echo This script is located as:
	echo $_SCRIPT_DIR;
	
	function f_test1 {
		# This does not work, it is subjective to change. it depends from where you ryn the script
		_drya_pwd=$(pwd)
		echo $_drya_pwd
	}
}


function f_exec {
	#f_detectOS
	#f_mainmenu
	#f_readKeystroke
	#f_wiki
	#f_menu1
		#f_install_vimrc
	#f_get_script_current_abs_path
	f_detect_dir_or_file
}
f_exec
