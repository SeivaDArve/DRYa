#!/bin/bash 
# Title: DRYa (Don't Repeat Yourself app)
# Description: The central script that manages other scripts and repos. You may use this app in many ways. Specially as a toolbox
# Use: You can call an fzf main menu that, for each fx in it, there is an equivalent terminal command

# Sourcing file with colors 
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

function f_greet {
   # Presents a Nice visual ascii name/logo for this entire script

   # If figlet app is installed:     print an ascii version of the text "DRYa" to improve the appearence of the app
   # "     "    "  is not insfalled: print only a message

   # If figlet not installed, use this message instead
      v_2nd_option="( DRYa ):\vrunning: drya.sh\n         figlet:  Not installed"

   # CORDN_5_10='\033[5;23H'
   # echo -e "$CORDN_5_10 Don't Repeat Yourself (app)"
   # 
   # uDev: Confirmar se no futuro pode haver problemas com a font

   clear
   figlet DRYa 2>/dev/null || echo -e "$v_2nd_option"
}

function f_greet2 {
   # Prints a more verbose output of the ascii text "DRYa" then f_greet

   bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh 2>/dev/null \
      || echo -e "DRYa: app available \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
}

function f_talk {
   # Copied from: ezGIT
         echo
   f_c4; echo -n "DRYa: "
   f_rc
}

function f_done {
   # Copied from: ezGIT
   f_c5; echo -n ": Done"
   f_rc
}

function f_prsK {
   # Press Any key to continue
   # Or wait X seconds





 
   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
      # EXEMPLO:
      #
      # v_txt="Editado X"
      # f_prsK
      #
      # EFEITO: 
      # DRYa: Are you sure: "Editar X"
      #  > Are you sure? (Press ANY key to confirm) 



   # Set how many seconds to wait before automatically continue
      v_secs=5

   # Message
      v_msg=" ... (Continue: ANY KEY | Cancel: Ctrl-C ) "

   # Set $v_txt to " ... " in case the user forgets to set it (must be unset before this fx finishes
      [[ -z $v_txt ]] && v_txt=" ... "

   # Text to print
         #echo
   f_talk; echo -n 'Are you sure? `'
     f_c5; echo -n "$v_txt"   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
     f_rc; echo '`'
           echo -n "$v_msg"
           read -sn1
     f_rc; echo -e "\r\033[K > A Continuar..."

   # Removing variables before the fx finished
      unset v_txt
}

function f_stroken {
   # When automatic github.com authentication is not set, an alternative (as text based credential, but salted) is printed on the screen. This is usefull until the app remains as Beta.

   # If ~/.netrc exists, no need to print the rest
      if [ -f ~/.netrc ]; then
         echo ".netrc exists. No github auth needed" 1>/dev/null

      else
         f_talk; echo    "stroken"
                 echo    " > Inside the ezGIT app I found this: "
         f_c4;   echo -n "seivadarve";
         f_rc;   echo    " and this:";
         f_c4;   echo    "ghp_JGIFXMcvvzfizn9OwAMdMdGMSPu9E30yVogPk"
         f_rc;   echo
      fi
}

function f_Hline {
   # Prints an horizontal line

   #echo $COLUMNS # Debug
   v_cols=$(tput cols)
   printf "%*s" $v_cols | tr " " "_"
}

function f_horizline {
   # Criar uma linha horizontal do tamanho correto do ecra

   # Buscar tamanho correto (precisa da dependencia `tput`)
      v_cols=$(tput cols)

   # Escrever uma linha no ecra
      for i in $(seq $v_cols); do
         echo -ne "-" 
      done
}

function f_verticline {
	v_lines=$(tput lines)
	for i in $(seq $v_lines); do
   	echo -ne "   |\n" 
	done
}

function f_install_drya {
   # Install DRYa itself + dependencies + 1st + termux-setup-storage + termux-API

   f_greet

   f_talk; echo "uDev: Are you sure you want to install DRYa?"; 
           echo
           echo "If you want to install drya itself, 3 ways:"
           echo "  1. Download and run:  github.com/DRYa/ghost-in.sh"
           echo "  2. Git Clone and Run: github.com/DRYa; bash Drya/install.uninstall/install.sh"
           echo "  3. Git Clone and Run: github.com/DRYa; bash drya.sh install --me"
}

function f_git_status {
   f_talk; echo
     f_c4; echo -n '`git status`'
     f_rc; echo

   git status
}

function f_git_pull {
   # Copied from: ezGIT
   f_talk; echo
     f_c4; echo -n '`git pull`'
     f_rc; echo

   git pull
}

function f_trap {
	# Set a trap to restore terminal on Ctrl-c (exit).
    	# Reset character attributes, make cursor visible, and restore
    	# previous screen contents (if possible).

    	trap 'tput sgr0; tput cnorm; tput rmcup || clear; exit 0' SIGINT

	# Tutorial:
	https://www.linuxjournal.com/content/bash-trap-command
}

function f_troubleshootingPWD {

   # Calling a function that defines the variable _SCRIPT_DIR:
      f_get_script_current_abs_path
            echo
      f_c4; echo -n _SCRIPT_DIR
      f_rc; echo -n ": "
      f_c3; echo $_SCRIPT_DIR
      f_rc; echo

   # Informing about our location
            echo "but we are running it from:"
      f_c4; echo -n "pwd"
      f_rc; echo -n ": "
      f_c3; echo $(pwd)
            echo;
      f_c4; echo -n "saving current "
      f_c3; echo -n "pwd " 
      f_c4; echo -n "into "
      f_c3; echo -n "_BEFORE_CALLING_SCRIPT"; 
      f_rc; echo

      _BEFORE_CALLING_SCRIPT=$(pwd)

      echo "_BEFORE_CALLING_SCRIPT: $_BEFORE_CALLING_SCRIPT"
      echo
   
   # Traveling to dir of main script in order to make use of relative file positions (this script is not compiled and this prevents "missing files" or "commands")
      cd $_SCRIPT_DIR

            echo "Now, cd into _SCRIPT_DIR"
      f_c4; echo -n "pwd"
      f_rc; echo -n ": "
      f_c3; echo $(pwd)
      f_rc; echo
            echo

   # If this troubleshooting works, you should be able to cat the following file from any directory:
      cat ./wiki/testFile
}

function f_ascii_icon {


	function f_center_to_screen_verbose {
      # Fx to verbosely study the process of creating this logo

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
         echo
         echo "Example of logo centered:"
         tput cup 13 $_cols
         echo "................................"


		# Now the same for lines:
         #tput lines
		
	}
	#f_center_to_screen_verbose

	function f_spaces {
		# Manually writting spaces before and after the ascii logo

      # Assumindo que o logo tem 33 ou mais letras de cumprimento horizontal

      # Sera feito o calculo com 40 letras
         # Ler quantas colunas tem no total da janela do terminal neste momento
         # udev: criar uma fx no inicio deste ficheiro para nao ser repetitivo esta calculo

         v_cols=$(tput cols)

      # Do total de colunas do terminal, retirar o tamanho que ocupa o logo e dividir por 2
         v_cols=$(($v_cols-32))
         v_cols=$(($v_cols/2))

      # Preencher do lado Esq com espacos vazios de forma que o logo fique ao centro
         for i in $(seq 1 $v_cols)
         do
            echo -n " "
         done
	}

       f_c6;
   f_Hline; echo
             echo
             echo
	f_spaces; echo -e  "     ||\` "
	f_spaces; echo -e  "     ||	"
	f_spaces; echo -e  " .|''||  '||''| '||  ||\`  '''|.	"
	f_spaces; echo -e  " ||  ||   ||     \`|..||  .|''||	"
	f_spaces; echo -e " \`|..||. .||.        ||  \`|..||.	"
	f_spaces; echo    "                  ,  |'		      "
	f_spaces; echo    "                    ''		         "
   f_Hline
}


function f_recicle_line {
   # Example on how to write 2x or more on the same line
   # uDev: create better explanation on this tput examples
	echo "First line..."
	f_rc
	read -p "Press any key to overwrite this line... " -n1 -s
	tput rc 1
   tput el
	echo "Second line. read replaced."
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
	f_c3; echo "This script is written/located at:"; 
	f_rc; echo $_SCRIPT_DIR;
	
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

   f_talk; echo "Must specify a repository to clone"
           echo
           echo " To list all public repositories"
           echo "  > '$ drya clone --list-public' or "
           echo "  > '$ drya clone -p' "
           echo 
           echo " To list all private repositories"
           echo "  > '$ drya clone --list-private' or"
           echo "  > '$ drya clone -P'"
           echo
           echo " To clone DRYa:  "
           echo "  > git clone https://github.com/SeivaDArve/DRYa.git ~/Repositories/DRYa"
           echo
           echo " Webpage with all repositories:"
           echo "  > https://github.com/SeivaDArve?tab=repositories"

   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
      v_txt="Visiting: https://github.com/SeivaDArve?tab=repositories"
      f_prsK
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

   function f_improve_readability {
      # These next functions are to improve the reading of `case-esac` below them

      function f_clone_repos_upk {
         echo "cloning upK"
         git clone https://github.com/SeivaDArve/upK.git
      }

      function f_clone_repos_upk-dv {
         echo "Cloning upK-diario-Dv"; 
         echo "Link for download is:"; 
         echo " > https://github.com/SeivaDArve/upK-diario-Dv.git"; 
         git clone https://github.com/SeivaDArve/upK-diario-Dv.git

      }

      function f_clone_repos_shiva {
         echo "cloning 112-Shiva-Sutras"; git clone https://github.com/SeivaDArve/112-Shiva-Sutras.git
      }

      function f_clone_repos_omni {
         echo "cloning omni-log"; git clone https://github.com/SeivaDArve/omni-log.git
      }

      function f_clone_repos_dWiki {
         echo "cloning dWiki"; git clone https://github.com/SeivaDArve/dWiki.git
      }

      function f_clone_repos_wikiD {
         echo "cloning dWiki"; git clone https://github.com/SeivaDArve/wikiD.git
      }

      function f_clone_repos_yoga {
         echo "cloning yogaBashApp"; git clone https://github.com/SeivaDArve/yogaBashApp.git
      }

      function f_clone_repos_moedaz {
         echo "cloning moedaz"; git clone https://github.com/SeivaDArve/moedaz.git
      }

      function f_clone_repos_Tesoro {
         echo "cloning Tesoro"; git clone https://github.com/SeivaDArve/Tesoro.git
      }

      function f_clone_repos_ezGIT {
         echo "cloning ezGIT"; git clone https://github.com/SeivaDArve/ezGIT.git
      }

      function f_clone_calc_extention {
         echo "cloning calc-extention-ROM-APK"; git clone https://github.com/SeivaDArve/calc-extention-ROM-APK.git
      }

      function f_3_sticks_alpha_bravo {
         echo "cloning 3-sticks-alpha-bravo"; git clone https://github.com/SeivaDArve/3-sticks-alpha-bravo.git
      }

      function f_clone_repos_public_repos {
         # This function scrapes the webpage of Seiva D'arve repositories on GitHub and lists all that is found

         echo "List of public repositories from Seiva D'Arve from GitHub.com:"
            

         # Saving the list of public repos into a var called $v_list
            v_list=$(curl -s https://github.com/SeivaDArve?tab=repositories \
                     | grep "codeRepository" \
                     | sed 's,        <a href="/SeivaDArve/,,g' \
                     | sed 's," itemprop="name codeRepository" >,,g')

         # Presenting each item of $v_list with a padding
            for i in $v_list
            do
               echo " > $i"
            done
      }

      function f_clone_repos_private_repos {
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
      }

      function f_clone_repos_setup_internal_dir {
         echo "uDev"  #uDev: create a dir at internal storage named Repositories to then be moved to external storage by the file explorer. There are no write permissions for termux at SD Card, but can read bash from it... in the other hand, File explorers can Write/move stuff into SD Card
      }
   }

   f_improve_readability  # Simply runs last fx. 

   f_talk 

   case $v_arg2 in
      # uDev: Search for dependencies file if any
      # uDev: Print their webpage link
      
      ezGIT | ezgit | ez)         
         # Runs the fx that clones ezGIT
         f_clone_repos_ezGIT
      ;;

      ROM | rom | calc-extention)
         f_clone_calc_extention
      ;;

      Tesoro | tesoro | T)          
         f_clone_repos_Tesoro
      ;;

      moedaz | mo)                 
         f_clone_repos_moedaz
      ;;

      yoga | yg)                   
         f_clone_repos_yoga
      ;;

      dWiki | DWiki | dw) 
         f_clone_repos_dWiki
      ;;

      wikiD | wiki | wd) 
         f_clone_repos_dWiki
      ;;

      omni-log | omni | log | om)   
         f_clone_repos_omni
      ;;

      shiva-sutras | shiva | ss | SS | 112 )    
         f_clone_repos_shiva
      ;;

      upk) 
         f_clone_repos_upk
      ;;

      upk-dv | upkd)   
         f_clone_repos_upk-dv
      ;;

      3-sticks-alpha-bravo | 3sab)  
         f_3_sticks_alpha_bravo
      ;;

      setup-internal-dir)          
         f_clone_repos_setup_internal_di
      ;;

      -p | p | --public-list) 
         f_clone_repos_public_repos
      ;;

      -P | P | --private-list) 
         f_clone_repos_private_repos
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
   # Install .gitconfig on the system
   
   
   v_file= ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig 
   v_place=~

   f_greet
   f_talk; echo "Installing .gitconfig:"
           echo " > File 1: .../DRYa/all/etc/dot-files/git-github/.gitconfig"
           echo " > To:     ~/"

   v_txt="Are you sure? " && f_prsK

   cp $v_file $v_place && f_talk && echo "Done! "
}



function f_dotFiles_install_vim {
   # Install .vimrc on the system

   v_file=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc
   v_place=~

   v_v1=$v_REPOS_CENTER
   v_v2="let g:dryaREPOS = '$v_v1' "
   #echo "Final: $v_v2"; read   # Debug

   f_greet
   f_talk; echo -n "Installing "
     f_c2; echo ".vimrc"
     f_rc

   f_talk; echo "STEP 1: Copy .vimrc"
           echo " > File 1: .../DRYa/all/etc/dot-files/vim/.vimrc"
           echo " > To:     ~/"

   f_talk; echo "STEP 2: At ~/.vimrc replace global variable: dryaREPOS"
           echo " > from: \"let g:dryaREPOS = '<DRYa-variable-for-Repository-Center>' \" "
           echo " > to:   \"let g:dryaREPOS = '$v_v1' \" "

   v_txt="Install .vimrc" && f_prsK
   
   # Start STEP 1
      cp $v_file $v_place && f_talk && echo "STEP 1: Done! "

   # Start STEP 2
      # At sed, we search patterns with /pattern
      # At sed, we replace entire line with c\
      # At sed, we replace entire line with variable with c\\
      # So... /pattern/c\\<variable-here>
      sed -i "/let g:dryaREPOS/c\\$v_v2" ~/.vimrc && f_talk && echo "STEP 2: Done! "

}

function f_dotFiles_install_termux_properties {
   # Install Termux colors and properties on the system

   v_file1=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/colors.properties 
   v_file2=${v_REPOS_CENTER}/DRYa/all/etc/dot-files/termux/termux.properties
   v_place=~/.termux/

   f_greet
   f_talk; echo "Installing Termux Colors + Termux properties"
           echo " > File 1: .../DRYa/all/etc/dot-files/termux/colors.properties"
           echo " > File 2: .../DRYa/all/etc/dot-files/termux/termux.properties"
           echo " > To:  ~/.termux/"

   v_txt="Are you sure? " && f_prsK
   
   cp $v_file1 $v_place && f_talk && echo "File 1: Done! "
   cp $v_file2 $v_place && f_talk && echo "File 2: Done! "

   echo "Done! (Restart the terminal is needed)"
}

function f_dotFiles_install_dryarc {
   f_talk; echo "source .dryarc if any exists (uDev)"
}


function f_dotFiles_install_netrc {
   # Installing .netrc at ~
   # This file allows the user to avoid repetitive autentication (user and password) for github.com
   # In this file, a stroken (token with a bug) is written, then corrected manually by the user, then used it is all set, no more repetition
   
   f_greet

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
      echo            "Machine github.com login $v_username password $v_token" > ~/.netrc
      echo            "File created "
      echo            " > with stroken instead of a token (still contains a bug)"
      read -s -n 1 -p " > Press [Any key] to continue and edit..."
      echo

   # Opening the file to edit
      echo "Opening the file ~/.netrc"
      echo " > (3 seconds to cancel with Ctrl-C)"

      read -s -n 1 -t 3

      vim ~/.netrc && echo "Done!"
}

function f_win_to_linux_pwd {
   # Convert text Windows Path into text Linux Path

   if [ -z $v_arg2 ]; then 

      f_greet
      f_talk; echo "Convert a Text file with a list of"
              echo "      Windows Paths into Linux Paths"
              echo "       > feed me 1 or + Windows paths to convert"

      # Make a dir and a file, to paste and convert windows text to linux text
         mkdir -p ~/.tmp 
         v_file=~/.tmp/wpwd-rel-path  # Note: Does not work: v_file="~/.tmp/wpwd-rel-path"
         touch $v_file 


      # File the file with some instructions
         echo >             $v_file
         echo >>            $v_file
         echo "# DRYa: Paste an Windows relative path into this vim file (uncommented) and exit with 'ZZ' " >> $v_file
         echo "# " >>       $v_file
         echo "# " >>       $v_file
         echo "# Help with vim commands:" >> $v_file
         echo "# > uDev" >> $v_file
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
            f_talk; echo "The file was empty"
         else 
            echo
            w=$(cat $v_file)
            echo $w
            export w  # Nao funciona quando é lido casualmente por um script
            #echo "uDev: Perguntar com fzf qual dos links quer navegar (\`D wpwd n\`)"
         fi

      #echo "uDev: colocar todo esse texto (path) numa variavel \$w"
      #echo "uDev: Give dir basename into variable \$W so that command '$ op .' can operate"
      #echo "uDev: Mostrar o antes e o depois"

   else
      f_talk; echo 'options for w-pwd `windows-$(pwd)`on WSL2'
              echo
      f_talk; echo "feed windows 'Path' to a file, to be converted to Linux 'Path'"
              echo " > D wpwd"

   fi
}

function f_drya_help {
   # Main help function
  
   f_greet2

   f_talk; echo "Help"
           echo
           echo "What is DRYa:"
           echo " > D.R.Y.a. "
           echo "   (Don't Repeat Yourself app)"
           echo "   is a CLI software intended"
           echo "   to prevent repetitive tasks"
           echo "   and work like a 2nd brain"
           echo "   written in Bash (Cross-Platform)"
           echo
           echo "Developer Intentions (on DRYa):"
           echo " > The most light weight app possible "
           echo "   that each command is performed very fast"
           echo
           echo " > Works on any device after proper config"
           echo "   Windows, Linux, Mac, Android, iPhone"
           echo
           echo " > All burocracy around the user of the app"
           echo "   is taken care of, without spy or malware"
           echo   
           echo "   possible because the code is not compiled"
           echo "   abd any user non-developer is able to open"
           echo "   each script and actually read every command"
           echo "   that is going to run, and change it"
           echo
           echo " > It is a compilation of every cool feature"
           echo "   of every other cool app without their"
           echo "   bloated garbage. It either mimics features"
           echo "   or gives simplified commands to the user"
           echo "   to make use of the original app. No need"
           echo "   install any 3rd party software that"
           echo "   duplixates functionality of other apps"
           echo
           echo " > A server or cloud should be running online"
           echo "   always to allow DRYa repo to be cloned"
           echo "   (if needed)"
           echo   
           echo
           echo "Author: "
           echo " > David Rodrigues (Seiva D'Arve)"
           echo "   flowreshe.seiva.d.arve@gmail.com"
           echo
           echo "uDev: press 'H' to Help menu with \`fzf\` for each option:"
           echo " 1. DRYa man page (uDev)"
           echo " 2. DRYa (Terminal printed instructions)"
           echo " 3. DRYa README.md file "
           echo " 4. DRYa cheat sheets and alias for terminal commands"
           echo " 5. DRYa cheat sheets for 'Temporized Menu' "
           echo " 6. DRYa environment variables and .dryarc"
           echo ' 6. DRYa file where `notify` saves history'
           echo " 6. traitsID: Print specs of current device"
           echo " 7. What is D.R.Y.a. "
           echo " 8. dee-pages: filter real commands from their own script"
           echo " 9. Welcome screen DRYa's instructions"
           echo " 10. DRYa é como uma luva que acenta no PC ou Phone e sabe o que instalar e como instalar"
}

function f_dot_files_list_available {
   # List dot-files available in DRYa repo

   f_greet
   f_talk; echo '`drya dot list-ready-and-uDev`'
           echo " > Files ready to copy from DRYa repo to their Default locations"

   # List all files in one array variable
      v_all_dot_files=(                \
         ".bashrc"                     \
         ".bash_logout"                \
         ".netrc"                      \
         ".vimrc"                      \
         "emacs:init.el"               \
         "emacs:lib"                   \
         "emacs:lib:upk"               \
         "emacs:lib:omni-log"          \
         ".gitconfig"                  \
         "xrandr"                      \
         "keyboard:layout"             \
         "manpages"                    \
         "termux:storage"              \
         "termux:repos"                \
         "termux:properties"           \
         "termux:colors"               \
         '~/ln/wsl'                    \  # Soft link for WSL2 C:\
         '~/ln/Repositories'           \  # Soft link for WSL2 C:\$USER\Repositories == /mnt/c/$USER/Repositories
         ".dryarc"                     \
         ".tmux.conf"                  \
         '$PS1'                        \
          "browser:bookmarks"          )  

   # `echo` variable horizontally:
      #echo "Array is: ${v_all_dot_files[@]}"

   # `echo` variable vertically:
      echo -e "\nListing all dot files to handle:"

      for i in ${v_all_dot_files[@]}
      do 
               echo -n " > "
         f_c2; echo $i
         f_rc
      done

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

function f_quick_install_all_upk {
   # Makes all dependencies for upk repo available
   # This might be used most likely at in-job phone
   
   f_greet

   # Echo a list of things that are going to be installed:
      # uDev
      # uDev
      # uDev
      # uDev
      # uDev
      # uDev

   # Change dir, to avoid changing at every command
      cd ${v_REPOS_CENTER}

   # Install dependencies (and automatically answering YES to all questions)
      # uDev: Test if it is windows and install GUI version also
      f_talk; echo "install emacs figlet vim"
      yes | pkg install emacs figlet vim 

   # Repo: upk
      f_talk; echo "Cloning: upK" && git clone https://github.com/SeivaDArve/upK.git
      
   # Repo: upk-diario-dv
      f_talk; echo "cloning: upk-diario-dv" && git clone https://github.com/SeivaDArve/upK-diario-Dv.git

      read
   # Installing .netrc
      f_dotFiles_install_netrc


   # Refresh the terminal
      #source ~/.bashrc

   #    install: 
   #             emacs for windows
   #             instal init.el
   f_talk; echo "udev: install all dependencies for upk repo to run"
}

function f_dot_files_install_presets {
   Lz='`D dot install presets`'

   L2="2. Quick Install | upk + upkd + dependencies "
   L1="1. Cancel "

   L0="SELECT (1 or +) dot-files to install: "

   v_list=$(echo -e "$L1 \n$L2 \n\n$Lz" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "$Lz" ]] && echo "$Lz" 
      [[ $v_list =~ "2. " ]] && f_quick_install_all_upk
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz"
      unset v_list

}

function f_dot_files_install {
   Lz='`D dot install`'

   # uDev: Redefinir browser pre-definido
   #       Endereco MAC (traitsID)
   #       Terminal best font
   #       Install: font: Monospace (best for terminal)
   
   #L10="10. .hushlogin"  # Se este ficheiro existir, o termux nao cria welcom screen

    L10="10. termux.properties"
     L9="9.  .tmux.conf"
     L8="8.  .bash_logout"
     L7="7.  .gitconfig "
     L6="6.  .vimrc "
     L5="5.  .netrc "
     L4="4.  .dryarc "

     L3="3.  Install | PRESETS"
     L2="2.  Install | TODOS "

     L1="1.  Cancel "

   L0="SELECT (1 or +) dot-files to install: "

   v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n\n$Lz" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "$Lz"  ]] && history -s "$Lz"
      [[ $v_list =~ "10. " ]] && f_dotFiles_install_termux_properties
      [[ $v_list =~ "9.  " ]] && echo "uDev"
      [[ $v_list =~ "8.  " ]] && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/bashrc/bash-logout/.bash_logout ~ && echo "DRYa: file .bash_logout copied to ~/.bash_logout"
      [[ $v_list =~ "7.  " ]] && f_dotFiles_install_git 
      [[ $v_list =~ "6.  " ]] && f_dotFiles_install_vim
      [[ $v_list =~ "5.  " ]] && f_dotFiles_install_netrc
      [[ $v_list =~ "4.  " ]] && f_dotFiles_install_dryarc
      [[ $v_list =~ "3.  " ]] && f_dot_files_install_presets
      [[ $v_list =~ "2.  " ]] && f_dotFiles_install_vim && f_dotFiles_install_git && f_dotFiles_install_termux_properties && f_dotFiles_install_dryarc && f_dotFiles_install_netrc
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz"
      unset v_list
}

function f_dot_files_menu {
   # Main Menu for dot files

      Lz='`D dot`'

      #L8="8. Factory Reset (- ghost-out.sh)"  # uDev: At any installation, the original default file should be stored in dryarc. So now this fx is possible. remove DRYa files and give back the dot-file that the system was fresh formated with.
      #L7="7. Factory Reset (+ ghost-out.sh)"  # uDev: When setting factory reset, leave a file to clone drya ENTIRELY
      L7="7. Factory Reset "  # uDev: When setting factory reset, leave a file to clone drya ENTIRELY
      L6="6. Menu | Backups"

      L5="5. Edit | Centralized only @ DRYa"
      L5='5. Edit | Installed only   @ Host'
      L5='5. Edit | Centralized > Install'

      L4="4. Menu | Uninstall "
      L3="3. Menu | Install" 
      L2="2. List | Available"  # uDev: Test if centralized DRYa dot-files were modified and are available to replace old ones at the current system
      L1="1. Cancel"

      L0="Menu: Manage dot-files: "

      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n\n$Lz" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "7. " ]] && echo "Detetado 7"
      [[ $v_list =~ "6. " ]] && echo "Detetado 6"
      [[ $v_list =~ "5. " ]] && echo "Detetado 5"
      [[ $v_list =~ "4. " ]] && echo "Detetado 4"
      [[ $v_list =~ "3. " ]] && f_dot_files_install
      [[ $v_list =~ "2. " ]] && f_dot_files_list_available
      [[ $v_list =~ "1. " ]] && echo "Canceled"
   
      unset v_list
}


function f_drya_fzf_MM_Toolbox {
   # Funcoes inbutidas na Repo DRYa 

   function f_void {
      # Runs only once at the beginning
       Lv="V. [ ] Verbose help"
      Lvx="V. [ ] Verbose help"
      LvX="V. [X] Verbose help"
   }
 
   function f_loop {
      # Esta fx pode voltar a ser chamada varias vezes 

      # Lista de opcoes para o menu `fzf`

         # Void: Lv, ...
         # L12='12. Agendar envio SMS && WHATSAPP'
         # L12='12. Comboios CP web-scraping
         # L12='12. Ementas Yummy
         # L12='12. fzf keyboard (para smartphones partidos)'
         # L12='12. dir to .jpg
         # L12='12. Agendar SMS
         # L12='12. sound record
         # L12='12. Conversor de texto formal para informal
         # L12='12. Temporizador: Proximo Maha Kumbh Mela
         # L12='12. Localizacao de telemovel via info de wi-fi disponiveis e via sonora com beeps
         # L12='12. Termux > Jarve > Django
         # L12='12. Random number generator
         # L12='12. nanD
         # L12='12. Change IP and acess banned website
         # L12='12. See list of saved passwords and correspondant hotspor names
         # L12='12. Fork Bomb (overload current RAM until system failure): Will need a pin

         L12='12. Script | sshfs-wrapper'
         L11='11. Audio  | Media Player'  
         L10='10. Print  | Previsao do Tempo'
          L9='9.  Print  | Online man pages'  
          L8='8.  Print  | morse'    # Link: https://www.instagram.com/reel/DEmApyMtMn7/?igsh=MTJqbjl6dWMxd2F1dg==
          L7='7.  Menu   | no-tes '
          L6='6.  Script | Convert `pwd` from Win to Linux'
          L5="5.  App    | xKill"
          L4="4.  App    | notify"
          L3="3.  Menu   | calculos/calculadoras"
          L2="2.  Menu   | dot-files"
          L1="1.  Cancel" 

         L0="DRYA: toolbox fx List: " 

         v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n\n$Lv" | fzf --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ "V. " ]] && [[ $v_list =~ "[X]" ]] && Lv="$Lvx" && f_loop
         [[ $v_list =~ "V. " ]] && [[ $v_list =~ "[ ]" ]] && Lv="$LvX" && f_loop

         [[ $v_list =~ "12. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/sshfs-wrapper.sh 
         [[ $v_list =~ "11. " ]] && echo "uDev: $L11"
         [[ $v_list =~ "10. " ]] && f_greet && f_talk && echo "Previsao do Tempo" && curl wttr.in 
         [[ $v_list =~ "9. "  ]] && f_greet && f_talk && read -p "Ask for a man page (curl will get it): " v_ans && curl cheat.sh/$v_ans
         [[ $v_list =~ "8. "  ]] && less ${v_REPOS_CENTER}/wikiD/all/morse-diagrams/morse-letters-diagram.txt
         [[ $v_list =~ "7. "  ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/no-tes.sh 
         [[ $v_list =~ "6. "  ]] && f_win_to_linux_pwd
         [[ $v_list =~ "5. "  ]] && echo "uDev"
         [[ $v_list =~ "4. "  ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh

         [[ $v_list =~ "3. "  ]] && [[ $Lv =~ "[ ]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh 
         [[ $v_list =~ "3. "  ]] && [[ $Lv =~ "[X]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh h

         [[ $v_list =~ "2. "  ]] && f_dot_files_menu
         [[ $v_list =~ "1. "  ]] && echo "Canceled"

      # Evitar loops a mais
         # A fx "...loop" pode ser chamada varias vezes para a alteracao da checkbox
         # Mas precisa que esse loop seja quebrado no final
         exit 0
   }

   # Correr 1x "void" e possivelmente correr varias vezes "loop"
      f_void
      f_loop

   unset v_list

}

function f_drya_fzf_MM {
   # FZF Main Menu (for DRYa)

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D .'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4="4. | Help"
      L3="3. | DRYa: Greet"
      L2="2. | Toolbox" 

      L1="1. Cancel" 

      L0='DRYa: `fzf` Main Menu: '

      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" >> $Lz4
      [[ $v_list =~ "4. " ]] && f_drya_help
      [[ $v_list =~ "3. " ]] && f_greet2
      [[ $v_list =~ "2. " ]] && f_drya_fzf_MM_Toolbox
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      #unset v_list
}

function f_instructions_of_usage {
   # Função para exibir como usar o script

   f_talk; echo "Instruções: Criar um link simbólico de <origem> para <destino>."
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
   f_talk; echo 'Também pode guardar o <origem> em uma variavel para não ter de escrever manualmente'
           echo ' > exemplo: `origem=$(pwd)`'
           echo ' >> `D sl $origem <novo-caminho-com-nome>`'
           echo
           echo ' > Com DRYa, pode guardar um caminho na variavel $h usando 5x .'
           echo ' >> ou seja: Navegar para origem e escrever `.....` para guardar h=$(pwd)'
           echo 
           echo ' >>> Resumindo: `D sl $h <nome-ou-caminho-com-nome>` para criar com DRYa um Soft-link de $h para $v'
           echo 
   f_talk; echo "Remover um link:"
           echo ' > Se for um diretorio: `unlink <diretorio-a-remover>`'
           echo ' > Se for um ficheiro:  `rm     <ficheiro-a-remover>`'
      exit 1
}


function f_exec {
   # When invalid args are given at the teminal: 
      #f_greet

   # It can be used for other function debugs also:
      # Comment/Uncomment to turn Off/On each to debug accordingly:

      #f_ascii_icon
      f_greet2
      #f_get_script_current_abs_path
      f_talk; echo "Invalid argument(s)"
              echo ' > for help: `drya -h`'
              echo

   # If no arg was given, also navigate do DRYa's repo directory
      # udev: in a script it is going there, but after the script finishes, the prompt comes back. (so, not working, it will not navigate in the end, needs to be fixed)
      cd ${v_REPOS_CENTER}/DRYa

}




# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------





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

   # Set Available time (in seconds) for Temporized quick menu
      v_secs=2

   # Info when no args are given
      f_talk; echo "is installed!"
              echo ' > Use: Terminal: `D --help` (for help)'
              echo ' > Use: fzf Menu: `D .`      (for main menu)'
              echo

   # Temporized Quick menu
      f_talk; echo -n "Temporized Menu"; f_c3; echo -n " (available for "; f_c5; echo -n "$v_secs"; f_c3; echo    " secs):"; f_rc
              echo    "       |"
              echo -n "       |_ To open MAIN fzf menu, press NOW: '"; f_c5; echo -n "d"; f_rc; echo -n "' or '"; f_c5; echo -n "."; f_rc; echo "'"
              echo -n '       |_ Equivalent Terminal commands: `'; f_c5; echo -n 'D .'; f_rc; echo '`' 

   
   # Options available during only few seconds
      f_talk; f_c5; echo -en "listening... "; f_rc

      read -sn1 -t $v_secs v_ans
      
      if [ -z $v_ans ]; then
         sleep 0.1
   
         # ANSII to go to beggining of line and clear endire line after cursor
            echo -ne "\r\033[K"

      elif [ $v_ans == "d" ] || [ $v_ans == "D" ] || [ $v_ans == "." ] || [ $v_ans == "+" ]; then
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

elif [ $1 == "activate" ] || [ $1 == "placeholder-off" ]; then  # Usado em aparelhos/dispositivos publicos
   # Ao instalar DRYa, fica autimaticamente ativo
   # Ao desativar DRYa com 'deactivate' fica possivel ativar novamente com 'activate'
   # Ativar serve para repor DRYa com todas as funcoes que tinha ao ser instalada

   f_greet

   echo "DRYa: activate"
   echo
   echo "uDev: Se nao existe nenhuma repo no dispositivo:"
   echo " > clonar DRYa do GitHub"

elif [ $1 == "deactivate" ] || [ $1 == "placeholder-on" ]; then
   # Apos insdalar DRYa, fica possivel desarivar com 'deactivate'
   # Serve para apagar tudo o que existe na pasta ~/Repositories incluindo DRYa, apagando tambem as configs na pasta ~ relativamente a DRYa e deixar no seu lugar um script que volta a clonar do Github 
   # Serve para usar em telemoveis ou dispositivos dos quais SeivaDArve na é o dono, tal como nos dispositivos do trabalho

   f_greet

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
   echo "uDev: Similar to: G v; source ~/.bashrc; apply all dot-files across the system"
   # uDev: Same as: `S Reload: DRYa + dot-files + Terminal`

   f_greet
   f_c4; echo -n "DRYa: "
   f_rc; echo "Downloading updates and applying them"
         cd ${v_REPOS_CENTER}/DRYa
   
   f_git_status
   f_git_pull

   echo

   # Aplly each dot-file in their correct places across the system
      f_talk; echo "applying dot-files:"
              echo " > .vimrc" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
              echo " > termux: colors + properties (uDev)"
              echo " > .gitconfig" && cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/git-github/.gitconfig ~
              echo " > init.el (uDev)"
              echo " > drya: .bash_logout file"
              echo

   # Reload .bashrc
      f_talk; echo "reloading functions, variables, alias at:"
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

elif [[ $1 == "wpwd" ]] || [[ $1 == "wPWD" ]]; then 
   # Convert text Windows Path into text Linux Path
   
   # Getting variables from the arguments, from the input
      v_arg2=$2

   f_win_to_linux_pwd

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

   echo "DRYa: seiva-up-time"
   echo
   echo "Seiva D'Arve iniciou estudos em Linux:"
   echo " > 2021-03-25"
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

   elif [[ $2 == "list-ready-and-uDev" ]] || [[ $2 == "list" ]]; then 
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



elif [ $1 == "install.uninstall" ] || [ $1 == "install" ] || [ $1 == "uninstall" ];  then 
   # Install DRYa and more stuff
   # Note: even when DRYa is not yet installed into ~/.bashrc but it is cloned to the machine, autocompletion already works for this command only `bash drya.sh install.uninstall` because the command name for the `fzf` menu is the same as the existent directory. But remember that `fzf` is a dependency and should be installed first


   if [[ -z $2 ]]; then 
      # If there are no args:

      # Lista de opcoes para o menu `fzf`
         Lz1='Save '; Lz2='D install'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L3='3. Install: DRYa (with `fzf`)'
         L2='2. Install: DRYa (with `select`)'; L2c='DRYa'  # `D install DRYa`
         L1='1. Cancel'

         L0="SELECIONE 1 Opcao: "
         
         v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
         [[ $v_list =~ "3. " ]] && echo uDev
         [[ $v_list =~ "2. " ]] && f_install_drya
         [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
         unset v_list

   elif [[ $2 == "--me" ]] || [ $2 == "DRYa" ] || [ $2 == "drya" ]; then 
      f_install_drya


   elif [[ $2 == "." ]]; then 
      vim ./install.uninstall/linux-or-WSL/master-bashrc/1-installer-fzf-alternative.sh


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


   elif [[ $2 == "upk-at-work" ]] || [[ $2 == "upk-tmp-phone" ]]; then 
      # Makes all dependencies for upk repo available
      # This might be used most likely at in-job phone

      f_quick_install_all_upk

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

   if [ $2 == "dot-files" ]; then 
         echo "drya: drya dot-files save"
         echo " > copy from default locations to drya repo"
   else
         echo "drya: What do you want to save? (uDev)"
   fi

elif [ $1 == "news" ]; then 
   # Runs a script inside DRYa directories that continuously rolls information
   bash ${v_REPOS_CENTER}/DRYa/all/bin/news-displayer/news-displayer.sh

elif [ $1 == "list-photoshop-edited-imgs" ] || [ $1 == "lsPSmeta" ]; then  # Na pasta atual, identifica todas as fotos editadas pelo Photoshop (com apoio do chatGPT)
   # uDev: Existem mais campos que mencionam 'Photoshop' sem ser so o campo '-Software', é necessario completar

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Extrai os metadados EXIF
          SOFTWARE=$(exiftool -Software "$i")
          
          # Verifica se o Software usado foi o Photoshop
          if [[ $SOFTWARE == *"Adobe Photoshop"* ]]; then
            echo "Imagem editada no Photoshop: $i"
          fi
        fi
      done

elif [ $1 == "clear-photoshop-editor-from-metadata-of-imgs" ] || [ $1 == "clrPSmeta" ]; then  # Na pasta atual, elimina os campos onde diz que a foto foi editada por algum software 
   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Remove o metadado do software da imagem
          #exiftool -Software= "$i"
          exiftool -all= "$i"
          echo "Metadado do software removido de: $i"
        fi
      done

elif [ $1 == "todo" ] || [ $1 == "t" ]; then  # Lista de tarefas
   echo "uDev: ToDo list: "
   echo "@ Android Notifications"
   echo "@ scratch-paper"
   echo "@ omni-log"
   echo "@ moedaz"
   echo "@ wikiD"
   echo "@ wikiD"
   echo "@ verbose-lines"

elif [ $1 == "list-all-file-metadata" ] || [ $1 == "lsmeta" ]; then  # mostra os seu metadados da imagem fornecida
   # Caminho para a imagem
      echo "Introduza o nome do ficheiro do qual quer ver os metadados"
      read -p " > " v_file

      exiftool "$v_file"

elif [ $1 == "list-all-dir-metadata" ] || [ $1 == "lsDirmeta" ]; then  # Junta todas as fotos do dir atual e mostra os seus metadados

   # Caminho para a pasta com as imagens
      FOLDER_PATH="."

   # Loop através dos arquivos na pasta
      for i in "$FOLDER_PATH"/*; do
        # Verifica se o arquivo é uma imagem (extensões .jpg, .jpeg, .png)
        if [[ $i == *.jpg || $i == *.jpeg || $i == *.png ]]; then
          # Listar todos os metadados da imagem
          exiftool "$i"
        fi
      done


elif [ $1 == "generate-photo-ID" ] || [ $1 == "gpID" ]; then  # Busca a data/hora atual de forma inconfundivel e adiciona o texto "Img-ID-xxxxxxxxxxxxxxxxx.jpg"
   echo "uDev: Idenfiticação de photos criando um nome com ID"
   # uDev: criar fx que busca TODO o sistema de pastas no Android apartir do termux para encontrar todos esses ID espalhados e enviar para a pasta desejada (local atual do cursor)

elif [ $1 == "soft-link" ] || [ $1 == "sl" ]; then 
   # uDev: criar também hard links para ficheiros e pastas
   
   f_greet

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

elif [ $1 == "calculo" ] || [ $1 == "calc" ] || [ $1 == "ca" ] || [ $1 == "calculator" ] || [ $1 == "clc" ] || [ $1 == "calculadora" ]; then
   # List of calculatores (some modified for Trading)

   if [ -z $2 ]; then 
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh

   elif [ $2 == "." ]; then 
      bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh .

   fi

elif [ $1 == "set-keyboard" ] || [ $1 == "kbd" ]; then 
   f_talk; echo "uDev: Options to set keyboard"
    
elif [ $1 == "set-timezone" ] || [ $1 == "timez" ]; then 
   f_talk; echo "uDev: Options to set timezone"
    
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

elif [ $1 == "no" ] || [ $1 == "note" ] || [ $1 == "notes" ]; then 
   bash ${v_REPOS_CENTER}/DRYa/all/bin/no-tes.sh
   
elif [ $1 == "noty" ] || [ $1 == "notify" ]; then 
   bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh

elif [ $1 == "QR" ] || [ $1 == "qr" ]; then 
   # Options for QR codes
   
   # uDev: 
   #       echo '`D QR-to-clone-drya` or `QR-clone` '
   #       echo " > uDev: Will present an image to the screen, other devices can scan it to retrieve it's text and run it on the terminal"

   function f_create_qr_from_text {
      f_greet
      f_talk; echo "Criar QR code: Insere o teu texto: "
              echo -n " > "
              read v_ans
              echo
              printf "$v_ans" | curl -F-=\<- qrenco.de/
   }

   function f_create_qr_from_file {
      f_greet
      f_talk; echo "Criar QR code: Insere o nome de um ficheiro: "
              echo -n " > "
              v_file=$(ls | fzf)
              echo $v_file
              echo
              v_ans=$(cat $v_file)
              curl qrenco.de/$v_ans
   }

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D QR'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L3='3. Criar QR code | Apartir de ficheiro'
      L2='2. Criar QR code | Apartir de texto'
      L1='1. Cancel'

      L0="SELECIONE 1 Opcao: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "3. " ]] && f_create_qr_from_file
      [[ $v_list =~ "2. " ]] && f_create_qr_from_text
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list



elif [ $1 == "p" ] || [ $1 == "presentation" ] || [ $1 == "logo" ]; then 
   # Presenting DRYa with ASCII text
   ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh || echo -e "DRYa: app availablei \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead

elif [ $1 == "create-windows-bootable-USB-cmd" ] || [ $1 == "cwusb" ]; then 
   #echo "uDev: Step-by-step guide to create a bootable USB at windows command prompt"

   function f_usb_tut_2 {  # uDev: rename to: _part_00
      clear
      figlet Windows USB
   }

   function f_example_0 {  # uDev: rename to: _part_0
      echo "Procedimento para o PC reconhecer o HD"
      echo " > Também resolve HD retirado de XBOX ONE, DVR, etc..."
      echo 
      echo "Para navegar no tutorial:"
      echo " > Tecla 'S' para o passo Seguinte"
      echo " > Tecla 'A' para o passo Anterior"
      echo 
   }

   function f_example_1 {  # uDev: rename to: _part_1
            echo
      f_c1; echo    '(exemplo)'
            echo    '|--------------------------------------------------------------|'
            echo    '| Microsoft Windows [Version 10.0.22631.44.60                  |'
            echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
            echo    '|                                                              |'
            echo -n '| C:\>'
      f_c2; echo -n       'diskpart'
      f_c1; echo                  '                                                 |'
      f_c1; echo    '|                                                              |'
            echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
            echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
            echo    '|                                                              |'
            echo    '| DISKPART>'
      f_c1; echo    '|--------------------------------------------------------------|'
      f_rc; echo
   }

   function f_example_ask {
      read -n 1 -p "Press [ENTER]"
   }


   # Greet the user
      f_usb_tut_2
      f_example_0 
      f_example_ask

   # Passo 1
      # 1- No Prompt digite DISKPART, quando ele abrir aparecera escrito DISKPART a esquerda

      f_usb_tut_2
   
      echo "Passo 1: "
      echo "  No prompt digite DISKPART, quando ele abrir aparecerá escrito DISKPART a esquerda"

      f_example_1
      f_example_ask

   # Passo 2:
      # Passo 2: Digite LIST DISK, esse comando ira listar is HD's instalados na maquina, preste muita atencao para nao escolher o HD errado
      f_usb_tut_2

               echo    "Passo 2:"
               echo    "  Digite LIST DISK, esse comando ira listar os HD's instalados na maquina"
               echo
         f_c1; echo    '(exemplo)'
               echo    '|--------------------------------------------------------------|'
               echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
               echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
               echo    '|                                                              |'
               echo -n '| C:\>'
         f_c2; echo -n       'diskpart'
         f_c1; echo                  '                                                 |'
         f_c1; echo    '|                                                              |'
               echo    '| Microsoft DiskPart version 10.0.22621.1                      |'
               echo    '|                                                              |'
               echo    '| Copyright (C) Microsoft Corporation.                         |'
               echo    '| On computer: YourName                                        |'
               echo    '|                                                              |'
               echo -n '| DISKPART>'
         f_c2; echo -n            'list disk'
         f_c1; echo    '                                           |'
               echo    '|                                                              |'
               echo    '| Disk ###  Status         Size     Free     Dyn  Gpt          |'
               echo    '| --------  -------------  -------  -------  ---  ---          |'
               echo    '| Disk 0    Online          476 GB      0 B        *           |'
               echo    '| Disk 1    Online           59 GB    29 MB                    |'
               echo    '|                                                              |'
               echo    '| DISKPART>                                                    |'
               echo    '|--------------------------------------------------------------|'
         f_rc; echo

      f_example_ask

   # Passo 3:
      # 3-  Digite SELECT DISK "X", no lugar do X colocar o numero referente ao HD que deseja formatar, colocar sem aspas.
      f_usb_tut_2


      function f_cwusb_passo_3 {
              echo    "Passo 3:"
              echo -n '  Digite "SELECT DISK '
        f_c2; echo -n                       'X'
        f_rc; echo                           '", mas no lugar do X colocar o numero'
              echo    '  referente ao HD que deseja formatar, colocar sem aspas.'
              echo    "  Preste muita atençao para nao escolher o HD errado"
              echo
        f_c1; echo    '(exemplo)'
              echo    '|--------------------------------------------------------------|'
              echo    '| Microsoft Windows [Version 10.0.22631.44.60]                 |'
              echo    '| (c) Microsoft Corporation. Todos os direitos Reservados.     |'    
              echo    '|                                                              |'
              echo -n '| C:\>'
        f_c2; echo -n       'diskpart'
        f_c1; echo                  '                                                 |'
              echo    '|                                                              |'
              echo    '| Microsoft DiskPart version 10.0.22621.1                      |'
              echo    '|                                                              |'
              echo    '| Copyright (C) Microsoft Corporation.                         |'
              echo    '| On computer: YourName                                        |'
              echo    '|                                                              |'
              echo -n '| DISKPART>'
        f_c2; echo -n            'list disk'
        f_c1; echo                        '                                           |'
              echo    '|                                                              |'
              echo    '| Disk ###  Status         Size     Free     Dyn  Gpt          |'
              echo    '| --------  -------------  -------  -------  ---  ---          |'
              echo    '| Disk 0    Online          476 GB      0 B        *           |'
              echo    '| Disk 1    Online           59 GB    29 MB                    |'
              echo    '|                                                              |'
      }

      f_cwusb_passo_3

              echo    '| DISKPART>                                                    |'
              echo    '|--------------------------------------------------------------|'
        f_rc; echo
        f_c4; echo    ' No seu PC, qual é o numero do disco do HD que vai selecionar?  '
        f_c1; echo -n '  DISKPART>'
        f_c2; echo -n            'select disk '


      function f_cwusb_passo_3_final {
              echo -n '| DISKPART>'
        f_c2; echo               "$v_disk"
        f_c1; echo    '|--------------------------------------------------------------|'
      }

            

            read v_disk
      f_rc; echo
      f_c4; echo -n " Confirme se vai selecionar o disco "
      f_c2; echo    "$v_disk"
      f_rc; echo    '  > "S" sim; "N" nao'
            echo -n '  > '
            read v_ans

         v_disk="select disk $v_disk"

         [[ $v_ans == "s" ]] || [[ $v_ans == "S" ]] && clear && f_usb_tut_2 && f_cwusb_passo_3 && f_cwusb_passo_3_final
         [[ $v_ans == "n" ]] || [[ $v_ans == "N" ]] && echo -e "\nOperacao cancelada: a Sair"; exit 
         echo

      f_rc
      f_example_ask

   #  4-  CLEAN
   #  5-  CREATE PARTITION PRIMARY
   #  6-  SELECT PARTITION 1
   #  7-  ACTIVE
   #  8-  FORMAT FS=NTFS QUICK ou FORMAT FS=FAT QUICK
   #      (FAT para cartoes de memoria, pendrives, HDs externos e outros dispositivos).
   #  9-  ASSIGN
   #  10- EXIT

elif [ $1 == "wiki" ]; then 
   # Menu to edit locally, visualize in the browser, etc...
   
   f_talk; echo "Opening: wikiD.org"
           echo " > uDev: Create menu for browser visualization"

   # uDev: Test fist if repo exists
   
   cd ${v_REPOS_CENTER}/wikiD/ && emacs wikiD.org

elif [ $1 == "morse" ]; then 
   less ${v_REPOS_CENTER}/wikiD/all/morse-diagrams/morse-letters-diagram.txt

elif [ $1 == "k" ]; then 
   echo 'uDev: fzf menu for entire keyboard'
   echo '      Used when keyboard configs are unsolved'
   read -sn1 -p " > Press enter "
   clear
   cat ${v_REPOS_CENTER}/DRYa/all/bin/fzf-keyboard-alterbative/keys-list.txt | fzf --header "Live text here: ..."

elif [ $1 == ".." ]; then  
   # After using any fzf menu and choosen to click on the `command` given there, a variable is saved on the environment. So `D ..` can go directly to that menu
   
   ### Estas fx com o ficheiro de historico $v_drya_fzf_menu_hist vao ser descontinuadas para se passar a usar `history -s "command"` que coloca no historico do bash o texto que quisermos
   #
   #    # Acess history of visited menus
   #       echo "Cancel" >> $v_drya_fzf_menu_hist
   #       v_list=$(cat "$v_drya_fzf_menu_hist" | fzf --tac --cycle --prompt="DRYa: SELECT 1 to repeat from: fzf sub-menus History: ")
   #  
   #    # Attempt to run such menu
   #       [[ $v_list != "Cancel" ]] && echo "$v_list" | sed 's/`//g'
   #       [[ $v_list =~ "Cancel" ]] && echo "Canceled"
   #  
   #    # Remove all text 'Cancel' from the previous file
   #       sed -i "/Cancel/d" $v_drya_fzf_menu_hist

   f_talk; echo '$v_drya_fzf_menu_hist sera agora substituido por `history -s "<comando>"`'
           echo

elif [[ $1 == "." ]] || [[ $1 == "+" ]] || [[ $1 == "d" ]] || [[ $1 == "D" ]]; then  
   # Open DRYa fzf Main Menu
   # uDev: If fzf is not installed, imediatly do it, no questions!

   f_drya_fzf_MM

elif [[ $1 == "," ]]; then  
   # Open DRYa fzf toolbox directly

   f_drya_fzf_MM_Toolbox

else 
   # When invalid arguments are given. (May also be used to debug functions)
   f_exec
fi


