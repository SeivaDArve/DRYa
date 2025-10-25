#!/bin/bash
# Title: ez-ov
# Description: 'Tas ma ovir?' Grava som apartir do microfone do dispositivo.
#              Feito para ser discreto
#              Vai substituir ezREC
#              Vai ter '$ ez ov on'
#              Vai ter '$ ez ov off'
#              Vai ter icons para home screen 'ezOV-on'   apartir do termux
#              Vai ter icons para home screen 'ezOV-off'  apartir do termux
#
#
#function ov {
#   if [ $1 = "on" ]...
#   if [ $1 = "off" ]...
#}

function f_ov_main_menu {

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='ov'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Set termux widged on Android main screen'                                      

      L3='3. Stop'                                      
      L2='2. Start'             

      L1='1. Cancel'

      Lh=$(echo -e "\nInstrucoes multi texto:\n -Aqui\n ")
      L0="ez-ov: Main Menu: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n\n$L4 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "4. " ]] && echo "uDev" 
      [[    $v_list =~ "3. " ]] && echo "uDev" 
      [[    $v_list =~ "2. " ]] && echo "uDev" 
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list
}





function ov {
   # Using Termux Mic

   if [ -z $1 ]; then 
      echo 'DRYa: ez-ov: Options to Record Microphone (use `ov`)'
      echo ' > Main menu: `ov .`'

   elif [[ $1 == "menu" ]] || [[ $1 == "." ]]; then
      f_ov_main_menu 

   elif [[ $1 == "init" ]] || [[ $1 == "a" ]] || [[ $1 == "+" ]]; then
      # Starts voice recording
      clear

      #termux-microphone-record -l 0
      termux-microphone-record -d && echo 'Going' || echo "error"

      # uDev: Enviar texto para ssms
      # uDev: Alterar uma das teclas de termux-extra-keys para simbolizar o estado atual

   elif [[ $1 == "stop" ]] || [[ $1 == "z" ]] || [[ $1 == "-" ]]; then
      # Stops voice recording
      clear

      termux-microphone-record -q && echo 'End' || echo "error"

      # uDev: Enviar texto para ssms
      # uDev: Alterar uma das teclas de termux-extra-keys para simbolizar o estado atual
   fi
}
