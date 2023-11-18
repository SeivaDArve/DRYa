#!/bin/bash

# uDev: This app should have 3 prefixes: M F and D

# Testing
   alias B="echo Future menuFAV"

   function A {
      echo "echo bla bla"
   }


function f_greet { 
   # Avoiding repetition
   clear
   figlet menuFAV 
}

function f_mF { 
   # Avoiding repetition
   clear
   figlet menuFAV File
}

function f_mD { 
   # Avoiding repetition
   clear
   figlet menuFAV Dir
}

function f_mM { 
   # Avoiding repetition
   clear
   figlet menuFAV Menu
}

function f_emacs_init_vim {
   # Important: menuFAV depends on this function
   # This edits the init file ALWAYS on the repo 'drya' first and THEN copies to ~
   # This way we know we can easily upload the file

      # First we edit the original/centralized file with our favourite text editor
         v_init_file="${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/init.el"
         vim $v_init_file 

      # After edition, independently of the text editor (read Note*1), some changes are same. Therefore, to
      # avoid duplication, we create a function to keep it simple and avoid spaghetti code
         f_manage_init_and_libraries_after_mod

         # Note*1: In this menuFAV there are 2 options that choose 2 text editors (vim and emacs) 
         #         to call the same function "f_manage_init_and_libraries_after_mod"
}

function M {
   # Function: "Directory"
   
   # uDev: why is it that D is not reserved for 'alias D="drya"'? 
      # sugestion: menuFAV will be under F so that D gets to be reserved for drya

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

   function f_create-file {
      echo
   }

   # Implementation of Use 1:
   if [ -z $1 ]; then 
      f_cor1
      figlet "menuFAV"
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
      cd ${v_REPOS_CENTER}/upK-diario-Dv && clear && figlet menuFAV && echo -e "Command used: upk-dv\n" && ls
      
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
   elif [ $1 == "m" ]; then

      case $2 in
         0) # Travel to Internal storage
            # uDev: clear; pwd; echo "you are in X dir"
            echo "Internal storage"
            pwd
            echo
            cd /sdcard && ls
         ;;
         1) # Travel to SD Card storage
            echo "SD card storage"
            pwd
            echo
            echo "Termux cannot WRITE to SD card,"
            echo "but can READ and RUN bash scripts from it"
            echo "If you have a huge database to store into SD external"
            echo "instead of internal, copy it to 'd -m 0' (internal storage) and with your"
            echo "file explorer, MOVE it to the SD card"
            echo
            cd /storage/0094-8210 && ls || cd /storage && ls

         ;;
         2) # Travel to USB storage
            echo "USB Storage"
            pwd
            echo
            cd /storage/83DB-10EA && ls || cd /storage && ls
         ;;
         3) # Travel to the dir where many USB storages are mounted
            echo "List of options for: USB storage"
            pwd
            echo
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
            echo "Do you need directories to be created in order to MOVE"
            echo "internal things to external SD?"
            echo 
            echo "If you want a directory called \"Repositories\" in both"
            echo "External and Internal storage, press ENTER 3x"
            echo "(or cancel with CTRL + C)"
            echo
    1        echo "#uDev: create an option to ask for custom dir name"
            echo "(default is /storage/Repositories"
            read
            read
            read

         ;;
         b) 
            # Travel to dir at Internal storage called Termux-bridge-Android
            cd /sdcard/Termux-bridge-Android && ls
         ;;
         *)
     1       echo "How to use:"
            echo "$ d -m"
            echo '0) # Travel to Internal storage'
            echo '1) # Travel to SD Card storage'
            echo '2) # Travel to USB storage'
            echo '3) # Travel to the dir where many USB storages are mounted'
            echo '4) # Travel to the dir where many USB storages are mounted'
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



function f_manage_init_and_libraries_after_mod {
   # This function is used by several select_menus: "emacs-init (emacs)" and "emacs-init (vim)"
   # Has a function of presentation
   # Has a function of prompting the user wether or not to apply the last changes

   function f_presenting_DF {
      # presenting the file for our M menuFAV:
         clear; 
         figlet "menuFAV"
         echo -e "File closed (after editions):\n > $v_init_file \n"
   }

   function f_asking_to_apply_init {
      # Ask if the user wants the changes to apply to this machine imediatly
         # If not, the user has to use this command again afterwards
         # unless the user want to do it manually
         
         echo "Do you want to apply these changes NOW?"
         echo " > If not, you may run this command againg later"
         echo " > Unless you want to aplly changes manually"
         echo 
         read -s -n 1 -p "Please enter Y/N (yes/no): " v_apply
   }   
   
   function f_applying_changes_init {
      # This is for Linux:

         # Copy recursively all files about emacs to the localized machine-specific directory:
            echo "DRYa: copying recursively: "
            echo " > \"centralized emacs files\" into \"~/.emacs.d\""
               cp -r ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/* ~/.emacs.d/
            echo "   > done!"
         
         # We want to use "~/.emacs.d" instead of "~/.emacs". Because it can create initialization bugs, we remove the first one.
            echo " > removing: ~/.emacs (avoiding bugs)"
               rm ~/.emacs 2>/dev/null; 
            echo "   > done!"

      # If we are on windows, the init file should also be somewhere at: %appdata%

         v_correct_win_dir="/mnt/c/Users/Dv-User/AppData/Roaming/.emacs.d"
         v_bugged_win_dir_to_del="/mnt/c/Users/Dv-User/AppData/Roaming/.emacs"

         if [ -d $v_correct_win_dir  ]; then
            # If the v_correct_win_dir exists, set it up too:
               echo -e "\nDRYa: Windows detected, adjusting: "

            # Copy files and directories recursively for the directory that emacs prefers on windows
               echo " > %AppData% exists, copying emacs files there too recursively"
                  cp -r ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/emacs/* $v_correct_win_dir
               echo "   > copied to: \"$v_correct_win_dir\""
               echo -e "   > done! \n"
            
            # Removing the extra file/directory that can create initialization issues
               echo " > removing: $v_bugged_win_dir_to_del (avoiding bugs)"
                  rm $v_bugged_win_dir_to_del 2>/dev/null
               echo "   > done!"

         fi
   }
                     
   # After defining all 3 last function, let's assemble them:
      # Presenting M
         f_presenting_DF

      # Asking if the user really want apply changes (with: f_applying_changes_init)
         f_asking_to_apply_init
      
         if [ $v_apply == "y" ] || [ $v_apply == "Y" ]; then echo -e "Your choice was: Do apply\n\n"; f_applying_changes_init; 
         elif [ $v_apply == "n" ] || [ $v_apply == "N" ]; then echo "Your choise was: Do not apply"; 
         else echo "Answers do not match, doing nothing for now. You can run the command again later";
         fi
}

# List fav files for edition (menuFAV)
   function F {

      
      function f_uDev_1 {
         # Function to remind the user about needed changes (uDev)
         echo -e "\n# uDev: all options MUST edit files inside DRYa repo (for easy upload) and then copy those files across the system"
      }

      # Reload the amount of '-' are needed to create an horizontal line
         source ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/f_horizontal_line.sh

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
            
      #uDev: Turn these variables into usable arguments for menuFAV
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
         

      # If there are no arguments, present the menuFAV
         if [ -z $1 ]; then

            clear
            figlet menuFAV

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
                     echo "Reload done to: ~/.bashrc by menuFAV"
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

                           # Note*1: In this menuFAV there are 2 options that choose 2 text editors (vim and emacs) 
                           #         to call the same function "f_manage_init_and_libraries_after_mod"

                     break
                  ;;
                  "emacs-init (vim)")
                     f_emacs_init_vim
                     break
                  ;;
                  secundary-files)
                     f_greet
                     echo "uDev: all alias like 'drya edit-bash-file' will need to be added to this menuFAV"
                     break
                  ;;
                  quit) 
                     break  
                  ;;
                  ? | help | --help | -h | h) 
                     f_greet
                     echo "menuFAV"
                     echo " > Edits files inside 'DRYa repository' then copies those files across the system"
                     echo " > Inside ~/.config/h.h/ you can install configs that are not meant to go online and they are machine-specific"
                     echo "   (Edit those files manually (uDev: in the future there will be an automated otion for that))"
                     break  
                  ;;
                  *)    
                     echo "menuFAV: Invalid option $REPLY"  
                  ;;
               esac
            done

         # When function F is presented with arguments (using elif):
            elif [ $1 == "0" ]; then f_unalias_all
            elif [ $1 == "." ]; then vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/menuFAV.sh ## Edit this file itself
            elif [ $1 == "1" ]; then echo "Test is working for 1"
            elif [ $1 == "5" ]; then echo "Alias for: drya update. Do you want to continue?"
            elif [ $1 == "12" ]; then f_emacs_init_vim
            elif [ $1 == "13" ]; then vim ${v_REPOS_CENTER}/DRYa/drya.sh
            elif [ $1 == "cv" ]; then echo "Opening curriculum vitae"; emacs /data/data/com.termux/files/home/Repositories/moedaz/all/real-documents/CC/currriculo-vitae-Dv.org
            elif [ $1 == "links" ]; then echo "uDev: open shiva sutra links"
            #elif [ $1 == "9" ]; f_F_9"


         # If arguments are given but they are wrong
            else echo "menuFAV: Please choose a valid arg"
         fi
   }   ## End of function F
