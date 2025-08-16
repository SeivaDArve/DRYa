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


function ov {
   # Using Termux Mic

   if [ -z $1 ]; then 
      echo 'DRYa: ez-ov: Options to Record Microphone (use `ov`)'

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
