#!/bin/bash

# f_greet
   # uDev

# Functions for text colors
   # Copied from ezGIT
   function f_cor1 {	
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput setaf 5 
   }
   function f_cor2 { 
      tput setaf 2 
   }
   function f_cor3 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput setaf 3
   }
   function f_cor5 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Similar to Bold
      # f_talk
      tput setaf 6
   }
   function f_cor4 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Similar to Bold
      # f_talk
      tput setaf 4
   }
   function f_resetCor { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput sgr0
   }
   function f_talk {
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Copied from: ezGIT
      echo
      f_cor4; echo -n "DRYa: "
      f_resetCor
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

# fzf menu exemplo

      # Lista de opções para o menu `fzf`
         v_list=$(echo -e "1. Opc \n2. Opc \n3. Opc " | fzf --prompt="fzf Example Menu: ")

      # Perceber qual foi a escolha da lista
         [[ $v_list =~ "1" ]] && echo "Detetado 1 (uDev)" && sleep 1
         [[ $v_list =~ "2" ]] && echo "Detetado 2 (uDev)" && sleep 1
         [[ $v_list =~ "3" ]] && echo "Detetado 3 (uDev)" && sleep 1
         unset v_list
    
	 
# fzf com texto textra no proprio menu, onde o texto � discartado, apenas respostas validas sao validas
       # Lista de opções para o menu `fzf` (com loop)
        while true
        do
           # Texto do menu
              v_list=$(echo -e "1. Opcao n.1 \n2. Opcao n.2 \n3. Opcao n.3 \n----------------------------- \nEscolha uma destas hipoteses: " | fzf -m --prompt="SELECIONE (1 ou +) do TRADE menu: ")
           
           # As SELECOES nao podem conter a o texto "hipotese" nem linhas vaxias de 3 espacos "   ". So quando nao tem esse texto é que quebra o loop
              if [[ $v_list =~ "hipotese" ]] || [[ $v_list =~ "---" ]]; then
                 echo "Menu: SFF nao selecione opcoes invalidas. [ENTER] para continuar"; read -sn 1
                 continue
              else
                 break
              fi
        done

      # Quando o menu é de Escolha multipla tipo `for` loop
         [[ $v_list =~ "1." ]] && echo "uDev: 1"
         [[ $v_list =~ "2." ]] && echo "uDev: 2"
         [[ $v_list =~ "3." ]] && echo "uDev: 3"
         unset v_list             # Reset a Variavel
