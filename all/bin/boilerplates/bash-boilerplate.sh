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
         [[ $v_list =~ "1" ]] && echo "Detetado 1 (debug)" && sleep 1
         [[ $v_list =~ "2" ]] && echo "Detetado 2 (debug)" && sleep 1
         [[ $v_list =~ "3" ]] && echo "Detetado 3 (debug)" && sleep 1
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
