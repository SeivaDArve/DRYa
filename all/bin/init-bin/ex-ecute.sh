#!/bin/bash
# Title: ex
# Description: Este script vai ler os argumentos que lhe sao dados e vai filtrar os resultados do comando 'ls' com o script 'grep' ao qual vai ser dado o argumento que introduziste. No final, se o comando 'ex' encontrar na pasta algum documento com o nome que introduziste como argumento, vai tentar executar esse ficheiro com Bash

# uDev: This commnad 'ex' will ask for an input value, will grep it from the 'ls' command and attempt to run the result... This is usefull for directories where all the files are scripts... the command ex will act as a menu system

function ex { 
   for i in $*
   do 
      bash $(ls | grep "$i")
      #python3 $(ls | grep ".py$" | grep "$i")
   done
}
