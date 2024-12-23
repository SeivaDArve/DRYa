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

# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz='0. `Terminal Command HERE`'

      L3="3. Opcao"
      L2="2. Opcao"
      L1="1. Cancel"

      L0='`fzf` Example Menu: '
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "3. " ]] && echo "uDev: 3" && sleep 0.1
      [[ $v_list =~ "2. " ]] && echo "uDev: 2" && sleep 0.1
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz"
      unset v_list
    
	 


# [fzf menu exemplo 2] 
   # Menu com loop + texto extra no proprio menu, onde o texto � discartado, apenas respostas validas sao validas

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
      
      # As SELECOES nao podem conter a o texto "hipotese" nem linhas vazias de 3 espacos "   ". So quando nao tem esse texto é que quebra o loop
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
   # Menu com loop + checkbox

   # Texto do menu
      Lz='`Terminal Command HERE`'

      L3="3. Opcao 3."
      L2a="2. [X] Opcao 2"
      L2b="2. [ ] Opcao 2"
      L1a="1. [X] Opcao 1"
      L1b="1. [ ] Opcao 1"

      Lc="Cancel"

      L0="SELECIONE (1 ou +) do menu: "

   # Verificar qual variante apresentar: A ou B
      function f_L1 {
         # A data contem o dia X ?
            # Sim: L1 = L1a
            # Nao: L1 = L1b

         v_date=$(date)
         [[ $_date != "Mon" ]] && L1="$L1a"
         [[ $_date =~ "Mon" ]] && L1="$L1b"
      }

   # Present the menu and updating each click using last defined fxs
      while true
      do
         # Refresh each variable
            f_L1; 

         v_list=$(echo -e "$Lc \n\n$L1 \n$L2 \n$L3" | fzf -m --prompt="$L0")
         
         # As SELECOES nao podem conter a o texto "hipotese" nem linhas vazias de 3 espacos "   ". So quando nao tem esse texto é que quebra o loop
            if [[ $v_list =~ "<all-invalid-options>" ]]; then
               echo "Menu: opcoes invalida."
               read -s -p " > [ENTER] para tentar novamente" -n 1
               continue

            else
               # Quando o menu de Escolha multipla tipo `for` loop

               [[ $v_list =~ "1. " ]] && echo "uDev: 1" && break
               [[ $v_list =~ "foo" ]] && echo "uDev: 2" && break
               [[ $v_list =~ "bar" ]] && echo "uDev: 3" && break
            fi
      done

   # Rese a lisea de variaveis
      unset v_list 








