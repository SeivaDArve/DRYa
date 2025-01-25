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


function f_refresh_hist_file {

   # Creating an history file
      # uDev: enviar antes para omni-log repo


   # Variables for dirs and files
      v_dir=${v_REPOS_CENTER}/omni-log/all/notify-history
      mkdir -p $v_dir

      v_file="termux-notify-output.txt"
      v_hist_file=$v_dir/$v_file



   # Testing if saving on .../omni-log/ or .config/h.h/
      # uDev: Assim, faz do omni-log um repositorio magbetico, se existir recebe fucheiros, se nao exiatir, nao recebe
      if [[ -d ${v_REPOS_CENTER}/omni-log ]]; then
         # Se a repo "omni-log" existir, criar la o ficheiro de historico

         echo " > File is going to be created at omni-log"
         # uDev: Mention path: echo " > "

      
      else
         # Se a repo "omni-log" nao existir, perguntar se quer clonar
         f_talk; echo "omni-log repo does not exist to place history files there"
                 echo " > Do you want to clone? (uDev)"
         read 

         v_dir=~/.config/h.h/drya/tmp
         mkdir -p $v_dir
         v_hist_file=$v_dir/$v_file
      fi
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
   done < $v_hist_file
}



function f_create_new_notification {
   # Criar notificacoes via termux


   f_greet
   f_talk; echo "Creating a new Android Notification"

   f_refresh_hist_file
            
   f_change_id && f_create_notify_message
}

function f_notify_fzf_MM {
   # Main menu for notify app

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='notify'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L3='3. Nova Notificacao | ID Costumizada'
      L2='2. Nova Notificacao | Standard ID'
      L1='1. Cancel'

      L0="Notify: SELECIONE 1 do menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3\n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "3. " ]] && echo uDev
      [[ $v_list =~ "2. " ]] && f_create_new_notification
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

if [[ -z $1 ]]; then
   # Menu Simples

   [[ $traits_OS == Android ]] && f_notify_fzf_MM || echo "You are not on Android to use notifications"

elif [[ $1 == "." ]]; then
   f_create_new_notification

elif [[ $1 == "-i" ]]; then
   # Add a custom ID
   f_custom_id

elif [[ $1 == "again" ]]; then
   # For each line in 'notify' history file, notify it again. (If you dont want the same history file to come up, delete such line)
   f_notify_again

elif [[ $1 == "m" ]] || [[ $1 == "mod" ]] ; then
   # Edit the history file

   # Sem esta fx, este arg nao funciona interativamente
      f_refresh_hist_file

   # fx f_refresh_hist_file maybe has to run first
   vim $v_hist_file
         
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


