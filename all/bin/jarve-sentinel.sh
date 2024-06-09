#!/bin/bash
#
# uDev: Jarve stats the sshfs server

# uDev: AutoRUN (on/off): iniciar o terminal abrindo logo o jarve: É otimo para usar em dispositivos que publico desconhecido tamb+em tenha acesso tal como o telemovel do emprego
   
# Update à repo DRYa  ## QUANDO O USER CARREGA 'J'
   # Cuidado: Ao utilizadores que nao sabem ler nem Bash nem os conteudos DRYa
   #          Quando alguem faz uso de um 'git branch' do qual nao viu as alteracoes
   #          Esta sujeito que o nosso DRYa seja atualizado para uma versao que extrar info maliciosa do nosso smartphone
   #          (Faz 'git pull' de DRYa de um ramo que seja seguro, usa so ramos seguros

   cd ${v_REPOS_CENTER}/DRYa
   clear
   figlet Jarve
   echo "Jarve: git pull à repo DRYa"
   echo
   git pull
   echo
   source ~/.bashrc

# uDev: se existir a repo 'verbose-lines': atualizar de X em X tempos

echo "Jarve running (uDev)"
echo " > type 'D clone try jarve' to download my repo"
echo " >> Use DRYa for shortcuts and commands"
echo " >> Use Jarve to decide what commands to run next"
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

