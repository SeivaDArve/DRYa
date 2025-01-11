#!/bin/bash

function f_greet {
   # If 'figlet' app is installed, print an ascii version of the text "DRYa" to improve the appearence of the app
      clear
      figlet DRYa || echo -e "( DRYa ):\vrunning drya.sh\n"
}

function f_c1 {	
   # Fx for colored text: Cor 1
   tput setaf 5 
}

function f_c2 { 
   # Fx for colored text: Cor 2
   tput setaf 2 
}

function f_c3 { 
   # Fx for colored text: Cor 3
   tput setaf 3
}

function f_c4 { 
   # Fx for colored text: Cor 4 (Similar to Bold)
   tput setaf 4
}

function f_c5 { 
   # Fx for colored text: Cor 5 (Similar to Bold)
   tput setaf 6
}

function f_rc { 
   # Fx for colored text: Standard (reset)
   tput sgr0
}

function f_talk {
         echo
   f_c4; echo -n "DRYa: "
   f_rc
}

function f_horizontal_line {
   # This function calculates the amount of line present in the terminal window for the current zoom and creates an horizontal line across the screen

   # Detecting how many columns there are currently in the terminal screen
      #v_cols="$COLUMNS"                     ## Method 1 (some linux distros have this environment variable)   
      v_cols=$(stty size | cut -d" " -f 2)  ## Method 2
      #v_cols=$(tput cols)                   ## Method 3 (tput needs to be installed)

   # Subtracticting 4 to this variable
      v_cols2=$(expr $v_cols - 4)

   # Debug: 
      #echo -e "There are currently $v_cols columns in the screen \n and from that number, $v_cols is the\n number of dashes '-' that the menu will have "; read

   # You may choose the apropriate symbol here
      v_underscore="-"

   # Store in a var, how many dashes can be replaced by empty spaces (according to the specific amount of available columns)
      v_underscoreCount=""

    for e in $(seq 1 $v_cols); do
      v_underscoreCount="${v_underscoreCount}${v_underscore}"
    done

   # The result is an horizontal line
      v_line=$v_underscoreCount

      # Debug:
         #echo "var '$v_line' is $v_underscoreCount" ; read

   # Removing last 4 characters from v_line. This way it can be used in SELECT menus
      v_line2=${v_line::-4}

      #export v_line
      #export v_line2

}

# Menu dizer SIM/nao. Enter = SIM
   function f_Yn_option {
      echo "Do you want to continue? [Y/n]"
      read -p " > " v_ans

      if [ -z $v_ans ] || [ $v_ans = "y" ] || [ $v_ans == "Y" ]; then
         echo "O programa continua"
      else
         echo "O programa acaba aqui"
      fi
   }

# Menu dizer sim/NAO. Enter = NAO
   function f_yN_option {
      echo "Do you want to continue? [y/N]"
      read -p " > " v_ans

      if [ -z $v_ans ] || [ $v_ans = "n" ] || [ $v_ans == "N" ]; then
         echo "O programa continua"
      else
         echo "O programa acaba aqui"
      fi
   }
   
# Date variables
   v_date=$(date +'%Y-%m-%d %H:%M:%S')
   v_date="Data/Hora: $v_date"

# Horizontal line variables
   # uDev

# Ficheiro tmp em pasta tmp

# Sound Samples
   termux-media-player play ${v_REPOS_CENTER}/DRYa/all/etc/sounds/example-sound-completion-bell.wav






# [fzf menu: Suplementos]

   function f_pin {
      # Adicionar codigo para aceder a fx pretendida
      echo
      #[[ $v_pin == "x" ]] && echo "pin acepted... (uDev)"

   }

   function f_stop_duplicates {
      # Mantem apenas X linhas (por exemplo 20) no ficheiro de historico
      # Remove linhas duplicadas no ficheiro de historico (com preferencia das mais antigas).
      echo
   }





# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Opcao c/ Pin'                                       
      L3='3. Opcao c/ fx history';  L3c='<fx-terminal-command>'  # L3c: terminal command to send to history file
      L2='2. Opcao simples'                                      
      L1='1. Cancel'

      L0="SELECIONE 1 do menu (exemplo): "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "4. " ]] && f_pin && echo "uDev: $L4"
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3" && history -s "$L3c" 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2" && sleep 0.1 
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
	 


# [fzf menu exemplo 2] 
   # Menu com loop + texto extra no proprio menu, onde o texto é discartado, apenas respostas validas sao validas

   while true
   do
      # Texto do menu
         Lz='`Terminal Command HERE`'

         L4="Escolha 1 destas opcoes"
         Lm="-----------------------"
         L3="2. Opcao 2. foo"
         L2="1. Opcao 3. bar"
         L1="Cancel"

         L0="SELECIONE (1 ou +) do menu: "
      
         v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lm \n$L4" | fzf -m --prompt="$L0")
      
      # As SELECOES nao podem conter a o texto "hipotese" nem linhas vazias de 3 espacos "   ". So quando nao tem esse texto Ã© que quebra o loop
         if [[ $v_list =~ "destas" ]] || [[ $v_list =~ "---" ]]; then
            echo "Menu: opcoes invalida. [ENTER] para tenrar novamente"; read -sn 1
            continue
         else
            break
         fi
   done

   # Quando o menu de Escolha multipla tipo `for` loop
      [[ $v_list =~ "1. " ]] && echo "uDev: 1"
      [[ $v_list =~ "foo" ]] && echo "uDev: 2"
      [[ $v_list =~ "bar" ]] && echo "uDev: 3"
      unset v_list  # Reset a Variavel






# [fzf menu exemplo 3]  (uDev)

   function f_void {
      # Runs only once at the beginning
      L5="5. [X] Verbose help"
      L5x="5. [ ] Verbose help"
      L5X="5. [X] Verbose help"
   }
 
   function f_loop {
      # Esta fx pode voltar a ser chamada varias vezes 

      # Lista de opcoes para o menu `fzf`
         L0="DRYA: Fx List:" 

         # Void: L5, ...
         L4="4. notify (+ Android notifications)"
         L3="3. Calculadoras"
         L2="2. Manage dot-files"
         L1="1. Cancel" 

         v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5" | fzf --cycle --prompt="$L0")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ "5. " ]] && [[ $v_list =~ "[X]" ]] && L5="$L5x" && f_loop
         [[ $v_list =~ "5. " ]] && [[ $v_list =~ "[ ]" ]] && L5="$L5X" && f_loop

         [[ $v_list =~ "4. " ]] && echo "uDev"

         [[ $v_list =~ "3. " ]] && [[ $L5 =~ "[ ]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh 
         [[ $v_list =~ "3. " ]] && [[ $L5 =~ "[X]" ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/ca-lculadoras.sh h

         [[ $v_list =~ "2. " ]] && f_dot_files_menu
         [[ $v_list =~ "1. " ]] && sleep 0.1

      # Evitar loops a mais
         # A fx "...loop" pode ser chamada varias vezes para a alteracao da checkbox
         # Mas precisa que esse loop seja quebrado no final
         exit 0
   }

   # Correr 1x "void" e possivelmente correr varias vezes "loop"
      f_void
      f_loop

   unset v_list
