#!/bin/bash

# uDev: Coordenar com `op`, em, Em, EM (emacs)

function e {
   # Title: e
   # Description: Este script `e` busca num ficheiro X qual é o editor de texto pre-definido (segundo o user de DRYa, nao do user do OS). O nome do editor de texto que for encontrado nesse ficheiro sera usado para abrir quaisquer ficheiros que sejam fornecido como argumentos no prompt 
   # Use: Use `ee` to define file editor, then open files with `e <file>`

   # Variaveis: $trid_dir         (diretorio de configs do traitsID.sh)
   #            $trid_editor      (nome do ficheiro existente em $trid_dir, cujo texto no seu interior é so o nome do editor de texto)
   #
   #            $trid_editor_file (Variavel dentro de traitsID.sh: `trid_editor_file=$trid_dir/trid_editor`
   #            $trid_editor_name (Texto recolhido de dentro do ficheiro com o nome $trid_editor, que existe na pasta $trid_dir. (Configurado dentro de traitsID.sh na fx f_traits_7)

   # Use: After 'traitsID.sh' detects system editor
   #      Example with `e file.txt`

   # uDev: `e` `ee` and `eee` should be on the same file.... maybe fluNav

   # Sourcing DRYa Lib 1: Color schemes
      v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
      [[ -f $v_lib1 ]] && source $v_lib1 || read -s -n 1 -p "DRYa: drya-lib-1 does not exist (error)"

      # Examples: f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
         v_greet="DRYa"
         v_talk="DRYa: e: "





   # Pesquisar a ultima alteracao ao ficheiro $trid_editor_file
      # Nota: Esta var tambem existe em traitsID.sh 
      trid_editor_name=$(cat $trid_editor_file 2>/dev/null)

   if [ -z $1 ]; then
      f_talk; echo "Qual o ficheiro que quer editar? (com $trid_editor_name)"

   elif [ $1 == "." ]; then

      # Variable to edit self (this script)
         v_self=${v_REPOS_CENTER}/DRYa/all/bin/init-bin/drya-text-editor.sh

      if [ -z $2 ]; then
         vim $v_self

      elif [ $2 == "v" ] || [ $2 == "vim" ]; then
         f_talk; echo "Escolhido editor 'vim'"

         # Para cada item fornecido como arg, editar com o editor que existir no ficheiro de config
            shift  # Para retirar `.`
            shift  # Para retirar `v`

            for i in $* 
            do
               echo " > vim $i"  # Tambem funciona como Debug
               read -sn1 -t 1
               vim $i
            done

      elif [ $2 == "e" ] || [ $2 == "emacs" ]; then
         f_talk; echo "Escolhido editor 'emacs'"

         # Para cada item fornecido como arg, editar com o editor que existir no ficheiro de config
            shift  # Para retirar `.`
            shift  # Para retirar `e`

            for i in $* 
            do
               echo " > emacs $i"  # Tambem funciona como Debug
               read -sn1 -t 1
               EM $i
            done
      fi

   else

      if [[ -z $trid_editor_name ]]; then
         # Mencionar se funciona ou nao
            f_talk; echo "Nenhum editor. Sera usado: vim"

         # Para cada item fornecido como arg, editar com o vim
            for i in $*
            do
               echo " > vim $i"  # Tambem funciona como Debug
               vim $i
            done

      else
         # Mencionar se funciona ou nao
            f_talk; echo "A editar ficheiros com: $trid_editor_name"

         # Para cada item fornecido como arg, editar com o editor que existir no ficheiro de config
            for i in $* 
            do
               echo " > $trid_editor_name $i"  # Tambem funciona como Debug
               eval $trid_editor_name $i
            done
      fi

   fi
}




function ee {
   # Menu `ee` to select the text editor. Works in tandem with the script `e` (located at .../DRYa/all/bin/e)

   if [ -z $1 ]; then
      # Escolher editor de texto para pre-definir 
      # uDev: Tem de funcionar em dintonia com traitsID

      # In fluNav, there is a command to open either a dir or to open a file:
      # '$ . <file>'
      # and if there is no dir or existent file, it will create one,
      # so, this function will decide which text editor will open the file

      trid_editor_file=$trid_dir/trid_editor
      trid_editor_name=$(cat $trid_editor_file) 2>/dev/null

      # Getting variable of current text editor
         Lhc=$(cat $trid_editor_file)

      # Lista de opcoes para o menu `fzf`
         Lz1='Saving '; Lz2='ee'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

         L11='11. `clone repo` + `cd repo` + `e *example-file.txt*` + `git push`'
         L10='10. less --wordwrap'
          L9='9.  vim (easy mode, `vim -y`)' 

          L8='8.  cat'
          L7='7.  nano'
          L6='6.  less '
          L5='5.  ed'   # Antigo editor de texto da Unix/Linux 
          L4='4.  emacs'
          L3='3.  vim'

          L2='2.  Print editor atual | `ee .`'
          L1='1.  Cancel'
         
         Lh=$(echo -e "\nNote: Current default text editor: $Lhc \n > Alias e=\"$Lhc\" \n ")
         L0="fluNav: ee: Set/Toggle/Swap text editor: "
         
         v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n\n$L9 \n$L10 \n$L11 \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

      # Atualizar historico fzf automaticamente (deste menu)
         echo "$Lz2" >> $Lz4
   
      # Perceber qual foi a escolha da lista
         [[   $v_list =~ $Lz3   ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
         [[   $v_list =~ "11. " ]] && echo "uDev"
         [[   $v_list =~ "10. " ]] && echo "less --wordwrap" > $trid_editor_file
         [[   $v_list =~ "9.  " ]] && echo "vim -y"          > $trid_editor_file
         [[   $v_list =~ "8.  " ]] && echo "cat"             > $trid_editor_file
         [[   $v_list =~ "7.  " ]] && echo "nano"            > $trid_editor_file
         [[   $v_list =~ "6.  " ]] && echo "less"            > $trid_editor_file
         [[   $v_list =~ "5.  " ]] && echo "ed"              > $trid_editor_file
         [[   $v_list =~ "4.  " ]] && echo "emacs"           > $trid_editor_file
         [[   $v_list =~ "3.  " ]] && echo "vim"             > $trid_editor_file
         [[   $v_list =~ "2.  " ]] && cat $trid_editor_file
         [[   $v_list =~ "1. "  ]] && echo "Canceled: Menu: $Lz2" 
         unset v_list

   elif [ $1 == "." ]; then
      cat $trid_editor_file
   fi
}

function eee {
   echo "uDev: open cheat sheets for current editor"
}

alias xdg=xdg-open

function op {
   # Function to open all files and directories given as arguments ($*)
      # Similar apps: termux-open; termux-open-url; wslview

   # uDev: Since DRYa is developing traitsID, then in the future we will get our OS from an environment variable made by DRYa

   # Test in which OS this script is running:
      v_uname=$(uname -a)

   # from the list o arguments, send links to an array, send non-links to another array
      # Unseting array variabls, so that they start empty
         unset link links          # Erasing the contents of the 'links' variable/array
         unset non_link non_links  # Erasing the contents of the 'non_links' variable/array
         #unset ls_detected_files
         #unset op_special_commands
         #unset saved_recognized_files

      # Filtering the arguments 
      #  for i in $*
      #  do
      #     # Testing each arg
      #        link=$(echo $i | grep "^http")         # Attempt to detect if a given argument is a link
      #        non_link=$(echo $i | grep -v "^http")  # Ateempt to detect if a given argument is not a link (by inverting the grep search with -v)

      #     # For debug, verbose var:
      #        echo "arg: $i"

      #     # If var if link, go to Variable A; If var is non_non link, go to var B  (WITH VERBOSE, FOR DEBUG)
      #        [[ ! -z $link ]] && echo "'link' var is: $link" && \
      #        links+=("$link")  # If variable 'link' comes with some value (meaning that we detected a link) then, append it to the array 'links'

      #        [[ ! -z $non_link ]] && echo "'non_link' var is: $non_link" && \
      #        non_links+=("$non_link")
      #  done

      # Verbose results (for debug):
      #  echo
      #  echo "------------------------------"
      #  echo "'links' array: ${links[@]}"
      #  echo "'non_links' array: ${non_links[@]}"
      #  #read; clear; exit 0  # For testing only

   
   if [ -z $1 ]; then
      # Search file to open with `fzf`

      # Buscar um ficheiro apartir da pasta atual até todas as subpastas
         unset v_item
         v_item=$(fzf -m --prompt="DRYa: op: Select ficheiros para abrir com xdg-open: ")

      # So se houver algum nome na variavel $v_item, tenta abrir com xdg (evita `xdg-open` de reclamar erro por falta de argumentos)
         [[ -n $v_item ]] && for i in $(echo $v_item); do echo "DRYa: opening: $i"; xdg-open $i; done

   elif [[ $1 == "brave" ]]; then

      if [[ $v_uname =~ "microsoft" ]]; then 
         v_erro="DRYa: could not open brave on"
         /mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe || echo "$v_erro windows (error)"

      else
         echo "uDev: Nao disponivel sem ser para windows"

      fi

   else
      # Try to find the file opener at each OS (for the given files, given as arguments):
         if [[ $v_uname =~ "Microsoft" ]]; then  # Test if this script is a Linux OS running inside windows (WSL (Windows sub-system for Linux):
            /mnt/c/windows/explorer.exe $*  # Original script, without a for loop
      
              # uDev: For links and non_links open accordingly:   
              #   # open each link
              #      for i in ${links[@]}
              #      do 
              #         /mnt/c/windows/explorer.exe $links  #Error: windows explorer does not open links
              #      done
              #
              #   # open each non_link
              #      for i in ${non_links[@]}
              #      do 
              #         /mnt/c/windows/explorer.exe $non_links
              #      done

         elif [[ $v_uname =~ "Android" ]]; then  # If it finds "Android" then it should be working at Termux terminal
               xdg-open $*
               # uDev: usar `termux-open --chooser`

         elif [[ $v_uname =~ "Linux" ]]; then  # If it is Any kind of Linux, try to open as standard
               xdg-open $*
         else
            echo "DRYa: 'op' command failed to open the arguments"
         fi
         
         # uDev: Add 'termux-open $* --chooser' as an option

         # uDev: '$ op grep 20240114_094706.jpg' para procurar 'grep' pela foto certa
         #       '$ op grep mv 20240114_094706.jpg' para mover a foto encontrada (precisa de um menu interativo)
      fi
}


function go {
	# This function opens applications apart from the terminal. It means that you can close the terminal after the aplications launch and the terminal being killed does not kill the apps it created
	for v_arg in $@
	do
		setsid $v_arg &>/dev/null
	done

      # Detecting if any of the arguments given has the word "terminal" to replace for "gnome-terminal"
      if [[ $@ =~ "terminal" ]]; then setsid gnome-terminal &>/dev/null; fi


      # Detect if LAST argument is "bye" to make the current terminal "exit"
         # Store all arguments inside a variable
         v_allArguments=$*
         
         # Using awk to detect only the last argument
         v_lastArg=$(echo $v_allArguments | awk '{ print $NF }')
         if [ ${v_lastArg} == "bye" ]; then 
            #echo "bye was said. Press enter to exit"    #Exit message
            #read                                        #Pause before exit
            exit
         fi

      # If there is an app called "bye" that you want to open with the command "go" then just put something else in from of it to prevent "exit" command to happen
         # Use: $ go bye ...

      # If you simply want to restart the terminal
         if [ $1 == "again" ]; then gnome-terminal && exit; fi

   # If you want to export just this "go" script for an entire repository, the name sugested is: bash-open-app-at-external-window
}

function f_emacs {
   # Attempt to untangle emacs alias (due to so many versions)
   
   # Path to binary emacs .exe for windows
      v_emacs_gui="/mnt/c/Program\ Files/Emacs/x86_64/bin/emacs.exe" 

   # Alias for TUI emacs (on Linux, Windows)
      alias emacs="emacs"
      alias    em="emacs"
      alias   ems="emacs --script"

   # Alias for GUI emacs (on windows only)
      alias Emacs="$v_emacs_gui" 
      alias    Em="$v_emacs_gui"

   # Alias 'EM' to adapt for the best emacs executable. Will TRY to set GUI first. If GUI is not existent, set as TUI instead (Usually the best alias to use)
      if [[ -f $v_emacs_gui ]]; then 
         alias EM="$v_emacs_gui"  # If emacs GUI exists (on windows), then
      else 
         alias EM="emacs"         # If emacs GUI does not exist, then set it for terminal emacs
      fi
}
f_emacs

