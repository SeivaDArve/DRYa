#!/bin/bash

# Title: Calculator-with-registry
# Description: Another version of calculator, this time, made around the command 'bc' that is the actual calculator. What this wrap-around script does is to add specific variables and math modifiers. It is tweeked to help on Binance Day Trading, where for example you can calculate '4 tkc' or '4 mkc' and it will tell you how much commission ('c') is taken from 4$ if you are a Market Maker ('mk') or a Market Taker ('tk')... Another fx is, for example, '[ 4 ]tk' or '[ 4 ]mk' and what ever number is inside the [] will be subtracted the corresponding commision out. Another fx is for example, outputing every prompt and result for a file written in org-mode (for emacs) allowing anotations and study.

   # Prompt de calculadora da DRYa que faz wrap-around ao pkg 'bc' e que dá exemplos no inicio do prompt para relembrar ao utilizador como se usa

function f_greet {
   # If 'figlet' app is installed, print an ascii version of the text "DRYa" to improve the appearence of the app
      clear
      figlet DRYa || echo -e "( DRYa ):\vrunning drya.sh\n"
}

   function f_cor4 { 
      # Similar to Bold
      # f_talk
      tput setaf 4
   }

   function f_resetCor { 
      tput sgr0
   }
      
function f_talk {
   # Copied from: ezGIT
   echo
   f_cor4; echo -n "DRYa: "
   f_resetCor
}

   f_greet

   # Definir o numero de casas decimais a aplicar aos resultados das contas
      #alias bc="bc <<< scale=2"  # Colocar este alias no ~/.bashrc para configurar 'bc' para usar sempre 2 casas decimais
      v_decimal=3                 # Alterar este numero para alterar a pre-definicao
      

   function f_start {
      f_talk; echo "Calculadora"
      echo " > Instruções: h"
      echo " > Casas decimais: $v_decimal"
      echo
   }
   f_start

   function f_clc_help {
      echo
      echo "---- Historico ----"
      echo " > Ver                  (software: less): 'V'"
      echo " > Editar               (software: vim) : 'E'"
      echo " > Ver ultimas linhas:  (software: less): 'U'"
      echo
      echo "---- Casas decimais ----"
      echo " > Editar: 'S'"
      echo " > Predefinido atualmente: $v_decimal"
      echo
      echo "---- Exemplos de como usar a calculadora 'bc' ----"
      echo " > 3 + (34 * 2)/3 + 1.2"
      echo
      echo "---- Exemplos de como usar a calculadora 'D clc' ----"
      echo " > 3x 2 : 3 + pi"
      echo
      echo "---- Editar o ecra ----"
      echo " > Limpar ecra: 'L' "
      echo
      echo "---- Inserir notas na registadora ----"
      echo " > d"
      echo "---- Notas ---- "
      echo " > Pode usar 'pi' que significa '3.1415'"
      echo " > Pode usar 'x' que significa '*' para usar nas multiplicações"
      echo " > Pode usar ':' que significa '/' para usar nas divisões"
      echo
      echo " > Podem ser criadas mais variaveis e modificadores "
      echo "   de: 'texto' para: 'numeros' no interior do script drya.sh"
      echo
      echo "---- Sair ----"
      echo " >  sair; quit; exit; q; Q; ZZ; Ctrl-C"
      echo
      echo "uDev: mostrar help com o less"
      echo "uDev: mudar nome da calc"
      echo "uDev: mudar scrip clc para .../bin"

   }

   # Criar ficheiro de historico
      v_dir=${v_REPOS_CENTER}/verbose-lines/history-calculator
      mkdir -p $v_dir

      v_file=history-drya-calculator.org

      v_log=$v_dir/$v_file

      touch $v_log

   # Disponibilizar a calculadora constantemente até que o utilizador cancele o axript
      while true
      do
         # Perguntar qual o Calculo ou Input a usar como comando
            echo -n " < "
            read v_input
            # Concatenar o text "<" com o input "$v_input" para ser enviado para um ficheiro de historico
               v_long_input=" < $v_input" 

            # Criar uma variavel que deteta que foi introduzido um input em vez de numeros para calculara, que faz com que no final do loop, nao execute calculos com variaveis que venham do loop anterior
               v_esc=0   # Todos os input tem de colocar esra variavel a '1' E no inicio de cada loop, esta variavel volta a zero


         # Permitir: modificadores matematicos + variaveis + incognitas
            # substituir 'x' por '*'
               v_input=${v_input//x/*}  # Usa a substituição de parametros do Bash

            # substituir ':' por '/'
               v_input=${v_input//:/\/}  # Usa a substituição de parametros do Bash

            # substituir 'pi' por '3.1415'
               v_input=${v_input//pi/3.1415}  # usa a substituição de parametros do bash

            # substituir 'tk' por '* 0.05' para multiplicacoes (taxa de Market Taker na corretora binance que é de 0.0500% de comissoes
               v_input=${v_input//tkc/* 0.05}  # usa a substituição de parametros do bash

            # substituir 'mk' por '* 0.02' para multiplicacoes (taxa de Market Maker na corretora binance que é de 0.02% de comisso0es
               v_input=${v_input//mkc/* 0.02}  # usa a substituição de parametros do bash

            # substituir 'ans' pelo resultado do loop anterior
               v_input=${v_input//ans/$v_result}  # usa a substituição de parametros do bash
              
            # uDev: MODIFICADOR: '[ ]tk' que faz o seguinte: 'v_var - (v_var × 0.05)' ou seja: Ve qual é o valor que está dentro de parenteses, e subtrai-lhe a comissao correspondente ja calculada
            # uDev: MODIFICADOR: '[ ]mk' que faz o seguinte: 'v_var - (v_var × 0.02)' ou seja: Ve qual é o valor que está dentro de parenteses, e subtrai-lhe a comissao correspondente ja calculada
            # uDev: MODIFICADOR: 'fi'    que faz o seguimte: é substituida pelo valor fixo de fibonacci

         # Tentar diferenciar entre comando dado a este script e conta para calcular
            v_result=$(echo "scale=$v_decimal; $v_input" | bc)

         # Dar estes input para sair da app:
            [[ $v_input == "sair" ]] || [[ $v_input == "exit" ]] || [[ $v_input == "quit" ]] || [[ $v_input == "Q" ]] || [[ $v_input == "q" ]] || [[ $v_input == "ZZ" ]] \
               && v_esc=1 && exit 0 

         # Visualizar ficheiro de historico
            [[ $v_input == "v" ]] || [[ $v_input == "V" ]] \
               && v_esc=1 && less $v_log && echo

         # Visualizar ficheiro de historico (so ultimas linhas)
            [[ $v_input == "u" ]] || [[ $v_input == "U" ]] \
               && v_esc=1 && tail $v_log | less && echo

         # Visualizar e editar ficheiro de historico
            [[ $v_input == "e" ]] || [[ $v_input == "E" ]] \
               && v_esc=1 && vim $v_log && echo

         # Visualizar e editar ficheiro de historico
            [[ $v_input == "emacs" ]] || [[ $v_input == "Emacs" ]] \
               && v_esc=1 && emacs $v_log && echo

         # Abrir ajuda
            [[ $v_input == "h" ]] || [[ $v_input == "H" ]] \
               && v_esc=1 && echo " > Instruções: " && f_clc_help

         # Limpar o ecra
            [[ $v_input == "l" ]] || [[ $v_input == "L" ]] \
               && v_esc=1 && clear && f_greet && f_start

         # Alterar a quantidade de casas decimais
            [[ $v_input == "s" ]] || [[ $v_input == "S" ]] \
               && v_esc=1 && read -p " >> Predefinir numero de casas decimais: " v_decimal && echo

         # Inserir data (timestamp) com mensagem adicionar (nota) no ficheiro de historico
            [[ $v_input == "d" ]] || [[ $v_input == "D" ]] \
               && v_esc=1 && echo " >> Inserir Data e Nota (no ficheiro de historico)." && read -p " >> Nota: " v_nota \
               && echo "                " >> $v_log \
               && echo "* [$(date)] > $v_nota"  >> $v_log \
               && echo

         # Mostrar os resultados (caso a variavel v_esc seja igual a 0)
            if [ $v_esc == "0" ]; then
               # Apresentar no ecra o valor resulante da conta
                  echo " > $v_result"
                  echo

               # Concatenar o texto ">" com o resultado "$v_result" para ser enviado para um ficheiro de historico
                  v_long_result=" > $v_result"  # Vai ser usado para enviar para um ficheiro de historico

               # Enviar ambas as variaves input e output para um ficheiro de historico
                  echo "            " >> $v_log
                  echo $v_long_input  >> $v_log
                  echo $v_long_result >> $v_log
            fi
      done
