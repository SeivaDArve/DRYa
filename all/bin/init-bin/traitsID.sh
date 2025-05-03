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

function f_set_file {
   # File that has a copy of all variables sent to environment

   # Giving it a name
      v_dir=~/.config/h.h/drya
      v_file="traitsID"
      v_id_file="$v_dir/$v_file"

   # Create the file from scratch at every terminal startup
      mkdir -p $v_dir
      rm       $v_id_file 2>/dev/null
      touch    $v_id_file
}

function trid {
   # This command is actually loaded to the terminal env

   if [ -z $1 ]; then
      # uDev: This file is re-loaded every terminal startup and all variables are reloaded. So, another file is also needed where variables no not chang for the actuall machine. so, traitsID_rc should also be there (like .dryarc) The file .dryarc may even be a better option
      echo "File re-loaded every startup"
      echo 
      
      # From the file created by traitsID, print at the terminal to help copy/paste
         cat $v_id_file | fzf

      #echo "File that overwrittes last file"
      #less .dryarc

   elif [ $1 == "." ]; then
      vim ${v_REPOS_CENTER}/DRYa/all/bin/init-bin/traitsID.sh

   fi
}




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
   
function f_trid_001 {
   # Detetar se estamos a operar o Termux
   # Será guardado como: trid_001; traits_termux; trid_at_termux

   # No termux a variavel $PREFIX nao vem vazia e tras normalmente o conteudo: "/data/data/com.termux/files/usr"

   if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
      # Debug # Estamos no termux

      traits_termux="true"   # Legacy, sshfs-wrapper uses it yet
      trid_at_termux="true"      
      trid_001="atTermux::true" # Key + Value pair
      export traits_termux trid_at_termux trid_001

      # Depois de verificado, enviar para o ficheiro pesquisavel
      echo 'traits_termux="true"'   >> $v_id_file
      echo 'trid_at_Termux="true"'  >> $v_id_file      
      echo 'trid_001="true"'        >> $v_id_file
      echo                          >> $v_id_file

   else
      # Debug # Nao estamos no termux

      traits_termux="false"   # Legacy, sshfs-wrapper uses it yet
      trid_at_termux="false"      
      trid_001="atTermux=false"
      export traits_termux trid_at_termux trid_001

      # Depois de verificado, enviar para o ficheiro pesquisavel
      echo 'traits_termux="false"'  >> $v_id_file
      echo 'trid_at_termux="false"' >> $v_id_file      
      echo 'trid_001="false"'       >> $v_id_file
      echo                          >> $v_id_file
   fi

}

function f_export {
   # Apos ser detetada a familia Linux Correta, esta fx exporta as variaveis para o Env

   # Copiar a variavel encontrada para cada uma das Var que pretendemos
      traits_pkgm=$v_found
      traits_2=$v_found
      pkgm=$v_found

   # Exportar todas as Var para o Env (É possivel ler o Env com o comando `printenv`)
      export traits_pkgm
      export traits_2
      export pkgm

}
   
function f_array_2 {
   # Verificar o package manager atual (pkg, apt, brew, pacman)
   # Será exportada a variavel: traits_pkgm; pkgm; traits_2

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







function f_detectOS_1 {
   # Detect OS

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
      echo "      > view traitsID with: 'trid' "


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

}

function f_gitconfig_current_machine_name {
   # Deteta qual é o nome usado pelo `git` e que coloca nos `git commits`
   # --- Se encontrar o nome standard 'seivadarve', pede para configurar/instalar o nome correto

   v_user=$(git config --get user.name)
   [[ $v_user == "seivaDArve" ]] && echo 'DRYa: task pendent: `D dot install git` to fix standard machine name' >> $v_MSGS
   
   traits_git_machine_name=$v_user

   export traits_git_machine_name

   # Send one empty line to the file
      echo "" >> $v_id_file

   echo "traits_git_machine_name=\"$traits_git_machine_name\"" >> $v_id_file
   
   
   
}



function f_exec {
f_set_file
f_array_0   1>/dev/null  # O output será envido para o crl... porque serve so para debug
f_trid_001               # Saber true|false se estamos a operar no Termux
f_array_2   1>/dev/null  # O output será envido para o crl... porque serve so para debug
f_export
f_gitconfig_current_machine_name

f_detectOS_1
#f_detectOS_2

}
f_exec




      

