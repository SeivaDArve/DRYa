#!/bin/bash
# Title: data.sh

function f_c2 { 
   # Fx for color 2
   # Used: f_talk

   tput setaf 12
}

function f_rc { 
   # Fx for color reset

   # This function is to be used when styles are to be CLEARED
   tput sgr0
}

function f_background_process {
   echo "data test hit" >> $v_MSGS

   function f_bg {
      while true
      do
               echo
         f_c2; echo -n "Data.sh: "
         f_rc; echo    "data test hit"
               echo

         sleep 60
      done
       
   }

   f_bg & 
   
   v_pid=$?

   echo "PID is: $v_pid"
}

function f_complete_date {
   # Exemplo: (Data atual) - (GDH 130622Sep2025) - (Ano 2025) - (Mês 09 Sep) - (Dia 13 Sat) - (Hora 06:22:56)

   # Montagem da data
      # Display: Titulo em linha com o restante
         v_texto="(Data atual) -"

      # Display: Grupo data hora
         v_txt="GDH"
         v_dia=$(date +'%d')
         v_hor=$(date +'%H')
         #v_fuso=$(date +'%z')
         v_min=$(date +'%M')
         v_mes=$(date +'%b')
         v_ano=$(date +'%Y')
         v_texto="${v_texto} ($v_txt ${v_dia}${v_hor}${v_min}${v_mes}${v_ano}) -"
   
      # Display: Ano sozinho
         v_ano=$(date +'%Y')
         v_texto="${v_texto} (Ano $v_ano) -"

      # Display: Mes sozinho
         v_mes=$(date +'%m %b')
         v_texto="${v_texto} (Mês $v_mes) -"

      # Display: Dia sozinho
         v_dia=$(date +'%d %a')
         v_texto="${v_texto} (Dia $v_dia) -"

      # Display: Hora + minutos + segundos
         v_hora=$(date +'%H:%M:%S')
         v_texto="${v_texto} (Hora $v_hora)"

   # Instrucoes ao desenvolvedor:
      # echo -ne "\r"      ## Move o cursor para o inicio da linha
      # echo -ne "\033[K"  ## Sequência de escape ANSI para limpar do cursor até o fim da linha.

      # Montrar o resultado no terminal
         echo -ne "\r\033[K$v_texto "  
}

function f_complete_date_loop {
   # Exemplo: "Data atual: (Dia 07 Sex)(Mês 06 jun)(Ano 2024)(03:38:38)"

   while true
   do
      f_complete_date
      sleep 1

      #read -t 1 -s v_key
      #[[ $v_key == "q" ]] && exit
      #[[ $v_key == "Q" ]] && exit
   done
}

function f_complete_date_loop_plus_figlet {
   clear
   figlet 'DRYa'
   echo "DRYa: data.sh"
   echo "----------------------------------------------------------"
   f_complete_date_loop
}

function f_help {
   # Instructions / Help
  
   echo 'DRYa: Command `data` with alias `d`'
   echo ' > `data`      # Output 1x Current time'
   echo ' > `data .`    # Main Menu'
   echo ' > `data h`    # Help and Instructions'
   echo ' > `data r`    # Loop Current time with figlet'
   echo ' > `data l`    # Loop Current time'
   echo ' > `data hr`   # Loop Current hour'
   echo ' > `data v`    # Output 1x variable-like time'
   echo ' > `data min`  # During 1 minut, display time'
   echo ' > `data seg`  # During 1 second display time'
}

function f_variables_date {
   # Exemplo: "Data-Hora_2024-06-07_04:21:26"

      v_data=$(date +'%Y-%m-%d_%Hh-%Mm-%Ss')
      v_data="Data-Hora_$v_data"
      echo "$v_data"
}

function f_variables_date_to_file {
   # Envia so a data para ficheiro drya-date-now (sem output)
   # (Durante o uso de `vim` pode despejar a data existente nesse ficheiro com as teclas de atalho `ZD` (confirmar teclas em .vimrc))
   # Exemplo: "<2024-06-07>"

   v_date_now=~/.config/h.h/drya/drya-date-now

   v_data=$(date +'<%Y-%m-%d>')
   echo "$v_data" >  $v_date_now
   echo -e "\nScript 'data.sh': nova data '$v_data' inserida no ficheiro $v_date_now\n" >> $v_MSGS
}

function f_variables_date_to_file_verbose {
   f_variables_date_to_file

   echo "DRYa: data.sh: Enviar data atual para um ficheiro"
   echo " 1. Teclas: \`d F\` para preencher ficheiro \$drya-date-now com data"
   echo " 2. Teclas: \`ZD\`  no \`vim\` para despejar essa data no doc"
   echo 
   echo "Localizacao do ficheiro drya-date-now: "
   echo " > $v_date_now"
   echo
   echo "Data atual (enviada):"
   echo " > $v_data"
   echo 
   echo 'Agora ao usar `vim` ja pode despejar essa data com as teclas:'
   echo ' > `ZD`  (confirmar em .vimrc)'
   echo
}

function f_hour_date {
   # Exemplo: "Data/Hora: 2024-06-07 04:21:26"

   # uDev: fx para print apenas 1x sem loop

   while true
   do
      
      # Instrucoes:
         # echo -ne "\r"      ## Move o cursor para o inicio da linha
         # echo -ne "\033[K"  ## Sequência de escape ANSI para limpar do cursor até o fim da linha.

      v_data=$(date +'%Y-%m-%d %H:%M:%S')
      echo -ne "\r\033[KData/Hora: $v_data "
      sleep 1

   done
}

function f_one_minute_date {
   tput setaf 3
   echo "Data e hora (Durante 1 minuto)"
   echo " > Cancelar [Ctrl + C]"
   tput sgr 0

   # Translating to Portuguese and storing in a variable
   if [ $(date +%A) == "Monday"    ]; then v_dia=Segunda; fi
   if [ $(date +%A) == "Tuesday"   ]; then v_dia=Terça;   fi
   if [ $(date +%A) == "Wednesday" ]; then v_dia=Quarta;  fi
   if [ $(date +%A) == "Thursday"  ]; then v_dia=Quinta;  fi
   if [ $(date +%A) == "Friday"    ]; then v_dia=Sexta;   fi
   if [ $(date +%A) == "Saturday"  ]; then v_dia=Sabado;  fi
   if [ $(date +%A) == "Sunday"    ]; then v_dia=Domingo; fi

   # Output the date and time for 60 seconds
   for i in {1..60}
   do
      echo -n "$v_dia "
      date +"%d/%m/%Y %H:%M:%S"
      sleep 1
   done
}

function f_one_second_date {
   tput setaf 3
   echo "Data e hora (Durante 1 segundo)"
   tput sgr 0

   # Translating to Portuguese and storing in a variable
   if [ $(date +%A) == "Monday"    ]; then v_dia=Segunda; fi
   if [ $(date +%A) == "Tuesday"   ]; then v_dia=Terça;   fi
   if [ $(date +%A) == "Wednesday" ]; then v_dia=Quarta;  fi
   if [ $(date +%A) == "Thursday"  ]; then v_dia=Quinta;  fi
   if [ $(date +%A) == "Friday"    ]; then v_dia=Sexta;   fi
   if [ $(date +%A) == "Saturday"  ]; then v_dia=Sabado;  fi
   if [ $(date +%A) == "Sunday"    ]; then v_dia=Domingo; fi

   # Output the date and time for 1 second
   echo -n "$v_dia "
   date +"%d/%m/%Y %H:%M:%S"
}

function f_nanoseconds {
  v_nano=$(date +'%N')
  echo $v_nano
}

function f_short_with_seconds {
  v_data_shrt_plus_secs=$(date +'<%Y-%m-%d %H:%M:%S>')
  echo "$v_data_shrt_plus_secs"
}

function f_data_ano_mes_dia {
   # Formato '2025-09-22'

   v_dia=$(date +'%d')
   v_mes=$(date +'%m') 
   v_ano=$(date +'%Y')
   
   v_result="$v_ano-$v_mes-$v_dia"
   echo $v_result
}

function f_data_grupo_data_hora {
   # Imprime a data no formato grupo Data Hora (ao estilo militar)
   # Formato: "(GDH: 240309set2025)"
   
   #echo "uDev: GDH: 111230Z DEC 25 (Dia 11, 12h30, fuso Z, Dezembro, 2025)"

   v_dia=$(date +'%d')
   v_hor=$(date +'%H')
   #v_fuso=$(date +'%z')
   v_min=$(date +'%M')
   v_mes=$(date +'%b')  # uDev: Corrigir 'Dez'=='Dec'  ::  uDev: Traduzir do Ing e do Pt para uma so lingua
   v_ano=$(date +'%Y')

   v_texto="(GDH: $v_texto ${v_dia}${v_hor}${v_min}${v_mes}${v_ano})"
   echo $v_texto
}

function f_data_alarm {

   function f_alarme {
      while true
      do
         clear
               echo
         f_c2; echo -n "Data.sh: "
         f_rc; echo    "Alarm (cancel with command \`d A\` (uDev)"
               echo

         sleep 60  # uDev: substituir por um prompt que pergunte qual o horario que pretende
      done
   }

   f_alarme & 
   # udev: buscar o numero do PID anterior e criar um alias para cancelar esse PID
}
# -----------------------------------------------





# Aplicar SEMPRE (simplificando) `d f` para que o `vim` possa usar `ZD` no `vim`
   f_variables_date_to_file 



if [ -z $1 ]; then
   # Imprimir 1x a data no terminal
      f_complete_date
      echo


elif  [ $1 == "." ]; then
   # Menu with all the options


   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='data.sh'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

     #L14='14. M | calandario lunisolar, em que cada mes tem 28 dias. 
      L19='19. | e | Data em formato numerico "ano-mes-dia"'
      L18='18. | I | Informar dia/forma de mudanca de hora Verao/Inverno Marco/Outubro'  # Toda a info: https://www.calendarr.com/portugal/mudanca-de-hora-em-portugal/
      L17='17. | n | Nanoseconds only'
      L16='16. | i | Data da internet (nao confiar no pc)'
      L15='15. | F | Data curta para ficheiros (+ verbose + instrucoes)  # uDev: iniciar background process para continuamente atualizar drya-date-now'
      L14='14. | f | Data curta para ficheiros (- verbose, envia para drya-date-now e drya-status-messages)'
      L13='13. | c | Data curta para terminal  (+ verbose, com segundos, envia para drya-date-now e drya-status-messages, define variavel v_data_shrt_plus_secs)'
      L12='12. | b | Data longa esclarecida (- loop)(- ASCII) - (background test)'
      L11='11. | d | Data longa esclarecida (- loop)(- ASCII)'
      L10='10. | r | Data longa esclarecida (+ loop)(+ ASCII)'
       L9='9.  | l | Data longa esclarecida (+ loop)'
       L8='8.  | v | Data em formato util para variaveis'
       L7='7.  | H | Data que foca na hora (+ loop)(- ASCII)'
       L6='6.  | m | Imprime linhas:  com a hora durante 1 min'
       L5='5.  | s | Imprime 1 linha: com a hora durante 1 seg'
       L4='4.  | g | Data estilo militar (Grupo Data Hora)'
      #L3='3.  | A | Alarm - Cancelar (uDev)'
       L3='3.  | a | Alarm - Iniciar  (uDev)'

       L2='2.  | h | Instructions / Help'
       L1='1.  Cancelar'

      Lh=$(echo -e "\nInfo: Ja esta a ser aplicado automaticamente 'd f' para se usar com 'ZD' no 'vim'\n ")
      L0="[m+] data.sh: main menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n$L16 \n$L17 \n$L18 \n$L19 \n\n$Lz3" | fzf --no-info -m --cycle --header="$Lh" --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "19. " ]] && f_data_ano_mes_dia
      [[ $v_list =~ "18. " ]] && echo "uDev"
      [[ $v_list =~ "17. " ]] && f_nanoseconds 
      [[ $v_list =~ "16. " ]] && echo "uDev"
      [[ $v_list =~ "15. " ]] && f_variables_date_to_file_verbose
      [[ $v_list =~ "14. " ]] && f_variables_date_to_file
      [[ $v_list =~ "13. " ]] && f_short_with_seconds
      [[ $v_list =~ "12. " ]] && f_background_process
      [[ $v_list =~ "11. " ]] && f_complete_date && echo
      [[ $v_list =~ "10. " ]] && f_complete_date_loop_plus_figlet
      [[ $v_list =~ "9.  " ]] && f_complete_date_loop
      [[ $v_list =~ "8.  " ]] && f_variables_date 
      [[ $v_list =~ "7.  " ]] && f_hour_date
      [[ $v_list =~ "6.  " ]] && f_one_minute_date
      [[ $v_list =~ "5.  " ]] && f_one_second_date
      [[ $v_list =~ "4.  " ]] && f_data_grupo_data_hora
      [[ $v_list =~ "3.  " ]] && echo "uDev: quando chegar a hora pretendida, soar alarme"
      [[ $v_list =~ "2.  " ]] && f_help
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" 
      unset v_list

elif  [ $1 == "h" ]; then
   # Instructions / Help
   f_help

elif  [ $1 == "b" ]; then
   # Data num processo em segundo plano
   # Usa drya-msgs para enviar info do PID do processo
   
   f_background_process
    
elif  [ $1 == "r" ]; then
   # Data completa esclarecida em loop com ASCII

   f_complete_date_loop_plus_figlet

elif  [ $1 == "l" ]; then
   # Data completa esclarecida em loop
   f_complete_date_loop

elif  [ $1 == "d" ]; then
   # Nota: `d` e `d d` sao o mesmo comando de proposito
   f_complete_date && echo

elif  [ $1 == "v" ]; then
   # Imprime 1x a data em um formato util para variaveis
   f_variables_date 

elif  [ $1 == "H" ]; then
   # Data que foca na hora
   f_hour_date

elif  [ $1 == "m" ]; then
   # Imprime linhas com a hora durante 1 min
   f_one_minute_date

elif  [ $1 == "s" ]; then
   # Imprime 1 linha com a hora durante 1 seg
   f_one_second_date

elif  [ $1 == "e" ]; then
   # Formato '2025-09-22'
   
   f_data_ano_mes_dia

elif  [ $1 == "g" ]; then
   # Imprime a data no formato grupo Data Hora (ao estilo militar)
   # Formato: "(GDH: 240309set2025)"

   f_data_grupo_data_hora

elif  [ $1 == "a" ]; then
   # Alarm
   echo "uDev: quando chegar a hora pretendida, soar alarme"
   f_data_alarm

elif  [ $1 == "f" ]; then
   # Data para ficheiro, sem verbose output
   f_variables_date_to_file

elif  [ $1 == "F" ]; then
   # Data para ficheiro, sem verbose output
   f_variables_date_to_file_verbose

elif  [ $1 == "c" ]; then
   f_short_with_seconds

elif  [ $1 == "n" ]; then
   f_nanoseconds

elif  [ $1 == "M" ]; then
   # uDev: Calendario lunisolar
   # Formato: Lua1-Terra28-Sol25 (13 meses = 13 Luas) + (28 dias = 28 Voltas da Terra) + (Ano 2025 = Voltas ao Sol 25, desde 2000)
   # Saturday (vem de Saturn-day, Dia de Saturno (o planeta)) # link: https://www.instagram.com/reel/DFIrKJuO_iQ/?igsh=aWljaHp1b21heXh5
   
   # calandario lunisolar, cada mes tem 28 dias. 
   # O ano comeca no dia 26 de julho com ressurgimento da estrela Sírius no horizonte (heliacal, segundo os Maias))
   # Para sincronizacao com o sol, dia 25 Juho é um dia fora do tempo
   # O primeiro dia da semana é sempre um domingo
   echo "uDev: Calendario com lua"


fi

