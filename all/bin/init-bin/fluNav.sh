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


function f__omni_log__push_hist_file_only {
   echo "uDev: Will be used drya-lib-4 here to work with omni-log"
}

function f__S_hist__refresh_file_name {
   # Ficheiro de historico com lista de ficheiros

   v_dir=~/.config/h.h/drya/flunav/tmp  &&  mkdir -p $v_dir
   v_file="drya-fluNav-S-hist" 

   i=$v_dir/$v_file

   v_fluNav_S_hist_file=$i

   # uDev: Omni log is not receiving files yet (use drya-lib-4)
   #       f__omni_log__push_hist_file_only
}

function f__V_hist__refresh_file_name {
   # Ficheiro de historico com lista de diretorios

   v_dir=~/.config/h.h/drya/flunav/tmp  &&  mkdir -p $v_dir
   v_file="drya-fluNav-V-hist" 

   i=$v_dir/$v_file

   v_fluNav_V_hist_file=$i

   # uDev: Omni log is not receiving files yet (use drya-lib-4)
   #       f__omni_log__push_hist_file_only
}

function f__S_hist__remove_duplicated_lines {
   # Removes duplicated lines from the history files using a temporary file

   # Note: This fx is meant to run only after history file's name was refreshed with f__S_hist__refresh_file_name
   
   # variable for the file names
      # Original file name (this var was created at f__S_hist__refresh_file_name)
      v_original=$v_fluNav_S_hist_file  

      # Temporary file name
      v_temporary=${v_original}.tmp

   
   # Creates a temporary file
      rm    $v_temporary 2>/dev/null   # Removes file if it exists. If it does not exist, then do not mention the error
      touch $v_temporary               # Create a temporary enpty file to work

   # Read original file line by line, but starting from the bottom with `tac` (instead of `cat`)
      for i in $(tac $v_original)
      do 
         # If original line does not exist already in the tmp file, copy it to tmp once
         grep --fixed-strings "$i" $v_temporary &>/dev/null
         [[ $? == 1 ]] && echo $i >> $v_temporary
      done

   # Overwrite original file with the content of temporary file
      tac $v_temporary > $v_original
   
   # Removing the tmp file in the end to clean dir
      rm $v_temporary
}

function f__S_hist__make_abs_path_into_relative_path {
   #echo "uDev: change: /data/data/com.termux/files/home/Repositories/"
   #echo "      into:   \${v_REPOS_CENTER}/ "
   sed -i "s#/data/data/com.termux/files/home/Repositories/#\${v_REPOS_CENTER}/#g" $v_original
}

function f__S_hist__change_abs_path__to__relative_path {
   echo "uDev: take fluNav:S history file, replace:"
   echo "      > /data/data/com.termux/files/home/Repositories/ to:"
   echo '      > ${v_REPOS_CENTER}/'
}

function f__V_hist__remove_duplicated_lines {
   # Removes duplicated lines from the history files using a temporary file

   # Note: This fx is meant to run only after history file's name was refreshed with f__S_hist__refresh_file_name
   
   # variable for the file names
      # Original file name (this var was created at f__V_hist__refresh_file_name)
      v_original=$v_fluNav_V_hist_file 

      # Temporary file name
      v_temporary=${v_original}.tmp

   
   # Creates a temporary file
      rm    $v_temporary 2>/dev/null   # Removes file if it exists. If it does not exist, then do not mention the error
      touch $v_temporary               # Create a temporary enpty file to work

   # Read original file line by line, but starting from the bottom with `tac` (instead of `cat`)
      for i in $(tac $v_original)
      do 
         # If original line does not exist already in the tmp file, copy it to tmp once
         grep --fixed-strings "$i" $v_temporary &>/dev/null
         [[ $? == 1 ]] && echo $i >> $v_temporary
      done

   # Overwrite original file with the content of temporary file
      tac $v_temporary > $v_original
   
   # Removing the tmp file in the end to clean dir
      rm $v_temporary
}

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
   echo "edited: ~/.bashrc"
   f_uDev
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

   read -s -n 1 -p " > Please enter [y/N]: " v_apply
   echo 
   echo 


   if [ -z $v_apply ]; then 
      echo " > No action taken"
      echo

   elif [ $v_apply == "y" ] || [ $v_apply == "Y" ]; then 
      echo " > Applying..." 
      echo

      f_applying_changes_init 

   elif [ $v_apply == "n" ] || [ $v_apply == "N" ]; then 
      echo "Not Applying..." 
      echo " > You may run this command again later"
      echo "   or apply manually"
      echo

   else 
      echo "Invalid answer. Not Applying"
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


function f_down {
   f_talk; echo "uDev: Download updates using drya-lib-4 (before opening file)"
}

function f_up {
   f_talk; echo "uDev: Upload updates using drya-lib-4 (after closing file)"
}





function . {
   # Navigate through the file system stupidly ez
   
   if [ -z $1 ]; then 
      # If no argument is given, lists storage (ls command)
      ls -p

   elif [ $1 == "?" ] || [ $1 == "h" ]; then 
      # Describe all these navigation alias

      f_greet
      f_talk; echo "Instructions:"
      echo
      echo '`. ?` or `. h`  Shows this help menu'
      echo '`. G`           Navigate to: Repos Center'
      echo ".  1x Means: open arguments given (with \`vim\` or \`cd\`)"
      echo
      echo ".  1x Means: ls (if there are no arguments)"
      echo "..  2x Means: cd .."
      echo "...  3x Means: cd -"
      echo "....  4x Means: pwd"
      echo ".....  5x Means: save this dir location in var \$h"
      echo "......  6x Means: save previous dir location in var \$v"
      echo ".......  7x Means: remember last 2 variables set as \$h and \$v"
      echo
      echo "To visit a file called 'h' use: \`vim h\`"

   elif [ $1 == "." ]; then 
      # Edit this script (fluNav)
      f_edit_self

   elif [ $1 == "G" ]; then 
      # If arg 1 is 'G' then navigate to the center of seiva's repos
      # uDev: Se houver uma pasta ou ficheiro com o nome "G", perguntar com `fzf` se quer abrir esse destino ou se quer ir para onde fluNav tem pre-destinado
      cd $v_REPOS_CENTER

   elif [ $1 == "t" ]; then 
      # If arg 1 is 't' then use `tree` in current dir
      # uDev: Se houver uma pasta ou ficheiro com o nome "t", perguntar com `fzf` se quer abrir esse destino ou se quer ir para onde fluNav tem pre-destinado
      # uDev: dizer em drya-status-messages qual é a depenencia (para o caso de dar erro por falta dela). Uma vez que é para isso que serve drya-status-message, é para ajudar no debug
      echo uDev

   elif [ $1 == "du" ]; then 
      # If arg 1 is 'dy' then use `du -h` para sabe quando espaco de memoria ocupa a pasta atual (ou ficheiro)
      echo uDev

   else
      # If argument is given, do the following:
      #  1. If arg is a directory: `cd`  into it
      #  2. If arg is a file:      `vim` to edit the file
      #  3. Also runs a script that fills a file $v_date_now = ~/.config/h.h/drya/drya_date_now that `vim` with '.vimrc' can use to paste into files with the command `Z..`

      # Create a file with the current date on it
         bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh f

      PWD=$(pwd) && \
      BASENAME=$(basename $PWD) && \
      cd $1 2>/dev/null \
      && f_talk \
      && echo "Listing files at:" \
      && echo " > ./$BASENAME" \
      && echo \
      && ls -p \
      || for i in $@; do vim $i; done  # uDev: if if is .jpg on termux, open accordingly 

   fi
}

function .. {
   # uDev: if there are an arg $2 with a number like `.. 3` navigate updir as many times as the number given

   cd ..
}

function ... {
   cd -
}

function .... {
   f_talk; echo 'Info: Current location `pwd`'
           echo " > $(pwd)"
}

function ..... {
   # Saves current directory location 
   # uDev: If script npNP gets finished, this one function gets useless. Finish that

   # Getting current dir's path
      h=$(pwd)

   # Verbose
      f_talk; echo 'Current location `pwd` saved as var $h'
              echo " > $h"
}

function ...... {
   # This function is usefull when you want to move files to the previous directory
      # 1 - Move to the destination you want to past the files
      # 2 - Move to the origin of the files in one command using absolute path (where they are currently)
      # 3 - press: .....
      # Use command: mv <file1> <file2> <file3> $v
      
   # uDev: If script npNP gets finished, this one function gets useless. Finish that

   # Getting last dir's path
      cd -   1>/dev/null   
      v=$(pwd)
      cd -   1>/dev/null   

   # Verbose
      f_talk; echo 'Last directory `pwd` saved as var: $v'
              echo " > $v"
}

function ....... {

   f_talk; echo 'Variable $h saved as:'
           echo " > $h"
           echo
   f_talk; echo 'Variable $v saved as:'
           echo " > $v"
}

function , {
   cd
}

function ,, {
   # Also resets the blinking cursor if it was hidden
   tput cnorm
   clear 
}  

function ,,, {
   # Same as both 2 previous commands put together
   , 
   ,,
}

function ., {
   # uDev: This is meant also to SEE if the directory is empty or not, therefore, if the dir is Totally empty, echo "This place is empty"
   ls -Ap
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

       L9='9. less '
       L8='8. less --wordwrap'
       L7='7. cat'
       L6='6. nano'
       L5='5. vim (easy mode)'  # `vim -y`

       L4='4. ed'   # Antigo editor de texto da Unix/Linux 
       L3='3. emacs'
       L2='2. vim'

       L1='1. Cancel'

      L0="fluNav: E: SELECT 1 editor de texto para pre-definir em \`e\`: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n$L8 \n$9 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "9.  " ]] && echo "uDev"
      [[ $v_list =~ "8.  " ]] && echo "uDev"
      [[ $v_list =~ "7.  " ]] && echo "uDev"
      [[ $v_list =~ "6.  " ]] && echo "uDev"
      [[ $v_list =~ "5.  " ]] && echo "uDev"
      [[ $v_list =~ "4.  " ]] && alias v_editor="ed" && echo "ed"
      [[ $v_list =~ "3.  " ]] && alias v_editor="emacs" && echo "emacs"
      [[ $v_list =~ "2.  " ]] && alias v_editor="vim" && echo "vim"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

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

      L0="fluNav: S: SELECT (1 ou +) ficheiros para editar: "
      
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

function f_fzf_mobile_android {
   # Navigate to places under `V mb`
   #    For `V mb` it is the arg $2 "f" or no arguments

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='V mb'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8='8. Go | WSL: C:\ '
      L7='7. Go | .../Internal storage/Termux-bridge-Android'
      L6='6. Go | .../mnt/USB (uDev: mounted USB. May use nanD)'
      L5='5. Go | external USB storage'
      L4='4. Go | SD Card storage'
      L3='3. Go | Internal storage'

      L2='2. Help/ Instructions'
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "8. " ]] && f_mobile_android_going_wsl
      [[ $v_list =~ "7. " ]] && f_mobile_android_going_termux_bridge_android
      [[ $v_list =~ "6. " ]] && f_mobile_android_going_USB_mnt_dir
      [[ $v_list =~ "5. " ]] && f_mobile_android_going_external_USB
      [[ $v_list =~ "4. " ]] && f_mobile_android_going_SD_card_storage
      [[ $v_list =~ "3. " ]] && f_mobile_android_going_internal_storage
      [[ $v_list =~ "2. " ]] && f_mobile_android_instructions
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_mobile_android_instructions {
   # Present Help and Instructions for `V mb`
   #    For `V mb` it is the arg $2 "h"

   echo "How to use:"
   echo "$ V mb [0|1|2|3|b|w|f|h]"
   echo '0) # Travel to Internal storage'
   echo '1) # Travel to SD Card storage'
   echo '2) # Travel to USB storage'
   echo '3) # Travel to the dir where many USB storages are mounted'
   echo 'b) # Travel to \"Internal storage/Termux-bridge-Android/\"'
   echo 'w) # Travel to directories related to wsl like C:\'
   echo 'f) # Menu fzz about all this'
   echo 'h) # Help and instructions'
}

function f_mobile_android_going_internal_storage {
   # Navigate to Internal Storage
   #    For `V mb` it is the arg $2 "0"

   # uDev: clear; pwd; echo "you are in X dir"
   echo "Internal storage"
   pwd
   echo

   f_greet
   echo "Internal Storage"
   f_horiz_line

   cd /sdcard && ls -p
}

function f_mobile_android_going_SD_card_storage {
   # Navigate to phone SD Card directory
   #    For `V mb` it is the arg $2 "1"

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

   cd $v_place_2 && ls -p
   f_horiz_line
   cd $v_place_3 && ls -p
}

function f_mobile_android_going_external_USB {
   # Navigate to External USB (at a phone)
   #    For `V mb` it is the arg $2 "2"

   echo "USB Storage"
   pwd
   echo

   f_greet
   echo "USB Storage"
   f_horiz_line

   cd /storage/83DB-10EA && ls -p || cd /storage && ls -p
}

function f_mobile_android_going_USB_mnt_dir {
   # Navigate to 
   #    For `V mb` it is the arg $2 "3"

   echo "List of options for: USB storage"
   pwd
   echo

   f_greet
   echo "Listing possible USB plugged in"
   f_horiz_line

   cd /storage && ls -p

   read -p "pause..."

   echo "Maybe Termux cannot WRITE to SD card,"
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
}

function f_mobile_android_going_termux_bridge_android {
   # Navigate to termux-bridge-android
   #    For `V mb` it is the arg $2 "b"

   f_greet

   echo "Directory: Internal Storage: Termux-bridge-Android"

   f_horiz_line

   cd /sdcard/Termux-bridge-Android && ls -p
}

function f_mobile_android_going_wsl {
   # Navigate to WSL (Windows subsistem for linux)
   #   For `V mb` it is the arg $2 "w"

   echo 'uDev: Navigating to C:\\ or Documents'
}

function f_mobile_android {
   #uDev: May be needed termux-setup-storage to access some directories

   if [ -z $v_arg2 ]; then 
      # If `V mb` does not come with one more arg ($2) then, menu fzf:
      f_fzf_mobile_android

   else
      # If `V mb` come with more args, act accordingly:

      case $v_arg2 in
         0) # Travel to Internal storage
            f_mobile_android_going_internal_storage
         ;;
         1) # Travel to SD Card storage
            f_mobile_android_going_SD_card_storage
         ;;
         2) # Travel to USB storage
            f_mobile_android_going_external_USB
         ;;
         3) # Travel to the dir where many USB storages are mounted
            f_mobile_android_going_USB_mnt_dir
         ;;
         b) # Travel to dir at Internal storage called Termux-bridge-Android
            f_mobile_android_going_termux_bridge_android
         ;;
         w) # Travel to wsl, C:\ etc..
            f_mobile_android_going_wsl
         ;;
         f) # Menu fzf about `V mb ...`  ## uDev: Remove everything and replace with fzf
            f_fzf_mobile_android
         ;;
         h) # Help and Instructions
            f_mobile_android_instructions
         ;;
         *) # If argument is invalid, present instructions
            f_mobile_android_instructions
         ;;
      esac
   fi
}

function f_uDev {
   # Function to remind the user about needed changes (uDev)
   echo -e "\n# uDev: all options MUST edit files inside DRYa repo (for easy upload) and then copy those files across the system"
}

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
   # This fx finds directories
   
   # uDev: Se for WSL3, detetar endereços: "C:\Users\$USER\Documents"
   # uDev: add: appdata (windows)
   # uDev: alias R: listar repositorios por numero para saltar para eles (ou usar menu fzf)


   function f_help {
      f_talk; echo "V: Instructions manual"
              echo '
   
      #  uDev: To replace NPnp looper: Keys
         `V .`  or `V search`       # Serve para adicionar PWD ao historico de loop
         `V h`  or `V help`         # 
         `V m`  or `V Menu`         # Menu fzf
         `V mb` or `V mobile`       # 
         `V +`  or `V add`          # Serve para adicionar PWD ao historico de loop
         `V -`  or `V rm`           # Serve para remover   PWD ao historico de loop
         `V RM` or `V erase-hist`   # Prompt the user if he wants to delete the entire list of locations
         `V rm` or `V remove
         `V ..                      # Edit/Visualize history file
         `V --                      # Remove all lines from history file   
         `V n`  or `V next`         # Serve para navegar em loop no historio ascendetemente 
         `V N`  or `V previous`     # Serve para navegar em loop no historio descendentemente 
         `V ls` or `V list-storage` # List all stored locations as other apps list buffers
   
      # Specific directory navigation
         `V d`  or `V drya` # Navigates do root of DRYa repo
         ...
   
      # Help and Usage (internal instructions):
         # Use 0:  `V h      `    # Help and instructions
         # Use 1:  `V        `    # Present a Menu
         # Use 2:  `V drya   `    # Travels to favorites  # uDev: to be absorved by the 'function . { }'
         # Use 3:  `V p <dir>`    # Create new dir and travel to it
         # Use 4:  `V r <dir>`    # finds and lists a dir to remove (use -R to confirm yout choice)
         # Use 5:  `V R <dir>`    # Removes dir (recommended to confirm which dir will be removed with the option -r)
         # Use 6:  `V .      `    # From current directory and below, uses `fzf` to search for a file. Then only navigate to its directory 
         # Use 7:  `V ..     `    # Navigate to last dir in the history list
         # Use 8:  `V ...    `    # Read the history file and select one path from there
         # Use 9:  `V <dir>  `    # Go to existent dir at current pwd
   '
   }

   function f_error_cd {
      # If `V` could not navigate to a certain dir beacuse it does not exist, then mention
      f_talk; echo "V: Such Dir does not exist (or repo not cloned)"
   }

   # Implementation of Use 1:
      if [ -z $1 ]; then 
         # Se nao for dado nenhum comando, abre o menu principal

         # Lista de opcoes para o menu `fzf`
            Lz1='Save '; Lz2='V'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

            L2='2. Apagar historico de pastas apresentadas por `V ...` (uDev)'                                      
            L1='1. Cancel'

            L0="fluNav: V: Menu de opcoes de Nav para Pastas: "
            
         # Ordem de Saida das opcoes durante run-time
            v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --pointer=">" --cycle --prompt="$L0")

         # Atuar de acordo com as instrucoes introduzidas pelo utilizador
            [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
            [[ $v_list =~ "2. " ]] && echo "uDev: $L2" 
            [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" 
            unset v_list

   # Implementation of Use 0:
      elif [ $1 == "h" ] || [ $1 == "help" ] || [ $1 == "?" ]; then
         f_help | less

   # Implementation of Use 2:
      # uDev: If correspondent repo does not exist, ask to clone intead of the error message

      elif [ $1 == "drya" ] || [ $1 == "dry" ] || [ $1 == "d" ] || [ $1 == "dd" ] || [ $1 == "D" ]; then
         cd ${v_REPOS_CENTER}/DRYa 2>/dev/null && ls -p || f_error_cd
      

      elif [ $1 == "jarve" ] || [ $1 == "jv" ] || [ $1 == "j" ] || [ $1 == "J" ]; then
         cd ${v_REPOS_CENTER}/jarve 2>/dev/null && ls -p || f_error_cd
      

      elif [ $1 == "moedaz" ] || [ $1 == "mo" ] || [ $1 == "m" ]; then
         if   [ -z $2      ]; then cd ${v_REPOS_CENTER}/moedaz 2>/dev/null && ls -p
         elif [ $2 == "cv" ]; then cd ${v_REPOS_CENTER}/moedaz/all/real-documents/CV 2>/dev/null && ls -p
         else f_error_cd
         fi

      elif [ $1 == "trade" ] || [ $1 == "t" ]; then
         cd ${v_REPOS_CENTER}/moedaz/all/trade/Binance-Bot 2>/dev/null && ls -p || f_error_cd
      

      elif [ $1 == "ezGIT" ] || [ $1 == "G" ] || [ $1 == "ez" ] || [ $1 == "g" ]; then
         cd ${v_REPOS_CENTER}/ezGIT 2>/dev/null && ls -p || f_error_cd
         

      elif [ $1 == "dwiki" ] || [ $1 = "dw" ]; then
         cd ${v_REPOS_CENTER}/dWiki 2>/dev/null && ls -p || f_error_cd
         

      elif [ $1 == "wiki" ] || [ $1 == "wikid" ] || [ $1 == "wikiD" ] || [ $1 = "wd" ] || [ $1 == "w" ]; then
         cd ${v_REPOS_CENTER}/wikiD 2>/dev/null && ls -p || f_error_cd
         

      elif [ $1 == "upk" ]; then
         cd ${v_REPOS_CENTER}/upK 2>/dev/null && ls -p || f_error_cd
         

      elif [ $1 == "upk-dv" ] || [ $1 == "upkd" ] || [ $1 == "upk-" ]; then
         cd ${v_REPOS_CENTER}/upK-diario-Dv && f_greet && f_talk; echo -e "\`V upk-dv\`\n" 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "ss" ]] || [ $1 == "112" ]; then
         cd ${v_REPOS_CENTER}/112-Shiva-Sutras 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "omni" ]] || [[ $1 == "log" ]] || [[ $1 == "om" ]]; then
         cd ${v_REPOS_CENTER}/omni-log 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "gps" ]]; then
         cd ${v_REPOS_CENTER}/mastering-GPS 2>/dev/null && ls -p || f_error_cd


      elif [[ $1 == "verbose-line" ]] || [ $1 == "vbl" ] || [ $1 == "vb" ]; then
         cd ${v_REPOS_CENTER}/verbose-lines 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "yoga" ]] || [ $1 == "Y" ] || [ $1 == "yg" ] || [ $1 == "y" ]; then
         cd ${v_REPOS_CENTER}/yogaBashApp 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "shamb" ]]; then
         cd ${v_REPOS_CENTER}/yogaBashApp/all/all-shambavi/ 2>/dev/null && ls -p || f_error_cd
      

      elif [[ $1 == "3sab" ]] || [[ $1 == "3s" ]] || [[ $1 == "3" ]]; then
         cd ${v_REPOS_CENTER}/3-sticks-alpha-bravo 2>/dev/null && ls -p || f_error_cd
         

      elif [[ $1 == "one" ]] || [[ $1 == "1" ]]; then
         cd ${v_REPOS_CENTER}/oneFile-bau 2>/dev/null && ls -p || f_error_cd


      elif [[ $1 == "scratch" ]] || [ $1 == "paper" ] || [ $1 = "sc" ]; then
         # uDev: `D q 1` to remove the repo
         cd ${v_REPOS_CENTER}/scratch-paper 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "dota" ]; then
         cd ${v_REPOS_CENTER}/Dota-2-guide 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "luxam" ]; then
         cd ${v_REPOS_CENTER}/luxam 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "ga" ] || [ $1 == "garpho" ]; then
         cd ${v_REPOS_CENTER}/garpho 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "ts" ] || [ $1 == "typescript" ] || [ $1 == "typescript-berg-house" ]; then
         cd ${v_REPOS_CENTER}/typescript-berg-house 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "cv" ] || [ $1 == "curriculum" ] || [ $1 == "curriculum-vitae" ]; then
         cd ${v_REPOS_CENTER}/Curriculum-Vitae 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "tmp" ]; then
         mkdir -p ~/.tmp
         cd ~/.tmp/ && ls -p


      elif [ $1 == "code" ]; then
         mkdir -p ~/.code
         cd ~/.code/ && ls -p


      elif [ $1 == "center" ]; then
         cd ${v_REPOS_CENTER} && ls -p


      elif [ $1 == "lxm" ]; then
         cd ${v_REPOS_CENTER}/luxam 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "wsl" ] || [ $1 == "win" ] || [ $1 == "W" ]; then
         cd /mnt/c/ 2>/dev/null && ls -p || f_error_cd


      elif [ $1 == "ln" ]; then
         # Se a pasta ~/ls/ existir, navega para ela e lista os seus conteudos
         [[ -d ~/ln/ ]] && cd ~/ln/ && ls -p


      elif [ $1 == "mb" ] || [ $1 == "mobile-android" ]; then
         v_arg2=$2
         f_mobile_android


   # Implementation of Use 3:
      elif [ $1 == "p" ]; then
         mkdir -p $2
         cd $2
         ls

   # Implementation of Use 4:
      elif [ $1 == "r" ]; then
         ls $2

   # Implementation of Use 5:
      elif [ $1 == "R" ]; then
         rm -rf $2
         ls
      # uDev: provide more safety



   # Implementation of Use 6:
      elif [ $1 == "." ]; then
         # From current directory and below, uses `fzf` to search for a file. Then only navigate to its directory 
         
         # Refresh the variable that stores the path
            f__V_hist__refresh_file_name  
            f__V_hist__remove_duplicated_lines

         # Info adicional durante o menu 
            Lh=$(pwd); Lh=$(basename $Lh); LH="Searching dirs at: .../$Lh/"

         # Menu fzf que procura subpastas 
            v_dir=$(fzf --header="$LH" --prompt="NAVEGUE para uma pasta (pode ignorar o conteudo): ")

         # Se tiver havido alguma escolha (que vem na var $v_dir) entaom navegar para la
            if [[ -n $v_dir ]]; then
               v_dirname=$(dirname $v_dir)
               v_pwd=$(pwd)

               v_last="$v_pwd/$v_dir"
               v_last=$(dirname $v_last)

               f_talk; echo "A navegar para: $v_dirname"
               #echo "$v_pwd/$v_dir" >> $v_fluNav_V_hist_file
               echo "$v_last" >> $v_fluNav_V_hist_file
               cd $v_dirname 
            fi


   # Implementation of Use 7:
      elif [ $1 == ".." ]; then
         if [ -z $2 ]; then
            # If no 'number' is given as 2nd arg: Navigate to last dir in the history list

            # Refresh the variable that stores the path
               f__V_hist__refresh_file_name  
               f__V_hist__remove_duplicated_lines

            v_go=$(tail -n 1 $v_fluNav_V_hist_file)
            cd $v_go

         else
            # If 'number' is given as 2nd arg: Filter history file and Navigate to corresponding line (from most recent to oldest)
            # HISTORY FILE will not be updated on purpouse

            # Testar se o arg dado foi um numero
               if [[ "$2" =~ ^-?[0-9]+$ ]]; then
                  echo "É um número inteiro" 1>/dev/null  # Debug
                  f__V_hist__remove_duplicated_lines
                  v_line=$(tail -n $2 $v_fluNav_V_hist_file | head -n 1 )
                  f_talk; echo "V: Navigating to: $v_line"
                  cd $v_line
               else
                  echo "Arg: 2: Tem de ser número inteiro (para navegar para a linha de historico de pastas correspondente"
               fi
         fi

   # Implementation of Use 8:
      elif [ $1 == "..." ]; then
         # Read the history file and select one path from there

         # Used only to centralize the history file into one single variable across the file
            f__V_hist__refresh_file_name  
            f__V_hist__remove_duplicated_lines

         # Criar um menu apartir do historico  
            # uDev: apagar linhas repetidas
            v_hist=$(cat $v_fluNav_V_hist_file | tac | fzf --prompt "fluNav: V: Historico, para NAVEGAR de novo: ")
      
         # Se a variavel nao vier vazia do menu fzf (e o utilizador escolheu um ficheiro para editar), entao abrir com o vim
            [[ -n $v_hist ]] && cd $v_hist && ls -p && unset $v_hist

      elif [ $1 == "...." ]; then
         # Used only to centralize the history file into one single variable across the file
            f__V_hist__refresh_file_name  
            f__V_hist__remove_duplicated_lines

         # Edit file manually 
            vim $v_fluNav_V_hist_file

   # Implementation of Use 9:
      else 
         # mkdir -p ~/.tmp
         # ls > ~/.tmp/found.txt
         # grep -n "$1" ~/.tmp/found
         # wc -l ~/.tmp/found

         v_found=$(ls | grep $1)
         echo Found: $v_found
         if [[ $? == "0" ]]; then
            cd $v_found && ls -p
         fi
         #uDev: use to command '$ file' to exclude all non directories
         #uDev: when there are 2 or more items found, allow the user to input a number as $2
   fi

}

function f_action {
   # When we use any F at the terminal prompt, the $1 arg is going to be evaluated here
   # Nota: Seria util que antes de abrir um ficheiro, fluNav navegasse primeiro para o seu dir relativo. Assim ao fechar o ficheiro, sabemos a qual repo pertence. isso ajuda aos dev que usam git
 
   if [ $v_nm == "fx_test" ]; then
      # fluNav testing (opening a file after downloading updates from github and sending it back after to github).

      f_greet
      f_down  # uDev: f_tst_repo: test if correspondant repo is already cloned (with drya-lib-4)

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

      cd  ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/
      vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/tm-tmux


   elif [ $v_nm == "search_history_files" ]; then
      # Search files with fzf menu and open with vim (but only those who are already listed in the history file)
      # `S ,`

      # Used only to centralize the history file into one single variable across the file
         f__S_hist__refresh_file_name
         f__S_hist__remove_duplicated_lines

      # Menu fzf that lists recent files
         unset v_list
         v_file=$(cat $v_fluNav_S_hist_file | fzf --prompt="fluNav: S: Searching history files: ")

         [[ -n $v_file ]] && vim $v_file 

   elif [ $v_nm == "search_files" ]; then
      # From current directory, search files with fzf menu and open with vim 
      # `S .`

      # uDev: add: `basename $(pwd)` ou absolute path no ficheiro de historico. Depois para pesquisar, remover $PREFIX com `sed`

      # Used only to centralize the history file into one single variable across the file
         f__S_hist__refresh_file_name
         f__S_hist__remove_duplicated_lines
         f__S_hist__change_abs_path__to__relative_path

      # Apartir da pasta atual ate todas as subpastas, Pesquisar todos os ficheiros e guardar na variavel $v_file
         Lh=$(pwd); Lh=$(basename $Lh); LH="Searching files at: .../$Lh/"
         unset v_list
         v_file=$(fzf --prompt="fluNav: edite 1 ficheiro: " --header="$LH" --preview 'cat {}' --preview-window=right:40%)

      # Se o menu fzf NAO vier vazio, envia o resultado para o ficheiro de historico e edita o ficheiro encontrado
         v_pwd=$(pwd)

         [[ -n $v_file ]] \
            && echo "$v_pwd/$v_file" >> $v_fluNav_S_hist_file \
            && f_talk \
            && echo "a Editar: $v_file" \
            && vim $v_file  



   elif [ $v_nm == "search_files_with_query" ]; then
      unset e; shift; for i in $@; do e="$e$i"; done;  v=$(fzf --query="$e" --select-1 --exit-0);  echo "Result: $v" 

   elif [ $v_nm == "edit_last_h_file" ]; then
      # Editar o ultimo ficheiro de historico
      # `S ..` 

      # Used only to centralize the history file into one single variable across the file
         f__S_hist__refresh_file_name
         f__S_hist__remove_duplicated_lines

      # Verificar qual é a ultima linha do ficheiro de historico
         [[ -f $v_fluNav_S_hist_file ]] && v_last=$(tail -n 1 $v_fluNav_S_hist_file)

      # Se a variavel nao vier vazia (e o utilizador escolheu um ficheiro para editar), entao abrir com o vim
         [[ -n $v_last ]] && vim $v_last || echo "fluNav: Nothing written in history file to edit"



   elif [ $v_nm == "fzf_one_hist_file" ]; then
      # Selecionar de um historico de ficheiro, um ficheiro para voltar a abrir
      # `S ...`

      # Used only to centralize the history file into one single variable across the file
         f__S_hist__refresh_file_name
         f__S_hist__remove_duplicated_lines
         #f__S_hist__make_abs_path_into_relative_path 

      # Buscar uma das linhas
         #v_hist=$(cat $v_text | tac | fzf --prompt "SELECIONE do Historico de ficheiros, 1 para EDITAR: ")
         v_hist=$(cat $v_fluNav_S_hist_file | fzf --tac --prompt "SELECIONE do Historico de ficheiros, 1 para EDITAR: ")
   
      # Se a variavel nao vier vazia do menu fzf (e o utilizador escolheu um ficheiro para editar), entao abrir com o vim
         [[ -n $v_hist ]] && vim $v_hist && unset $v_hist

      # Se a variavel nao vier vazia do menu fzf, tambem envia a ultima selacao para o fim do documento de historico
         [[ -n $v_hist ]] && echo "$v_hist" >> $v_fluNav_S_hist_file


   elif [ $v_nm == "edit_hist_file" ]; then
      # Editar o ficheiro de historico
      # `S ....`

      f__S_hist__refresh_file_name  # Used only to centralize the history file into one single variable across the script
      f__S_hist__remove_duplicated_lines
      
      vim $v_fluNav_S_hist_file

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
      # Edit this script (fluNav)
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
      elif [ $1 == "."        ]; then 
         if   [ -z $2 ]; then v_nm="search_files";                     f_action; # Search Files with fzf, then open
         elif [ -n $2 ]; then unset e; shift; for i in $@; do e="$e$i"; done; v=$(fzf --prompt="Automatic query: " --query="$e" --select-1 --exit-0); echo "Result: $v";fi  # For each argument given after first argument, filter with grep as if it is a fuzzy finder like fzf
      elif [ $1 == ".."       ]; then v_nm="edit_last_h_file";       f_action;     # Asks i
      elif [ $1 == "..."      ]; then v_nm="fzf_one_hist_file";      f_action;     # Asks i
      elif [ $1 == "...."     ]; then v_nm="edit_hist_file";         f_action;     # Asks i
      elif [ $1 == ","        ]; then v_nm="search_history_files";   f_action;     # Asks i
      elif [ $1 == "-2"       ]; then v_nm="test";                   f_action; echo "Test is working for 19"; f_up
      elif [ $1 == "-1"       ]; then v_nm="fx_test";                f_action; ## Just test if this file is working
      elif [ $1 == "S"        ]; then v_nm="self";                   f_action; ## Edit this file itself 
      elif [ $1 == "0"        ]; then v_nm="unalias";                f_action; source ~/.bashrc
      elif [ $1 == "1"        ]; then v_nm="dryaSH";                 f_action; vim ${v_REPOS_CENTER}/DRYa/drya.sh; #f_up
      elif [ $1 == "1."       ]; then v_nm="dryaSH_op_1";            f_action; cd  ${v_REPOS_CENTER}/DRYa && EM drya.sh; f_up
      elif [ $1 == "2"        ]; then v_nm="initVIM";                f_action; f_edit__init_file_emacs__with_vim; f_up
      elif [ $1 == "3"        ]; then v_nm="jarve-sentinel";         f_action; cd ${v_REPOS_CENTER}/DRYa/all/bin/ && vim jarve-sentinel.sh; f_up
      elif [ $1 == "4"        ]; then v_nm="traitsID";               f_action; cd ${v_REPOS_CENTER}/DRYa/all/bin/init-bin && vim traitsID.sh; f_up
      elif [ $1 == "5"        ]; then v_nm="F5";                     f_action; # Refresh the entire terminal 
      elif [ $1 == "wd"       ]; then v_nm="wikiD";                  f_action; cd ${v_REPOS_CENTER}/wikiD && EM wikiD.org; f_up
      elif [ $1 == "cv"       ]; then v_nm="curriculum";             f_action; echo "Opening curriculum vitae"; emacs /data/data/com.termux/files/home/Repositories/moedaz/all/real-documents/CC/currriculo-vitae-Dv.org; f_up
      elif [ $1 == "links"    ]; then v_nm="ss_links";               f_action; echo "uDev: open shiva sutra links"; f_up
      elif [ $1 == "luxam"    ]; then v_nm="luxam";                  f_action; cd ${v_REPOS_CENTER}/luxam/ && EM grelhas-de-avaliacao.org; f_up
      elif [ $1 == "trade"    ]; then v_nm="trade";                  f_action; # Sync the trade.org wikipedia
      elif [ $1 == "om"       ]; then v_nm="om";                     f_action; # Sync the omni-log.org file 
      elif [ $1 == "note"     ]; then v_nm="note";                   f_action; # Sync one Scratch File. Number of file is to be given as $2 (second argument)
      elif [ $1 == "car"      ]; then v_nm="car";                    f_action; # Sync a file with Everything about the car
      elif [ $1 == "upk"      ]; then v_nm="upk";                    f_action; # Asks in a menu, which file is meant to be sync
      elif [ $1 == "tm"       ]; then v_nm="tmux";                   f_action; # Asks in a menu, which file is meant to be sync


   # Caso tenha sido dado um argumento que nao consta na lista
      else 
         f_talk; echo "Invalid argument. Try again"    # If arguments are given but they are wrong


      fi
}   
