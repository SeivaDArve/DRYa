#!/bin/bash
# Title: TraitsID (Getting info about the machine)
# Description: faz uso do kernel para identificar variaveis que permiam ao script DRYa de tornar Cross-Platform. Assim, será possivel ao utilizador usar os mesmos softwares independentemente se esta no Android, Linux, WSL2 no Windows, Windows, etc.
#              No final do ficheiro também estara um catalogo de todas as variaveis
#              As variaveis que vao ser encontradas vao ser colocadas em 4 sitios: Uma Array; Exportadas para o Env; Concatenadas num ficheiro de configs; No final deste documento de texto num mini catalogo de variaveis

# uDev: Send all this to a file: .../DRYa/all/bin/init-bin/traitsID.sh
# uDev: Detetar WM (window manager, se estar a usar GNOME, KDE...
# uDev: Se o dispositivo nao for reconhecido, mostrar outro comportamento, por exemplo, nao mostrar que Jarve e DRYa existe no dispositivo
# uDev: Detect Wifi connection name
# uDev: set raspberry pi Screen Resolution (when using "Silver" TV) for: 1360x768
# uDev: Set windows time and date automaticaly with batch scripts
# uDev: Porque nao usar tambem sqlite3 (base de dados) para guardar as variaveis?

function f_set_vars_source_script_output {
   # File that has a copy of all variables sent to environment

   # Nome do ficheiro SOURCE (este mesmo ficheiro, que mantem alias 'trid' do script 'traitsID.sh')
      trid_source="${v_REPOS_CENTER}/DRYa/all/source-all-drya-files"
      trid_0="trid_source::$trid_source"  # Na versao atual de bash, não da para exportar arrays, será usado um metodo mais arcaico

   # Nome do ficheiro SCRIPT traitsID.sh
      trid_script="${v_REPOS_CENTER}/DRYa/all/bin/traitsID.sh"
      trid_1="trid_script::$trid_script"  # Na versao atual de bash, não da para exportar arrays, será usado um metodo mais arcaico

   # Nome do ficheiro OUTPUT com as variaveis
      trid_dir=~/.config/h.h/drya/
      trid_file=traitsID
      trid_output=$trid_dir/$trid_file
      trid_2="trid_output::$trid_output"  # Na versao atual de bash, não da para exportar arrays, será usado um metodo mais arcaico

   # Sempre que o terminal inicia, recria o ficheiro de output
      mkdir -p $trid_dir
      rm       $trid_output 2>/dev/null
      touch    $trid_output

   # Guardar em "trid_output" todas as var
      echo "trid_source=$trid_source" >> $trid_output
      echo "trid_0=$trid_0"           >> $trid_output
      echo "trid_script=$trid_script" >> $trid_output
      echo "trid_1=$trid_1"           >> $trid_output
      echo "trid_output=$trid_output" >> $trid_output
      echo "trid_2=$trid_2"           >> $trid_output
      echo "trid_dir=$trid_dir"       >> $trid_output
      echo "trid_file=$trid_file"     >> $trid_output
      echo "                        " >> $trid_output
}





function f_array_0 {
   # Criar um Array Associativo (semelhante a um dicionario em python com pares de key + value)

   # Como na versão atual de Bash não da para exportar arrays, será usado um metodo mais arcaico
   echo "Este ficheiro é:"
   echo "> $trid_script"  # Esta variavel foi criada e exportada em 'source-all-drya-files'
   echo 
   echo "Elemento [0] do array arcaico:"
   echo " > Cujo 'Key' + 'Pair' estao separados por '::'"
   echo " >> $trid_0"   # esta variavel foi criada e exportada em 'source-all-drya-file'
   echo 
}
   
function f_trid_3 {
   # Detetar se estamos a operar o Termux
   # Será guardado como: trid_3; trid_termux; trid_atTermux

   # No termux a variavel $PREFIX nao vem vazia e tras normalmente o conteudo: "/data/data/com.termux/files/usr"

   if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
      # Debug # Estamos no termux

      trid_termux="true"   # Legacy, sshfs-wrapper uses it yet
      trid_atTermux="true"      
      trid_3="atTermux::true" # Key + Value pair
      export trid_termux trid_atTermux trid_3

      # Depois de verificado, enviar para o ficheiro pesquisavel
      echo 'trid_termux="true"'   >> $trid_output
      echo 'trid_atTermux="true"' >> $trid_output      
      echo 'trid_3="true"'        >> $trid_output
      echo                        >> $trid_output

   else
      # Debug # Nao estamos no termux

      trid_termux="false"   # Legacy, sshfs-wrapper uses it yet
      trid_atTermux="false"      
      trid_3="atTermux=false"
      export trid_termux trid_atTermux trid_3

      # Depois de verificado, enviar para o ficheiro pesquisavel
      echo 'trid_termux="false"'  >> $trid_output
      echo 'trid_atTermux="false"' >> $trid_output      
      echo 'trid_3="false"'       >> $trid_output
      echo                          >> $trid_output
   fi

}

function f_export {
   # Apos ser detetada a familia Linux Correta, esta fx exporta as variaveis para o Env

   # Copiar a variavel encontrada para cada uma das Var que pretendemos
      trid_pkgm=$v_found
      trid_4=$v_found
      pkgm=$v_found

   # Exportar todas as Var para o Env (É possivel ler o Env com o comando `printenv`)
      export trid_pkgm
      export trid_4
      export pkgm

}
   
function f_array_3 {
   # Verificar o package manager atual (pkg, apt, brew, pacman)
   # Será exportada a variavel: trid_pkgm; pkgm; trid_4

   if [ -f /etc/os-release ]; then
      source /etc/os-release

      if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] || [ $ID = "raspbian" ]; then
         # Encontrada a familia Debian

         v_found="apt"
         f_export

      elif [ "$ID" = "arch" ] || [ "$ID" = "manjaro" ]; then
         # Encontrada a familia Arch

         v_found="pacman"
         f_export

      elif command -v dnf >/dev/null 2>&1; then
         # Encontrada a familia Red Hat

         v_found="dnf"
         f_export

      else
         v_found="nil"
         echo "DRYa: traitsID: Package Manager Linux desconhecido"
      fi

   elif [ -d "$PREFIX" ]; then
      # Encontrado o Termux (Android)

      v_found="pkg"
      f_export

   elif [ "$(uname)" == "Darwin" ]; then
      # Encontrado o macOS

      v_found="brew"
      f_export

   else
       v_found="nil"
       echo "DRYa: traitsID: Package Manager desconhecido"
   fi
}


function f_detectOS_2 {
         clear
	f_c3; echo Detect OS
	f_rc; echo "whoami: 	$(whoami)"
         echo "OS type: 	${OSTYPE}"
         echo "uname:		$(uname)"
         echo "uname -a: 	$(uname -a)"
         read
}







function f_detect_OS {
   # Detect Operative System
   
   #echo Detect
   #cat $trid_output
   #read

   # Using command 'uname'
      v_uname=$(uname -a)

   # Filter the info to Detect OS
   # SIGLA for $v_arr1: 'trid=A'? (A)ndroid (W)indows (L)inux (R)aspberry (U)nknown

   if [[ $v_uname =~ "Android" ]]; then 
      echo "DRYa: Running on: Android"
      echo 'trid_OS="Android"' >> $trid_output 

      trid_OS="Android"; export trid_OS
      v_arr1=A
      
   elif  [[ $v_uname =~ "Microsoft" ]]; then 
      echo "DRYa: Running on: Windows"
      echo 'trid_OS="Windows"' >> $trid_output

      trid_OS="Microsoft"; export trid_OS
      v_arr1=W

      # uDev: Verificar se o sistema está no WSL2

   elif [[ $v_uname =~ "raspberrypi" ]]; then 
      # Linux has to be the last one, because it means Windows and Android are not present
      echo "DRYa: Running on: Linux (Raspberry Pi)"
      echo 'trid_OS="Linux-Rasp"' >> $trid_output

      trid_OS="RaspberryPi"; export trid_OS
      v_arr1=R

   elif [[ $v_uname =~ "Linux" ]]; then 
      # Linux has to be the last one, because it means Windows and Android are not present
      echo "DRYa: Running on: Linux"
      echo 'trid_OS="Linux"' >> $trid_output

      trid_OS="Linux"; export trid_OS
      v_arr1=L

   else
      echo "DRYa: Running on: NOT DETECTED"
      trid_OS="NotDetected"; export trid_OS
      v_arr1=U
   fi 

   # Display a way to reach the info
      echo "      > view traitsID with: 'trid' "


   # Create a single string with all info (as a code):
      declare -a v_trid=(
         [0]="trid="
         [1]=$v_arr1
      )
      echo "${v_trid[0]}${v_trid[1]}" >> $trid_output


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
   source $trid_output

}

function f_gitconfig_current_machine_name {
   # Deteta qual é o nome usado pelo `git` e que coloca nos `git commits`
   # --- Se encontrar o nome standard 'seivadarve', pede para configurar/instalar o nome correto

   v_user=$(git config --get user.name)
   [[ $v_user == "seivaDArve" ]] && echo 'DRYa: task pendent: `D dot install git` to fix standard machine name' >> $v_MSGS
   
   trid_git_machine_name=$v_user

   export trid_git_machine_name

   # Send one empty line to the file
      echo "" >> $trid_output

   echo "trid_git_machine_name=\"$trid_git_machine_name\"" >> $trid_output
   echo "trid_gmn=\"$trid_git_machine_name\"" >> $trid_output
   
   
   
}

function f_detect_package_manager {
   # Deteta qual é o package manager do OS e coloca numa variavel 'v_pkg'

   if command -v apt &>/dev/null; then
      echo "apt" 

   elif command -v dnf &>/dev/null; then
      echo "dnf"

   elif command -v yum &>/dev/null; then
      echo "yum"

   elif command -v pacman &>/dev/null; then
      echo "pacman"

   elif command -v zypper &>/dev/null; then
      echo "zypper"

   elif command -v apk &>/dev/null; then
      echo "apk"

   # uDev: falta `pkg` do termux

   else
      echo "unknown"

   fi
} 

function f_trid_print_all {

   echo "trid: (uDev) Print a list of all vars like neofetch"
   cat $trid_output
}







function f_fetch {
   f_set_vars_source_script_output
   f_array_0   1>/dev/null  # O output será envido para o crl... porque serve so para debug
   f_trid_3                 # Saber true|false se estamos a operar no Termux
   f_array_3   1>/dev/null  # O output será envido para o crl... porque serve so para debug
   f_export
   f_gitconfig_current_machine_name

   f_detect_OS
   #f_detectOS_2
   #f_detect_OS_verbose
}



# uDev: `export` provavelmente nao e preciso.

if [ -z $1 ];then
   echo "uDev: fzf menu"

elif [ $1 == "h" ]; then
   # uDev: This file is re-loaded every terminal startup and all variables are reloaded. So, another file is also needed where variables no not chang for the actuall machine. so, traitsID_rc should also be there (like .dryarc) The file .dryarc may even be a better option
   echo "DRYa: traitsID: Main Script Location:"
   echo " > $trid_script"
   echo 
   echo "DRYa: traitsID: Output file Location:"
   echo " > $trid_output"
   echo 

elif [ $1 == "." ]; then
   vim $trid_script

elif [ $1 == ".." ]; then
   vim $trid_output

elif [ $1 == "fetch" ] || [ $1 == "f" ]; then
   # Start a new search of all variables and store them in a file
   f_fetch

elif [ $1 == "printenv" ] || [ $1 == "env" ]; then
   printenv | grep --color="auto" "trid"

elif [ $1 == "print" ] || [ $1 == "A" ]; then
   # Print all variables

   if [ -z $2 ]; then
      f_trid_print_all

   elif [ $2 == "greet" ] || [ $2 == "gr" ]; then
      figlet traitsID
      f_trid_print_all
   fi
fi
