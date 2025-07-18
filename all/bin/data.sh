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
   # Exemplo: "Data atual: (Dia 07 Sex)(Mês 06 jun)(Ano 2024)(03:38:38)"

            # (Data atual) - (Ano 2025) - (Mes 06 Jun) - (Dia 18 Wed) - (03:03:14)

   # Instrucoes ao developer:
      # echo -ne "\r"      ## Move o cursor para o inicio da linha
      # echo -ne "\033[K"  ## Sequência de escape ANSI para limpar do cursor até o fim da linha.

   v_texto="(Data atual) -"

   v_dia=$(date +'%d')
   v_hor=$(date +'%H')
   #v_fuso=$(date +'%z')
   v_min=$(date +'%M')
   v_mes=$(date +'%b')
   v_ano=$(date +'%Y')
   v_texto="${v_texto} (${v_dia}${v_hor}${v_min}${v_mes}${v_ano}) -"

   v_ano=$(date +'%Y')
   v_texto="${v_texto} (Ano $v_ano) -"

   v_mes=$(date +'%m %b')
   v_texto="${v_texto} (Mês $v_mes) -"

   v_dia=$(date +'%d %a')
   v_texto="${v_texto} (Dia $v_dia) -"

   v_hora=$(date +'%H:%M:%S')
   v_texto="${v_texto} (Hora $v_hora)"

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
   echo 'Agora ao usar `vim\` ja pode despejar essa data com as teclas:'
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



# -----------------------------------------------


# uDev: Data neste formato:
# (Data atual) - (Ano 2025) - (Mes 06 Jun) - (Dia 18 Wed) - (03:03:14)


if [ -z $1 ]; then
   f_complete_date 
   echo

elif  [ $1 == "." ]; then
   # Menu with all the options

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='data.sh'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

     #L14='14. M | calandario lunar, em que cada mes tem 28 dias
      L14='14. F | Data para ficheiro (com verbose + instrucoes)'
      L13='13. f | Data em formato para ficheiros (sem verbose, envia para drya-date-now e drya-status-messages)'
      L12='12. b | Data completa esclarecida sem loop sem LOGO (background)'
      L11='11. d | Data completa esclarecida sem loop sem LOGO'
      L10='10. r | Data completa esclarecida com loop com LOGO'
       L9='9.  l | Data completa esclarecida com loop'
       L8='8.  h | Instructions / Help'
       L7='7.  v | Imprime 1x a data em um formato util para variaveis'
       L6='6.  H | Data que foca na hora'
       L5='5.  m | Imprime linhas com a hora durante 1 min'
       L4='4.  s | Imprime 1 linha com a hora durante 1 seg'
       L3='3.  g | Grupo Data Hora (ao estilo militar)'
       L2='2.  a | Alarm'

       L1='1.  Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "14. " ]] && f_variables_date_to_file_verbose
      [[ $v_list =~ "13. " ]] && f_variables_date_to_file
      [[ $v_list =~ "12. " ]] && f_background_process
      [[ $v_list =~ "11. " ]] && f_complete_date && echo
      [[ $v_list =~ "10. " ]] && f_complete_date_loop_plus_figlet
      [[ $v_list =~ "9.  " ]] && f_complete_date_loop
      [[ $v_list =~ "8.  " ]] && f_help
      [[ $v_list =~ "7.  " ]] && f_variables_date 
      [[ $v_list =~ "6.  " ]] && f_hour_date
      [[ $v_list =~ "5.  " ]] && f_one_minute_date
      [[ $v_list =~ "4.  " ]] && f_one_second_date
      [[ $v_list =~ "3.  " ]] && echo "uDev: GDH: 111230Z DEC 25 (Dia 11, 12h30, fuso Z, Dezembro, 2025)"
      [[ $v_list =~ "2.  " ]] && echo "uDev: quando chegar a hora pretendida, soar alarme"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list

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

elif  [ $1 == "h" ]; then
   # Instructions / Help
   f_help

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

elif  [ $1 == "g" ]; then
   # Imprime a data no formato grupo Data Hora (ao estilo militar)
   # 09FEB25 0930

   v_dia=$(date +'%d')
   v_hor=$(date +'%H')
   #v_fuso=$(date +'%z')
   v_min=$(date +'%M')
   v_mes=$(date +'%b')
   v_ano=$(date +'%Y')

   v_texto="Grupo Data Hora (GDH):"
   v_texto="$v_texto ${v_dia}${v_hor}${v_min}${v_mes}${v_ano}"
   echo $v_texto

elif  [ $1 == "a" ]; then
   # Alarm
   echo "uDev: quando chegar a hora pretendida, soar alarme"

elif  [ $1 == "f" ]; then
   # Data para ficheiro, sem verbose output
   f_variables_date_to_file

elif  [ $1 == "F" ]; then
   # Data para ficheiro, sem verbose output
   f_variables_date_to_file_verbose

elif  [ $1 == "M" ]; then
   # uDev: Calendario lunar
   # Formato: Lua1-Terra28-Sol25 (13 meses = 13 Luas) + (28 dias = 28 Voltas da Terra) + (Ano 2025 = Voltas ao Sol 25, desde 2000)
   # Saturday (vem de Saturn-day, Dia de Saturno (o planeta)) # link: https://www.instagram.com/reel/DFIrKJuO_iQ/?igsh=aWljaHp1b21heXh5
   echo "uDev: Calendario com lua"


fi

