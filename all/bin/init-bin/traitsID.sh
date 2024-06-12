#!/bin/bash
# Title: TraitsID
# Description: faz uso do kernel para identificar variaveis que permiam ao script DRYa de tornar Cross-Platform. Assim, será possivel ao utilizador usar os mesmos softwares independentemente se esta no Android, Linux, WSL2 no Windows, Windows, etc.
#              No final do ficheiro também estara um catalogo de todas as variaveis
#              As variaveis que vao ser encontradas vao ser colocadas em 4 sitios: Uma Array; Exportadas para o Env; Concatenadas num ficheiro de configs; No final deste documento de texto num mini catalogo de variaveis


function f_array_0 {
   # Criar um Array Associativo (semelhante a um dicionario em python com pares de key + value)
      # Como na versão atual de Bash não da para exportar arrays, será usado um metodo mais arcaico
      echo "Este ficheiro é:"
      echo "> $traits_file"  # Esta variavel foi criada e exportada em 'source-all-drya-files'
      echo 
      echo "Elemento [0] do array arcaico:"
      echo " > Cujo 'Key' + 'Pair' estao separados por '::'"
      echo " >> $traits_0"   # esta variavel foi criada e exportada em 'source-all-drya-file'
      echo 
}
f_array_0 1>/dev/null  # O output será envido para o crl... porque serve so para debug
   
function f_array_1 {
   # Detetar o Termux
      # No termux a variavel $PREFIX nao vem vazia e tras normalmente o conteudo: "/data/data/com.termux/files/usr"
      if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
         #echo "Estamos no termux"  # Debug
         traits_termux="true"
         export traits_termux

         traits_1="Is-Termux::$traits_termux"
         export traits_1

         echo "Var termux:"
         echo " > $traits_1"

      else
         traits_termux="false"
         export traits_termux
   
         traits_1="Is-Termux::$traits_termux"
         export traits_1

         echo "Var termux:"
         echo " > $traits_1"
      fi
}
f_array_1 1>/dev/null  # O output será envido para o crl... porque serve so para debug
   






# Vindo de source-all-drya-files ------------------------------ {



   # Getting info about the machine

   # uDev: Send all this to a file: .../DRYa/all/bin/init-bin/traitsID.sh
   # uDrv: Detetar WM (window manager, se estar a usar GNOME, KDE...

   # Clear the file with all the outputs of traitsID (it is created anew every single time DRYa is loaded on a terminal)
      # Each variable will be sent to the env
         # export v_var

      # Variables will also be pasted into a file for fast ´cat´
         v_dir=~/.config/h.h/drya/
         v_file="traitsID"
         v_id_file="${v_dir}${v_file}"

         mkdir -p $v_dir
         touch $v_id_file

   # Create the file from scrarch at every terminal startup
      rm $v_id_file 2>/dev/null
      touch $v_id_file

      alias tid="less $v_id_file"

   # Using command 'uname'
      v_uname=$(uname -a)

   # Filter the info to Detect OS
   # SIGLA for $v_arr1: tid:A???? (A)ndroid (Wi)ndows (L)inux (R)aspberry (U)nknown

      if [[ $v_uname =~ "Android" ]]; then 
         echo "DRYa: Running on: Android"
         echo 'traits_OS="Android"' >> $v_id_file 

         traits_OS="Android"; export traits_OS
         v_arr1=A
         
      elif  [[ $v_uname =~ "Microsoft" ]]; then 
         echo "DRYa: Running on: Windows"
         echo 'traits_OS="Windows"' >> $v_id_file

         traits_OS="Microsoft"; export traits_OS
         v_arr1=W

         # uDev: Verificar se o sistema está no WSL2

      elif [[ $v_uname =~ "raspberrypi" ]]; then 
         # Linux has to be the last one, because it means Windows and Android are not present
         echo "DRYa: Running on: Linux (Raspberry Pi)"
         echo 'traits_OS="Linux-Rasp"' >> $v_id_file

         traits_OS="RaspberryPi"; export traits_OS
         v_arr1=R

      elif [[ $v_uname =~ "Linux" ]]; then 
         # Linux has to be the last one, because it means Windows and Android are not present
         echo "DRYa: Running on: Linux"
         echo 'traits_OS="Linux"' >> $v_id_file

         traits_OS="Linux"; export traits_OS
         v_arr1=L

      else
         echo "DRYa: Running on: NOT DETECTED"
         traits_OS="NotDetected"; export traits_OS
         v_arr1=U
      fi 

      # Display a way to reach the info
         echo "      > view traitsID with: 'tid' "


      # Create a single string with all info (as a code):
         declare -a v_tid=(
            [0]="tid="
            [1]=$v_arr1
         )
         echo "${v_tid[0]}${v_tid[1]}" >> $v_id_file

      # Create a script at DRYa/all/bin/ for drya-neofetch
         # uDev: Create the same for Device: Samsung, TLC, Lenovo, Azus (drya will need a .config for this, and needs the user to answer a script)
         # uDev: Detecte personal/safe device from job/public/unsafe device
         # uDev: Create the same for package manager: apt, pacman, dnf, pkg
         # uDev: Create the same for processor: ARM, 64 Bits, 32 Bits (Raspberry pi?)
         # uDev: Create a binary for each combination: 00101: pacman, lenovo, windows, userX
         # uDev: Create environment variables: drya-env-os; drya-env-me (for command whoami); etc
         # uDev: Versao do Linux (para config do teclado)
            #which yum >/dev/null && { echo Fedora flavour; exit 0; }
            #which zypper >/dev/null && { echo Suse of sorts; exit 0; }
            #which apt-get >/dev/null && { echo Debian based;  }
      # Detect wifi not connected networks due to lack of passaword and chech our list of wifi passwords to see if we can log on it

   # Source file After writting with all variables for traitsID
      source $v_id_file






# } --------------------------------------------------------------





# Verificar o package manager atual (pkg, apt, brew, pacman)
   if [ -f /etc/os-release ]; then
      source /etc/os-release
       if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
           echo "apt"
           traits_pkgm="apt"
           pkgm="apt"
           export traits_pkgm
           export pkgm

       elif [ "$ID" = "arch" ] || [ "$ID" = "manjaro" ]; then
           echo "pacman"
           traits_pkgm="pacman"
           pkgm="pacman"
           export traits_pkgm
           export pkgm

       else
           echo "Outro package manager Linux"
       fi
   # Verificar se o sistema operacional é Termux (Android)
   elif [ -d "$PREFIX" ]; then
      echo "pkg"
      traits_pkgm="pkg"
      pkgm="pkg"
      export traits_pkgm
      export pkgm

   # Verificar se o sistema operacional é macOS
   elif [ "$(uname)" == "Darwin" ]; then
      echo "brew"
      traits_pkgm="brew"
      pkgm="brew"
      export traits_pkgm
      export pkgm

   else
       echo "Package manager não identificado"
   fi
      

# Catalogo de todas as variaveis do traitsID encontradas neste ficheiro desde o inicio
   # traits_file =
   # traits_0 = 

   # traits_termux = [ 'true' | 'false' ]
   # traits_1 = 
