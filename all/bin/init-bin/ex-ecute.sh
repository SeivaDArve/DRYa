#!/bin/bash
# Title: ex
# Description: Este script vai ler os argumentos que lhe sao dados e vai filtrar os resultados do comando 'ls' com o script 'grep' ao qual vai ser dado o argumento que introduziste. No final, se o comando 'ex' encontrar na pasta algum documento com o nome que introduziste como argumento, vai tentar executar esse ficheiro com Bash

function ex { 
   for i in $*
   do 
      # Vai buscar ficheiros na pasta cujas primeiras letras do nome correspondam aos argumentos que estejam a ser buscados
      # Assim, cada pasta/diretorio pode ser uma especie menu incorporado por pre-definicao
      # Basta renomear os ficheiros por: 1-ficheiro; 2-ficheiro; 3-ficheiro
      # que o comando 'ex' reconhece que o argumento dado '3' significa "3-ficheiro" em vez de "2-ficheiro3"

      # uDev: This commnad 'ex' will ask for an input value, will grep it from the 'ls' command and attempt to run the result... This is usefull for directories where all the files are scripts... the command ex will act as a menu system
      # uDev: Se houver mais do que um ficheiro: questionar qual o utilizador quer
      # uDev: atender à extensao do ficheiro, se for .py entao abre com python
      # uDev: vao existir numeros 01, 02, 03, 04... para esses numeros, detetar se sao abaixo de 10 e permitir que o argumento dado a 'ex' seja so com 1 digito (exemplo: '$ ex 1' igual a: '$ ex 01')

      if [[ $i -lt 10 ]]; then
         # Variavel a concatenar ao numero que for menor que 10 (exemplo: 01, 02, 03, 04)
         # Evita usar '$ ex 01' e pode passar a usar '$ ex 1' que este software deteta o numero correto
            v_zero="0"

         # Concat 2 variables ($v_zero + $i): 
            v_zero_plus_i="${v_zero}$i"

         # Run the concatnation
            bash $(ls | grep "^$v_zero_plus_i")
      else
         # Run normally if it is lower or higher than 10
            bash $(ls | grep "^$i")
      fi

      #bash $(ls | grep "^$i")
      #python3 $(ls | grep ".py$" | grep "$i")
   done
}
