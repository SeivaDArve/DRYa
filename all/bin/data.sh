#!/bin/bash
# Title: data.sh

function f_complete_date {
   # Exemplo: "Data atual: (Dia 07 Sex)(Mês 06 jun)(Ano 2024)(03:38:38)"

   # Instrucoes ao developer:
      # echo -ne "\r"      ## Move o cursor para o inicio da linha
      # echo -ne "\033[K"  ## Sequência de escape ANSI para limpar do cursor até o fim da linha.

   v_texto="Data atual: (Dia"
   v_dia=$(date +'%d %a')
   v_texto_dia="$v_texto $v_dia"

   v_texto="$v_texto_dia)(Mês"
   v_mes=$(date +'%m %b')
   v_texto_mes="$v_texto $v_mes"

   v_texto="$v_texto_mes)(Ano"
   v_ano=$(date +'%Y)')
   v_texto_ano="$v_texto $v_ano"

   v_hora=$(date +'(%H:%M:%S)')
   v_data="$v_texto_ano$v_hora"
   echo -ne "\r\033[K$v_data "
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

function f_help {
   # Instructions / Help
  
   echo 'DRYa: Command `data` with alias `d`'
   echo ' > `data`      # Output 1x Current time'
   echo ' > `data h`    # Help and Instructions'
   echo ' > `data L`    # Loop Current time with figlet'
   echo ' > `data l`    # Loop Current time'
   echo ' > `data hr`   # Loop Current hour'
   echo ' > `data v`    # Output 1x variable-like time'
   echo ' > `data min`  # During 1 minut, display time'
   echo ' > `data seg`  # During 1 second display time'
}

function f_variables_date {
   # Exemplo: "Data/Hora: 2024-06-07 04:21:26"

      v_data=$(date +'%Y-%m-%d_%Hh-%Mm-%Ss')
      echo -e "Data-Hora_$v_data"
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



if [ -z $1 ]; then
   f_complete_date 
   echo

elif  [ $1 == "L" ]; then
   # Data completa esclarecida em loop com ASCII
   clear
   figlet 'DRYa'
   echo "DRYa: data.sh"
   echo "----------------------------------------------------------"
   f_complete_date_loop

elif  [ $1 == "l" ]; then
   # Data completa esclarecida em loop
   f_complete_date_loop

elif  [ $1 == "h" ]; then
   # Instructions / Help
   f_help

elif  [ $1 == "v" ]; then
   # Imprime 1x a data em um formato util para variaveis
   f_variables_date 

elif  [ $1 == "hr" ]; then
   # Data que foca na hora
   f_hour_date

elif  [ $1 == "min" ]; then
   # Imprime linhas com a hora durante 1 min
   f_one_minute_date

elif  [ $1 == "seg" ]; then
   # Imprime 1 linha com a hora durante 1 seg
   f_one_second_date

elif  [ $1 == "g" ]; then
   # Imprime a data no formato grupo Data Hora (ao estilo militar)
   # 09FEB25 0930
   echo "uDev: GDH"
fi

