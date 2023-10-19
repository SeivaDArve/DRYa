#!/bin/bash 
# Title: DRYa
# Description: Don't Repeat Yourself (app)
# Use: You may use this app in many way. One of those is a package manager for a few specific repositories (until you change it)

# This script was intended to be called at the terminal by the alias 'drya'. 
   # If the package manager that installs this script does not set this alias, lets set this alias here (from within)
   alias drya="${v_REPOS_CENTER}/DRYa/drya.sh"


function f_greet {
   # If 'figlet' app is installed, print an ascii version of the text "DRYa" to improve the appearence of the app
      clear
      figlet DRYa || echo -e "( DRYa ):\vrunning drya.sh\n"
}

function f_greet2 {
   # Prints a more verbose output of the ascii text "DRYa"
      ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
}

# Functions for text colors
   # Copied from ezGIT
   function f_cor1 {	
      # For figlet titles
      tput setaf 5 
   }
   function f_cor2 { 
      tput setaf 2 
   }
   function f_cor3 { 
      # Mentioning user input or valiable input
      tput setaf 3
   }
   function f_cor4 { 
      # Similar to Bold
      tput setaf 4
   }
   function f_resetCor { 
      tput sgr0
   }
      
function f_talk {
   # Copied from: ezGIT
   echo
   f_cor4; echo -n "DRYa: "
   f_resetCor
}

function f_git_status {
   # Copied from: ezGIT
   echo
   f_cor4; echo -n "DRYa/ezGIT: "
   f_resetCor; echo "git status"
   git status
}

function f_git_pull {
   # Copied from: ezGIT
   echo
   f_cor4; echo -n "DRYa/ezGIT: "
   f_resetCor; echo "git pull"
   git pull
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
	echo "Menu D (Drya)"
	echo "Menu J (jarve)"
	echo "Menu G (ezGIT)"
	echo "Menu Y (yogaBashApp)"
	f_setafC
}

function f_tput_tutorial {
   # uDev: Send this to Dwiki or wikiD
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

cat << heredoc
info:
To undo "tput rev" use "tput sgr0"

info:
"read -rsn1 input": Expect only one letter (and don't wait for submitting) and be silent (don't write that letter back).
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
function f_drya_plus {
   clear
   echo "uDev: will cat a file under ~/.config/h.h/drya/"
}

function f_clone_info {
   # Info given:
   # > Tell how to clone DRYa
   # > List Repositories (public and private)
   # > Automatically redirects Termux to github.com
      echo "DRYa: Must specify a repository to clone"
      echo
      echo " You can use:"
      echo " > '$ drya clone --list-public' or "
      echo " > '$ drya clone -p' "
      echo "    to list all public repositories"
      echo 
      echo " You can use: "
      echo " > '$ drya clone --list-private' or"
      echo " > '$ drya clone -P'"
      echo "   to list all private repositories"
      echo
      echo "To clone DRYa:  "
      echo " > git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa"
      echo
      echo " Press ENTER to visit a webpage with all repositories:"
      echo " > https://github.com/SeivaDArve?tab=repositories"
      echo
      echo " Press Ctrl-C to abort"
      read -s
      echo
      f_horizline
      echo " Note: So far, drya can open this link only with Termux"
      echo " > uDev: No other browser found"
      echo
      echo "Opening URL with Termux (terminal)"
      termux-open-url https://github.com/SeivaDArve?tab=repositories
}

function f_clone_repos {
   # Saving current location (To come back to this directory after cloning)
      v_pwd=$(pwd)  ## After cloning any repo, we will come back to this place

   # Before doing any cloning, change to the correct place for cloning
      cd $v_REPOS_CENTER

   case $2 in
      ezGIT) echo "cloning ezGIT"; git clone https://github.com/SeivaDArve/ezGIT.git
             #uDev: Install its dependencies too
      ;;
      moedaz) echo "cloning moedaz"; git clone https://github.com/SeivaDArve/moedaz.git;;
      yoga) echo "cloning yogaBashApp"; git clone https://github.com/SeivaDArve/yogaBashApp.git;;
      dWiki | wiki | DWiki | Dwiki) echo "cloning dWiki"; git clone https://github.com/SeivaDArve/dWiki.git;;
      log) echo "cloning omni-log"; git clone https://github.com/SeivaDArve/omni-log.git;;
      upk) echo "cloning upK"; git clone https://github.com/SeivaDArve/upK.git;;
      upk-dv | upkd) 
         echo "cloning upK-diario-Dv"; 
         echo "Link for download is:"; 
         echo " > https://github.com/SeivaDArve/upK-diario-Dv.git"; 
         echo " > uDev: Include stroken"
         echo 
         git clone https://github.com/SeivaDArve/upK-diario-Dv.git
      ;;
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
   esac

   # At the end of cloning, returning to the previous directory and discarding the variable
      cd $v_pwd  
      unset v_pwd
}

function f_exec {
	f_greet
	# Comment/Uncomment to turn Off/On therefore to bebug easily step by step:
	#f_install_configDir
   #f_default_vars

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

   ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
   echo "DRYa: I'm Installed and Ready"
   echo " > for help: drya -h"

   bash f_traits_id
}







# ---------------------------------------
# -- Functions above -- Arguments Below
# ---------------------------------------





# Function drya
   # this file is alias "drya" inside "source-all-drya-files"
   # Use: The programming structure '$ case / esac' 
      # is best to be the last part of this file
      # in order to have an interactive '$ drya' in
      # the terminal
      # and if you give no arguments to '$ drya'
      # like '$ drya + do something' then '$ drya' will still
      # open the f_greet and f_quick_menu through f_exec

if [ -z "$*" ]; then
  # Do something else if there are no arguments
     clear
     f_greet
     f_talk; echo "No arguments were given"

elif [ $1 == "?" ] || [ $1 == "-h" ] || [ $1 == "--help" ] || [ $1 == "-?" ]; then
   # Help menu
   
   clear; f_greet

   f_talk; echo "Help options will have:"
           echo -e " > man page \n > Terminal printed instructions \n > README file \n > (uDev)"

   echo
   echo "DRYa is a CLI software that... by the author David Rodrigues... that syncs... "

elif [ $1 == "l" ]; then 
   # Save GPS locations
   # uDev: this function needs to go to the repo: master-GPS

   if [ $2 == "location-network" ]; then 
      # Displays current GPS location using network as provider
      termux-location -p network

   elif [ $2 == "location-gps" ]; then 
      # Displays current GPS location using GPS as provider
      termux-location -p GPS

   elif [ $2 == "save-location-network" ]; then 
      # Displays current GPS location using network as provider and saves it
      # Directory for saved text
      # ${REPOS_CENTER}/DRYa/all/var/report-termux-locations.txt
      termux-location -p network
   fi


elif [ $1 == "+" ]; then 
   # Function found at: source-all-drya-files which is the first file on DRYa repository to run
   # This function is used to uncluter the welcome screen of a terminal when DRYa is installed (because DRYa outputs a lot of text)
   
   if [ -z "$2" ]; then
      echo "uDev"
      f_drya_plus

   elif [ $2 == "msgs" ]; then 
      # Option to read the $DRYa_MESSAGES file
         # They are stored at: ~/.config/h.h/drya/.dryaMessages
         less ~/.config/h.h/drya/.dryaMessages
   fi

elif [ $1 == "update" ]; then 
    echo "uDev: Similar to: DD; G v; source ~/.bashrc; apply all dot-files across the system"

    f_greet
    f_cor4; echo -n "DRYa: "
    f_resetCor; echo "Downloading updates and applying them"
         cd ${v_REPOS_CENTER}/DRYa
    f_git_status
    f_git_pull
    echo

    # Aplly each dot-file in their correct places across the system
    f_cor4; echo -n "DRYa: "
    f_resetCor; echo "applying dot-files:"
    echo " > .vimrc" && cp ${v_REPOS_CENTER}/DRYa/all/dot-files/vim/.vimrc ~
    echo " > termux: colors + properties (uDev)"
    echo " > .gitconfig" && cp ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/.gitconfig ~
    echo " > init.el (uDev)"
    echo

    # Reload .bashrc
    f_cor4; echo -n "DRYa: "
    f_resetCor; echo "reloading functions, variables, alias at:"
    echo " > ~/.bashrc"
          source ~/.bashrc 1>/dev/null && echo " > Done!" && echo


elif [ $1 == "clone" ]; then 
   # Gets repositories from Github.com and tells how to clone DRYa itself
   # Any repo from Seiva's github.com is cloned to the default directory ~/Repositories

   # uDev: Some repositories have files to be sourcer (like: source-all-moedaz-files) so, after cloning, DRYa must reload everything sourcing ~/.bashrc

   clear
   f_greet

   if [ -z "$2" ]; then
      # If nothing was specified to clone
         f_clone_info
   else
      # If an argument was given, clone will be attemoted
         f_clone_repos
   fi

elif [ $1 == "config" ]; then 
   # uDev: at source-all-drya-files one function called traitsID will have these options
      uname -a | grep "Microsoft" 1>/dev/null
      if [ $? == 0 ]; then echo "This is microsoft"; fi
      uname -a | grep "Android" 1>/dev/null
      if [ $? == 0 ]; then echo "This is Android"; fi
      
      v_hostname=$(hostname); echo "Hostname is: $v_hostname"
      v_whoami=$(whoami); echo "whoami is: $v_whoami"
      echo
      echo "uDev: This info must be environment variables for other apps"

elif [ $1 == "backup" ]; then 
   # uDev: at DRYa/all/bin/.../3-steps-formater a script will be available to make such backups and prepare format
      echo "drya: uDev: in the future you may call this function to send files from one device to another device using the web"
      echo 
      echo "DRYa backup options:"
      echo " - Smartphone >> Raspberry Pi (cloud) >> External HDD"

elif [ $1 == "seiva-up-time" ]; then 
         # uDev: Tells how long the Linux experience started for Seiva
         echo "DRYa: Seiva D'Arve started intense linux learning at: March 25th, 2021"


elif [ $1 == "install" ]; then 
         # Install DRYa and more stuff

         if [[ -z $2 ]]; then 
            # If there are no args:
            echo "drya: Please specify what to install"
            echo
            echo "If you want to install drya itself, 3 ways:"
            echo "  1. Download and run: github.com/drya/ghost-in.sh"
            echo "  2. Git Clone and Run: github.com/DRYa; bash Drya/install.uninstall/install.sh"
            echo "  3. Git Clone and Run: github.com/DRYa; bash drya.sh install --me"

         else
            # Install extra stuff
            case $2 in
               doom-emacs)
                  echo "Installing doom emacs for linux "
                  read -p " > Do you want to continue?"

                  # Dependencies
                     sudo apt install git emacs ripgrep fd find
                  
                  # Now, doom itself
                     git clone --depth 1 http://github.com/hlissner/doom-emacs ~/.emacs.d
                  
                  # Installing doom
                     cd ~
                     bash .emacs.d/bin/doom install
                  
                  # Utilities found in bin/doom
                     #bash .emacs.d/bin/doom sync
                     #bash .emacs.d/bin/doom upgrade
                     #bash .emacs.d/bin/doom doctor
                     #bash .emacs.d/bin/doom purge
                     #bash .emacs.d/bin/doom help
                     
                  # Instead of giving the full path to the command, we can add the dir to ou PATH variable
                     export PATH="$HOME/.emacs.d/bin:$PATH"

                  # The standard emacs dir is ~/.emacs.d
                     # DistroTube (DT) says to never play in this directory
                     # Play in the directory ~/.doom.d instead
                     # An alternative, instead of using ~/.doom.d you can use ~/.config/.doom.d (you move the dir, you do not duplicate it)
                     
                     # Let's move our dir
                        mv ~/.doom.d ~/.config/.doom.d

                  # Now just launch
                     echo "Now run emacs like you normally would"
                     echo "Done!"
 
               ;;
               --me)
                  echo "uDev: Are you sure you want to install DRYa?"; 
                  # Install DRYa itself
                  # termux-setup-storage
                  # install '1st' here 
                  # pkg install termux-api
               ;;
               xrandr) 
                  echo "DRYa: By detecting the traitsID and detecting a raspberry pi, then we know we are using a Tv. And, if no args are given, such tV is brand "silver" therefore, this script applies the screen resolution of:"
                  echo " > 1360x768 "
               ;;  
               dot-files)
                  echo "DRYa: drya install dot-files"
                  echo " > copying from drya repo to default locations"
                  echo " > uDev"
                  echo 

		  # Verbose notes
                  echo "It can config:"
                  echo " > emacs (init file + libraries)"
                  echo " > git-github"
                  echo " > man page"
                  echo " > ezGIT automatic encryption"
                  echo " uDev"
                  echo

		  # For .netrc
           # uDev: if file exists, probably it is configured alread. So, ask the user if wants to copy it again or leave it
           
		  # For git
                  echo "attempting git"
                  echo " > Copying .../DRYa/all/dot-files/git-github/.gitconfig"
                  echo " to"
                  echo " > ~"
                  read -s -n 1
                  cp ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/.gitconfig ~
                  echo "Done!"
                  echo

		  # For vim
                  echo "attempting Vim"
                  echo " > Copying .../DRYa/all/dot-files/vim/.vimrc"
                  echo " to"
                  echo " > ~"
                  read -s -n 1
                  cp ${v_REPOS_CENTER}/DRYa/all/dot-files/vim/.vimrc ~
                  echo "Done!"
                  echo

		  # Colors and properties for Termux
                  echo "attempting termux colors"
                  echo " > Copying .../DRYa/all/dot-files/termux/colors.properties"
                  echo "   and     .../DRYa/all/dot-files/termux/termux.properties"
                  echo "   to      ~/.termux"
                  read -s -n 1
                  cp ${v_REPOS_CENTER}/DRYa/all/dot-files/termux/colors.properties ~/.termux/
                  cp ${v_REPOS_CENTER}/DRYa/all/dot-files/termux/termux.properties ~/.termux/
                  echo "Done! (Restart thr terminal is needed)"
               ;;
               netrc)
                  # Installing the file that allows the user to bypass entering user and password at every git push
                  # Automatic setup for file: .netrc
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
               ;;
               upk-at-work)
                  # Makes all dependencies for upk repo available
                  # This might be used most likely at in-job phone
                     cd ${v_REPOS_CENTER}

                  # Install emacs
                     pkg install emacs
                     # uDev: Test if it is windows and install GUI version also

                  # Install figlet
                     pkg install figlet

                  # Install vim
                     pkg install vim

                  # Repo: upk
                     echo "cloning:upK" && git clone https://github.com/SeivaDArve/upK.git

                  # Installing .netrc
                     bash ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/bin/create-netrc-from-stroken.sh
                     vim ~/.netrc
                     
                  # Repo: upk-diario-dv
                     echo "cloning: upk-diario-dv" && git clone https://github.com/SeivaDArve/upK-diario-Dv.git
            

                  # Refresh the terminal
                     #source ~/.bashrc

                  #    install: 
                  #             emacs for windows
                  #             instal init.el
                  echo "drya: udev: instal all dependencies for upk repo to run"
               ;;
               doom-emacs-windows)
                  echo "uDev: Tutorial here:"
                  echo " > https://dev.to/scarktt/installing-doom-emacs-on-windows-23ja"
               ;;
               *)
                  echo "drya: What do you want to install? invalid arg"
               ;;
            esac
         fi

elif [ $1 == "edit" ]; then 
         case $2 in
            stroken)
               # Editing stroken globally
               vim ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/current-stroken
                  echo "File edited at: ...DRYa/all/dot-files/git-github/current-stroken"
                  echo

               cp ${v_REPOS_CENTER}/DRYa/all/dot-files/git-github/current-stroken ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken
                  echo "Copied also too: ...DRYa/install.uninstall/stroken"
                  echo
               
                  # Adding info for the new user:
                     echo -e "\n(note \"info exists also at: .../DRYa/all/dot-files/git-git-hub/current-stroken\")" >> ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken

               # Verbose output
                  echo "You may install stroken as ~/.netrc file with the command:"
                  echo " > drya install stroken"
                  # uDev: to be sent to: drya.sh edit stroken
            ;;
            news)
               vim ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh
            ;;
            alias | config-bash-alias)
               ## PERMANENT CHANGES if "git push" is used
               vim ${v_REPOS_CENTER}/DRYa/all/etc/config-bash-alias
               
               # Other ways to open the same file: 
                  # Using menu F (from D.F) defined/programed at config-bash-alias (the same file we are opening)
                     # '$ F'

                  # Using the alias set on 'source-all-drya-files'
                     # '$ ,.' 
            ;;
            source | source-drya | source-all-drya-files) 
               vim ${v_REPOS_CENTER}/DRYa/all/source-all-drya-files

               # Other ways to open the same file: 
                  # Using menu F (from D.F) defined/programed at config-bash-alias (the same file we are opening)
                     # '$ F'

                  # Using the alias set on 'source-all-drya-files'
                     # '$ ,..' 
            ;;
            termux)
               # Will edit termux.properties file at ~/.termux/termux.properties
               echo uDev
            ;;
            *)
               echo "drya: What do you want to edit?"
               echo 
               echo "Notes:"
               echo " > you can call '$ M' for the Menu with favourite files for edition"
               echo " > Press [M] to open 'M Menu' with favourite files (uDev)"

            ;;

         esac



elif [ $1 == "remove" ]; then 
         case $2 in
            dot-files)
               echo "drya: drya dot-files remove"
               echo " > remove files from default locations and do not touch files inside drya repo"
            ;;
            upk)
               # Makes all dependencies for upk repo disapear
               # This might be used most likely at in-job phone
               #    remove:  upk repo
               #             upk-dv
               #             !emacs
               #             !emacs for windows
               #             !install init.el
               #             source bashrc file
               #             !figlet
               #             netrc
               echo "drya: udev: remove all dependencies for upk repo to run"
            ;;
            netrc)
               f_greet
               echo "drya: removing the dot file ~/.netrc"
               echo -e "\nAre you sure you want to remove ~/.netrc? \n > [ Ctrl-C ] to Cancel\n > [ Any key ] to accept"
               read -s -n 1
               echo
               rm ~/.netrc && echo "Done!"

            ;;
            *)
               echo "drya: What do you want to remove? (uDev)"
            ;;
         esac

elif [ $1 == "save" ]; then 
         case $2 in
            dot-files)
               echo "drya: drya dot-files save"
               echo " > copy from default locations to drya repo"
            ;;
            *)
               echo "drya: What do you want to save? (uDev)"
            ;;
         esac

elif [ $1 == "news" ]; then 
         # Runs a script inside DRYa directories that continuously rolls information
         bash ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh


elif [ $1 == "vlm" ]; then 
         # Works on termux only
            # Toggles the value volume-key from =virtual to =volume (inside termux. more info at: man termux)

         echo uDev

         #echo "volume keys on Termux toggled. Now they act as X instead of Y"
         # volume-keys=volume
         # volume-keys=virtual

elif [ $1 == "logo" ]; then 
         # Presenting DRYa
         ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead

elif [ $1 == "gui" ]; then 
         TERM=ansi \
            whiptail --title "Example Dialog" \
                     --infobox "This is an example of an info box" 8 78 \
                     --yesno "yea" 8 8
else 

         f_exec

fi


