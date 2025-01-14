#!/bin/bash
# Title: fluNav (fluent navigation)

# Dependencies: figlet, file, fzf (may bi instaled by typing):
   # '$ pkg install figlet file fzf'




 

# uDev: This app should NOT have 3 prefixes: V, S, E and .....
#       Instead: use only: `. M` for fluNav menu
#
#       letra S para ABRIR ficheiros com SYNC
#       letra . para abrir ficheiros sem s


# uDev: 
#    '. '       ## ls
#    'V mo'     ## cd moedaz
#    'DD'       ## cd DRYa
#    'op file.org' detect current emacs (instead of EM, Em, em)


# Leters to be used:
#     function S     (Sync files before/after editing at: DRYa/locally/maybe github)
#     function V     (NaVigate to dirs)
#     function PNpn  (Replaced with `fzf` + `V`    ---->    `V +`  `V -`  `V .`  `V ..`  `V --` (To create a tmp favourite list of dirs  @verbose-lines or @~/.config/h.h/drya/)
#     function PNpn  (Replaced with `fzf` + `S`    ---->    `S +`  `S -`  `S .`  `S ..`  `S --` (To create a tmp favourite list of files @Verbose-lines or @~/.config/h.h/drya/)
#     function .
#     function ..
#     function ...
#     function ....
#     Forbiden function: Function D   ##   Reserved for DRYa


      
# uDev: Set traitsID_Editor to avoid:
#       > Open X (with vim)
#       > Open X (with emacs)


# uDev: bind Ctrl-F to F5 (refresh terminal and source files)

# uDev: morse-code-style
#       Dot="morse ."
#       Dash="morse ,"
#       word="morse ..., ,.., .,,"



function f_c1 {
   tput setaf 5
}


function f_c5 {
   tput setaf 6
}

function f_rc { 
   # This function is to be used to CLEAR all styles
   tput sgr0
}

function f_done {
   f_c5; echo ": Done!"
   f_rc
}

function f_greet { 
   # Avoiding repetition
   clear
   f_c5; figlet fluNav
   f_rc
}
      
function f_talk {
   # Copied from: ezGIT
         echo
   f_c5; echo -n "DRYa: fluNav: "
   f_rc
}


function f_horiz_line {
   # Using the in-built horizontal line from DRYa
   bash ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/f_horizontal_line.sh
   echo $v_line
}


function f_edit__config_bash_alias {
   vim ${v_REPOS_CENTER}/DRYa/all/etc/config-bash-alias
   f_greet
   echo "edited: config-bash-alias"
}

function f_edit__notes {
   f_greet
   note  # This is an alias set on config-bash-alias file
}

function f_edit__source_all_drya_files {
   vim ${v_REPOS_CENTER}/DRYa/all/source-all-drya-files
   f_greet
   echo "edited: source-all-drya-files"
}

function f_edit__bashrc {
   vim ~/.bashrc
   f_greet  
   echo "edited: ~/.bashrc"; f_uDev
}

function f_edit__source_all_moedaz_files {
   f_greet
   vim ${v_REPOS_CENTER}/moedaz/all/source-all-moedaz-files
   echo "edited: source-all-moedaz-files"
}

function f_edit__vimrc {
   vim ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc
   f_greet
   echo "edited: .vimrc on DRYa"
   cp ${v_REPOS_CENTER}/DRYa/all/etc/dot-files/vim/.vimrc ~
   echo "copied: from DRYa to ~"
}

function f_edit__1st_emacs {
   f_greet
   echo "Editing the list of 1st apps to install"
   read -s -t 2
   EM ${v_REPOS_CENTER}/DRYa/all/bin/populate-machines/level+1/1st
   f_greet
   echo "edited: 1st"
}

function f_edit__1st_vim {
   f_greet
   echo "Editing the list of 1st apps to install"
   read -s -t 2
   vim ${v_REPOS_CENTER}/DRYa/all/bin/populate-machines/level+1/1st
   f_greet
   echo "edited: 1st"
}

function f_edit__init_file_emacs__with_emacs {
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

}

function f_edit__init_file_emacs__with_vim {
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
function f_help {
   f_greet
   echo "fluNav"
   echo " > Edits files inside 'DRYa repository' then copies those files across the system"
   echo " > Inside ~/.config/h.h/ you can install configs that are not meant to go online and they are machine-specific"
   echo "   (Edit those files manually (uDev: in the future there will be an automated otion for that))"
}
function f_refresh_terminal_and_drya {
   source ~/.bashrc
   drya update
   echo "Reload done to: ~/.bashrc by fluNav"
   # uDev: Fazer reset tambem ao init.el
}




function f_applying_changes_init {
   # For emacs init file

   # This is for Linux:
      # Copy recursively all files about emacs to the localized machine-specific directory:
         f_talk; echo "copying recursively: "
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
   # This function is used by several select_menus: 
   #    "emacs-init (emacs)" and 
   #    "emacs-init (vim)"

   f_greet
   f_talk; echo "Edited file is now closed:"
           echo " > $v_init_file"
           echo

   f_talk; echo "Do you want to apply these changes imediatly?"
           echo 

   read -s -n 1 -p "Please enter Y/N (yes/no): " v_apply
   echo 


   if [ -z $v_apply ]; then 
      f_talk; echo " > No action taken"

   elif [ $v_apply == "y" ] || [ $v_apply == "Y" ]; then 
      f_talk; echo "Applying..." 
              echo

      f_applying_changes_init 

   elif [ $v_apply == "n" ] || [ $v_apply == "N" ]; then 
      f_talk; echo "Not Applying..." 
              echo
              echo " > You may run this command again later"
              echo "   or apply manually"
              echo
   else 
      f_talk; echo "Invalid answer. Not Applying"
   fi
}


function f_edit_self {

   f_greet

   # Verbose: Before opening file
      f_talk; echo "Editing fluNav original file"
              echo " > .../DRYa/all/bin/init-bin/fluNav.sh"

              echo
              read -s -n 1 -p "[Press any key to continue] "
              echo 

   # Verbose: Actually opening the file
      vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/fluNav.sh

   # Verbose: After opening the file
      f_talk; echo "Closed: fluNav original file"
              echo
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
   # Nota: Seria util que antes de abrir um ficheiro, fluNav navegasse primeiro para o seu dir relativo. Assim ao fechar o ficheiro, sabemos a qual repo pertence. isso ajuda aos dev que usam git
 
   if [ $v_nm == "fx-test" ]; then
      # fluNav testing (opening a file after downloading updates from github and sending it back after to github).

      f_greet

      f_down  # uDev: f_tst_repo: test if correspondant repo is already cloned

      echo "$v_nm: Testing fluNav"

      f_up

   elif [ $v_nm == "car" ]; then
      # uDev: Fix this fx to ask the user to clone respective repo from github.com if inexistent

      f_greet 

      # Variables for this task
         v_respective_repo=${v_REPOS_CENTER}/moedaz 
         v_respective_file_dir=${v_REPOS_CENTER}/moedaz/all/viatura/ 
         v_respective_file=viatura-all-info.org


      function f_ask_what_to_do {
         # Inform "error" if correspondant repo does not exist and then quit

         # Lista de opÃ§Ãµes para o menu `fzf`
         v_list=$(echo -e "1. Do not Clone (do nothing) \n2. Clone from github (and edit the file)" | fzf --prompt="fluNav: repo 'moedaz' does not exist")

         # Perceber qual foi a escolha da lista
            [[ $v_list =~ "1" ]] && echo "fluNav: did not clone 'moedaz' and did not open 'car' file"
            [[ $v_list =~ "2" ]] && echo "Detetado 2 (debug)" && sleep 1
            unset v_list
      }

      # If repo does not exist, ask user what to do
         [[ ! -d $v_respective_repo ]] && f_ask_what_to_do

      # Downloading updates from github
         #f_down

      function f_edit {
         # Editing the file
         
         echo "$v_nm: Editing one or more files from .../moedaz/viatura/..."
         cd $v_respective_file_dir && EM $v_respective_file 
      }

      # If repo does exist, proced and edit the file
         [[ -d $v_respective_repo ]] && f_edit


      # Uploading changes to github
         # f_up
   
   elif [ $v_nm == "tmux" ]; then

      f_greet 

      cd ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/
      vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/tm-tmux

   elif [ $v_nm == "search-files" ]; then
      # From current directory, search files with fzf menu and open with vim 

      # Apartir da pasta atual ate todas as subpastas, Pesquisar todos os ficheiros e guardar na variavel $v_file
         v_file=$(fzf --prompt="EDITE um ficheiro: ")

      # Adiconar a um ficheiro temporario fluNav
         v_dir=~/.config/h.h/drya/flunav
         v_file_hist=~/.config/h.h/drya/flunav/history-files

         mkdir -p $v_dir; echo "$v_file" >> $v_file_hist

      # Finalmente, editar o ficheiro
         [[ ! -z $v_file ]] && echo "fluNav: a Editar: $v_file" && vim $v_file  # Editar o ficheiro caso não esteja vazio devido ao ESC (utilizadopara sair do menu)

   elif [ $v_nm == "edit-history-files" ]; then
      # Selecionar de um historico de ficheiro, um ficheiro para voltar a abrir

      # Criar um menu apartir do historico  (uDev: apagar linhas repetidas)
         v_hist=$(cat ~/.config/h.h/drya/flunav/history-files | tac | fzf --prompt "SELECIONE do Historico de ficheiros, 1 para EDITAR: ")
   
      # Se a variavel nao vier vazia (e o utilizador escolheu um ficheiro para editar), entao abrir com o vim
         [[ ! -z $v_hist ]] && vim $v_hist && unset $v_hist

      
   elif [ $v_nm == "upk" ]; then

      # Esta fx pode e deve usar o nan-D
      #    Cada smartphone deve ter um ficheiro nD em cada pasta principal (Armazenamento Interno, Cartao SD)
      #    criados com o explorador do proprio Android para facilitar a busca feita pelo Termux  
      #    exemplo: .../Armazenamento\ Interno/nD.Arm-Int.txt
      #    exemplo: .../Cartao\ SD/nD.CartSD.txt
      # 
      #    Ou colocar so um ficheiro "nanD.txt" em todas as pastas que quremos que ele busque

      f_greet 

      #f_down
      echo "$v_nm: Menu to support UPK"
      echo 
      echo "What would you like to sync?"
      echo " 1. Horario Novo"
      echo "    2. Mostrar horario atual"
      echo 
      echo " 3. Renomear e buscar uma foto do DCIM"
      echo 
   
   elif [ $v_nm == "self" ]; then
      f_edit_self

   elif [ $v_nm == "trade" ]; then

      f_greet

      echo "$v_nm being edited"
      cd ${v_REPOS_CENTER}/moedaz/trade && \
      G v && \
      EM all/trade/trade.org && \
      G ++ b

      v_file="all/trade/trade.org"
      v_parent="moedaz"

      echo " > Alias: 'S trade'"
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

      f_greet

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










#alias .="ls"  ## Replaced by the 'function . { }' and the 'function D { }'
alias ..="cd .."
alias ...="cd -"

function . {
   # Navigate through the file system stupidly ez
   
   # uDev: Include 'function d' to give 'favs' if directory is not found

      if [ -z $1 ]; then 
         # If no argument is given, lists storage (ls command)
         ls -p

      elif [ $1 == "." ]; then 
         f_edit_self

      #elif [ $1 == "-" ]; then 
         # Open last file edited, because last file opened saved it's absolute path somewhere 

      elif [ $1 == "G" ]; then 
         # If arg 1 is 'G' then navigate to the center of seiva's repos
         cd $v_REPOS_CENTER
         # uDev: this command '. .' is usually issued at the beggining of the day when the user is going to start the coding session. Therefore: Echo once a day to REMEMBER to git pull
         # uDev: similar to '$ D .' ezGIT could have also an alias to navigate to it's home dir. Use command '$ . G .' to do it
   
      elif [ $1 == "?" ] || [ $1 == "h" ]; then 
         # Describe all these navigation alias

         f_greet
         
         f_talk; echo "Instructions:"
         echo
         echo '`. ?` or `. h`  Shows this help menu'
         echo '`. G`           Navigate to: Repos Center'
         echo
         echo ".  1x Means: ls"
         echo "..  2x Means: cd .."
         echo "...  3x Means: cd -"
         echo "....  4x Means: pwd"
         echo ".....  5x Means: save this dir location in var \$h"
         echo "......  6x Means: save previous dir location in var \$v"
         echo ".......  7x Means: remember last 2 variables set as \$h and \$v"
         echo
         echo "To visit a file called 'h' use: \`vim h\`"

      elif [ ! -z $1 ]; then
         # If argument is given and it is a dir, cd into it, otherwise if it a file, edit it
         
            cd $1 2>/dev/null && \
            v=$(pwd) && \
            b=$(basename $v) && \
            echo "DRYa: fluNav: Listing files at:" && \
            echo " > ./$b" && \
            echo && \
            ls || \
            for i in $@; do vim $i; done  # uDev: if if is .jpg on termux, open accordingly  ::  Atempt of c_editor failed here

      fi
}
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
   # Escolher editor de texto para pre-definir 

   # In fluNav, there is a command to open either a dir or to open a file:
   # '$ . <file>'
   # and if there is no dir or existent file, it will create one,
   # so, this function will decide which text editor will open the file

   # uDev: Set traitsID accordingly

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='E'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L6='6. less --wordwrap'
       L5='5. cat'
       L4='4. nano'

       L3='3. emacs'
       L2='2. vim'

       L1='1. Cancel'

      L0="SELECIONE 1 editor de texto para pre-definir: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "4.  " ]] && alias v_editor="nano" && echo "Nano"
      [[ $v_list =~ "3.  " ]] && alias v_editor="emacs" && echo "emacs"
      [[ $v_list =~ "2.  " ]] && alias v_editor="vim" && echo "emacs"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}


function f_trade_interactive_dir {

   f_greet 

   echo "moedaz: trade: interactive DASHBOARD"
   echo " > You may use the comand 'ex'"
   echo
   ls -1
}

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



function f_menu_fzf_S {
   # Menu Quick file edit (para quando S nao recebe argumentos no terminal)

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='S'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      # udev: traitsID has to solve this. Avoid duplicated line for each file editor and use the '3. Toggle file editor' instead
         v_editor1="vim  "
         v_editor2="emacs "
         v_editor3="less --wordwrap"
         L65="65. Edit | $traits_editor   | Example"

      L15='15. Edit | vim   | config-bash-alias'
      L14='14. Edit | vim   | notes'
      L13='13. Edit | vim   | source-all-drya-files'
      L12='12. Edit | vim   | .bashrc'
      L11='11. Edit | vim   | source-all-moedaz-files'
      L10='10. Edit | vim   | .vimrc'
       L9='9.  Edit | emacs | 1st'
       L8='8.  Edit | vim   | 1st'
       L7='7.  Edit | emacs | emacs-init'
       L6='6.  Edit | vim   | emacs-init'

       L5='5.  Help'
       L4='4.  Toggle file editor'
       L3='3.  Reload  | dot-files + DRYa + Terminal'
       L2='2.  Reload  | Terminal'
       L1='1.  Cancel'

      L0="SELECIONE (1 ou +) ficheiros para editar: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n\n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n\n$Lz3" | fzf --cycle -m --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "15. " ]] && f_edit__config_bash_alias
      [[ $v_list =~ "14. " ]] && f_edit__notes
      [[ $v_list =~ "13. " ]] && f_edit__source_all_drya_files 
      [[ $v_list =~ "12. " ]] && f_edit__bashrc
      [[ $v_list =~ "11. " ]] && f_edit__source_all_moedaz_files
      [[ $v_list =~ "10. " ]] && f_edit__vimrc
      [[ $v_list =~ "9.  " ]] && f_edit__1st_emacs
      [[ $v_list =~ "8.  " ]] && f_edit__1st_vim
      [[ $v_list =~ "7.  " ]] && f_edit__init_file_emacs__with_emacs
      [[ $v_list =~ "6.  " ]] && f_edit__init_file_emacs__with_vim
      [[ $v_list =~ "5.  " ]] && f_help
      [[ $v_list =~ "4.  " ]] && echo "uDev: toggle file editor"
      [[ $v_list =~ "3.  " ]] && echo 'uDev: Same as `D update`'
      [[ $v_list =~ "2.  " ]] && source ~/.bashrc
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}





function f_mobile_android {
   # if [ -z $2 ]; then 

   case $v_arg2 in
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
         echo "$ V m [0|1|2|3|4|b]"
         echo '0) # Travel to Internal storage'
         echo '1) # Travel to SD Card storage'
         echo '2) # Travel to USB storage'
         echo '3) # Travel to the dir where many USB storages are mounted'
         echo 'b) # Travel to \"Internal storage/Termux-bridge-Android/\"'
    #uDev: May be needed termux-setup-storage to access some directories
      ;;
   esac
}


function f_uDev {
   # Function to remind the user about needed changes (uDev)
   echo -e "\n# uDev: all options MUST edit files inside DRYa repo (for easy upload) and then copy those files across the system"
}





# ---------------------------------
# Brought by config-bash-alias       }
# ---------------------------------





function f_hist_2_fzf {
   #echo "Escolheu 2. Ultimos Ficheiros"
   v_text=$(cat $v_file)


   if [[ -z $v_text ]]; then
      echo "Nao tem nenhum Ficheiro recente na lista"

   else 
      v_escolha=$(cat "$v_file" | fzf --prompt="SELECT ficheiro RECENTE para editar: " )
      #echo "Escolhido: $v_escolha"

      # Navega para a pasta que obtem mais ficheiros
         cd

      # Se alguma coisa foi escolhido e essa variavel nao estiver vazia, abre com vim
         [[ ! -z $v_escolha ]] && vim $v_escolha
      
      # Volta para a pasta inicial
         cd - 1>/dev/null
   fi

}

function H {
   # Funcao para 2 coisas: Abrir historico Bash com `fzf` e Abrir historico dos ultimos ficheiros editados que queremos editar de novo

   #   # Criar um ficheiro que gere o historico de Ultimos ficheiros (se nao existir)
   #      # Nome do ficheiro
   #         v_file=~/.config/h.h/drya/H-fzf 
   #    
   #      # Confirmar se existe
   #         if [ ! -f $v_file ]; then
   #            echo "Ficheiro n existe, vai ser criado" 
   #            touch "$v_file" && echo " > Criado"
   #         fi
   #
   #   if [[ -z $1 ]]; then
   #         f_hist_2_fzf
   #
   #   elif [[ $1 == ".." ]]; then
   #      v_hist=$(echo -e "2. Ultimos Ficheiros \n1. Historico Bash " | fzf)
   #
   #      [[ $v_hist =~ "1" ]] && echo "Escolheu 1" && history | tac | fzf
   #
   #      if [[ $v_hist =~ "2" ]]; then
   #         f_hist_2_fzf
   #      fi
   #
   #   elif [ $1 == "+" ]; then
   #      echo "adding"
   #      cd
   #      v_add=$(fzf)
   #      echo "$v_add" >> $v_file
   #      cd -
   #
   #   elif [ $1 == "--" ]; then
   #      echo "removing entire file"
   #      rm $v_file
   #
   #   elif [ $1 == "." ]; then
   #      cat $v_file | fzf --prompt="VISUALIZAR cada ficheiro guardado: " 1>/dev/null
   #   fi

   # As linhas anteriores nao precisam existir porque
   # podemos usar o comando `history -s "comando"`
   # para enviar texto para o ficheiro de historico do bash

   cat ~/.bash_history | fzf --tac --prompt "RUN 1 command from HISTORY: " 
}








function V {
   # Function: "Directory" ou "Place (V)"
   
   # uDev: Se for WSL3, detetar endereços: "C:\Users\$USER\Documents"
   # uDev: add: appdata (windows)
   # uDev: alias R: listar repositorios por numero para saltar para eles (ou usar menu fzf)


   # Implementation of Use 1:
      if [ -z $1 ]; then 
         f_greet
         f_talk; echo "V: No arguments. Choose some place to go to"

   # Implementation of Use 0:
      elif [ $1 == "h" ] || [ $1 == "help" ] || [ $1 == "?" ]; then
         echo "uDev: Instructions"
         # Help and Usage:
            # This fx finds directories

            # This function is a combination of:
            #   `cd` ; `ls` ;  + alias ; 

            # Use 0:  '$ V h           # Help and instructions
            # Use 1:  '$ V             # Complains that there is no destination specified
            # Use 2:  '$ V drya        # Travels to favorites  # uDev: to be absorved by the 'function . { }'
            # Use 3:  '$ V -p <dir>    # Create new dir and travel to it
            # Use 4:  '$ V -r <dir>    # finds and lists a dir to remove (use -R to confirm yout choice)
            # Use 5:  '$ V -R <dir>    # Removes dir (recommended to confirm which dir will be removed with the option -r)
            # Use 6:  '$ V ..          # Search a list of paths to navigate to
            # Use 7:  '$ V .           # Uses `fzf` to search for a file. Then navigate to it's directory
            # Use 8:  '$ V <dir>       # Go to existent dir at current pwd
            # Use 9:  '$ V +           # Store current path to a list of paths
            # Use 10: '$ V -           # Remove current path to a list of paths
            # Use 10: '$ V --          # Remove all lines from history file   


   # Implementation of Use 2:
      elif [ $1 == "drya" ] || [ $1 == "dry" ] || [ $1 == "d" ] || [ $1 == "D" ]; then
         cd ${v_REPOS_CENTER}/DRYa && ls
      

      elif [ $1 == "moedaz" ] || [ $1 == "mo" ] ; then
         cd ${v_REPOS_CENTER}/moedaz && ls
      

      elif [ $1 == "trade" ] || [ $1 == "t" ]; then
         cd ${v_REPOS_CENTER}/moedaz/all/trade/Binance-Bot && ls
         #f_trade_interactive_dir
      

      elif [ $1 == "ezGIT" ] || [ $1 == "G" ] || [ $1 == "ez" ] || [ $1 == "g" ]; then
         cd ${v_REPOS_CENTER}/ezGIT && ls
         

      elif [ $1 == "dwiki" ] || [ $1 = "dw" ]; then
         cd ${v_REPOS_CENTER}/dWiki && ls
         

      elif [ $1 == "wiki" ] || [ $1 == "wikid" ] || [ $1 == "wikiD" ] || [ $1 = "wd" ] || [ $1 == "w" ]; then
         cd ${v_REPOS_CENTER}/wikiD && ls
         

      elif [ $1 == "upk" ]; then
         cd ${v_REPOS_CENTER}/upK && ls
         

      elif [ $1 == "upk-dv" ] || [ $1 == "upkd" ] || [ $1 == "upk-" ]; then
         cd ${v_REPOS_CENTER}/upK-diario-Dv && f_greet && f_talk; echo -e "\`V upk-dv\`\n" && ls
         

      elif [[ $1 == "ss" ]] || [ $1 == "112" ]; then
         cd ${v_REPOS_CENTER}/112-Shiva-Sutras && ls
         

      elif [[ $1 == "omni" ]] || [[ $1 == "log" ]] || [[ $1 == "om" ]]; then
         cd ${v_REPOS_CENTER}/omni-log && ls
         

      elif [[ $1 == "gps" ]]; then
         cd ${v_REPOS_CENTER}/mastering-GPS && ls


      elif [[ $1 == "verbose-line" ]] || [ $1 == "vbl" ] || [ $1 == "vb" ]; then
         cd ${v_REPOS_CENTER}/verbose-lines && ls
         

      elif [[ $1 == "yoga" ]] || [ $1 == "yogab" ] || [ $1 == "yg" ]; then
         cd ${v_REPOS_CENTER}/yogaBashApp && ls
         

      elif [[ $1 == "shamb" ]]; then
         cd ${v_REPOS_CENTER}/yogaBashApp/all/all-shambavi/ && ls
      

      elif [[ $1 == "3sab" ]] || [[ $1 == "3s" ]] || [[ $1 == "3" ]]; then
         cd ${v_REPOS_CENTER}/3-sticks-alpha-bravo && ls
         

      elif [ $1 == "tmp" ]; then
         mkdir -p ~/.tmp
         cd ~/.tmp/ && ls


      elif [ $1 == "code" ]; then
         mkdir -p ~/.code
         cd ~/.code/ && ls


      elif [ $1 == "center" ]; then
         cd ${v_REPOS_CENTER} && ls


      elif [[ $1 == "scratch" ]] || [ $1 == "paper" ] || [ $1 = "sc" ]; then
         cd ${v_REPOS_CENTER}/scratch-paper && ls


      elif [ $1 == "dota" ]; then
         cd ${v_REPOS_CENTER}/Dota-2-guide && ls


      elif [ $1 == "lxm" ]; then
         cd ${v_REPOS_CENTER}/luxam && ls


      elif [ $1 == "ln" ]; then
         # Se a pasta ~/ls/ existir, navega para ela e lista os seus conteudos
         [[ -d ~/ln/ ]] && cd ~/ln/ && ls


      elif [ $1 == "m" ] || [ $1 == "mobile-android" ]; then
         v_arg2=$2
         f_mobile_android


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
      
      # uDev: provide more safety

   # Implementation of Use 6:
      elif [ $1 == ".." ]; then
         # uDev: Search a list of stored paths to navigate to
         echo



   # Implementation of Use 7:
      elif [ $1 == "." ]; then
         # From current directory, search other directories with fzf menu and navigate there
         
         v_dir=$(fzf --prompt="NAVEGUE para uma pasta (pode ignorar o conteudo): ")

         if [[ ! -z $v_dir ]]; then
            # navegar para a pasta caso não esteja vazio devido ao ESC (utilizadopara sair do menu)
            v_dirname=$(dirname $v_dir)
            f_talk; echo "A navegar para: $v_dirname"
            cd $v_dirname
         fi

   # Implementation of Use 8:
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

function S {
   # List fav files for edition (fluNav)
   
   # Reload the amount of '-' are needed to create an horizontal line
      source ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/f_horizontal_line.sh 1>/dev/null

   # If there are no arguments, present the fluNav
      if [ -z $1 ]; then

      f_menu_fzf_S  # Menu fzf

   # When function S is presented with arguments:
      # Acts on the file, And syncs with github after
      # Across the system, many files may have many alias. But to sync with fluNav, they must be listed here:
      # The v_nm variable is meant to dump data from the $1 variable, enabling the $1 to be used again for other reson
      elif [ $1 == "."        ]; then v_nm="search-files";        f_action; # Asks in a menu, which file is meant to be sync
      elif [ $1 == "-2"       ]; then v_nm="test";                f_action; echo "Test is working for 19"; f_up
      elif [ $1 == "-1"       ]; then v_nm="fx-test";             f_action; ## Just test if this file is working
      elif [ $1 == "S"        ]; then v_nm="self";                f_action; ## Edit this file itself 
      elif [ $1 == "0"        ]; then v_nm="unalias";             f_action; f_unalias_all; f_up
      elif [ $1 == "1"        ]; then v_nm="dryaSH";              f_action; vim ${v_REPOS_CENTER}/DRYa/drya.sh; f_up
      elif [ $1 == "1."       ]; then v_nm="dryaSH-op-1";         f_action; cd  ${v_REPOS_CENTER}/DRYa && EM drya.sh; f_up
      elif [ $1 == "2"        ]; then v_nm="initVIM";             f_action; f_edit__init_file_emacs__with_vim; f_up
      elif [ $1 == "3"        ]; then v_nm="jarve-sentinel";      f_action; cd ${v_REPOS_CENTER}/DRYa/all/bin/ && vim jarve-sentinel.sh; f_up
      elif [ $1 == "4"        ]; then v_nm="traitsID";            f_action; cd ${v_REPOS_CENTER}/DRYa/all/bin/init-bin && vim traitsID.sh; f_up
      elif [ $1 == "5"        ]; then v_nm="F5";                  f_action; # Refresh the entire terminal 
      elif [ $1 == "wd"       ]; then v_nm="wikiD";               f_action; cd ${v_REPOS_CENTER}/wikiD && EM wikiD.org; f_up
      elif [ $1 == "cv"       ]; then v_nm="curriculum";          f_action; echo "Opening curriculum vitae"; emacs /data/data/com.termux/files/home/Repositories/moedaz/all/real-documents/CC/currriculo-vitae-Dv.org; f_up
      elif [ $1 == "links"    ]; then v_nm="ss-links";            f_action; echo "uDev: open shiva sutra links"; f_up
      elif [ $1 == "luxam"    ]; then v_nm="luxam";               f_action; cd ${v_REPOS_CENTER}/luxam/ && EM grelhas-de-avaliacao.org; f_up
      elif [ $1 == "trade"    ]; then v_nm="trade";               f_action; # Sync the trade.org wikipedia
      elif [ $1 == "om"       ]; then v_nm="om";                  f_action; # Sync the omni-log.org file 
      elif [ $1 == "note"     ]; then v_nm="note";                f_action; # Sync one Scratch File. Number of file is to be given as $2 (second argument)
      elif [ $1 == "car"      ]; then v_nm="car";                 f_action; # Sync a file with Everything about the car
      elif [ $1 == "upk"      ]; then v_nm="upk";                 f_action; # Asks in a menu, which file is meant to be sync
      elif [ $1 == "tm"       ]; then v_nm="tmux";                f_action; # Asks in a menu, which file is meant to be sync
      elif [ $1 == ".."       ]; then v_nm="edit-history-files";  f_action; # Asks in a menu, which file is meant to be sync

   # Caso tenha sido dado um argumento que nao consta na lista
      else 
         f_talk; echo "Invalid argument. Try again"    # If arguments are given but they are wrong


      fi
}   
