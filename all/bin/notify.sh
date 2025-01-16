#!/bin/bash


   # uDev: --------------------------------------------------------------
      function ouvir {
         # Cria um while loop infinito por exemplo no smartphone Indratena que ouve updates no github, baixa, instala, executa
         # Usará um ficheiro em verbose-lines e jarve-sentinel
         # uDev: Criar na wikiD um header que informa todos os sitios onde a DRYa mexe com o github
         f_talk; echo "Listener: uDev"
      }

      function falar {
         # uDev: Cria uma notificacao noutro Android, via um ficheiro verbose-lines e jarve-sentinel
         f_talk; echo "Speaker: uDev"
      }
   # --------------------------------------------------------------------




function f_greet {
   clear
   figlet "Notify"
}

function f_c4 { 
   # Similar to Bold. Used in: f_talk
   # This function is to be used when something is ASKED
   tput setaf 4
}

function f_rc { 
   # This function is to be used when styles are to be CLEARED
   tput sgr0
}

function f_talk {
   # Copied from: ezGIT
         echo
   f_c4; echo -n "DRYa: Notify: "
   f_rc
}





   # Create an ID for each notification created
      function f_create_id {
         # It will be a concat of year + month + day + hour + Min + Sec
         # It will be a concat of  %Y  +  %m   +  %d +  %k  +  %M +  %S
         v_date=$(date +%Y%m%d%k%M%S)
         v_id=$v_date
      }

   # Add a line to history file
      function f_create_hist {
            echo "$(date) > $v_ans" >> ${v_dir}${v_file}
      }

   # Create the message itself
      function f_notify_create {
         termux-notification -t "DRYa: Notify:" -c "$v_ans" -i "$v_id" --icon circle_notifications --image-path /data/data/com.termux/files/home/Repositories/DRYa/all/etc/dot-files/termux/termux-icon.png && echo "Sucess!"
      }

   # Input a message
      function f_create_notify_message {
         echo
         echo "What is your message? "
         read -p " > " v_ans

         f_create_id
         f_notify_create
         f_create_hist
      }

   # Echo notification ID number
      function f_change_id {
         echo
         echo "Id for this notification will be: "
         echo " > $v_id"
      }


   function f_custom_id {
      f_change_id
      echo
      echo " >> What is your custom notification ID?"
      echo "     (will overwrite any notification with same ID)"
      read -p "     > " v_id
      echo
      f_change_id
      f_create_notify_message
   }

   function f_notify_again {
      echo

      while read i; do
         v_ans=$(echo "$i" | cut -d ">" -f 2 | sed "s/ //")
         echo $v_ans
         f_create_id
         f_notify_create
      done < $v_file2
   }



function f_notify {
   # Criar notificacoes via termux


   f_greet
   f_talk; echo "Create an Android notification message"

   # Creating an history file
      # uDev: enviar antes para omni-log repo
      v_dir=~/.config/h.h/drya/tmp/
      v_file="termux-notify-output.txt"
      mkdir -p $v_dir
      v_file2=${v_dir}${v_file}
            
   f_change_id && f_create_notify_message

     
}

if [[ -z $1 ]]; then
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='notify'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L2='2. Nova Mensagem'                                      
      L1='1. Cancel'

      L0="Notify: SELECIONE 1 do menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "2. " ]] && f_notify
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
   

elif [[ $1 == "." ]]; then
   f_notify

elif [[ $1 == "-i" ]]; then
   # Add a custom ID
   f_custom_id

elif [[ $1 == "again" ]]; then
   # For each line in 'notify' history file, notify it again. (If you dont want the same history file to come up, delete such line)
   f_notify_again

elif [[ $1 == "m" ]] || [[ $1 == "mod" ]] ; then
   # Edit the history file
   vim $v_file2
         
elif [[ $1 == "-l" ]]; then
   # List all DRYa messages (only DRYa)
   termux-notification-list | grep -B 2 -A 7 "tag"

   
elif [[ $1 == "-h" ]]; then
   echo
   echo "Manipulate ID: "
   echo " > notify -i"

elif [[ $1 == "-v" ]]; then
   less ${v_dir}${v_file}
      
else
   echo "uDev"
fi


