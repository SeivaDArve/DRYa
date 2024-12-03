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
   echo
   git pull
   echo

# uDev: se existir a repo 'verbose-lines': atualizar de X em X tempos

echo "Jarve running (uDev)"
echo " > type 'D clone try jarve' to download my repo"
echo " > Use DRYa for shortcuts and commands"
echo " > Use Jarve to decide what commands to run next"
echo " > jarve sets up everything after laptop suspention ends"
echo
echo " > uDev: tmux will open 1 vertical split screen. "
echo "   >> One for jarve-sentinel.sh showing always the same screen (as ready to update, or updating)"
echo "   >> One for news-displayer.sh to list all the changes"
echo 

read -p "[ANY KEY] para executar o sentinel"
while true
do
   echo "Starting ezGIT pull all"
   bash ${v_REPOS_CENTER}/ezGIT/ezGIT.sh v all &>/dev/null
   echo "ended at <date> (waiting 5 min to restart)"
   # uDev: sound at the end

done

# uDev: Tomar conta de:
#        > Detetar ano/mes/dia/hora/minuto constantemente para apps de calendario tipo:
#        > moedaz: compromissos agendados "source-all-moedaz-files"
#        > moedaz: trade: "G-Midnight-balance-of-day-checker.py"
#
# uDev: Sempre que for ativado o Jarve, enviar inicialmente o ambos os IP pronto para SSH para o Verbose-lines e Git Pull a essa repo (caso seja o raspberry, e a momolada esteja encarregue de carregar no botao ON, ja nao tem de enviar por whatsapp nenhuma info pra mim). Serve para o SSHFS

