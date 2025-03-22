# Title: web.sh
# Description: Used to be an alias `web` that neede to be added to the options at `D ip`, to, the alias became this script

# dee: T: `web`  ::  D: Fx que abre websites corretamente de acordo com o dispositivo/maquina atual  #HashTag:987657897

# Simply opening a browser (args may be given)
# Note: after this fx, some shortcuts will be created also

# uDev: Usar metodo de desconectar o precesso por completo do terminal atual
# uDev: Filtrar os "browser-bookmarks" e fornecer uma opcao para isso

# Homepage pre-definida
   homePage_name="Duckduckgo.com"
   homePage="https://$homePage_name"

# Reset à variavel
   unset v_URL

# Identificar os argumentos que se enviam para esta fx
   if [ -z $1 ]; then 
      # Se nao for dado nenhum argumento, dar o menu: 

      # Lista de opcoes

         #L8='8. Saber qual é o browser pre-definido'  # `xdg-settings get default-web-browser`
         #L7="7. Online Terminal"  # https://www.terminaltemple.com/
         #L7="Pagina do historico Google

         L6="6. Ir | Router Config Page"

         L5="5. Ir | Google.com"
         L4="4. Ir | $homePage_name"
         L3='3. Ir | Seiva Website'

         L2='2. Abrir | Bookmarks Guardados '
         L1='1. Cancel'

      v_ask=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n$L5 \n\n$L6" | fzf --cycle --prompt="SELECT: como quer aceder à Web: ")

      [[ $v_ask =~ "6. " ]] && v_URL="firefox http://192.168.1.1"  # 192.168.0.1 ou 192.168.1.1
      [[ $v_ask =~ "5. " ]] && v_URL="https://google.com"
      [[ $v_ask =~ "4. " ]] && v_URL="https://duckduckgo.com"
      [[ $v_ask =~ "3. " ]] && v_URL="https://seiva.yolasite.com"
      [[ $v_ask =~ "2. " ]] && f_fzf_raw_link_opener 
      [[ $v_ask =~ "1. " ]] && echo "Canceled"
      
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
      f_fzf_raw_link_opener

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
      xdg-open $v_URL & 

   elif [[ $traits_OS == "Windows" ]]; then    # Maybe using windows 
      echo "DRYa: A abrir com Windows: $v_URL"
      "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$v_URL" &

   else
      echo "DRYa: Erro a abrir o link"
   
   fi

   
