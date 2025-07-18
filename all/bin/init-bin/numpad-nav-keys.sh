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
  #alias 10="cd ${v_REPOS_CENTER} && ls"  # Set on source-all-drya-files

   alias 11="G ."
   alias 111="G . A"

   alias 12="G v"
   alias 121="G v A ."


function f_shutdown {
   # Desligar a maquina

   # Fedora Linux
      sleep $v_time && shutdown --poweroff
}

function f_fzf_power_options {
   # POWER OPTIONS: Using Num Pad numbers as shortcuts

   # Menu
      L10="A. Abort (Restart and Shutdown)          "
       L9="T. Temporizar acções                     "
       
       L8="6. Refresh   | (F5)                      "
       L7="8. Reiniciar | Reeboot  | Restart        "
       L6="2. Hibernar                              "
       L5="4. Suspender                             "
       L4="0. Desligar  | Encerrar | Shutdown | OFF "
       L3="5. Bloquear ecra                         "
       #L3="5. Bloquear terminal                    " `clear && cmatrix && f_pin`

       L2="A. Abort (Restart and Shutdown)          "
       L1="1. Cancel                                "

      L0="POWER Options: "

      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n\n$L9 \n$L10" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "A. " ]] && echo "A Abortar os encerramentos" && shutdown -c
      [[ $v_list =~ "T. " ]] && echo "uDev T."
      [[ $v_list =~ "6. " ]] && source ~/.bashrc
      [[ $v_list =~ "8. " ]] && echo "Reiniciar" && f_restart  # Restart à maquina
      [[ $v_list =~ "2. " ]] && echo "Hibernar"  && f_hibernate
      [[ $v_list =~ "4. " ]] && echo "Suspender" && systemctl suspend
      [[ $v_list =~ "0. " ]] && echo "Desligar"  && f_shutdown
      [[ $v_list =~ "5. " ]] && echo "uDev 5"
      [[ $v_list =~ "1. " ]] && echo "Cancelado" 
}


   # uDev: Criar uma fx para cada comando e os alias "numeros" + alias "escritos" chamam essas fx.
   # ----- Dica: Pode ser usado o teclado numerico para escrever: Exemplo tecla 1: 'nada'; tecla 2: 'ABC'; tecla 3: 'DEF'; tecla 4: 'GHI' ...
   alias         exe="/mnt/c/Windows/System32/cmd.exe /c"
   alias           5="f_fzf_power_options"
   alias      246855="echo 'Lock Screen'"
   alias      246852="echo 'Shutdown'; shutdown now"
   alias      246858="echo 'Restart'; shutdown -r now"
   alias      246850="echo 'Hibernete'; win-hibernate 2>/dev/null|| echo ' > This command is for Windows only'"
   alias      246851="echo 'Suspend'"
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
#     uDev: init-bin: fluNav: app que usa apenas o numpad para TUDO no pc, navegacao, menus... TUDO...
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
