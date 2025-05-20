#!/bin/bash
# Title: web
# Description: Make web options easier to Seiva
 

# Note: Alias related to web were kept in .../DRYa/etc/config-bash-alias
#
#       Example: 
#
#       Shortcuts for fx `web`
#         # dee: HashTag:987657897
#         alias siigo="eval web siigo"
#         alias gpt="eval web gpt"
#         alias lojas="eval web lojas"
#         alias yt="eval web yt"
#         alias ytd="read -p 'Enter youtube link to download: ' v_ans; yt-dlp $v_ans"
#         alias whatsapp="xdg-open https://web.whatsapp.com"



function web {
   # dee: T: `web`  ::  D: Fx que abre websites corretamente de acordo com o dispositivo/maquina atual  #HashTag:987657897
   # Simply opening a browser (args may be given)
   # Note: after this fx, some shortcuts will be created also
   
   # uDev: Usar metodo de desconectar o processo por completo do terminal atual

   # Homepage pre-definida
      homePage_name="Duckduckgo.com"
      homePage="https://$homePage_name"

   # Reset à variavel
      unset v_URL



   function f_detetar_browsers_instalados_e_pre_definido {
      # Faz uma lista de browsers instalados, diz tambem qual é o pre-definido
     
      # Listar Browers
         echo "DRYa: Browsers Instalados:"
   
         for i in firefox google-chrome chromium brave opera vivaldi epiphany; do
           if command -v $i >/dev/null 2>&1; then
             echo " > $i em: $(command -v $i)"
           fi
         done


      # Verbose: Informar browser pre-definido
         v_default=$(xdg-settings get default-web-browser)

         echo
         echo "DRYa: Browser Pre-Definido:"
         echo " > $v_default"
   }





   function f_fzf_raw_link_opener {
      # Navegar para a pasta que contem o backup de bookmarks, depois FILTRA esses bookmarks. "Raw" significa "Extrair so texto dos links, sem os <div> do HTML"

      v_dir=${v_REPOS_CENTER}/omni-log/all/browser-bookmarks

      if [[ -d $v_dir ]]; then
         cd $v_dir
         bash $v_dir/raw-link-opener.sh
         cd -
      else
         echo "DRYa: Repo omni-log (que contem os bookmarks) nao esta no sistema"
      fi
      
   }




   # Identificar os argumentos que se enviam para esta fx
      if [ -z $1 ]; then 
         # Se nao for dado nenhum argumento, dar o menu: 
   
         # Lista de opcoes
            L12='12. Pesquisa online (com browser pre-definido + google.com)'

            L11="11. Experimentar Terminal Online"  
            L10="10. Experimentar Distros Linux Online" 
             L9="9.  Pagina do historico Google" 

             L8='8.  Detetar | Browser pre-definido + Browsers instalados' 
             L7="7.  Navegar | Router Config Page"

             L6="6.  Ir | Google.com"
             L5="5.  Ir | $homePage_name"
             L4='4.  Ir | Seiva Website'
             L3='3.  Ir | Seiva Github.com'

             L2='2.  Abrir | Bookmarks Guardados '
             L1='1.  Cancel'

         v_ask=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$L9 \n$L10 \n$L11 \n\n$L12" | fzf --cycle --prompt="SELECT: como quer aceder à Web: ")

         [[ $v_ask =~ "12. " ]] && read -p "DRYa: Pesquisa web (google): " v_ans && xdg-open "https://www.google.com/search?q=$(echo $v_ans | sed 's/ /+/g')"
         [[ $v_ask =~ "11. " ]] && v_URL="https://www.terminaltemple.com"
         [[ $v_ask =~ "10. " ]] && v_URL="https://distrosea.com/pt"
         [[ $v_ask =~ "9.  " ]] && v_URL="https://myactivity.google.com"
         [[ $v_ask =~ "8.  " ]] && f_detetar_browsers_instalados_e_pre_definido 
         [[ $v_ask =~ "7.  " ]] && v_URL="firefox http://192.168.1.1"  # 192.168.0.1 ou 192.168.1.1  # uDev: firefox pode nao ser o browser pre-definido
         [[ $v_ask =~ "6.  " ]] && v_URL="https://google.com"
         [[ $v_ask =~ "5.  " ]] && v_URL="https://duckduckgo.com"
         [[ $v_ask =~ "4.  " ]] && v_URL="https://seiva.yolasite.com"
         [[ $v_ask =~ "3.  " ]] && v_URL="https://github.com/SeivaDArve"
         [[ $v_ask =~ "2.  " ]] && f_fzf_raw_link_opener 
         [[ $v_ask =~ "1.  " ]] && echo "Canceled"
         
      elif [ $1 == "." ]; then 
         unset v_URL
         v_URL="https://seiva.yolasite.com"
         
      elif [ $1 == "siigo" ]; then 
         v_URL="https://siigo-maintenance.com/#/calendar"

      elif [ $1 == "gpt" ]; then 
         v_URL="https://chatgpt.com/?oai-dm=1"

      elif [ $1 == "duck" ]; then 
         v_URL="https://duckduckgo.com"
         
      elif [ $1 == "lojas" ]; then 
         v_URL="https://www.cascaishopping.pt/mapa/#/location/639a8d573b88061336d69a59"

      elif [ $1 == "yt" ]; then 
         v_URL="https://www.youtube.com"

      elif [ $1 == "bm" ]; then 
         # Abrir bookmarks guardados
         f_fzf_raw_link_opener

      elif [ $1 == "s" ]; then 
         # Web Search (browser pre-definido + google.com)
         read -p "DRYa: Pesquisa web (google): " v_ans
         xdg-open "https://www.google.com/search?q=$(echo $v_ans | sed 's/ /+/g')"

      else
         echo "DRYa: web: Tem de inserir um link valido"
         #echo " > Vamos tentar abrir o texto introduzido "
         #v_URL=$1

      fi

   # Send file 'nohup.out' to a tmp dir
      mkdir -p ~/.tmp


   # Identificar a maquina atual
      if [[ -z $v_URL ]]; then
         echo "Link Aberto pelo script: raw-link-opener.sh" 1>/dev/null

      elif [[ $traits_OS == "Android" ]]; then     # When using Termux
         echo "DRYa: A abrir com Termux: "
         echo " > $v_URL"

         cd ~/.tmp

         #termux-open-url "$v_URL" &
         nohup termux-open-url "$v_URL" & disown
         cd -
      
      elif [[ $traits_OS == "Linux" ]]; then      # When using Linux 
         echo "DRYa: A abrir com Linux: $v_URL"
         xdg-open $v_URL & disown

      elif [[ $traits_OS == "Windows" ]]; then    # Maybe using windows 
         echo "DRYa: A abrir com Windows: $v_URL"
         "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$v_URL" & disown

      else
         echo "DRYa: Erro a abrir o link"
      
      fi
}
