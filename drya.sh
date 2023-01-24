#!/bin/bash 

function f_greet {
   figlet DRYa || echo "DRYa: Hi there;)"
}

function f_master_dryaRC {
	clear
	f_setafD; echo "Menu to master .dryarc file"
	f_setafC


	function f_findPlace {
		# Check if parent dir "~/.config/seivaDArve" exists

		_DIR_NAME=~/.config/seivaDArve/
		f_detect_dir
		echo ak
		read
	}

		  echo ""
		  echo "Are you looking for .dryarc?"
		  echo ""
		  echo "edit: Original (at repo)"
		  echo "edit: Temporary (at use at: ~)"
	read
	f_findPlace
}

function f_trap {
	# Set a trap to restore terminal on Ctrl-c (exit).
    	# Reset character attributes, make cursor visible, and restore
    	# previous screen contents (if possible).

    	trap 'tput sgr0; tput cnorm; tput rmcup || clear; exit 0' SIGINT

	# Tutorial:
	https://www.linuxjournal.com/content/bash-trap-command
}

function f_default_vars {
	

	# When at "1" it allows info to be printed at the footer. In the future you can toggle this info On/Off by pressing "i"
	_i=1

	function f_troubleshootingPWD {

		# Calling a function that defines the variable _SCRIPT_DIR:
		f_get_script_current_abs_path
			f_nn
			f_setafA; echo -n _SCRIPT_DIR
			f_setafC; echo -n ": "
			f_setafD; echo $_SCRIPT_DIR
			f_setafC;
			f_nn

		# Informing about our location
		echo "but we are running it from:"
			f_setafA; echo -n "pwd"
			f_setafC; echo -n ": "
			f_setafD; echo $(pwd)
			f_nn;
			f_setafA; echo -n "saving current "
			f_setafD; echo -n "pwd "; 
			f_setafA; echo -n "into "
			f_setafD; echo -n "_BEFORE_CALLING_SCRIPT"; 
			f_setafC;
			f_nn;

			_BEFORE_CALLING_SCRIPT=$(pwd)

			echo "_BEFORE_CALLING_SCRIPT: $_BEFORE_CALLING_SCRIPT"
			f_nn;
		
		# Traveling to dir of main script in order to make use of relative file positions (this script is not compiled and this prevents "missing files" or "commands")
		echo "Now, cd into _SCRIPT_DIR"
		cd $_SCRIPT_DIR
			f_setafA; echo -n "pwd"
			f_setafC; echo -n ": "
			f_setafD; echo $(pwd)
			f_setafC
			f_nn;

		echo yo!; f_nn

		# If this troubleshooting works, you should be able to cat the following file from any directory:
		cat ./wiki/testFile
			sleep 2; clear
	}
	f_troubleshootingPWD

	function f_positionSelector {
		_v=0; # Selector of vertical position (for the cursor)
		_h=0; # Selector of horizontal  position (for the cursor)
		_m=0; # Selector of menu position (for the cursor)

		function v_positionSelector {
			#_xy=(concatonate _v _h _m)
			echo "_v $_v"
			echo "_h $_h"
			echo "_m $_m"
		}
		# "v_ functions" stands for "verbose_ function"
		#v_positionSelector
	}
	f_positionSelector
}

function f_nn {
	# This function only prints a new line
	echo ""
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
		echo -n "           "
	}

	tput setaf 28
	tput bold
		  echo ""; #-------------------------------------
	f_spaces; echo -e "     ||\`				"
	f_spaces; echo "     ||				"
	f_spaces; echo -e " .|''||  '||''| '||  ||\`  '''|.	"
	f_spaces; echo -e " ||  ||   ||     \`|..||  .|''||	"
	f_spaces; echo -e " \`|..||. .||.        ||  \`|..||.	"
	f_spaces; echo "                  ,  |'		"
	f_spaces; echo "                    ''		"
		  echo ""; #-------------------------------------
	tput sgr0

	function f_countDown {
	# To do: add a while loop to this. To prevent manuall inputs "3... 2... 1... bla bla bla rubish"
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
	#f_countDown
	sleep 2
}


function f_tableOfContents {
	tput rev
	echo Table of contents
	tput sgr0
	f_setafA
	echo ""
	echo "Menu D (drya)"
	echo "Menu J (jarve)"
	echo "Menu G (easyGit)"
	echo "Menu Y (yogaBashApp)"
	f_setafC
}

function f_tput_tutorial {
	cat << heredoc
(1)String output parameter settings
　　bel       Alarm bell
　　blink     Flashing mode
　　bold      bold
　　civis     hide cursor
　　clear     Clear screen
　　cnorm     Do not hide cursor
　　cup       Move cursor to screen position( x，y)
　　el        Clear to end of line
　　ell       Clear to beginning of line
　　smso      Start highlight mode
　　rmso      Stop highlight mode
　　smul      Start underline mode
　　rmul      End underline mode
　　sc        Save current cursor position
　　rc        Restore cursor to last saved position
　　sgr0      Normal screen
　　rev       Reverse view
(2)Digital output parameter setting
　　cols      Number of columns
　　ittab     Set width
　　lines     Number of screen lines
(3)Boolean output parameter setting
　　chts      The cursor is not visible
　　hs        With status line
(4)scenery
   setaf ColorNumber## set foreground color
   setab ColorNumber ##Set background color
heredoc
}

function f_slideVup {
	((_V=_V+1))
	#echo $_V
}
		
function f_slideHup {
	((_h=_h+1))
	#echo $_h
}

function f_slideVdw {
	((_V=_V-1))
	#echo $_V
}
		
function f_slideHdw {
	((_h=_h-1))
	#echo $_h
}

function f_setafA {
	# This function is to be used when something is ASKED
	tput setaf 4
}

function f_setafD {
	# This function is to be used when something is DECLAIRED
	tput setaf 3
}

function f_setafD2 {
	# This function is to be used when something is DECLAIRED
	tput setaf 2
}

function f_setafS {
	# This function is to be used when something is SEARCHED
	tput setaf 5
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

function f_fillscreenE {
	# It fills the screen with "e" characters
	function f_fillcols {
		_count=$(tput cols)
		for i in $(seq $_count); do
		   	echo -ne "e" 
		done
	}
	_count=$(tput lines)
	for i in $(seq $_count); do
		f_fillcols
	done

	tput cup 2 2
	sleep 2
	tput el
	tput cup 5 5
	tput eel
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
   	echo -ne "   |\n" 
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
	function f_method1 {
		while true
			do
	
			# If you run f_exec for the first time, this if statment will break the while loop allowing f_mainmenu to run for the first time without asking for any keystroke or changes
			if [ ${_h} = 0 ] && [ ${_V} = 0 ]; then
				#echo "no keystroke is asked"
				_h=1;_V=1
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
			f_mainmenu
	}

	function f_method2 {
		while read -rsn1 input
		do
    			case "$input"
				in
				$'\x1B') # ESC ASCII code (https://dirask.com/posts/ASCII-Table-pJ3Y0j)
					read -rsn1 -t 0.1 input
					if [ "$input" = "[" ]
					then
						read -rsn1 -t 0.1 input
						case "$input"
						in
							A) echo '^' ;;
							B) echo 'v' ;;
							C) echo '>' ;;
							D) echo '<' ;;
						esac
					fi
					read -rsn5 -t 0.1   # flushing stdin
					;;
				a) echo "Letra A" ;;
				q) # q letter
					break
					;;
				*) # other letters
					echo "$input"
				;;
    			esac
		done
	}
	f_method2

	f_keyOutputX
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

function f_keyOutputX {
	# Add bottom horizontal line again
	#tput cup 25 0; f_horizline
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
	function f_mStyle {
		# Create a style/frame for the menu:
		clear

		_xPlace=3
		_hLinePlace=28
		_mPlace=1

		f_verticline
		tput home;     f_horizline; 
		tput cup $_hLinePlace 0; f_horizline

		tput cup 0 $_xPlace; echo X
		tput cup $_hLinePlace $_xPlace; echo X

		tput cup 0 9;  echo " Menu DRYa "

		tput cup 2 $_mPlace; echo "M"
		tput cup 3 $_mPlace; echo "e"
		tput cup 4 $_mPlace; echo "n"
		tput cup 5 $_mPlace; echo "u"
		tput cup 6 $_mPlace; echo ":"
		tput cup 7 $_mPlace; echo ""
		tput cup 8 $_mPlace; echo "$_m"
		
	}
	f_mStyle

	# If "i" is pressed, toggle print info at the footer:
	if [ $_i == "1" ]; then f_footer; fi

	# When done printing the frame of the menu, read these:
#	if [ $_m == 1 ]; then f_menu1; fi
	#if [ $_m = 2 ]; then f_menu2; fi
	#if [ $_m = 3 ]; then f_menu3; fi
	#if [ $_m = 4 ]; then f_menu4; fi
	#if [ $_m = 5 ]; then f_menu5; fi
	#if [ $_m = 6 ]; then f_menu6; fi
	#if [ $_m = 7 ]; then f_menu7; fi
	#if [ $_m = 8 ]; then f_menu8; fi
	#if [ $_m = 9 ]; then f_menu9; fi
	#if [ $_m = 0 ]; then f_menu0; fi

	f_keyOutputX
}

function f_detect_dir {
	if [ -d "$_DIR_NAME" ]; then
		# Define a variable to hold a certain state
		_d=exists

		f_setafS; echo $_DIR_NAME
		f_setafD; echo exists
		f_setafC
	else
		# Define a variable to hold a certain state
		_d=missing

		f_setafS; echo $_DIR_NAME
		f_setafD; echo not found
		f_setafC
	fi
}

function f_detect_file {
	if [ -f "$_FILE_NAME" ]; then
		# Define a variable to hold a certain state
		_f=exists

		f_setafS; echo $_FILE_NAME
		f_setafD; echo exists
		f_setafC
	else
		# Define a variable to hold a certain state
		_f=missing

		f_setafS; echo $_FILE_NAME
		f_setafD; echo not found
		f_setafC
	fi
}

function f_detect_these {
	# To check if a directory exists side by side with DRYa repo:

	f_get_script_current_abs_path

	cd $_SCRIPT_DIR
	f_setafD; echo Current pwd:
	f_setafC
		  echo -e "$(pwd)\n"

	f_setafA; echo "What are you looking for?"
	f_setafC
		  echo "(0) .dryarc"
		  echo "(1) jarve repo?"
		  echo "(2) upK repo?"
		  echo "(3) .vimrc file?"
		  echo "(4) gitMenu"
		  echo ""

	read _ans

	#if [ $_ans = * ]; then
	#	echo "you just hit enter, right?"
	if [ $_ans = "0" ]; then f_master_dryaRC; fi
	if [ $_ans = "1" ]; then _DIR_NAME=../jarve; f_detect_dir; fi
	if [ $_ans = "2" ]; then _DIR_NAME=../upK; f_detect_dir 
	elif [ $_ans = "3" ]; then _FILE_NAME=../jarve/jrv/etc/.vimrc; f_detect_file
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
		f_detect_these
	fi

}
	
function f_get_script_current_abs_path {

	# no matter from where we will execute this script, $SCRIPT_DIR will indicate the correct directory where this script is located
	_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
	f_setafD; echo "This script is written/located at:"; 
	f_setafC
	echo $_SCRIPT_DIR;
	
	function f_test1 {
		# This does not work, it is subjective to change. it depends from where you ryn the script
		_drya_pwd=$(pwd)
		echo $_drya_pwd
	}
}

function f_exec {
	f_greet
	# Comment/Uncomment to turn Off/On therefore to bebug easily step by step:
	#f_install_configDir
   $f_default_vars

	#f_cursorON
	#f_cursorOFF
	#f_make_file_dryarc 
   #f_ascii_icon
	#f_tableOfContents
   #f_mainmenu
	#f_wiki
	#f_install_vimrc
	#f_get_script_current_abs_path
	#source ../jarve/jrv/etc/usr-etc/termux-Dv/.jrvrc
	#f_detect_these
	#f_fillscreenE
	#f_master_dryaRC
   #f_readKeystroke
   echo stupid
}








# Function drya
   # this file is alias "drya" inside "source-all-drya-files"
   # Use: The programming structure '$ case / esac' 
      # is best to be the last part of this file
      # in order to have an interactive '$ drya' in
      # the terminal
      # and if you give no arguments to '$ drya'
      # like '$ drya + do something' then '$ drya' will still
      # open the f_greet and f_quick_menu through f_exec

   case $1 in
#      +)
#         echo
#      ;;
#      --communicate)
#          # An end-to-end communication between any of my devices with drya installed. Like a messenger. Encripted
#      ;;
#      --menu)
#      ;;
#      -i)
#      ;;
#      -h | --help)
#         clear
#         f_greet
#         f_cor1; echo -n "drya: "; f_resetCor
#         echo -n "Para sair da pagina de instruções pressione: "
#         f_cor1; echo "Q"; f_resetCor
#         sleep 3
#         less ~/Repositories/moedaz/README.md
#      ;;
      clone)
         # Defore doing any cloning, change to the correct place for cloning
            # any repo under from Seiva's github clone to the correct place is automatically installed
            # Because DRYa already is configured for all those repositories even if they do not exist.
            v_pwd=$(pwd)  ## After cloning any repo, we will come back to this place
            cd $v_REPOS_CENTER

         case $2 in
            ezGIT) echo "cloning ezGIT"; git clone https://github.com/SeivaDArve/ezGIT.git;;
            moedaz) echo "cloning ezGIT"; git clone https://github.com/SeivaDArve/moedaz.git;;
            dWiki | wiki) echo "cloning dWiki"; git clone https://github.com/SeivaDArve/dWiki.git;;
            upk) echo "not ready";;
            try) echo -e "trying to clone: $3 \n"; git clone https://github.com/SeivaDArve/$3.git;;
            setup-internal-dir) echo "uDev";; #uDev: create a dir at internal storage named Repositories to then be moved to external storage by the file explorer. There are no write permissions for termux at SD Card, but can read bash from it... in the other hand, File explorers can Write/move stuff into SD Card
            ss) echo "cloning 112-Shiva-Sutras"; git clone https://github.com/SeivaDArve/112-Shiva-Sutras.git;;
            -p | --public-list) 
               # This function scrapes the webpage of Seiva D'arve repositories on GitHub and lists all that is found

               echo "List of public repositories from Seiva D'Arve from GitHub.com:"
                  curl -s https://github.com/SeivaDArve?tab=repositories \
                  | grep "codeRepository" \
                  | sed 's,        <a href="/SeivaDArve/,,g' \
                  | sed 's," itemprop="name codeRepository" >,,g'
            ;;
            -P | --private-list) 
               echo "# uDev: listing of all repositories including private ones is not ready yet"
               : '
                 Multi comment example
                 :D
               '

               : '
               # Example on: How to curl a list of private repositories at github if they are invisible and you need to login:
                 curl \
                     -u "username:password" \
                     -X GET \
                     https://mygithuburl.com/user/repos?visibility=private
               '
            ;;
            *) 
               echo "DRYa: Must specify a repository to clone"
               echo
               echo " You can use: '$ drya clone --list-public' or '$ drya clone -p' to list all public repositories"
               echo " You can use: '$ drya clone --list-private' or '$ drya clone -P' to list all private repositories"
               echo
               echo " Press ENTER to visit a page will all repositories:"
               echo " > https://github.com/SeivaDArve?tab=repositories"
               read
               echo
               echo "# uDev: No browser is ready to open, and no function is set to scrape"
         esac
         
         # At the end of cloning, returning to the previous directory and discarding the variable
            cd $v_pwd  
            unset v_pwd
      ;;
      *) 
         f_exec
      ;;

   esac

