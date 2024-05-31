#!/bin/bash
#
# uDev: Jarve stats the sshfs server

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



#
# while true  ## Loop sem intençao de quebrar automaticamente
# do
#
#  # Procurar coisas para fazer. Depois ao encontrar, nao passar para outra atividade até que essa nao eateja toda concluida
#
#     while true
#     do
#       <Encontrar tarefa incomplera #1>
#       if [ ?$ == "0" ]; then <Se o comando anterior teve sucesso, tentar fazer de novo, senao, break>; fi
#     done
#
#
#
#
#     while true
#     do
#       <Encontrar tarefa incomplera #2>
#       if [ ?$ == "0" ]; then <Se o comando anterior teve sucesso, tentar fazer de novo, senao, break>; fi
#     done
#
#
#
#
#     while true
#     do
#       <Encontrar tarefa incomplera #3>
#       if [ ?$ == "0" ]; then <Se o comando anterior teve sucesso, tentar fazer de novo, senao, break>; fi
#     done
#
#
#
# done
#
