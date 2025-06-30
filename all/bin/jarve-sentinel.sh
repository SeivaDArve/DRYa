#!/bin/bash

# uDev: Jarve stats the sshfs server

# uDev: AutoRUN (on/off): iniciar o terminal abrindo logo o jarve: É otimo para usar em dispositivos que publico desconhecido tamb+em tenha acesso tal como o telemovel do emprego
   
# Update a tudo ## QUANDO O USER CARREGA 'J'

   cd ${v_REPOS_CENTER}/DRYa
   clear
   figlet Jarve
   echo "Jarve: You can suspend your laptop now"
   echo "       (leave laptop OFF suspended: to enable IMEDIATE update when turned ON)"
   echo "       (leave laptop ON: to update every 5 mins)"
   echo "       (press 's' to suspend)"
   echo "       (press 'n' to add news-displayer.sh and see the change log)"
   echo "       (press 'd' to clone my repo)"
   echo

# uDev: se existir a repo 'verbose-lines': atualizar de X em X tempos

echo "Jarve: running (uDev list)"
echo 
echo " > Este script serve para testar a existencia da repo 'Jarve' com drya-lib-4 e esclarecer"
echo "   que esta repo vai incluir agenda + calendario + relogio + lembretes (assincrono)"
echo
echo " > jarve sets up everything after laptop suspention ends"
echo " > ASCII art to know from a distance changes are being made"
echo " > Every time changes are detected, play a sound (differente sounds)"
echo " > Every time changes are finished, play a sound (different sounds)"
echo " > Detetar ano/mes/dia/hora/minuto constantemente para apps de calendario tipo:"
echo " > moedaz: compromissos agendados \"source-all-moedaz-files\""
echo " > moedaz: trade: \"G-Midnight-balance-of-day-checker.py\""
echo
echo " > uDev: tmux will open 1 vertical split screen. "
echo "   >> One for jarve-sentinel.sh showing always the same screen (as ready to update, or updating)"
echo "   >> One for news-displayer.sh to list all the changes"
echo 
echo " > Sempre que for ativado o Jarve:" 
echo "   >> enviar inicialmente ambos os IP pronto para SSH para o Verbose-lines" 
echo "   >> Git Pull a essa repo (caso seja o raspberry, e a momolada esteja encarregue de carregar "
echo "   >> no botao ON, ja nao tem de enviar por whatsapp nenhuma info pra mim). Serve para o SSHFS"
echo 
echo
echo
echo  "Este comando mostra:"
echo  "|----------------------|"
echo  "| Jarve daemon: On/Off |"
echo  "|----------------------|"
echo
echo
echo  "[ANY KEY] para executar o sentinel"

while true
do

   # A cada 5 minutos
      echo "Starting ezGIT pull all (exemplo)"
      #bash ${v_REPOS_CENTER}/ezGIT/ezGIT.sh v all &>/dev/null
      echo "ended at <date> (waiting 5 min to restart)"
      # uDev: sound at the end
      sleep 60*5

   # A cada 

done


