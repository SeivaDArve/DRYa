#!/bin/bash
# Title: fluNav (fluent navigation)
# uDev: insert: nppn-looper + '. ?' commands
#
# uDev: Why not a tput menu for each? (better than select menu)

# uDev: This app should NOT have 3 prefixes: M F and D
#       Instead: use only: .
#       But if some reason it does not work, try F (file) and P (place)


# ---------------------------------
# uDev list                          {
# ---------------------------------

#    '. '       ## ls
#    '. mo'     ## cd moedaz
#    '. D'      ## cd DRYa
#    '. n'      ## next dir forward  (from NPNP looper)
#    '.. n'     ## next dir backward (from NPNP looper)
#    '. s'      ## save current dir  (from NPNP looper)
#    '.. s'     ## del current dir   (from NPNP looper)
#    '. e'      ## set default text editor and sends to .dryaRC
#    'op file.org' detect current emacs (instead of EM, Em, em)



# Leters to be used:
#     function F
#     function M
#     function PNpn
#     function E
#     function S      # To sync files (uDev: Replace with F?)
#     function .
#     function ..
#     function ...
#     function ....
#     Forbiden function: Function D   ##   Reserved for DRYa

# ---------------------------------
# uDev list                          }
# ---------------------------------

function f_cor5 {
   tput setaf 6
}

function f_done {
   f_cor5; echo ": Done!"
   f_resetCor
}

function f_greet { 
   # Avoiding repetition
   clear
   figlet fluNav
}

function f_mF { 
   # Avoiding repetition
   clear
   figlet fluNav File
}

function f_mD { 
   # Avoiding repetition
   clear
   figlet fluNav Dir
}

function f_mM { 
   # Avoiding repetition
   clear
   figlet fluNav Menu
}

function f_presenting_DF {
   # presenting the file for our M fluNav:
      clear; 
      figlet "fluNav"
      echo -e "File closed (after editions):\n > $v_init_file \n"
}

function f_horiz_line {
   # Using the in-built horizontal line from DRYa
   echo $v_line
}

function f_asking_to_apply_init {
   # Ask if the user wants the changes to apply to this machine imediatly
      # If not, the user has to use this command again afterwards
      # unless the user want to do it manually
      
      echo "Do you want to apply these changes NOW?"
      echo " > If not, you may run this command againg later"
      echo "   or apply manually"
      echo 
      read -s -n 1 -p "Please enter Y/N (yes/no): " v_apply
}   

function f_applying_changes_init {

   # This is for Linux:
      # Copy recursively all files about emacs to the localized machine-specific directory:
         echo "DRYa: copying recursively: "
         echo -n " > Sending \"centralized emacs files\" to \"~/.emacs.d\"" && \
            cp -r ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/* ~/.emacs.d/  && f_done
      
      # We want to use "~/.emacs.d" instead of "~/.emacs". Because it can create initialization bugs, we remove the first one.
         echo -n " > Removing: \"~/.emacs\" (avoiding bugs)" && \
            rm ~/.emacs 2>/dev/null; f_done

   # If we are on windows, the init file should also be somewhere at: %appdata%
      # Finding right directories:
         v_correct_win_dir="/mnt/c/Users/Dv-User/AppData/Roaming/.emacs.d"
         v_bugged_win_dir_to_del="/mnt/c/Users/Dv-User/AppData/Roaming/.emacs"

      if [ -d $v_correct_win_dir  ]; then
         # If the v_correct_win_dir exists, set it up too:
            echo -e "\nDRYa: Windows detected, adjusting: "

         # Copy files and directories recursively for the directory that emacs prefers on windows
            echo " > %AppData% exists, copying emacs files there too recursively"
               cp -r ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/* $v_correct_win_dir
            echo -n "   > copied to: \"$v_correct_win_dir\"" && f_done
         
         # Removing the extra file/directory that can create initialization issues
            echo " > Removing: $v_bugged_win_dir_to_del (avoiding bugs)"
               rm $v_bugged_win_dir_to_del 2>/dev/null && f_done

      fi
}

function f_manage_init_and_libraries_after_mod {
   # This function is used by several select_menus: "emacs-init (emacs)" and "emacs-init (vim)"
   # Has a function of presentation
   # Has a function of prompting the user wether or not to apply the last changes

   # After defining all 3 last functions (f_presenting_DF f_applying_changes_init f_asking_to_apply_init), let's assemble them:
      f_presenting_DF

   # Asking if the user really want apply changes (with: f_applying_changes_init)
      f_asking_to_apply_init
   
      if [ $v_apply == "y" ] || [ $v_apply == "Y" ]; then echo -e "\rYour choice was Yes: Do apply\n"; f_applying_changes_init; 
      elif [ $v_apply == "n" ] || [ $v_apply == "N" ]; then echo "\rYour choise was No: Do not apply"; 
      else echo "Answers do not match, doing nothing for now. You can run the command again later";
      fi
}

function f_emacs_init_vim {
   # Important: fluNav depends on this function
   # This edits the init file ALWAYS on the repo 'drya' first and THEN copies to ~
   # This way we know we can easily upload the file

   # First we edit the original/centralized file with our favourite text editor
      v_init_file="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/init.el"
      vim $v_init_file 

   # After edition, independently of the text editor (read Note*1), some changes are same. Therefore, to
   # avoid duplication, we create a function to keep it simple and avoid spaghetti code
      f_manage_init_and_libraries_after_mod

      # Note*1: In this fluNav there are 2 options that choose 2 text editors (vim and emacs) 
      #         to call the same function "f_manage_init_and_libraries_after_mod"
}

function f_edit_self {
      clear
      figlet fluNav 
      echo "Editing/Opening: fluNav original file"
      echo " > Parent repo: DRYa"
      echo
      echo
      echo "-------- info --------"
      echo "Outdated: opening REPOS CENTER with: '. .'"
      echo " > Updated: '. G' to navigate there"
      echo 
      echo "To open fluNav (catalogue of all sync files):"
      echo " > Function: F ."
      echo " > Function: . ."
      echo "----------------------"
      echo
      echo
      echo "Press any key to continue"
      echo " > To open fluNav.sh in vim editor" 
      read -s -n 1 -p " "
      vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/fluNav.sh

      clear
      figlet fluNav 
      echo "Edited/Closed: fluNav original file"
      echo
      echo "Do you want to refresh the terminal to apply the changes?"
      echo " > uDev (it will be alias: 'F 5')"
      echo " > Press any key to continue"
      echo " > (Or wait 5 secs to abort)"
      read -s -n 1 -t 5

      f_up 

}

function f_sync_ez_b4_after {
   # Sync with ezGIT Before and After the file is opened

      cd ${v_REPOS_CENTER}/$v_parent && \

      echo 
      echo "Will be syncronized only with ezGIT"
      echo " > Before + After edition"
      echo
      echo "Do you want to continue? (Press any key)"
      echo " > Press Ctrl-C to land on its dir only"
      read -s -n 1

      G v && \
      EM $v_file && \
      G ++ b
      echo
      echo Done!
}

function f_action {
   # When we use any F at the terminal prompt, the $1 arg is going to be evaluated here
 
   if [ $v_nm == "test" ]; then
      clear
      figlet fluNav 
      f_down
      echo "$v_nm: Testing fluNav"
   
   elif [ $v_nm == "car" ]; then
      clear
      figlet fluNav 
      #f_down
      echo "$v_nm: Editing 1 or + files from .../moedaz/viatura/..."
   
   elif [ $v_nm == "self" ]; then
      f_edit_self

   elif [ $v_nm == "trade" ]; then
      clear
      figlet fluNav 
      echo "$v_nm being edited"

      v_file="all/trade.org"
      v_parent="moedaz"

      echo " > Alias: 'F trade'"
      echo " > Syncronization available: ezGIT (pull + Push all with random comment)"
      echo 
      echo "Parent repo: moedaz"
      echo "Other alias: 'trade' (no sync)"
      echo 

      f_sync_ez_b4_after

   elif [ $v_nm == "om" ]; then

      # Variables to use on next function (to sync)
         v_file="omni-log.org"
         v_parent="omni-log"
         #v_editor= Em || Vim

      clear
      figlet fluNav 
      echo "$v_nm being edited (file: omni-log.org)"
      echo " > Alias: 'F om' (sync)"
      echo
      echo "Parent repo: omni-log"
      echo "Other alias: 'om' (no sync)"
      echo 
      echo " > Syncronization available: "
      echo "   ezGIT (pull + Push all with random comment)"
      echo 

      f_sync_ez_b4_after

   elif [ $v_nm == "foo" ]; then
      echo bar
   fi

   # To download updates:
      #f_down
}

function f_down {
   # To download updates:
   echo "uDev: Download from github (before opening file)"
   echo " > Code-Name of file to sync: $v_nm"
   bash ${v_REPOS_CENTER}/ezGIT/ezGIT.sh count^
}

function f_up {
   echo 
   echo "uDev: Upload to github (after closing file)"
}







# ---------------------------------
# Brought by config-bash-alias       {
# ---------------------------------



function . {
   # Navigate through the file system stupidly ez
   
   # uDev: Include 'function d' to give 'favs' if directory is not found

      if [ -z $1 ]; then 
         # If no argument is given, lists storage (ls command)
         ls 

      elif [ $1 == "." ]; then 
         f_edit_self

      elif [ $1 == "G" ]; then 
         # If arg 1 is 'G' then navigate to the center of seiva's repos
         cd $v_REPOS_CENTER
         # uDev: this command '. .' is usually issued at thr beggining of the day when the user is going to start the coding session. Therefore: Echo once a day to REMEMBER to git pull
   
      elif [ $1 == "?" ]; then 
         # Describe all these navigation alias
         echo "'. ?' Shows this help menu" 
         echo ".  1x Means: ls"
         echo "..  2x Means: cd .."
         echo "...  3x Means: cd -"
         echo "....  4x Means: pwd"
         echo ".....  5x Means: save this dir location in var \$h"
         echo "......  6x Means: save previous dir location in var \$v"
         echo ".......  7x Means: remember last 2 variables set as \$h and \$v"

      elif [ ! -z $1 ]; then
         # If argument is given and it is a dir, cd into it, otherwise if it a file, edit it
         cd $1 || vim $1
      fi
}

#alias .="ls"  ## Replaced by the 'function . { }' and the 'function D { }'
alias ..="cd .."
alias ...="cd -"

function .... {
   echo 'Current location $(pwd)'
   echo " > $(pwd)"
}

function ..... {
   # Saves current directory location 
   # uDev: If script npNP gets finished, this one function gets useless. Finish that
   h=$(pwd)
   echo 'Current location $(pwd) saved as variable $h'
   echo " > $(pwd)"
}
function ...... {
   # This function is usefull when you want to move files to the previous directory
      # 1 - Move to the destination you want to past the files
      # 2 - Move to the origin of the files in one command using absolute path (where they are currently)
      # 3 - press: .....
      # Use command: mv <file1> <file2> <file3> $v
   # uDev: If script npNP gets finished, this one function gets useless. Finish that
   cd -   1>/dev/null   
   v=$(pwd)
   cd -   1>/dev/null   
   echo 'Last directory $(pwd) saved as variable: $v'
   echo " > $v"
}
function ....... {

   echo 'Variable $h saved as:'
   echo " > $h"
   echo
   echo 'Variable $v saved as:'
   echo " > $v"
}


function E {
   select i in Nano Vim Emacs; do 
      case $i in 
         Nano)
	         if [ $i == "1" ]; then alias e="nano"; fi
         ;;
         Vim)
            if [ $i == "2" ]; then alias e="vim"; fi
         ;;
         Emacs)
            if [ $i == "3" ]; then alias e="emacs"; fi
         ;;
         *)
            echo lol
         ;;
      esac
   done
	
}


function hkllhcf {
   # (Trasido do config-bash-alias para casar com este ficheiro fluNav)
   # If if you invoke "cdl" and no dir exists
   if [ ! -d "./$1" ]; then
      
      # A function that is needed to be prepared in case later on the code it is called:
      function f_cdl_mkdir {
         # Generate a random number to be used as a key to delete our previous directory if it was  reated by mistake
         declare v_random=$RANDOM

         # If a new directory is to be created, verbose descriptions will happen
         echo -n " > That directory "
         tput setaf 4
         echo -n $1
         tput sgr0
         echo " was not existent"
         echo "  > Therefore was created"
         echo -n "  > Delete it by executing "
         tput setaf 4
         echo $v_random
         tput sgr0
      }

      declare cur_dir=$1
      mkdir -p $1 
      f_cdl_mkdir
      cd $1
      ls

   else
      # If you invoke "cdl" and dir exists
      cd $1
      ls
      echo "normal run"
   fi
}

# Alias morse-code-style
   # Dot="morse ."
   # Dash="morse ,"
   # word="morse ..., ,.., .,,"

function npNP-dir-looper {
   # Title: next-previous-Negative-Positive
   # (looper app) Save a loop of directories:
      alias P="Positive dir"  #uDev: Adds current dir to loop
      alias N="Negative dir"  #uDev: Removes current dir from loop
      alias p="previous dir"  #uDev: Swap to previous dir present in the loop 
      alias n="next dir"      #uDev: Swap to next dir present in the loop
      alias PP="list all stored locations as other apps list buffers"
      alias NN="Prompt the user if he wants to delete the entire list of locations"
      # when adding arguments:
         # Using a number as an argument like: '$ np 1' makes you travel the the location listed first
         # Using - or + to swap priority of the location listed in the list (example: '$ np +' and '$ np -)

      # np | pn | Np | Pn) list all dirs and current one
      function P {
         mkdir -p ~/.config/h.h/nPpN-dir-looper
         pwd >> ~/.config/h.h/nPpN-dir-looper/nPpN-list.txt
          
      }

      # Curiosity: by typing '$ man termux' you can see that by coincidence and also by luck, termux uses the volume key <Up> to perform control over the terminal and over the smartphone.
         # Two of those Volume Up shorcut control are:
         # 'Volume key Up + P': Page Up
         # 'Volume key Up + N': Page Down
         # To make it even better, remember that the command ZZ in Vim, puts the current line at the middle of the screen.
            # These 3 commands allow you to see before, after and around your current line in the current file
}  ## end of function: npNP-dir-looper











# ---------------------------------
# Brought by config-bash-alias       }
# ---------------------------------












function M {
   # Function: "Directory"
   
   # uDev: why is it that D is not reserved for 'alias D="drya"'? 
      # sugestion: fluNav will be under F so that D gets to be reserved for drya

   # uDev: Se for WSL3, detetar endereços: "C:\Users\$USER\Documents"

   # Description: 
      # This function is a combination of:
         # '$ cd'
         # '$ ls'
         # + alias
         # It finds directories
         # uDev: to find and edite files, function f needes to be created and needs to ask for the default text editor

   # Dependencies: figlet, file
      # Install it by typing:
      # '$ pkg install figlet'
      # '$ pkg install file'

   # Usage:
      # Use 1: '$ D             # Complains that there is no destination specified
      # Use 2: '$ D drya        # Travels to favorites  # uDev: to be absorved by the 'function . { }'
      # Use 3: '$ D -p <dir>    # Create new dir and travel to it
      # Use 4: '$ D -r <dir>    # finds and lists a dir to remove (use -R to confirm yout choice)
      # Use 5: '$ D -R <dir>    # Removes dir (recommended to confirm which dir will be removed with the option -r)
      # Use 6: '$ D ..          # Go to parent dir and ls
      # Use 7: '$ D <dir>       # Go to existent dir

   # Implementation of Use 1:
   if [ -z $1 ]; then 
      f_cor1
      figlet "fluNav"
      f_resetCor
      echo " > No arguments. Choose some place to go to"

   # Implementation of Use 2:
   elif [ $1 == "drya" ] || [ $1 == "dry" ] || [ $1 == "d" ] || [ $1 == "D" ]; then
      cd ${v_REPOS_CENTER}/DRYa && ls
   
   # Implementation of Use 2:
   elif [ $1 == "moedaz" ] || [ $1 == "mo" ] ; then
      cd ${v_REPOS_CENTER}/moedaz && ls
   
   # Implementation of Use 2:
   elif [ $1 == "ezGIT" ] || [ $1 == "G" ] || [ $1 == "ez" ] || [ $1 == "g" ]; then
      cd ${v_REPOS_CENTER}/ezGIT && ls
      
   # Implementation of Use 2:
   elif [ $1 == "dwiki" ] || [ $1 == "wiki" ] || [ $1 = "dw" ] || [ $1 == "w" ]; then
      cd ${v_REPOS_CENTER}/dWiki && ls
      
   # Implementation of Use 2:
   elif [ $1 == "upk" ]; then
      cd ${v_REPOS_CENTER}/upK && ls
      
   # Implementation of Use 2:
   elif [ $1 == "upk-dv" ] || [ $1 == "upkd" ] || [ $1 == "upk-" ]; then
      cd ${v_REPOS_CENTER}/upK-diario-Dv && clear && figlet fluNav && echo -e "Command used: upk-dv\n" && ls
      
   # Implementation of Use 2:
   elif [[ $1 == "ss" ]] || [ $1 == "112" ]; then
      cd ${v_REPOS_CENTER}/112-Shiva-Sutras && ls
      
   # Implementation of Use 2:
   elif [[ $1 == "omni" ]] || [[ $1 == "log" ]] || [[ $1 == "om" ]]; then
      cd ${v_REPOS_CENTER}/omni-log && ls
      
   # Implementation of Use 2:
   elif [[ $1 == "gps" ]]; then
      cd ${v_REPOS_CENTER}/mastering-GPS && ls
      
   # Implementation of Use 2:
   elif [[ $1 == "yoga" ]] || [ $1 == "yogab" ] || [ $1 == "yg" ]; then
      cd ${v_REPOS_CENTER}/yogaBashApp && ls
      
   # Implementation of Use 2:
   elif [[ $1 == "shamb" ]]; then
      cd ${v_REPOS_CENTER}/yogaBashApp/all/all-shambavi/ && ls
      
   # Implementation of Use 2:
   elif [ $1 == "tmp" ]; then
      mkdir -p ~/.tmp
      cd ~/.tmp/ && ls

   # Implementation of Use 2:
   elif [ $1 == "code" ]; then
      mkdir -p ~/.code
      cd ~/.code/ && ls

   # Implementation of Use 2:
   elif [ $1 == "center" ]; then
      cd ${v_REPOS_CENTER} && ls

   # Implementation of Use 2:
   elif [[ $1 == "scratch" ]] || [ $1 == "paper" ] || [ $1 = "sc" ]; then
      cd ${v_REPOS_CENTER}/scratch-paper && ls

   # Implementation of Use 2:
   elif [ $1 == "dota" ]; then
      cd ${v_REPOS_CENTER}/Dota-2-guide && ls

   # Implementation of Use 2:
   elif [ $1 == "lx" ]; then
      cd ${v_REPOS_CENTER}/luxam && ls

   # Implementation of Use 2:
   elif [ $1 == "m" ]; then

      case $2 in
         0) # Travel to Internal storage
            # uDev: clear; pwd; echo "you are in X dir"
            echo "Internal storage"
            pwd
            echo

            f_greet
            echo "Internal Storage"
            f_horiz_line

            cd /sdcard && ls
         ;;
         1) # Travel to SD Card storage

            v_place_2=/storage/0123-4567
            v_place_3=/storage/

            f_greet

            echo "SD card storage"
            echo
            echo "Termux cannot WRITE to SD card,"
            echo "but can READ and RUN bash scripts from it"
            echo "If you have a huge database to store into SD external"
            echo "instead of internal, copy it to 'd -m 0' (internal storage) and with your"
            echo "file explorer, MOVE it to the SD card"
            echo

            echo "Listing: $v_place_2"
            echo "Listing: $v_place_3"
            echo

            echo "SD card Storage"
            f_horiz_line

            cd $v_place_2 && ls
            f_horiz_line
            cd $v_place_3 && ls

         ;;
         2) # Travel to USB storage
            echo "USB Storage"
            pwd
            echo

            f_greet
            echo "USB Storage"
            f_horiz_line

            cd /storage/83DB-10EA && ls || cd /storage && ls
         ;;
         3) # Travel to the dir where many USB storages are mounted
            echo "List of options for: USB storage"
            pwd
            echo

            f_greet
            echo "Listing possible USB plugged in"
            f_horiz_line

            cd /storage && ls
         ;;
         4) # Travel to the dir where many USB storages are mounted
            clear
            echo "Termux cannot WRITE to SD card,"
            echo "but can READ and RUN bash scripts from it"
            echo "If you have a huge database to store into SD external"
            echo "instead of internal, copy it to 'd -m 0' (internal storage) and with your"
            echo "file explorer, MOVE it to the SD card"
            echo

            f_greet
            echo "SD card Storage"
            f_horiz_line

            echo "Do you need directories to be created in order to MOVE"
            echo "internal things to external SD?"
            echo 
            echo "If you want a directory called \"Repositories\" in both"
            echo "External and Internal storage, press ENTER 3x"
            echo "(or cancel with CTRL + C)"
            echo
            echo "#uDev: create an option to ask for custom dir name"
            echo "(default is /storage/Repositories"
            read
            read
            read

         ;;
         b) 
            # Travel to dir at Internal storage called Termux-bridge-Android

            f_greet
            echo "Directory: Internal Storage: Termux-bridge-Android"
            f_horiz_line

            cd /sdcard/Termux-bridge-Android && ls
         ;;
         *)
            echo "How to use:"
            echo "$ M m [0|1|2|3|4|b]"
            echo '0) # Travel to Internal storage'
            echo '1) # Travel to SD Card storage'
            echo '2) # Travel to USB storage'
            echo '3) # Travel to the dir where many USB storages are mounted'
            echo 'b) # Travel to \"Internal storage/Termux-bridge-Android/\"'
	    #uDev: May be needed termux-setup-storage to access some directories
         ;;
      esac

   # Implementation of Use 3:
   elif [ $1 == "-p" ]; then
      mkdir -p $2
      cd $2
      ls

   # Implementation of Use 4:
   elif [ $1 == "-r" ]; then
      ls $2

   # Implementation of Use 5:
   elif [ $1 == "-R" ]; then
      rm -rf $2
      ls
      
      # uDev: privide more safety

   # Implementation of Use 6:
   elif [ $1 == ".." ]; then
      cd ..
      ls

      # uDev: add a $2 to insert a number. That number is thr number of time '$ cd ..' will be executed

   # Implementation of Use 7:
   else 
      # mkdir -p ~/.tmp
      # ls > ~/.tmp/found.txt
      # grep -n "$1" ~/.tmp/found
      # wc -l ~/.tmp/found

      v_found=$(ls | grep $1)
      echo Found: $v_found
      if [[ $? == "0" ]]; then
         cd $v_found && ls
      fi
      #uDev: use to command '$ file' to exclude all non directories
      #uDev: when there are 2 or more items found, allow the user to input a number as $2
   fi
}




# List fav files for edition (fluNav)
   function F {
   # uDev: letra S é melhor para ABRIR ficheiros com SYNC
   #       letra . para abrir ficheiros sem sync

      
      function f_uDev_1 {
         # Function to remind the user about needed changes (uDev)
         echo -e "\n# uDev: all options MUST edit files inside DRYa repo (for easy upload) and then copy those files across the system"
      }

      # Reload the amount of '-' are needed to create an horizontal line
         source ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/f_horizontal_line.sh 1>/dev/null

      # Note: each function in this app will define new values for example to "alias 1", "alias 2", "alias 3"...
         alias 1="echo Default alias 1"

      function f_unalias_all {
         # Each time we run function 'F' unset all previous alias that may be set again by 'F'
            #unalias 0  ## Will be used to unalias all
            unalias 1
            unalias 2
            unalias 3
            unalias 4
            unalias 5
            unalias 6
            unalias 7
            unalias 8
            unalias 9
            unalias 10
            unalias 11
            unalias 12
      }
      alias 0="f_unalias_all"

      #f_unalias_all
            
      #uDev: Turn these variables into usable arguments for fluNav
         #   Play with alias
         #   F 4 2 1
            # If !-z then for i in $@; do bash $i
            # a cada 'bash $i' novos alias sao RE-definidos
            # function 1 { 
            #    alias 1="do something"
            # }

         alias F1="uDev: will be used to list of cheat sheets (from Dwiki)"
         #alias F2
         #alias F3
         #alias F4="f_F4"
         #alias F5="source ~/.bashrc and init.el (refresh)"
         #alias F6

         #function f_F4 {
         #   alias 4="f_F4_4"
         #}
         

      # If there are no arguments, present the fluNav
         if [ -z $1 ]; then

            clear
            figlet fluNav

            echo "SELECT file to edit by Title"
            echo


            # Change the prompt message:
               PS3="Select a file to edit: "
               COLUMNS=0

               select opt in $v_line2 config-bash-alias notes source-all-drya-files Refresh-Reload-Source source-all-moedaz-files .bashrc .vimrc "com.list-econ-items.txt" com.associative-array 1st "emacs-init (emacs)" "emacs-init (vim)" secundary-files termux.properties help quit $v_line2; do

               case $opt in
                  config-bash-alias)
                     vim ${v_REPOS_CENTER}/DRYa/all/etc/config-bash-alias
                     f_greet
                     echo "edited: config-bash-alias"
                     break
                  ;;
                  notes)
                     f_greet
                     f_notes
                     break
                  ;;
                  source-all-drya-files)
                     vim ${v_REPOS_CENTER}/DRYa/all/source-all-drya-files
                     f_greet
                     echo "edited: source-all-drya-files"
                     break
                  ;;
                  .bashrc)
                     vim ~/.bashrc
                     f_greet  
                     echo "edited: ~/.bashrc"; f_uDev_1
                     break
                  ;;
                  source-all-moedaz-files)
                     f_greet
                     vim ${v_REPOS_CENTER}/moedaz/all/source-all-moedaz-files
                     echo "edited: source-all-moedaz-files"
                     break
                  ;;
                  com.list-econ-items.txt)
                     vim ${v_REPOS_CENTER}/moedaz/all/var/com.list-econ-items.txt
                     f_greet
                     echo "edited: com.list-econ-items.txt"
                     break
                  ;;
                  com.associative-array)
                     vim ${v_REPOS_CENTER}/moedaz/all/var/com.associative-array
                     break
                  ;;
                  .vimrc)
                     vim ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc
                     f_greet
                     echo "edited: .vimrc on DRYa"
                     cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
                     echo "copied: from DRYa to ~"
                     break
                  ;;
                  Refresh-Reload-Source)
                     #clear
                     source ~/.bashrc
                     f_greet
                     drya update
                     echo "Reload done to: ~/.bashrc by fluNav"
                     # uDev: Fazer reset tambem ao init.el
                     break
                  ;;
                  1st)
                     f_greet
                     echo "Editing the list of 1st apps to install"
                     read -s -t 2
                     vim ${v_REPOS_CENTER}/DRYa/all/bin/populate-machines/level+1/1st
                     f_greet
                     echo "edited: 1st"
                     break
                  ;;
                  "emacs-init (emacs)")
                     # This edits the init file ALWAYS on the repo 'drya' first and THEN copies to ~
                     # This way we know we can easily upload the file
                        
                        # First we edit the original/centralized file with our favourite text editor
                           v_init_file="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/init.el"
                           emacs $v_init_file 

                        # After edition, independently of the text editor (read Note*1), some changes are same. Therefore, to
                        # avoid duplication, we create a function to keep it simple and avoid spaghetti code
                           f_manage_init_and_libraries_after_mod

                           # Note*1: In this fluNav there are 2 options that choose 2 text editors (vim and emacs) 
                           #         to call the same function "f_manage_init_and_libraries_after_mod"

                     break
                  ;;
                  "emacs-init (vim)")
                     f_emacs_init_vim
                     break
                  ;;
                  secundary-files)
                     f_greet
                     echo "uDev: all alias like 'drya edit-bash-file' will need to be added to this fluNav"
                     break
                  ;;
                  quit) 
                     break  
                  ;;
                  ? | help | --help | -h | h) 
                     f_greet
                     echo "fluNav"
                     echo " > Edits files inside 'DRYa repository' then copies those files across the system"
                     echo " > Inside ~/.config/h.h/ you can install configs that are not meant to go online and they are machine-specific"
                     echo "   (Edit those files manually (uDev: in the future there will be an automated otion for that))"
                     break  
                  ;;
                  *)    
                     echo "fluNav: Invalid option $REPLY"  
                  ;;
               esac
            done

         # When function F is presented with arguments (using elif):
         # And sync with github
         # Use this menu to MANUALLY add/remove files to be handled
         # Across the system, many files may have many alias. But to sync with fluNav, they must be listed here:
         # The v_nm variable is meant to dump data from the $1 variable, enabling the $1 to be used again for other reson
            elif [ $1 == "test"  ]; then v_nm="test";        f_action; ## Just test if this file is working
            elif [ $1 == "."     ]; then v_nm="self";        f_action; ## Edit this file itself 
            elif [ $1 == "0"     ]; then v_nm="unalias";     f_action; f_unalias_all; f_up
            elif [ $1 == "1"     ]; then v_nm="dryaSH";      f_action; vim ${v_REPOS_CENTER}/DRYa/drya.sh; f_up
            elif [ $1 == "1."    ]; then v_nm="dryaSH-op-1"; f_action; cd  ${v_REPOS_CENTER}/DRYa && EM drya.sh; f_up
            elif [ $1 == "2"     ]; then v_nm="initVIM";     f_action; f_emacs_init_vim; f_up
            elif [ $1 == "5"     ]; then v_nm="F5";          f_action; # Refresh the entire terminal 
            elif [ $1 == "19"    ]; then v_nm="test";        f_action; echo "Test is working for 19"; f_up
            elif [ $1 == "wd"    ]; then v_nm="wikiD";       f_action; cd ${v_REPOS_CENTER}/wikiD && EM wikiD.org; f_up
            elif [ $1 == "cv"    ]; then v_nm="curriculum";  f_action; echo "Opening curriculum vitae"; emacs /data/data/com.termux/files/home/Repositories/moedaz/all/real-documents/CC/currriculo-vitae-Dv.org; f_up
            elif [ $1 == "links" ]; then v_nm="ss-links";    f_action; echo "uDev: open shiva sutra links"; f_up
            elif [ $1 == "luxam" ]; then v_nm="luxam";       f_action; cd ${v_REPOS_CENTER}/luxam/ && EM grelhas-de-avaliacao.org; f_up
            elif [ $1 == "trade" ]; then v_nm="trade";       f_action; # Sync the trade.org wikipedia
            elif [ $1 == "om"    ]; then v_nm="om";          f_action; # Sync the omni-log.org file 
            elif [ $1 == "note"  ]; then v_nm="note";        f_action; # Sync one Scratch File. Number of file is to be given as $2 (second argument)
            elif [ $1 == "car"   ]; then v_nm="car";         f_action; # Sync Everything about the car

            else echo "fluNav: Please choose a valid arg"    # If arguments are given but they are wrong
         fi
   }   ## End of function F
