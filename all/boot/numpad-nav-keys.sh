#!/bin/bash
# Title: Numpad navigation keys
# Description: Using only the Numapad to do the same as commands. Improving speed

# Tempo para leitura, antes de executar o comando
   v_time=20

# For DRYa:
   alias 0="drya"
   alias 01="drya ."
   alias 02="drya ,"
   alias 03="drya kbd"
   # alias 5: Power options
   # uDev: alias for Windows WSL2: home/Documents

# For ezGIT
   alias 1="G"
  #alias 10="cd ${v_REPOS_CENTER} && ls"  # Set on dryaSRC

   alias 11="G ."
   alias 111="G . A"

   alias 12="G v"
   alias 121="G v A ."

   alias 13="G ^"


# List de OS possibeis (ver traitsID.sh)
#  trid_OS="Android"
#  trid_OS="Linux-Microsoft"
#  trid_OS="RaspberryPi"
#  trid_OS="Linux"
#  trid_OS="NotDetected"





function f_hibernate {
   if [ -z $trid_OS ]; then
      echo 'DRYa: numpad: Tem de especificar OS primeiro (em $trid_OS)'

   elif [ $trid_OS == "Linux-Microsoft" ]; then
      cd ${v_REPOS_CENTER}/DRYa/all/batch/shut-restart-hibernate-sleep/
      /mnt/c/Windows/System32/cmd.exe /c hibernar.lnk

   elif [ $trid_OS == "Linux" ]; then
      sudo systemctl hibernate
   fi
}

function f_restart {
   if [ -z $trid_OS ]; then
      echo 'DRYa: numpad: Tem de especificar OS primeiro (em $trid_OS)'

   elif [ $trid_OS == "Linux-Microsoft" ]; then

      sleep $v_time
      cd ${v_REPOS_CENTER}/DRYa/all/batch/shut-restart-hibernate-sleep/
      /mnt/c/Windows/System32/cmd.exe /c reiniciar.lnk

   elif [ $trid_OS == "Linux" ]; then
      sleep $v_time && (shutdown -r now || shutdown --reboot)
   fi
}

function f_desligar {
   echo "Desligar"  

   if [ -z $trid_OS ]; then
      echo 'DRYa: numpad: Tem de especificar OS primeiro (em $trid_OS)'

   elif [ $trid_OS == "Linux-Microsoft" ]; then
      cd ${v_REPOS_CENTER}/DRYa/all/batch/shut-restart-hibernate-sleep/
      /mnt/c/Windows/System32/cmd.exe /c desligar.lnk
   
   elif [ $trid_OS == "Linux" ]; then
      echo " > Sleep time: $v_time seconds"
      echo " > (Enter to Fast Forward)"
      read -sn 1 -t $v_time -p " > " && (shutdown --poweroff || shutdown now)
   fi
}












function f_fzf_power_options {
   # POWER OPTIONS: Using Num Pad numbers as shortcuts

   # Lista de opcoes para o menu `fzf`
      L10='T. Temporizar acções'
       
       L9='C. Bloquear terminal' 
       L8='6. Restart Terminal | `rs`'
       L7='8. Reiniciar/ Reeboot/ Restart'
       L6='2. Hibernar'
       L5='4. Suspender'
       L4='0. Desligar/ Encerrar/ Shutdown/ OFF'
       L3='5. Bloquear ecra'

       L2='1. Cancel'
       L1='A. Abort (cancel Restart and Shutdown process)'

      L0="numpad-nav-keys: POWER options: "

      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n\n$L10 " | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[    $v_list =~ "A. " ]] && echo "A Abortar os encerramentos" && shutdown -c
      [[    $v_list =~ "T. " ]] && echo "uDev T."
      [[    $v_list =~ "9. " ]] && clear && cmatrix && v_pin_txt="Para regressar ao terminal, introduza: " && f_pin
      [[    $v_list =~ "6. " ]] && source ~/.bashrc
      [[    $v_list =~ "8. " ]] && echo "Reiniciar" && echo "hit 1" && f_restart && echo "hit 2"  # Restart à maquina
      [[    $v_list =~ "2. " ]] && echo "Hibernar"  && f_hibernate 
      [[    $v_list =~ "4. " ]] && echo "Suspender" && systemctl suspend
      [[    $v_list =~ "0. " ]] && f_desligar
      [[    $v_list =~ "5. " ]] && echo "uDev 5"
      [[    $v_list =~ "1. " ]] && echo "Cancelado" 
      unset  v_list
}


   # uDev: Criar uma fx para cada comando e os alias "numeros" + alias "escritos" chamam essas fx.
   # ----- Dica: Pode ser usado o teclado numerico para escrever: Exemplo tecla 1: 'nada'; tecla 2: 'ABC'; tecla 3: 'DEF'; tecla 4: 'GHI' ...
   alias           5="f_fzf_power_options"
   alias      246855="echo 'Lock Screen'"
   alias      246852="echo 'Shutdown'; shutdown now"
   alias      246858="echo 'Restart'; shutdown -r now"
   alias      246850="echo 'Hibernete'; win-hibernate 2>/dev/null|| echo ' > This command is for Windows only'"
   alias      246851="echo 'Suspend'"
   alias         exe="/mnt/c/Windows/System32/cmd.exe /c"
   alias    shutdown="shutdown -r now"
   alias      reboot="shutdown -r now"
   alias     restart="shutdown -r now"
   alias lock-screen="shutdown -r now"
   alias   hibernate="shutdown -r now"
   alias      reboot="shutdown -r now"
   alias       xkill="echo 'Activate gnome xKill to force GUI apps to close'"

   alias    48256="termux-microphone-record -d 1>/dev/null" # Starts voice recording without any terminal output
   alias "48256."="termux-microphone-record -q 1>/dev/null" # Stops  voice recording without any terminal output




# uDev: 
#     -------------------------------------------------------
#     Reserved alias/variables for DRYa
#     uDev: .../all/boot: fluNav: app que usa apenas o numpad para TUDO no pc, navegacao, menus... TUDO...
#
#     2468   = DRYa app ------------------------------- (bash ~/Repositories/DRYa/drya.sh)
#     24685  = DRYa's Repository Center --------------- (cd ~/Repositories)
#     246851 = Move to DRYa directory ----------------- (cd ~/Repositories/DRYa/)
#     246852 = Move to DRYa's most usefull parallel app (cd ~/Repositories/ezGIT/)
#     24681  = DRYa's function 1 (Currently: menu 1)
#     24682  = DRYa's function 2 (Currently: menu 2)
#     246811 = DRYa Refresh ALL (just like F5 does + refresh dot-files)
#
# -------------------------------------------------------
