#!/bin/bash
# Title: Numpad navigation keys
# Description: Using only the Numapad to do the same as commands. Improving speed

# For DRYa:
   alias 5="drya"

# For ezGIT
   alias 1="G"
   alias 11="G ."
   alias 111="G . A"

   alias 12="G v A ."

function f_fzf_power_options {
   # POWER OPTIONS: Using Num Pad numbers as shortcuts

   # Menu
      # ------------------------------------------ #
      L9="A. Abort (Restart and Shutdown)          "
      L8="T. Temporizar acções                     "
      # ------------------------------------------ #
      
      L7="6. Refresh   | (F5)                      "
      L6="8. Reiniciar | Reeboot  | Restart        "
      L5="2. Hibernar                              "
      L4="4. Suspender                             "
      L3="0. Desligar  | Encerrar | Shutdown | OFF "
      L2="5. Bloquear ecra                         "
      L1="1. Cancel                                "
      # ------------------------------------------ #
      L0="POWER Options: "

      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n\n$L8 \n$L9" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ "0" ]] && echo "Desligar" && f_shutdown  # Desliga a maquina
      [[ $v_list =~ "5" ]] && echo "Detetado 5 (debug)"
      [[ $v_list =~ "4" ]] && echo "Suspender" && systemctl suspend
      [[ $v_list =~ "2" ]] && echo "Hibernar" && f_hibernate
      [[ $v_list =~ "6" ]] && echo "Detetado 6 (debug)"
      [[ $v_list =~ "8" ]] && echo "Reiniciar" && f_restart  # Restart à maquina
}


   # uDev: Vai have uma fx para cada comando e os alias numerios + os alias escritos chamam essa fx.
      # Dica: Pode ser usado o teclado numerico para escrever: Exemplo tecla 1: 'nada'; tecla 2: 'ABC'; tecla 3: 'DEF'; tecla 4: 'GHI' ...
   alias           exe="/mnt/c/Windows/System32/cmd.exe /c"
   alias        5="f_fzf_power_options"
   alias        246855="echo 'Lock Screen'"
   alias        246852="echo 'Shutdown'; shutdown now"
   alias        246858="echo 'Restart'; shutdown -r now"
   alias        246850="echo 'Hibernete'; win-hibernate 2>/dev/null|| echo ' > This command is for Windows only'"
   alias        246851="echo 'Suspend'"
   alias      shutdown="shutdown -r now"
   alias        reboot="shutdown -r now"
   alias       restart="shutdown -r now"
   alias   lock-screen="shutdown -r now"
   alias     hibernate="shutdown -r now"
   alias        reboot="shutdown -r now"
   alias         xkill="echo 'Activate gnome xKill to force GUI apps to close'"

   alias    48256="termux-microphone-record -d 1>/dev/null" # Starts voice recording without any terminal output
   alias "48256."="termux-microphone-record -q 1>/dev/null" # Stops voice recording without any terminal output
