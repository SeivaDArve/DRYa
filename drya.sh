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
   # Prints a more verbose output of the ascii text "DRYa" then f_greet
      ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
}

# Functions for text colors (used usually with `figlet`)
   function f_cor1 {	
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
      # Similar to Bold. Used in: f_talk
      tput setaf 4
   }
   function f_cor5 { 
      # Similar to Bold
      tput setaf 6
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

function f_done {
   # Copied from: ezGIT
   f_cor5; echo -n ": Done"
   f_resetCor
}

function f_stroken {
   # When automatic github.com authentication is not set, an alternative (as taxt based credential, but salted) is printed on the screen. This is usefull until the app remains as Beta.
   # While the app is in beta, this is usefull

   # If ~/.netrc exists, no need to print the rest
      if [ -f ~/.netrc ]; then
         #echo "netrc exists"
         echo "it exists" 1>/dev/null
      else
         f_talk; echo "stroken"
                 echo " > Inside the ezGIT app I found this: "
         f_cor4; echo -n "seivadarve";
         f_resetCor; echo " and this:";
         f_cor4; echo "ghp_JGIFXMcvvzfizn9OwAMdMdGMSPu9E30yVogPk"
         f_resetCor
         echo
      fi
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

		  echo 
		  echo "Are you looking for .dryarc?"
		  echo 
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
			f_setafD; echo -n "pwd " 
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

function f_calcular_tempo_decorrido_apos_data {
   # Data de aniversário no formato YYYY-MM-DD
      #STARTINGDATE="1992-04-01"  # Variavel que é preciso alimentar a este script

   # Converter a data de aniversário para um timestamp
      BIRTH_TIMESTAMP=$(date -d "$STARTINGDATE" +%s)

   # Obter o timestamp atual
      CURRENT_TIMESTAMP=$(date +%s)

   # Calcular a diferença em segundos
      DIFF_SECONDS=$(( CURRENT_TIMESTAMP - BIRTH_TIMESTAMP ))

   # Converter a diferença para dias, meses e anos
      DIFF_DAYS=$(( DIFF_SECONDS / 86400 ))

   # Calcular a diferença em anos e meses
      YEARS=$(( DIFF_DAYS / 365 ))
      MONTHS=$(( (DIFF_DAYS % 365) / 30 ))
      DAYS=$(( (DIFF_DAYS % 365) % 30 ))

   # Imprimir o resultado
      echo "Tempo passado desde $STARTINGDATE:"
      echo " > $YEARS anos, $MONTHS meses e $DAYS dias."
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
   echo "uDev: will cat a file under ~/.config/h.h/drya/drya-welcome"
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

function f_init_clone_repos {
   # Saving current location (To come back to this directory after cloning)
      v_pwd=$(pwd)  ## After cloning any repo, we will come back to this place

   # Before doing any cloning, change to the correct place for cloning
      cd $v_REPOS_CENTER

      f_stroken
}


function f_clone_repos {

   f_talk 

   case $v_arg2 in
      # uDev: Search for dependencies file if any
      # uDev: Print their webpage link
      
      ezGIT | ezgit | ez)           echo "cloning ezGIT"; git clone https://github.com/SeivaDArve/ezGIT.git
      ;;

      Tesoro | tesoro | T)          echo "cloning Tesoro"; git clone https://github.com/SeivaDArve/Tesoro.git
      ;;

      moedaz | mo)                  echo "cloning moedaz"; git clone https://github.com/SeivaDArve/moedaz.git
      ;;

      yoga | yg)                    echo "cloning yogaBashApp"; git clone https://github.com/SeivaDArve/yogaBashApp.git
      ;;

      dWiki | wiki | DWiki | Dwiki) echo "cloning dWiki"; git clone https://github.com/SeivaDArve/dWiki.git
      ;;

      omni-log | omni | log | om)   echo "cloning omni-log"; git clone https://github.com/SeivaDArve/omni-log.git
      ;;

      shiva-sutras | shiva | ss)    echo "cloning 112-Shiva-Sutras"; git clone https://github.com/SeivaDArve/112-Shiva-Sutras.git
      ;;

      upk)                          echo "cloning upK"; git clone https://github.com/SeivaDArve/upK.git
      ;;

      upk-dv | upkd)                echo "cloning upK-diario-Dv"; 
                                    echo "Link for download is:"; 
                                    echo " > https://github.com/SeivaDArve/upK-diario-Dv.git"; 
                                    git clone https://github.com/SeivaDArve/upK-diario-Dv.git
      ;;

      setup-internal-dir)           echo "uDev"  #uDev: create a dir at internal storage named Repositories to then be moved to external storage by the file explorer. There are no write permissions for termux at SD Card, but can read bash from it... in the other hand, File explorers can Write/move stuff into SD Card
      ;;

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
         f_talk; echo "Repository not recognized"
      ;;
   esac

   # At the end of cloning, returning to the previous directory and discarding the variable
      cd $v_pwd  
      unset v_pwd
}

function f_dotFiles_install_git {
   # For git
   
   clear

   echo "attempting git"
   echo " Copying "
   echo " > .../DRYa/all/etc/dot-files/git-github/.gitconfig"
   echo " to"
   echo -e" > \$HOME"
   read -s -n 1
   cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig ~
   echo "Done!"
   echo
}

function f_dotFiles_install_vim {
   # For vim

   clear 

   echo "attempting Vim"
   echo " > Copying .../DRYa/all/etc/dot-files/vim/.vimrc"
   echo " to"
   echo " > ~"
   read -s -n 1
   cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
   echo "Done!"
   echo
}

function f_dotFiles_install_termux_properties {
   # Colors and properties for Termux
      echo "attempting termux colors"
      echo " > Copying .../DRYa/all/etc/dot-files/termux/colors.properties"
      echo "   and     .../DRYa/all/etc/dot-files/termux/termux.properties"
      echo "   to      ~/.termux"
      read -s -n 1
      cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/colors.properties ~/.termux/
      cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/termux.properties ~/.termux/
      echo "Done! (Restart thr terminal is needed)"
}

function f_dotFiles_install_dryarc {
   echo "DRYa: source .dryarc if any exists (uDev)"
}


function f_dotFiles_install_netrc {
   # Installing .netrc
   
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
       v_username=$(cat ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken | head -n 1)
       v_token=$(cat ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken | tail -n 1)

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
}

function f_drya_help {
   # Main help function
  
   clear; f_greet

   f_talk; echo "Help"
   
   echo
   echo "What is DRYa:"
   echo " > DRYa is a CLI software that prevents repetitive tasks"
   echo " > D.R.Y.a. (Don't Repeat Yourself app)"
   echo " > author: David Rodrigues (Seiva D'Arve)"
   echo
   echo "uDev: press 'H' to Help menu with \`fzf\` for each option:"
   echo " 1. DRYa man page (uDev)"
   echo " 2. DRYa (Terminal printed instructions)"
   echo " 3. DRYa README.md file "
   echo " 4. DRYa cheat sheets and alias for terminal commands"
   echo " 5. DRYa cheat sheets for 'Temporized Menu' "
   echo " 6. traitsID: Print specs of current device"
   echo " 7. What is D.R.Y.a. "
}

function f_dot_files_list_available {
   # List dot-files available in DRYa repo

   f_greet
   f_talk; echo "drya dot-files list-ready"
   echo " > Files ready to copy from DRYa repo to their Default locations"

   # List all files in one array variable
      v_all_dot_files=(".bashrc" ".bash_logout" ".netrc" ".vimrc" "emacs:init.el" \ 
                       "emacs:lib" "emacs:lib:upk" "emacs:lib:omni-log" ".gitconfig" \
                       "xrandr" "keyboard:layout" "manpages" "termux:storage" \
                       "termux:repos" "termux:properties" \
                       "termux:colors" \
                       '~/ln/wsl' \           # Soft link for WSL2 C:\
                       '~/ln/Repositories' \  # Soft link for WSL2 C:\$USER\Repositories == /mnt/c/$USER/Repositories
                       ".dryarc" \
                       ".tmux.conf" "\$PS1" "browser:bookmarks")  

   # ECHO variable horizontally:
      #echo "Array is: ${v_all_dot_files[@]}"

   # ECHO variable veryically:
      echo -e "\nListing all dot files to handle:"
      for i in ${v_all_dot_files[@]}; do echo -n " > "; f_cor2; echo $i; f_resetCor; done

   # Verbose notes
      echo 
      echo "It can config:"
      echo " > emacs (init file + libraries)"
      echo " > git and github with .netrc"
      echo " > man pages"
      echo " > ezGIT automatic encryption"
      echo " > .vimrc"
      echo " > termux.properties"
      echo " > termux widgets"
      echo " uDev"
      echo
}

function f_dot_files_install {
   L8="8. termux.properties"
   L7="7. .bash_logout"
   L6="6. .gitconfig "
   L5="5. .vimrc "
   L4="4. .netrc "
   L3="3. .dryarc "

   L2="2. PRESETS"
   L1="1. TODOS "

   L0="SELECT (1 or +) dot-files to install: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "1" ]] && f_dotFiles_install_vim && f_dotFiles_install_git && f_dotFiles_install_termux_properties && f_dotFiles_install_dryarc && f_dotFiles_install_netrc
      [[ $v_list =~ "2" ]] && echo "Detected 2: PRESETS"
      [[ $v_list =~ "3" ]] && f_dotFiles_install_dryarc
      [[ $v_list =~ "4" ]] && f_dotFiles_install_netrc
      [[ $v_list =~ "5" ]] && f_dotFiles_install_vim
      [[ $v_list =~ "6" ]] && f_dotFiles_install_git 
      [[ $v_list =~ "7" ]] && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/bashrc/bash-logout/.bash_logout ~ && echo "DRYa: file .bash_logout copied to ~/.bash_logout"
      [[ $v_list =~ "8" ]] && f_dotFiles_install_termux_properties
   
      unset v_list
}

function f_dot_files_menu {
   # Main Menu for dot files
      L7="7. Factory Reset"  # uDev: At any installation, the original default file should be stored in dryarc. So now this fx is possible. remove DRYa files and give back the dot-file that the system was fresh formated with.
      L6="6. Backup"
      L5="5. Edit original (at Default DRYa repo) "
      L4="4. Edit Installed (files across the system) "
      L3="3. Remove "
      L2="2. Install" 
      L1="1. List available and describe (at DRYa repo) "

      L0="Menu: Manage dot-files: "

      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "1" ]] && f_dot_files_list_available
      [[ $v_list =~ "2" ]] && f_dot_files_install
      [[ $v_list =~ "3" ]] && echo "Detetado 3"
      [[ $v_list =~ "4" ]] && echo "Detetado 4"
      [[ $v_list =~ "5" ]] && echo "Detetado 5"
      [[ $v_list =~ "6" ]] && echo "Detetado 6"
      [[ $v_list =~ "7" ]] && echo "Detetado 6"
   
      unset v_list
}

function f_drya_fzf_MM_functionality_pakage {
   # Funcoes inbutidas na Repo DRYa 

   # Lista de opcoes para o menu `fzf`
      elem_0="DRYA: Functionality Pakage:" 

      elem_3="3. Help" 
      elem_2="2. Manage dot-files"
      elem_1="1. Exit" 

      v_list=$(echo -e "$elem_1 \n$elem_2 \n$elem_3" | fzf --cycle --prompt="$elem_0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "1" ]] && sleep 0.1
      [[ $v_list =~ "2" ]] && f_dot_files_menu
      [[ $v_list =~ "3" ]] && sleep 0.1
      unset v_list

}

function f_drya_fzf_MM {
   # FZF Main Menu (for DRYa)

   # Lista de opcoes para o menu `fzf`
      elem_0="DRYA: fzf main Menu:" 

      elem_3="3. Help and Info"
      elem_2="2. Functionality package" 
      elem_1="1. Exit menu" 

      v_list=$(echo -e "$elem_1 \n$elem_2 \n$elem_3" | fzf --cycle --prompt="$elem_0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "1" ]] && sleep 0.1  # este comando nao faz nada, dai ter so um temporizador
      [[ $v_list =~ "2" ]] && echo "DRYa: Functionality" && f_drya_fzf_MM_functionality_pakage
      [[ $v_list =~ "3" ]] && f_drya_help
      unset v_list
}



function f_exec {
   # When invalid args are given at the teminal: 
      #f_greet

   # It can be used for other function debugs also:
      # Comment/Uncomment to turn Off/On each to debug accordingly:

      #f_default_vars
      #f_cursorON
      #f_cursorOFF
      #f_make_file_dryarc 
      #f_ascii_icon
      #f_mainmenu
      #f_wiki
      #f_install_vimrc
      #f_get_script_current_abs_path
      #source ../jarve/jrv/etc/usr-etc/termux-Dv/.jrvrc
      #f_fillscreenE
      #f_master_dryaRC
      #f_readKeystroke

   ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app available \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
   f_talk; echo "No valid arguments were given"
           echo "       > for help: drya -h"

   # If no arg was given, also navigate do DRYa's repo directory
      # udev: in a script it is going there, but after the script finishes, the prompt comes back. (so, not working, it will not navigate in the end, needs to be fixed)
      cd ${v_REPOS_CENTER}/DRYa

}




# ---------------------------------------
# -- Functions above -- Arguments Below
# ---------------------------------------





# ARGUMENTS: for the Function DRYa
   # Use the programming structure provided below (if elif else fi) along 
   # with the Alias "drya" or "D" (defined in the file "source-all-drya-files")
      # Examples at the teminal: 
      #
      #  drya (with-no-arguments)
      #  drya -h
      #  drya --help
      #  drya +
      #
      #  D (with-no-arguments)
      #  D -h
      #  D --help
      #  D +
      # 

if [ -z "$*" ]; then
  # Do something if there are no arguments

  f_greet
  f_talk; echo "is installed!"
          echo
          echo "      Can be used:"
          echo "       > by calling Terminal commands. Example: 'D --help'"
          echo "       > by calling 'D +' for extended \`fzf\` main menu"

   f_talk; echo "Temporized Menu (available only for 2 secs):"
   echo -n " > Press '"; f_cor5; echo -n "d"; f_resetCor; echo "' to open DRYa fzf main menu"
   echo   "   (same as Terminal command: 'D +')"

   
   # Options available during only 2 seconds
      f_talk; f_cor5; echo -en "listening... "; f_resetCor

      read -sn1 -t 2 v_ans
      
      if [ -z $v_ans ]; then
         sleep 0.1
   
         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

      elif [ $v_ans == "d" ]; then
         # When 'd' is pressed to open DRYa fzf main menu

         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

         # Calling the actual menu
            f_drya_fzf_MM

      else

         # If there is a variable, delete and tell which was
         
         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

         echo "Argument $v_ans not recognized at the temporized menu"
         unset v_ans

      fi

elif [ $1 == "--help" ] || [ $1 == "?" ] || [ $1 == "h" ] || [ $1 == "-h" ] || [ $1 == "-?" ] || [ $1 == "rtfm" ]; then
   # Help menu  ::  rtfm: Read the Fucking Manual
   
   f_drya_help

elif [ $1 == "." ]; then  # List files here
   cd ${v_REPOS_CENTER}/DRYa && ls

elif [ $1 == "activate" ] || [ $1 == "placeholder-off" ]; then  # Usado em aparelhos/dispositivos publicos
   # Ao instalar DRYa, fica autimaticamente ativo
   # Ao desativar DRYa com 'deactivate' fica possivel ativar novamente com 'activate'
   # Ativar serve para repor DRYa com todas as funcoes que tinha ao ser instalada
   clear
   figlet DRYa
   echo "DRYa: activate"
   echo
   echo "uDev: Se nao existe nenhuma repo no dispositivo:"
   echo " > clonar DRYa do GitHub"

elif [ $1 == "deactivate" ] || [ $1 == "placeholder-on" ]; then
   # Apos insdalar DRYa, fica possivel desarivar com 'deactivate'
   # Serve para apagar tudo o que existe na pasta ~/Repositories incluindo DRYa, apagando tambem as configs na pasta ~ relativamente a DRYa e deixar no seu lugar um script que volta a clonar do Github 
   # Serve para usar em telemoveis ou dispositivos dos quais SeivaDArve na é o dono, tal como nos dispositivos do trabalho
   clear
   figlet DRYa
   echo "DRYa: deactivate"
   echo
   echo "uDev: Apagar TUDO em:"
   echo " > ~/Repositories"
   echo " > ~/.config"
   echo " > ~/.netrc"
   echo "e deixar so um script para voltar a clonar DRYa do GitHub"
   echo

   # Criar o fucheiro que Re-Ativa DRYa, clonando do Github
      echo '#!/bin/bash' > ~/.DRYa-activate.sh
      echo '# Title: Activate DRYa again' >> ~/.DRYa-activate.sh
      echo '# Description: Run this script to clone DRYa to ~/Repositories automatically' >> ~/.DRYa-activate.sh
      echo "git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa" >> ~/.DRYa-activate.sh && echo "DRYa: Criado ~/.DRYa-activate.sh"
      # uDev: usar ~/.config/h.h/DRYa-activate.sh rm vez de ~/.DRYa-activate.sh
      # uDev: Mencionar o Stroken

elif [ $1 == "location" ]; then 
   # Save GPS locations
   # uDev: this function needs to go to the repo: master-GPS

   if [ $2 == "network" ]; then 
      # Displays current GPS location using network as provider
      termux-location -p network

   elif [ $2 == "gps" ]; then 
      # Displays current GPS location using GPS as provider
      termux-location -p GPS

   elif [ $2 == "network-save" ]; then 
      # Displays current GPS location using network and saves in a file
      # ${REPOS_CENTER}/DRYa/all/var/report-termux-locations.txt
      termux-location -p network

   elif [ $2 == "gps-save" ]; then 
      # Displays current GPS location using GPS and saves in a file
      # ${REPOS_CENTER}/DRYa/all/var/report-termux-locations.txt
      termux-location -p GPS

   fi


elif [ $1 == "verbose" ] || [ $1 == "v" ]; then 
   # Function found at: source-all-drya-files which is the first file on DRYa repository to run
   # This function is used to uncluter the welcome screen of a terminal when DRYa is installed (because DRYa outputs a lot of text)

   # uDev: drya h    # 1st Level of help
   # uDev: drya hh   # 2nd level of help
   # uDev: drya hhh  # 3rd level of help
   # uDev: drya hhhh # 4th level of help ... instead of "msgs"
   
   if [ -z "$2" ]; then
      echo "uDev"
      f_drya_plus

   elif [ $2 == "msgs" ]; then 
      # Option to read the $DRYa_MESSAGES file
         # They are stored at: ~/.config/h.h/drya/.dryaMessages
         less ~/.config/h.h/drya/drya-msgs
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
    echo " > .vimrc" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
    echo " > termux: colors + properties (uDev)"
    echo " > .gitconfig" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig ~
    echo " > init.el (uDev)"
    echo " > drya: .bash_logout file"
    echo

    # Reload .bashrc
    f_cor4; echo -n "DRYa: "
    f_resetCor; echo "reloading functions, variables, alias at:"
    echo " > ~/.bashrc"
          source ~/.bashrc 1>/dev/null && echo " > Done!" && echo

elif [ $1 == "logout" ]; then 
   # If you made modifications at ...DRYa/all/etc/logout-all-drya-files 
   # and you want to conveniently apply it's changes at ~/.bash_logout
   # just run this command
   #
   # The file ~/.bash_logout has an fx that calls logout-all-drya-files

   if [ -z "$2" ]; then
      # If nothing was specified to clone
         echo "What option do you want to perform around the logout file?"

   elif [ $2 == "edit" ]; then
      vim ${v_REPOS_CENTER}/DRYa/all/etc/logout-all-drya-files

   #elif [ $2 == "install" ]; then
      # It is ready and was sent to DRYa fzf main menu

   else
      echo "Option not recognized"
   fi

elif [ $1 == "clone" ]; then 
   # Gets repositories from Github.com and tells how to clone DRYa itself
   # Any repo from Seiva's github.com is cloned to the default directory ~/Repositories

   # uDev: Some repositories have files to be sourcer (like: source-all-moedaz-files) so, after cloning, DRYa must reload everything sourcing ~/.bashrc

   #uDev: Install repo dependencies too

   clear
   f_greet

   if [ -z "$2" ]; then
      # If nothing was specified to clone
         f_clone_info

   elif [ $2 == "try" ]; then
      f_talk; echo -e "trying to clone: $3 \n"; 

      f_init_clone_repos  ## Commun functionality shared with: drya clone $2

      git clone https://github.com/SeivaDArve/$3.git

   else  
      v_arg2=$2

      f_init_clone_repos  ## Commun functionality shared with: drya clone try $3

      f_clone_repos 
   fi

elif [ $1 == "config" ]; then 

   if [ -z $2 ]; then 
      # uDev: at source-all-drya-files one function called traitsID will have these options
     
      # uDev: traitsID already gives these variables as environment variables. No need to repeat code 

      uname -a | grep "Microsoft" 1>/dev/null
      if [ $? == 0 ]; then echo "This is microsoft"; fi
      uname -a | grep "Android" 1>/dev/null
      if [ $? == 0 ]; then echo "This is Android"; fi
      
      v_hostname=$(hostname); echo "Hostname is: $v_hostname"
      v_whoami=$(whoami); echo "whoami is: $v_whoami"
      echo
      echo "uDev: This info must be environment variables for other apps"

   elif [[ $1 == ".dot" ]] || [[ $1 == "dotfiles" ]] || [[ $1 == "dot-files" ]] || [[ $1 == "dot" ]]; then 
      f_dot_files_menu
      
   else
      echo "List of possible things to config is uDev"
   fi

elif [ $1 == "wpwd" ]; then 

   f_greet

   if [ -z $2 ]; then 
      echo 'DRYa: options for w-pwd `windows-$(pwd)`on WSL2'
      echo
      echo "DRYa: feed windows 'Path' to a file, to be converted to Linux 'Path'"
      echo " > D wpwd p || D wpwd path"

   elif [ $2 == "p" ]; then 
      clear
      figlet DRYa
      echo "DRYa: feed me 1 or + Windows paths to convert"
      echo

      # Make a dir and a file, to paste and convert windows text to linux text
         mkdir -p ~/.tmp 
         v_file=~/.tmp/wpwd-rel-path  # Note: Does not work: v_file="~/.tmp/wpwd-rel-path"
         touch $v_file 

      # File the file with some instructions
         echo -e "\n\n# DRYa: Paste an Windows relative path into this vim file and exit with 'ZZ' " > $v_file
         echo -e "# \n# \n# Help with vim commands:\n# > uDev" >> $v_file
         # uDev: finish vim instructions

      # Edit the file, so that the user can paste the C:\<path> and exit
         vim $v_file

      # Convert the text inside the file
         sed -i '/^#/d'             $v_file  # Delete all commented lines
         sed -i '/^$/d'             $v_file  # Delete all empty lines

         sed -i 's#C:\\#/mnt/c/#g'  $v_file  # Convert C:\ into /mnt/c
         sed -i 's#c:\\#/mnt/c/#g'  $v_file  # Convert c:\ into /mnt/c

         sed -i 's#D:\\#/mnt/d/#g'  $v_file  # Convert D:\ into /mnt/d
         sed -i 's#d:\\#/mnt/d/#g'  $v_file  # Convert d:\ into /mnt/d

         sed -i 's#E:\\#/mnt/e/#g'  $v_file  # Convert E:\ into /mnt/e
         sed -i 's#e:\\#/mnt/e/#g'  $v_file  # Convert e:\ into /mnt/e

         sed -i 's#^\\#\./#g'       $v_file  # Convert / if it exists in the begining of the line (relative path) into ./ (relative path)
         sed -i 's/\\/\//g'         $v_file  # Convert \ into /
         sed -i 's/ /\\ /g'         $v_file  # Convert with spaces " " into "\ "

      # Copy text to variable, to test if file/variable is empty
         v_text=$(cat ~/.tmp/wpwd-rel-path )
         #v_text=""  # Debug: To test if file is empty

      # Tell if it is empty or print the remaining contents (hopefully with a valid path converted)
         if [ -z "$v_text" ]; then
            echo "The file is empty"
         else 
            w=$(cat $v_file)
            echo $w
            export w
            echo "uDev: Perguntar com fzf qual dos links quer navegar (\`D wpwd n\`)"
         fi

      echo "Foi colocar todo esse texto (path) numa variavel \$w"
      echo
      echo "uDev: Give dir basename into variable \$W so that command '$ op .' can operate"
      echo "uDev: Mostrar o antes e o depois"
   fi

elif [ $1 == "backup" ]; then 

   if [ -z $2 ]; then 
      # uDev: at DRYa/all/bin/.../3-steps-formater a script will be available to make such backups and prepare format
      # Pode ser usado o SyncThing
      echo "drya: uDev: in the future you may call this function to send files from one device to another device using the web"
      echo 
      echo "DRYa backup options:"
      echo " - Smartphone >> Raspberry Pi (cloud) >> External HDD"
      echo
      echo "DRYa: type 'drya backup list' to be listed a sugestion of files to backup"

   elif [ $2 == "list" ]; then 
      echo "Backup on Smartphone (sugestions):"
      echo " > Contacts"
      echo " > Gmail accounts and passwords"
      echo " > Social media login credentials"
      echo " > Snapshot all installed apps"
      echo " > Browser bookmarks"
      echo " > Update all Repositories on termux"
      echo " > All SD CARD and Internal Storage content"
      echo " > ..."
      echo
      echo "Backup on Computer (suhestions):"
      echo " > ..."
   fi


elif [ $1 == "eysek" ]; then 

   f_greet 

   # Frase bonita
      echo "Desde o filme..." 
      echo

   # Variavel com a data
      STARTINGDATE="2021-02-05"  

   # Data de aniversário no formato YYYY-MM-DD
      f_calcular_tempo_decorrido_apos_data


elif [ $1 == "seiva-up-time" ]; then 
   # uDev: Tells how long the Linux experience started for Seiva
   
   f_greet

   echo "DRYa: Seiva D'Arve started intense linux learning at: March 25th, 2021"
   echo

   # Variavel com a data
      STARTINGDATE="2021-03-25"  

   # Data de aniversário no formato YYYY-MM-DD
      f_calcular_tempo_decorrido_apos_data

   # uDev: Add: seiva-trade-up-time para indicar esta data importante, ou entao incluir no moedaz como data de aniversario


elif [ $1 == "ip" ]; then 
   # Mencionar no terminsl qual é o endereço de IP publico e local

   f_greet

   # Obtendo o IP público usando curl e um serviço online
      PUBLIC_IP=$(curl -s ifconfig.me)

   # Obtendo o IP local usando hostname -I (funciona na maioria dos sistemas Linux)
      LOCAL_IP=$(ifconfig | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}')

      # Alternativa 1: 
         #LOCAL_IP=$(hostname -I | awk '{print $1}')

      # Alternativa 2: 
         #LOCAL_IP=$(ip addr show | grep "inet\b" | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)

   # Imprimindo os resultados
      echo "IP Público: $PUBLIC_IP"
      echo "IP Local: $LOCAL_IP"

elif [ $1 == "mac" ]; then 

   f_greet

   # Get MAC address using ifconfig
      mac_address=$(ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')

   # Print MAC address
      echo "MAC Address: $mac_address"
      echo

   # Print Android ID
      ANDROID_ID=$(termux-telephony-deviceinfo | grep 'device_id' | awk -F': ' '{print $2}' | tr -d '",')
      echo "Android ID: $ANDROID_ID"
      echo

   # Print Numero de serie do Android
      SERIAL=$(getprop ro.serialno)
      echo "Número de série do dispositivo: $SERIAL"
      echo

   # Mais info
      getprop | grep "product" | grep brand
      echo
      getprop | grep "product" | grep model
      echo
      getprop | grep "product" | grep name
      echo


elif [[ $1 == ".dot" ]] || [[ $1 == "dotfiles" ]] || [[ $1 == "dot-files" ]] || [[ $1 == "dot" ]]; then 
   # Installing all configuration files

   if [[ -z $2 ]]; then 
      # Main Menu for dot-files
      f_dot_files_menu  

   elif [[ $2 == "list-ready" ]] || [[ $2 == "list-available" ]]; then 
      # List dot-files available in DRYa repo
      f_dot_files_list_available

   elif [[ $2 == "install" ]]; then 
      # Menu to install dot files
      f_dot_files_install

   elif [[ $2 == "remove" ]]; then 
      echo "uDev"

   elif [[ $2 == "backup" ]]; then 
      echo "uDev: Backup Browser-Bokkmarks"

   elif [[ $2 == "edit" ]]; then 
      echo "uDev"

   fi



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

   elif [[ $2 == "--me" ]] || [ $2 == "DRYa" ]; then 
      echo "uDev: Are you sure you want to install DRYa?"; 
      # Install DRYa itself
      # install dependencies
      # termux-setup-storage
      # pkg install termux-api

   elif [[ $2 == "ps1" ]] || [ $2 == "PS1" ]; then 
      # uDev: This is a config to set, not an instalation
      cd ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/ && source ./termux-PS1

   elif [[ $2 == "bitcoin-core" ]]; then 
      # Install a full Bitcoin node to validade blocks and allow mining
      sudo snap install bitcoin-core

   elif [[ $2 == "pycharm" ]]; then 
      # Install a dedicated GUI text editor for python

      f_greet

      echo "Installing PyCharm on Fedora"
      echo " > Press ENTER to continue; Press Ctrl-C to Abort"
      echo 
      read -sn 1
      echo "Tutorial source: https://snapcraft.io/install/pycharm-community/fedora#install"
      echo 
      # Installing Snap Store and from there, installing pycharm-community
         sudo dnf install snapd
         sudo ln -s /var/lib/snapd/snap /snap
         sudo snap install pycharm-community --classic
      echo
      echo "PyCharm installed"
      echo " > Logout the session or restart to update and use pyCharm"
  
   elif [[ $2 == "doom-emacs-windows" ]]; then 
      # installing Doom Emacs on Windows
      echo "uDev: Tutorial here:"
      echo " > https://dev.to/scarktt/installing-doom-emacs-on-windows-23ja"


   elif [[ $2 == "doom-emacs" ]]; then 
      # installing Doom Emacs on Linux
      echo "Installing Doom Emacs on Linux "
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


   elif [[ $2 == "xrandr" ]] || [ $2 == "" ]; then 
      # Config the correct screen resolution with `xrandr`
      # uDev: This is a config to set, not an instalation

      echo "DRYa: By detecting the traitsID and detecting a raspberry pi, then we know we are using a Tv. And, if no args are given, such tV is brand "silver" therefore, this script applies the screen resolution of:"
      echo " > 1360x768 "


   elif [[ $2 == "upk-at-work" ]]; then 
      # Makes all dependencies for upk repo available
      # This might be used most likely at in-job phone
      
      # Echo a list of things that are going to be installed:
         # uDev
         # uDev
         # uDev
         # uDev
         # uDev
         # uDev

      # Change dir, to avoid changing at every command
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
         bash ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/bin/create-netrc-from-stroken.sh
         vim ~/.netrc
         
      # Repo: upk-diario-dv
         echo "cloning: upk-diario-dv" && git clone https://github.com/SeivaDArve/upK-diario-Dv.git


      # Refresh the terminal
         #source ~/.bashrc

      #    install: 
      #             emacs for windows
      #             instal init.el
      echo "drya: udev: instal all dependencies for upk repo to run"

   else
      echo "drya: What do you want to install? invalid arg"
   fi

elif [ $1 == "ssh" ]; then 
   # Options for SSH File System

   # Para transportar os argumento de script para script, exportamos para o env
      # uDev: fazer destes EXPORT o standard deste script drya.sh no inicio do ficheiro, para que qualquer sub-script possa beneficiar destes argumentos
      ARG1=$1
      ARG2=$2
      ARG3=$3
      export ARG1 ARG2 ARG3

   # Para facilitar ao utilizador que pode querer fazer alteracoes ao script, viajamos primeiro para a pasta onde se encontra o script
      cd ${v_REPOS_CENTER}/DRYa/all/bin/
   
   # Executamos o wrapper do SSHFS
      bash ${v_REPOS_CENTER}/DRYa/all/bin/sshfs-wrapper.sh

elif [ $1 == "edit" ]; then 
         case $2 in
            stroken)
               # Editing stroken globally
               vim ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken
                  echo "File edited at: ...DRYa/all/etc/dot-files/git-github/current-stroken"
                  echo

               cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/current-stroken ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken
                  echo "Copied also too: ...DRYa/install.uninstall/stroken"
                  echo
               
                  # Adding info for the new user:
                     echo -e "\n(note \"info exists also at: .../DRYa/all/etc/dot-files/git-git-hub/current-stroken\")" >> ${v_REPOS_CENTER}/DRYa/install.uninstall/stroken

               # Verbose output
                  echo "You may install stroken as ~/.netrc file with the command:"
                  echo " > drya install stroken"
                  # uDev: to be sent to: drya.sh edit stroken
            ;;
            news)
               vim ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh
            ;;
            dryarc)
               echo "edit the file to program this machine without saving inside original DRYa (uDev)"
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
               # Remove ~/.config/h.h
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

elif [ $1 == "list-photoshop-edited-imgs" ] || [ $1 == "lsPSmeta" ]; then  # Na pasta atual, identifica todas as fotos editadas pelo Photoshop (com apoio do chatGPT)
   # uDev: Existem mais campos que mencionam 'Photoshop' sem ser so o campo '-Software', é necessario completar

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for FILE in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $FILE == *.jpg || $FILE == *.jpeg || $FILE == *.png ]]; then
          # Extrai os metadados EXIF
          SOFTWARE=$(exiftool -Software "$FILE")
          
          # Verifica se o Software usado foi o Photoshop
          if [[ $SOFTWARE == *"Adobe Photoshop"* ]]; then
            echo "Imagem editada no Photoshop: $FILE"
          fi
        fi
      done

elif [ $1 == "clear-photoshop-editor-from-metadata-of-imgs" ] || [ $1 == "clrPSmeta" ]; then  # Na pasta atual, elimina os campos onde diz que a foto foi editada por algum software 
   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for FILE in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $FILE == *.jpg || $FILE == *.jpeg || $FILE == *.png ]]; then
          # Remove o metadado do software da imagem
          #exiftool -Software= "$FILE"
          exiftool -all= "$FILE"
          echo "Metadado do software removido de: $FILE"
        fi
      done

elif [ $1 == "list-all-file-metadata" ] || [ $1 == "lsmeta" ]; then  # mostra os seu metadados da imagem fornecida
   # Caminho para a imagem
      echo "Introduza o nome do ficheiro do qual quer ver os metadados"
      read -p " > " v_file

      exiftool "$v_file"

elif [ $1 == "list-all-dir-metadata" ] || [ $1 == "lsDirmeta" ]; then  # Junta todas as fotos do dir atual e mostra os seus metadados

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for FILE in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $FILE == *.jpg || $FILE == *.jpeg || $FILE == *.png ]]; then
          # Listar todos os metadados da imagem
          exiftool "$FILE"
        fi
      done


elif [ $1 == "generate-photo-ID" ] || [ $1 == "gpID" ]; then  # Busca a data/hora atual de forma inconfundivel e adiciona o texto "Img-ID-xxxxxxxxxxxxxxxxx.jpg"
   echo "uDev: Idenfiticação de photos criando um nome com ID"
   # uDev: criar fx que busca TODO o sistema de pastas no Android apartir do termux para encontrar todos esses ID espalhados e enviar para a pasta desejada (local atual do cursor)

elif [ $1 == "soft-link" ] || [ $1 == "sl" ]; then 
   # uDev: criar também hard links para ficheiros e pastas
   
   f_greet

   # Função para exibir como usar o script
      f_instructions_of_usage() {
         f_talk; 
         #echo "Uso: $0 <origem> <destino>"
         echo "Instruções: Criar um link simbólico de <origem> para <destino>."
         echo " > Origem:  É o arquivo ou diretório existente que se deseja referenciar."
         echo " > Destino: É o caminho e nome do link simbólico que você está a criar."
         echo "            Para o destino, tem de escolher um nome novo"
         echo 
         echo ' > exemplo: `ln -s         <diretorio-existente> <novo-caminho-com-nome>`'
         echo
         echo ' > exemplo: `drya sof-link <diretorio-existente> <novo-caminho-com-nome>`'
         echo ' > exemplo: `drya sl       <diretorio-existente> <novo-caminho-com-nome>`'
         echo ' > exemplo: `D sl          <diretorio-existente> <novo-caminho-com-nome>`'
         echo 
         f_talk
         echo 'Também pode guardar o <origem> em uma variavel para não ter de escrever manualmente'
         echo ' > exemplo: `origem=$(pwd)`'
         echo ' >> `D sl $origem <novo-caminho-com-nome>`'
         echo
         echo ' > Com DRYa, pode guardar um caminho na variavel $h usando 5x .'
         echo ' >> ou seja: Navegar para origem e escrever `.....` para guardar h=$(pwd)'
         echo 
         echo ' >>> Resumindo: `D sl $h <nome-ou-caminho-com-nome>` para criar com DRYa um Soft-link de $h para $v'
         echo 
         f_talk
         echo "Remover um link:"
         echo ' > Se for um diretorio: `unlink <diretorio-a-remover>`'
         echo ' > Se for um ficheiro:  `rm     <ficheiro-a-remover>`'
         exit 1
      }

   # Verificar se o número de argumentos é igual a 2
      if [ "$#" -ne 3 ]; then
         f_instructions_of_usage
      fi

   origem=$2
   destino=$3

   # Verificar se o arquivo/diretório de origem existe
      if [ ! -e "$origem" ]; then
          echo "Erro: O arquivo ou diretório de origem '$origem' não existe."
          f_instructions_of_usage
          exit 1
      fi

   # Criar o link simbólico
      ln -s "$origem" "$destino"

   # Verificar se o link simbólico foi criado com sucesso
      if [ "$?" -eq 0 ]; then
          echo "Link simbólico criado com sucesso: '$destino' -> '$origem'"
      else
          echo "Erro ao criar o link simbólico."
          f_instructions_of_usage
          exit 1
      fi

elif [ $1 == "calculator" ] || [ $1 == "calculadora" ] || [ $1 == "calc" ] || [ $1 == "clc" ]; then
    # calculator modified for Trading 
    bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculator-reg.sh
    
elif [ $1 == "vlm" ]; then 
         # Works on termux only
            # Toggles the value volume-key from =virtual to =volume (inside termux. more info at: man termux)

         echo uDev

         #echo "volume keys on Termux toggled. Now they act as X instead of Y"
         # DO NOT CHANGE VOLUME ON DRYa REPO, CHANGE ONLY AT ~/.termux/ (no need to continuously git push such changes
         # volume-keys = volume
         # volume-keys = virtual
         # Default is virtual

         # As per termux instructions, we can reload the configs: 
            #termux-reload-settings

elif [ $1 == "QR-to-clone-drya" ] || [ $1 == "QR-clone" ]; then 
   echo "uDev: Will present an image to the screen, other devices can scan it to retrieve it's text and run it on the terminal"

elif [ $1 == "logo" ]; then 
         # Presenting DRYa
         ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead

elif [ $1 == "gui" ]; then 
         TERM=ansi \
            whiptail --title "Example Dialog" \
                     --infobox "This is an example of an info box" 8 78 \
                     --yesno "yea" 8 8

elif [ $1 == "+" ]; then 
   # The DRYa's fzf main menu
   # uDev: If fzf is not installed, imediatly do it, no questions!

   f_drya_fzf_MM

else 
   # When invalid arguments are given. (May also be used to debug functions)
      f_exec

fi


