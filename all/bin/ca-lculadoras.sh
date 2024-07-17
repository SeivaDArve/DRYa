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

# Criar ficheiro de historico
   #v_dir=${v_REPOS_CENTER}/verbose-lines/history-calculator
   v_dir=~/.config/h.h/verbose-lines/mail-box/history-calculator
   mkdir -p $v_dir

   v_file=history-drya-calculator.org
   v_log=$v_dir/$v_file

   touch $v_log




function f_exec_calculadora_registadora {
   # Calculadora dedicaca a contas básicas e a calculos de comissoes

   f_greet

   # Definir o numero de casas decimais a aplicar aos resultados das contas
      #alias bc="bc <<< scale=2"  # Colocar este alias no ~/.bashrc para configurar 'bc' para usar sempre 2 casas decimais
      v_decimal=3                 # Alterar este numero para alterar a pre-definicao
   

   function f_start {
      f_talk; echo "Calculadora Basica (extendida)"
      echo " > Instruções: h"
      echo " > Casas decimais: $v_decimal"
      echo
   }
   f_start

   function f_clc_help {
      # HereDoc com instruçoes de utilização

# --- # -------------------------------------------------------------------------
   cat <<EOF
Historico/Registadora --------------------------------------------"
 > Ver                  (software: less) : 'V'
 > Editar               (software: vim)  : 'E'
 > Editar               (software: emacs): 'emacs'
 > Ver ultimas linhas:  (software: less) : 'U'

 > Editar manualmente um input anterior falhado: 'f'



Casas decimais ---------------------------------------------------"
 > Editar: 'S'
 > Predefinido atualmente: $v_decimal"



Exemplos de como usar a calculadora 'bc' -------------------------"
 > 3 + (34 * 2)/3 + 1.2



Exemplos de como usar a calculadora 'D clc' ----------------------"
 > 3x 2 : 3 + pi + ( 3 tkc ) - (4mkc)



Editar o ecra ----------------------------------------------------"
 > Limpar ecra: 'L' 
 > uDev: Mater sempre limpo (para usar em conjunto com '$ watch $v_log'



Inserir notas na registadora -------------------------------------"
 > N



Modificadores ----------------------------------------------------"
 > Pode usar 'pi' que significa '3.1415'
 > Pode usar 'x' que significa '*' para usar nas multiplicações
 > Pode usar ':' que significa '/' para usar nas divisões

 > Procura o texto 'tkc' que significa 'taker commission' e substitui para o texto '* 0.05' para calcular comissoes correspondentes
 >> '4tkc' é igual a '4 * 0.05' = '0.20'

 > Procura o texto 'mkc' que significa 'maker commission' e substitui para o texto '* 0.02' para calcular comissoes correspondentes
 >> '4mkc' é igual a '4 * 0.02' = '0.08'

 > Encontra o conteudo de '[ ]tk' e modifica. Se o conteudo for 'y' entao calcula: [y]tk
 >> '[4]tk' é igual a '(4 - (4 * 0.05))' = '3.80'

 > Encontra o conteudo de '[ ]mk' e modifica. Se o conteudo for 'y' entao calcula: [y]mk
 >> '[4]mk' é igual a '(4 - (4 * 0.02))' = '3.92' 


Em desenvolvimento (uDev)  -----------------------------------------------"
 > Nota: Podem ser criadas mais variaveis e modificadores 
          > exemplo: de: 'texto' para: 'numeros' no interior do script ca-lculator-reg.sh

 > Modificadores: 
    > MODIFICADOR: 'fi'    que faz o seguinte: é substituida pelo valor fixo de fibonacci
    > MODIFICADOR: '[]atk' Calcula o preco de Fecho para quem abriu um trade como taker
    > MODIFICADOR: '[]amk' Calcula o preco de Fecho para quem abriu um trade como maker
    > Se abrirmos o editor 'f' entao o script executa cada linha com um for loop em vez de executar so a primeira
    > No inicio do script, buscar o historico à repo: verbose-lines
    > Ao sair do script, depositar o historico na repo: verbose-lines

 > Encontrar o conteudo de '[ ]a-mk-f' e modificar
   >> Calcula como sair com zero '0' de um trade em que abrimos e fechamos a operaçao como maker
   >> Abrir um trade tem comissoes, fechar também.
   >> '[4]amk' é igual a '(4 + 2 * (4 * 0.02))' = '4 + 0.20 + 0.20' = (4.40) 
   >> (Refere-se ao valor de abertura de Market Maker 
      e resulta a quanto é que temos de fechar a operação para sair com Zero
      é preciso introduzir Alavancagem e preço de entrada

 > Atalho para visualizar constantemente o ficheiro \$v_log de 2 em 2 segundos
   >> Por exemplo: 
   >> '$ watch -n 2 tail $v_log'

 > Conversor de unidade de medida + Conversor de Cambios
   > exemplo: 1 BTC = 1000 mBTC (1 Bitcoin = 1000 mili Bitcoins)    # Converter Unidades
   > exemplo: 1 Bitcoin = X Satoshi (uDev)                          # Converter Unidades 
   > exemplo: 1 mBTC = 56.6646 EUR (1 mili Bitcoin = 56,6646 Euros) # Converter com taxas de cambio
   > exemplo: 10 EUR = 0.17648 mBTC                                 # Converter com taxas de cambio
   


Sair -------------------------------------------------------------"
 >  sair; quit; exit; q; Q; ZZ; Ctrl-C

EOF
# --- # -------------------------------------------------------------------------
   }


   function f_create_tmp {
      # Criar ficheiro temporario (para edição do resultado anterior)
         v_tmp_dir=~/.tmp
         mkdir -p $v_tmp_dir

         v_tmp_file=editar-resultado-anterior
         v_tmp=$v_tmp_dir/$v_tmp_file

         touch $v_tmp
   } 

   function f_tmp_instructions {
      # Enviar instrucoes para quem abrir o ficheiro temporario
         echo -e "\n\n# Coloque o seu input neste ficheiro de texto (com editor vim) e simplesmente feche" >> $v_tmp
   }

   while true # Disponibilizar a calculadora constantemente até que o utilizador cancele o script
   do
      

      # Criar uma variavel para denunciar que foi detetada a introdução de um input de comando em vez de numeros para calculara
      # será usada no final do loop. Antes de chegar ao calculo pode ser modificada para 1 se for detetado um comando, impedindo o calculo que resultaria em erro
      # É feito reset no inicio de cada loop para não ser executado o comando do loop anterior
      # Todos os input tem de colocar esra variavel a '1' E no inicio de cada loop, esta variavel volta a zero
         v_esc=0   

      # Criar uma variavel que guarda o resultado do loop anterior e o edita antes de tentar calcular de novo
         v_failed_input=$v_input  # O terminal Bash nao permite navegar com as setas, esta variavel irá permitir ao loop seguinte abrir este texto com um editor e depois modificar se for preciso

      # Perguntar qual o Calculo ou Input a usar como comando
         echo -n " < "
         read v_input
         # Concatenar o texto "<" com o input "$v_input" para ser enviado para um ficheiro de registo (historico)
            v_long_input=" < $v_input" 

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
           

         ########################################################################
         # Com apoio do chatGPT que fornce uma "PCRE" (Perl Compatible Regular Expression) para utilizar no ´grep´
            # Encontrar e modificar ']tk'
               # Extrai o conteúdo entre '[' e ']tk' e armazena em uma variável separada por espaços
               # A variavel $CONTEUDO irá ser uma frase cujo numero de palavras é igual ao resultado da pesquisa REGEX
                  CONTEUDO=$(echo "$v_input" | grep -oP '\[\K[^\]]+(?=\]tk)' | tr '\n' ' ')
                  #echo "Conteudo: $CONTEUDO"; read  # Debug

               # Remove o espaço final
                  CONTEUDO=$(echo "$CONTEUDO" | sed 's/ $//' )

               # Exibe o resultado (debug)
                  #echo "Conteúdo dentro de '[' e ']tk': $CONTEUDO"

               #  Vai ler quantas palavras existem na variavel $CONTEUDO e vai fazer essa mesma quantidade de loops
               #  Em cada loop 'i' assumirá a o mesmo significado que a palavra encontrada para depois ser isubstituida seu novo significado
                  for i in $CONTEUDO
                  do
                     #echo

                     # Para cada ']tk' encontrado, sustituir por: '$i * 0.05)'
                        #echo "Conteudo é: $i"  # (para debug)
                        v_input=${v_input//]tk/ - ($i * 0.05))}  # usa a substituição de parametros do bash
                        #echo "Portanto: $v_input"  # (para debug)
                        #echo
                  done
                  #echo "Input atual: $v_input"; read


            # Encontrar e modificar ']mk'
               # Extrai o conteúdo entre '[' e ']mk' e armazena em uma variável separada por espaços
               # A variavel $CONTEUDO irá ser uma frase cujo numero de palavras é igual ao resultado da pesquisa REGEX
                  CONTEUDO=$(echo "$v_input" | grep -oP '\[\K[^\]]+(?=\]mk)' | tr '\n' ' ')
                  #echo "Conteudo: $CONTEUDO"; read  # Debug

               # Remove o espaço final
                  CONTEUDO=$(echo "$CONTEUDO" | sed 's/ $//' )

               # Exibe o resultado (debug)
                  #echo "Conteúdo dentro de '[' e ']mk': $CONTEUDO"

               #  Vai ler quantas palavras existem na variavel $CONTEUDO e vai fazer essa mesma quantidade de loops
               #  Em cada loop 'i' assumirá a o mesmo significado que a palavra encontrada para depois ser isubstituida seu novo significado
                  for i in $CONTEUDO
                  do
                     #echo

                     # Para cada ']tk' encontrado, sustituir por: '$i * 0.05)'
                        #echo "Conteudo é: $i"  # (para debug)
                        v_input=${v_input//]mk/ - ($i * 0.02))}  # usa a substituição de parametros do bash
                        #echo "Portanto: $v_input"  # (para debug)
                        #echo
                  done


            # Modificar globalmente '[' por '(' que só pode ser feito no final de entrontrar todos os ]tk e ]mk
               v_input=$(echo "$v_input" | sed "s/\[/\(/g")
               #echo "Melhor: $v_input"  # (para debug)
         ########################################################################


            # Se o padrao ']tk' foi encontrado pelo menos 1x, proceder à extracao do numero que estiver entre '[' e ']tk'
            # Modificar todos os parenteses quadrados '[' por parenteses curvos '(' para poder proceder ao calculo
               v_input=${v_input//\[/(}  # usa a substituição de parametros do bash

      function f_calcular {
         # Tentar diferenciar entre comando dado a este script e conta para calcular
         # Se o Resultado ($v_result) do calculo der errado, será igual a zero '0' e não dá mensagem de erro que bloqueie o funcionamento normal do script
         # E assim, o input de Entrada ($v_input) tem uma oportunidade de ser avaliado 
            v_result=$(echo "scale=$v_decimal; $v_input" | bc)
      }
      f_calcular

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
            && v_esc=1 && echo " > Instruções: " && f_clc_help | less && echo

      # Limpar o ecra
         [[ $v_input == "l" ]] || [[ $v_input == "L" ]] \
            && v_esc=1 && clear && f_greet && f_start

      # Alterar a quantidade de casas decimais
         [[ $v_input == "s" ]] || [[ $v_input == "S" ]] \
            && v_esc=1 && read -p " >> Predefinir numero de casas decimais: " v_decimal && echo

      # Inserir data (timestamp) com mensagem adicionar (nota) no ficheiro de historico
         [[ $v_input == "n" ]] || [[ $v_input == "N" ]] \
            && v_esc=1 && echo " >> Inserir Data e Nota (no ficheiro de historico)." && read -p " >> Nota: " v_nota && echo " " >> $v_log  && echo "* Nota: [$(date +'%Y-%m-%d %H:%M:%S')] > $v_nota"  >> $v_log \ && echo

      # Editar o resultado falhado do loop anterior
         [[ $v_input == "f" ]] || [[ $v_input == "F" ]] \
            && v_esc=0 \
            && f_create_tmp \
            && echo -n "$v_failed_input" > $v_tmp \
            && f_tmp_instructions \
            && vim $v_tmp \
            && v_input=$(cat $v_tmp | head -n 1) \
            && v_old=" < Velho input: $v_failed_input" \
            && v_new=" < Novo input: $v_input" \
            && echo "$v_old" \
            && echo "$v_new" \
            && f_calcular \
            #&& echo

      # At the end, if letters are still found, then, nicely, say ERROOOOR!
         if [[ $v_esc = "0" ]] && [[ $v_input =~ [a-zA-Z] ]]; then  # Deteta que nenhum modificador foi atuado porque $v_esc é '0' e não deu erro. O input '3+1' não dá erro, o input 'r3+1' da zero, o input '3+1r' da erro... Portanto, nesta fx vamos detetar letras e dizer que tem erro, passando $v_esc para '1' inpedindo de ser calculado
            #echo " > A string contém letras."  # Debug

            v_esc=1; echo " > A string não pode conter letras."; echo
         fi

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
               [[ ! -z $v_new ]] && echo $v_old >> $v_log && echo $v_new >> $v_log && unset v_new  # Caso haja alteracoes com a fx 'f', tambem explicar isso no ficheiro de log
               echo $v_long_result >> $v_log
         fi
   done
}

function f_exec_calculadora_conversora {
   # Conversora de 1 unidade para 1 outra unidade


   function f_info_unidades_de_medida {
cat << EOF
Informação dedicada a conversoes de BITCOIN usando a carteira Electrum

Na carteira Electrum, assim como na maioria das carteiras de Bitcoin, o saldo é medido em unidades de Bitcoin e suas subunidades. As unidades de medida usadas para medir o saldo são:
BTC, mBTC, µBTC (bits) e Satoshis (sat).

1 - Bitcoin (BTC):

    A unidade padrão e mais conhecida de medida.
       1 BTC = 100,000,000 Satoshis (sats).

2 - MilliBitcoin (mBTC):

    Uma subunidade de Bitcoin.
       1 mBTC = 0.001 BTC = 100,000 Satoshis.

3 - MicroBitcoin (µBTC) ou Bit:

    Outra subunidade de Bitcoin.
       1 µBTC = 0.000001 BTC = 100 Satoshis.

4 - Satoshi (sat):

    A menor unidade de Bitcoin.
       1 Satoshi = 0.00000001 BTC.


Exemplo Prático
   Se você tiver 0.12345678 BTC na sua carteira:

   Em BTC, será exibido como:            0.12345678 BTC.
   Em mBTC, será exibido como:           123.45678 mBTC.
   Em µBTC (bits), será exibido como:    123456.78 µBTC.
   Em Satoshis (sat), será exibido como: 12,345,678 sat.
EOF
}

   # Texto do menu
      v_list=$(echo -e "1. Converter: de BTC  para... \n2. Converter: de mBTC para... \n3. Converter: de µBIT para... \n4. Converter: de Sat  para... \n5. Info sobre unidades" | fzf --cycle -m --prompt="SELECIONE Converora de 1 unidade para 1 outra: ")
               
   # Quando o menu Ã© de Escolha multipla tipo `for` loop
      [[ $v_list =~ "1." ]] && echo "debug"
      [[ $v_list =~ "2." ]] && echo "debug"
      [[ $v_list =~ "5." ]] && f_info_unidades_de_medida | less
      unset v_list             # Reset Ã  Variavel
}

function f_exec_calculadora_cambios {
   echo "uDev: cambios"
}

function f_exec_calculadora_regra_de_3 {
f_greet
f_talk; echo "Calculadora Regra de 3 Simples"

echo "
                           |
---------------------------|
  |  Regra de 3 Simples:   | 
  |                        |
  |       A     C          |
  |      --- = ---         |
  |       B     X          |
  |                        |
  |    X = (B x C) / A     |
  |                        |
  |---------------------------
  |

Lenga-lenga: 
 - A está para B
      assim como C está para... ... X
_______________________________________

"

read -p "Introduza A: " vA
read -p "Introduza B: " vB
read -p "Introduza C: " vC

echo
echo "A = $vA"
echo "B = $vB"
echo "C = $vC"

#v_result=$(echo "scale=$v_decimal; $v_input" | bc)
v_multip=$(echo "scale=3; $vB * $vC" | bc)
vX=$(echo "scale=3; $v_multip / $vA" | bc)
echo
echo "X = $vX"
echo
echo "$vA está para $vB, assim como $vC está para $vX"
}

# Menu para aceder a todas as calculadoras


# Texto do menu
   v_list=$(echo -e "1. calculadora-registadora \n2. calculadora-conversora \n3. calculadora-cambios \n4. calculadora-regra-3-simples \n5. Historico" | fzf -m --cycle --prompt="SELECIONE 1 calculadora: ")
            
# Quando o menu Ã© de Escolha multipla tipo `for` loop
   [[ $v_list =~ "1." ]] && f_exec_calculadora_registadora
   [[ $v_list =~ "2." ]] && f_exec_calculadora_conversora
   [[ $v_list =~ "3." ]] && f_exec_calculadora_cambios
   [[ $v_list =~ "4." ]] && f_exec_calculadora_regra_de_3
   [[ $v_list =~ "5." ]] && vim $v_log
   unset v_list             # Reset Ã  Variavel
