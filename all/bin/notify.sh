#!/bin/bash

function f_talk {
   clear
   figlet "DRYa Notify"
}

function f_notify {
   # Criar notificacoes via termux

   # uDev: --------------------------------------------------------------
      function ouvir {
         # Cria um while loop infinito por exemplo no smartphone Indratena que ouve updates no github, baixa, instala, executa
         # Usará um ficheiro em verbose-lines e jarve-sentinel
         # uDev: Criar na wikiD um header que informa todos os sitios onde a DRYa mexe com o github
         echo "DRYa: Listener: uDev"
      }

      function falar {
         # uDev: Cria uma notificacao noutro Android, via um ficheiro verbose-lines e jarve-sentinel
         echo "DRYa: Speaker: uDev"
      }
   # --------------------------------------------------------------------

   clear
   figlet "DRYa Notify"
   #f_talk; 
   echo "Notify: Create an Android notification message"

   # Creating an history file
      # uDev: enviar antes para omni-log repo
      v_dir=~/.config/h.h/drya/tmp/
      v_file="termux-notify-output.txt"
      mkdir -p $v_dir
      v_file2=${v_dir}${v_file}
            
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
      function f_notify_message {
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

   # No arg:
      if [[ -z $1 ]]; then
         f_change_id
         f_notify_message

   # If arg -i is given to '$ notify' then, add the change to alter the ID
      elif [[ $1 == "-i" ]]; then
         f_change_id
         echo
         echo " >> What is your custom notification ID?"
         echo "     (will overwrite any notification with same ID)"
         read -p "     > " v_id
         echo
         f_change_id
         f_notify_message

   # List all DRYa messages (only DRYa)
      elif [[ $1 == "-l" ]]; then
         termux-notification-list | grep -B 2 -A 7 "tag"

   # For each line in 'notify' history file, notify it again. (If you dont want the same history file to come up, delete such line)
      elif [[ $1 == "again" ]]; then

         echo

         while read i; do
            v_ans=$(echo "$i" | cut -d ">" -f 2 | sed "s/ //")
            echo $v_ans
            f_create_id
            f_notify_create
         done < $v_file2
         
   # Edit the history file
      elif [[ $1 == "m" ]] || [[ $1 == "mod" ]] ; then
         vim $v_file2
         
      elif [[ $1 == "-h" ]]; then
         echo
         echo "Manipulate ID: "
         echo " > notify -i"

      elif [[ $1 == "-v" ]]; then
         less ${v_dir}${v_file}
      fi
      
     
}

f_notify
