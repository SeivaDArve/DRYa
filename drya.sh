#!/bin/bash

clear

function f_default_vars {
	# Max Cols: 56; Max lines: 28 (to aprox match smartphone screen)
	
	# Decide 2 sliders, one Horizontal and one Vertical
	_V=0; _H=0
		
	# Decide a variable to control the page number of current menu being displayed
	_m=0
}

function f_cursorON {
	# Show cursor normally. Use "tput civis" to hide
	tput cnorm
}

function f_cursorOFF {
	# Hide cursor to prevent flickering of the screen. Use "tput cnorm" to show again
	tput civis
}

function f_ascii_icon {

	function f_center_to_screen_verbose {
		# To messure the screen width:
		_cols=$(tput cols)
		echo Total cols: $_cols

		# To messure hslf the width of the screen:
		_cols=$((_cols/2))
		echo Half the sreen is: $_cols

		# The ascii logo is 32 characters long (half is 16)
		echo "The ascii logo is 32 characters long (half is 16)"

		# Center to screen
		echo To center the logo horizontally to the screen we subtract half of the logo cols to half of the screen widht. And that is where we center our cursor


		_cols=$((_cols-16))
		echo -e "\nRemaining cols: $_cols"
		echo $_cols Is where we put our cursor


		echo Example of logo widht:
		echo "................................"

		echo -e "\nExample of logo centered:"
		tput cup 13 $_cols
		echo "................................"


		# Now the same for lines:
		#tput lines
		
	}
	#f_center_to_screen_verbose

	function f_spaces {
		# Manually writting 12 spaces before the ascii logo like defined at f_center_of_screen_verbose
		# Manually means: script not complete yet, it should detect the screen and act automated
		echo -n "          "
	}

	f_spaces; echo -e "     ||\`				"
	f_spaces; echo "     ||				"
	f_spaces; echo -e " .|''||  '||''| '||  ||\`  '''|.	"
	f_spaces; echo -e " ||  ||   ||     \`|..||  .|''||	"
	f_spaces; echo -e " \`|..||. .||.        ||  \`|..||.	"
	f_spaces; echo "                  ,  |'		"
	f_spaces; echo "                    ''		"

	sleep 1
	tput sc 
	echo -n "3"
	sleep 1
	tput rc
	echo -n "2"
	sleep 1
	tput rc
	echo -n	 "1"
	sleep 1
	clear
}

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


function f_setafA {
	# This function is to be used when something is ASKED
	tput setaf 4
}

function f_setafD {
	# This function is to be used when something is DECLAIRED
	tput setaf 3
}

function f_setafC {
	# This function is to be used when styles are to be CLEARED
	tput sgr0
}

function f_res_cursor {
	tput cup 25 4
}

function f_clear_space {
	# Repeat 24x
	for i in {1..2}; do echo "hi"; done
}

function f_horizline {
	_count=$(tput cols)
	for i in $(seq $_count); do
	   	echo -ne "-" 
	done
}

function f_verticline {
	_count=$(tput lines)
	for i in $(seq $_count); do
   	echo -ne "    |\n" 
	#sleep 0.5
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
	clear
	f_setafD; echo Detect OS
	f_setafC
	echo "whoami: 	$(whoami)"
	echo "OS type: 	${OSTYPE}"
	echo "uname:		$(uname)"
	echo "uname -a: 	$(uname -a)"
	read

	f_menu1
}

function f_readKeystroke {
	while true
		do

		# If you run f_exec for the first time, this if statment will break the while loop allowing f_mainmenu to run for the first time without asking for any keystroke or changes
		if [ ${_H} = 0 ] && [ ${_V} = 0 ]; then
			#echo "no keystroke is asked"
			_H=1;_V=1
			f_menu1
		fi
			
		read -rsn1 input
		if [ "$input" = "s" ]; then
    			echo "key pressed: s"
			sleep 1
			#echo $_V
			f_slideVdw
			
		fi

		if [ "$input" = "b" ]; then echo "key pressed: b"; fi
		if [ "$input" = "S" ]; then echo ""; tput cnorm; exit; fi
		if [ "$input" = "D" ]; then f_detectOS; fi

		# Next it needs to recognize:
		# -Arrow Keys
		# -Enter
		
	done
		f_menu1
}

function f_entryA1 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 1 ]; then tput rev; fi

	tput cup 2 7
	echo "Entry 1"

	# Reset text format (if any)
	tput sgr0

	# Reset Cursor position
	f_res_cursor
}

function f_entryA2 {
	# Reverse colors for this entry if it matches cursor
	if [ ${_V} = 2 ]; then tput rev; fi

	tput cup 3 4
	echo "Entry 2"

	# Reset text format (if any)
	tput sgr0

	# Reset Cursor position
	f_res_cursor
}

function f_reset_PS1 {
	# Add bottom horizontal line again
	tput cup 25 0; f_horizline
	# Just change position
	tput cup 23 0
}

function f_footer {

	tput rev

	# Arrows
	tput cup 23 6
	echo " <   ^   v   > "
	tput cup 24 6
	echo "(a) (w) (s) (d)"

	# Stop
	tput cup 24 22
	echo "(S)top"

	# Decect Device
	tput cup 24 29
	echo "(D)etect Device"

	# Reset cursor to bottom
	tput cup 25 4

	tput sgr0
}

function f_menu1 {

	# Change the menu variable for internal comunication
	_m=1

	tput cup 2 1
	echo "M1"
	echo " --"
	echo " --"
	echo " --"
	echo " --"
	echo " --"
	f_res_cursor
	f_entryA1
	#f_entryA2
	#f_entryA3
}

#function f_menu2 {
#	#f_entryB1
#	#f_entryB2
#	#f_entryB3
#}

function f_mainmenu {
	# Create a style for the menu:
	tput clear
	f_verticline
	tput home; f_horizline; 
	tput cup 25 0; f_horizline
	tput cup 0 3
	echo " Menu DRYa "

	f_footer
	if [ $_m == 1 ]; then f_menu1; fi
	#if [ $_m = 2 ]; then f_menu2; fi
	#if [ $_m = 3 ]; then f_menu3; fi
	#if [ $_m = 4 ]; then f_menu4; fi
	#if [ $_m = 5 ]; then f_menu5; fi
	#if [ $_m = 6 ]; then f_menu6; fi
	#if [ $_m = 7 ]; then f_menu7; fi
	#if [ $_m = 8 ]; then f_menu8; fi
	#if [ $_m = 9 ]; then f_menu9; fi
	#if [ $_m = 0 ]; then f_menu0; fi

	f_readKeystroke
	f_reset_PS1
}


function f_detect_dir_or_file {
	# To check if a directory exists side by side with DRYa repo:

	f_get_script_current_abs_path

	cd $_SCRIPT_DIR
	f_setafD; echo Current pwd:
	f_setafC
		  echo -e "$(pwd)\n"

	f_setafA; echo "What are you looking for?"
	f_setafC
		  echo "(1) jarve repo?"
		  echo "(2) upK repo?"
		  echo "(3) .vimrc file?"
		  echo "(4) gitMenu"
		  echo ""

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

	#if [ $_ans = * ]; then
	#	echo "you just hit enter, right?"
	if [ $_ans = "1" ]; then
		_DIR_NAME=../jarve
		f_detect_dir 
	elif [ $_ans = "2" ]; then
		_DIR_NAME=../upK
		f_detect_dir 
	elif [ $_ans = "3" ]; then
		_FILE_NAME=../jarve/jrv/etc/.vimrc
		f_detect_file

		f_setafA; echo -ne "\nDo you want that .vimrc file to replace the current ~/.vimrc? (y/n) "
		f_setafC

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
		echo "Please enter one of the options below"
		read
		clear
		f_detect_dir_or_file
	fi

}
	
function f_get_script_current_abs_path {

	# no matter from where we will execute this script, $SCRIPT_DIR will indicate the correct directory where this script is located
	_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
	f_setafD; echo "This script is located at:"; 
	f_setafC
	echo $_SCRIPT_DIR;
	
	function f_test1 {
		# This does not work, it is subjective to change. it depends from where you ryn the script
		_drya_pwd=$(pwd)
		echo $_drya_pwd
	}
}


function f_exec {
	f_default_vars

	f_cursorON
	#f_cursorOFF

	#f_ascii_icon
	#f_mainmenu
	#f_readKeystroke
	#f_wiki
	#f_menu1
	#f_install_vimrc
	#f_get_script_current_abs_path
	source ../jarve/jrv/etc/usr-etc/termux-Dv/.jrvrc
	#f_detect_dir_or_file
}
f_exec
