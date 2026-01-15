#!/bin/bash

# Title: oOo
# Description: Script qye serve para relembrar que a onomatopeia de um fantasma é otima para treinar o vibrato



#   Explicação das sequências ANSI:
#      \r → retorna o cursor ao início da linha
#      \033[2K → limpa toda a linha atual
#      echo -ne → -n evita newline, -e habilita interpretação de escapes
#
#
#   Exemplo
#      echo -ne "Primeira frase..."   # imprime sem quebrar linha
#      sleep 1                        # espera 1 segundo
#
#      echo -ne "\r\033[2K"           # volta ao início da linha e limpa a linha
#      echo "Frase reescrita!"        # imprime a nova frase



# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )

   v_greet="DRYa"
   v_talk="DRYa: oOo: "

# Preparing for DRYa welcome screen
   f_hzl
   echo

# Delay pretendido
   v_secs=0.05

   v_vibrt="Vibrato (do fantasma):"
   v_fant1="oOooOooOooOooOooOooOooO... "
   v_fant2="ooOooOooOooOooOooOooOoo... "
   v_fant3="OooOooOooOooOooOooOooOo... "
   v_fant4="oOooOooOooOooOooOooOooO... "

function f_run {
   # Corpo da mensagem (texto que é reescrito na mesma linha)

   echo -ne "\r\033[2K"
   echo -ne "$v_vibrt $v_fant1"   # imprime sem quebrar linha
   sleep $v_secs                  # espera 1 segundo

   echo -ne "\r\033[2K"
   echo -ne "$v_vibrt $v_fant2"        # imprime a nova frase
   sleep $v_secs                  # espera 1 segundo

   echo -ne "\r\033[2K"           # volta ao início da linha e limpa a linha
   echo -ne "$v_vibrt $v_fant3"        # imprime a nova frase
   sleep $v_secs                  # espera 1 segundo

   echo -ne "\r\033[2K"           # volta ao início da linha e limpa a linha
   echo -ne "$v_vibrt $v_fant4"        # imprime a nova frase
   sleep $v_secs                  # espera 1 segundo
}

# Imprimir no ecra o resultado
   f_run
   f_run
   f_run
   f_run

   echo
