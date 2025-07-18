#!/bin/bash
# Title: TraitsID (Getting info about the machine)
# Description: faz uso do kernel para identificar variaveis que permiam ao script DRYa de tornar Cross-Platform. Assim, será possivel ao utilizador usar os mesmos softwares independentemente se esta no Android, Linux, WSL2 no Windows, Windows, etc.
#              No final do ficheiro também estara um catalogo de todas as variaveis
#              As variaveis que vao ser encontradas vao ser colocadas em 4 sitios: Uma Array; Exportadas para o Env; Concatenadas num ficheiro de configs; No final deste documento de texto num mini catalogo de variaveis

# uDev: Create a script at DRYa/all/bin/ for drya-neofetch
   # uDev: Create the same for Device: Samsung, TLC, Lenovo, Azus (drya will need a .config for this, and needs the user to answer a script)
   # uDev: Detecte personal/safe device from job/public/unsafe device
   # uDev: Create the same for package manager: apt, pacman, dnf, pkg
   # uDev: Create the same for processor: ARM, 64 Bits, 32 Bits (Raspberry pi?)
   # uDev: Create a binary for each combination: 00101: pacman, lenovo, windows, userX
   # uDev: Create environment variables: drya-env-os; drya-env-me (for command whoami); etc
   # uDev: Detect wifi not connected networks due to lack of passaword and chech our list of wifi passwords to see if we can log on it
   # uDev: Versao do Linux (para config do teclado)
      #which yum >/dev/null && { echo Fedora flavour; exit 0; }
      #which zypper >/dev/null && { echo Suse of sorts; exit 0; }
      #which apt-get >/dev/null && { echo Debian based;  }


# uDev: Send all this to a file: .../DRYa/all/bin/init-bin/traitsID.sh
# uDev: Detetar WM (window manager, se estar a usar GNOME, KDE...
# uDev: Se o dispositivo nao for reconhecido, mostrar outro comportamento, por exemplo, nao mostrar que Jarve e DRYa existe no dispositivo
# uDev: set raspberry pi Screen Resolution (when using "Silver" TV) for: 1360x768
# uDev: Set windows time and date automaticaly with batch scripts
# uDev: Porque nao usar tambem sqlite3 (base de dados) para guardar as variaveis?
# uDev: Detect $SHELL
# uDev: Detect wifi network name (add a loop, to oeriodically check the name)
# uDev: Crir editor de texto predefinido
# uDev: Detetar qual o numero da shell ou sub shell em que estamos (por exemplo `bash bash` que entra em uma sub shell)

#udev: v_hostname=$(hostname); echo "Hostname is: $v_hostname"
#udev: v_whoami=$(whoami); echo "whoami is: $v_whoami"

# Sourcing file with colors 
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="traitsID"
   v_talk="trid: "


function f_trid_0_1_2 {
   # f_set_vars_source_script_output
   # File that has a copy of all variables sent to environment



   # Nome do ficheiro SOURCE (este mesmo ficheiro, que mantem alias 'trid' do script 'traitsID.sh')
      # (Definido em source-all-drya-files)

   # Nome do ficheiro SCRIPT traitsID.sh
      # (Definido em source-all-drya-files)

   # Nome do ficheiro OUTPUT traitsID.sh
      # (Definido em source-all-drya-files)



   # Recriar o ficheiro OUTPUT (Sempre que o terminal inicia). variaveis iniciadas em $trid_source
      [[ -f    $trid_dir ]] && rm $trid_dir  # Se existir um ficheiro com o mesmo nome que o dir que tentamos criar, dir nao sera criado antes desse ficheiro ser removido
      mkdir -p $trid_dir
      rm       $trid_output 2>/dev/null
      touch    $trid_output

   function f_verbose_output_0 {
      # Info inicial do ficheiro
         echo "# Title: traitsID output"
         echo "# Description: File that gather most important system variables for DRYa" 
         echo "# Note: The info in this file is gathered at terminal startup. May change during the session"
         echo  

      # Guardar em "trid_output" todas as var
         echo "trid_0=$trid_0           "           
         echo "trid_source=$trid_source " 
         echo "                         " 
         echo "trid_1=$trid_1           "           
         echo "trid_script=$trid_script " 
         echo "                         " 
         echo "trid_2=$trid_2           "           
         echo "trid_dir=$trid_dir       "       
         echo "trid_file=$trid_file     "     
         echo "trid_output=$trid_output " 
         echo "                         " 
   } >> $trid_output

   f_verbose_output_0 
}

function f_trid_3 {
   # f_gitconfig_current_machine_name
   # Deteta qual é o nome usado pelo `git` e que coloca nos `git commits`
   # --- Se encontrar o nome standard 'seivadarve', pede para configurar/instalar o nome correto

   trid_git_machine_name=$(git config --get user.name)
   trid_gmn=$trid_git_machine_name

   echo "trid_3=\"trid_git_machine_name::$trid_gmn\" "  >> $trid_output
   echo "trid_git_machine_name=\"$trid_gmn\"         "  >> $trid_output
   echo "trid_gmn=\"$trid_gmn\"                      "  >> $trid_output
   echo "                                            "  >> $trid_output
}

function f_trid_4 {
   # Verificar o package manager atual (pkg, apt, brew, pacman)

   if [ -f /etc/os-release ]; then
      source /etc/os-release

      if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] || [ $ID = "raspbian" ]; then
         # Encontrada a familia Debian
         trid_pkgm="apt"

      elif [ "$ID" = "arch" ] || [ "$ID" = "manjaro" ]; then
         # Encontrada a familia Arch
         trid_pkgm="pacman"

      elif [ $ID == "fedora" ] || command -v yum >/dev/null 2>&1; then
         # Encontrada a familia Red Hat
         trid_pkgm="dnf"

      elif command -v zypper &>/dev/null; then
         # Familias Open Suse
         echo "zypper"

      elif command -v apk &>/dev/null; then
         # Familias Alpine Linux
         echo "apk"

      else
         # Familia nao encontrada
         trid_pkgm="Not-Detected"
      fi

   elif [ -d "$PREFIX" ]; then
      # Encontrado o Termux (Android)
      trid_pkgm="pkg"

   elif [ "$(uname)" == "Darwin" ]; then
      # Encontrado o macOS
      trid_pkgm="brew"

   else
      # Familia nao encontrada
      trid_pkgm="Not-Detected"
   fi




   # Exportar todas as Var para $trid_output
      echo "trid_4=\"trid_pkgm::$trid_pkgm\"" >> $trid_output
      echo "trid_pkgm=$trid_pkgm"             >> $trid_output
      echo "pkgm=$trid_pkgm"                  >> $trid_output
      echo                                    >> $trid_output
}

function f_trid_5 {
   # Detetar se estamos a operar o Termux
   # Será guardado como: trid_5; trid_termux; trid_atTermux

   # No termux a variavel $PREFIX nao vem vazia e tras normalmente o conteudo: "/data/data/com.termux/files/usr"

   if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
      # Estamos no termux

      trid_termux="true"   # Legacy, sshfs-wrapper uses it yet
      trid_atTermux="true"      

   else
      # Nao estamos no termux

      trid_termux="false"   # Legacy, sshfs-wrapper uses it yet
      trid_atTermux="false"      

   fi

   # Depois de verificado, enviar para o ficheiro pesquisavel
      echo "trid_5=\"trid_atTermux::$trid_atTermux\"" >> $trid_output
      echo "trid_atTermux=$trid_termux"               >> $trid_output      
      echo "trid_termux=$trid_termux"                 >> $trid_output
      echo                                            >> $trid_output

}

function f_trid_6 {
   # f_detect_OS
   # Detect Operative System
   
   #echo Detect
   #cat $trid_output
   #read

   # Using command 'uname'
      v_uname=$(uname -a)

   # Filter the info to Detect OS
   # SIGLA for $trid_os 'A': (A)ndroid (W)indows (L)inux (R)aspberry (U)nknown

   if [[ $v_uname =~ "Android" ]]; then 
      # Detetar se é Android
      trid_OS="Android"
      trid_os=A
      
   elif  [[ $v_uname =~ "microsoft" ]]; then 
      # Detetar se é Windows
      # uDev: Verificar se o sistema está no WSL2
      trid_OS="Linux-Microsoft"
      trid_os=W

   elif [[ $v_uname =~ "raspberrypi" ]]; then 
      # Linux has to be the last one, because it means Windows and Android are not present
      trid_OS="RaspberryPi"
      trid_os=R

   elif [[ $v_uname =~ "Linux" ]]; then 
      # Linux has to be the last one, because it means Windows and Android are not present
      trid_OS="Linux"
      trid_os=L

   else
      # Se nao for detetado nenhum dos anteriores, entao é desconhecido
      trid_OS="NotDetected"
      trid_os=U

   fi 

   # Send out results
      echo "trid_6=\"trid_OS::$trid_OS\"" >> $trid_output 
      echo "trid_OS=\"$trid_OS\""         >> $trid_output 
      echo "trid_os=$trid_os"             >> $trid_output
      echo                                >> $trid_output
}

function f_trid_7 {
   # Definir ficheiro onde guardar o nome do editor de texto a usar. Mencionar o seu nome e caminho
   # Nota: tem de funcionar em sintonia com a fx `E` em "fluNav" e `e` em .../DRYa/bin/e

   # Nome do ficheiro 
      trid_editor_file=$trid_dir/trid_editor  # variavel 'trid_dir' configurado em source-all-drya-files
   
   # Se o ficheiro que menciona qual o editor de texto pre-definido nao existir, entao, cria um
      if [ -f $trid_editor_file ]; then
         echo "Debug: O ficheiro que menciona o editor de texto: existe"  1>/dev/null
         trid_editor_name=$(cat $trid_editor_file)

      else
         echo "Debug: O ficheiro que menciona o editor de texto: nao existe"  1>/dev/null
         echo "vim" > $trid_editor_file  # Criar ficheiro, ao mesmo tempo, inserir o texto "vim" nesse ficheiro
      fi

   # Send out results
      echo "trid_7=\"trid_editor_file::$trid_editor_file\"" >> $trid_output 
      echo "trid_editor_file=\"$trid_editor_file\""         >> $trid_output 
      echo                                                  >> $trid_output
}


function f_trid_8 {
   # Definir ficheiro onde guardar o nome do editor de texto a usar. Mencionar o seu nome e caminho
   # Nota: tem de funcionar em sintonia com a fx `E` em "fluNav" e `e` em .../DRYa/bin/e

   # Nome do ficheiro 
      trid_editor_name=$(cat $trid_editor_file) 2>/dev/null
   
   function f_verbose_output_8 {
      # Send out results
         echo 'trid_8="trid_editor_name=$(cat $trid_editor_file)"           '
         echo 'trid_editor_name="trid_editor_name=$(cat $trid_editor_file)" '     
         echo "# At terminal Startup: \$trid_editor_name=$trid_editor_name  "     
         echo "# Script that wraps any editor: \`e example.txt\` = \`$trid_editor_name example.txt\`" 
         echo                                                 
   } >> $trid_output

   f_verbose_output_8 
}






















function f_trid_print_all {

   echo "trid: (uDev) Print a list of all vars like neofetch"
   cat $trid_output
}

function f_detectOS_2 {
	trid_user=$(whoami)

   # Nome da maquina dentro da rede atual
      trid_node=$(uname -n) 

   # Se a Shell for Bash, é possive fazer uso da Var `OSTYPE` que vem no env
      trid_OS_type="OS type:  ${OSTYPE}"
      case "$OSTYPE" in
         linux-gnu*)   echo "Linux";;
         darwin*)      echo "macOS";;
         cygwin*)      echo "Cygwin on Windows";;
         msys*)        echo "Git Bash (MSYS)";;
         freebsd*)     echo "FreeBSD";;
         *)            echo "Desconhecido";;
      esac

   # 
      echo "uname:    $(uname)"
      echo "uname -a: $(uname -a)"
      read
}

function f_actions {
   [[ $trid_gmn == "seivaDArve" ]] && echo 'DRYa: task pendent: `D dot install git` to fix standard machine name' >> $v_MSGS
}

function f_startup {

   # Var de espacamento
      e="     "

   v_ed=$(cat $trid_editor_file)
   trid_gmn=$(git config --get user.name)

   function f_coloring_variable_git_name__normal {
      echo "$e Git name    : $trid_gmn"
   }

   function f_coloring_variable_git_name__red {
            echo -n "$e Git name    : "
      f_c8; echo                     "$trid_gmn"
      f_rc
   }

   f_talk; echo    "Running on  : $trid_OS"
          #echo "$e Git name    : $trid_gmn"
           [[ $trid_gmn == "seivaDArve" ]] && f_coloring_variable_git_name__red || f_coloring_variable_git_name__normal 
           echo "$e Text editor : $v_ed"
}

function f_printenv {
   f_talk; echo "Printing env variables:"

   printenv | grep --color="auto" "trid"
   v_count=$(printenv | grep "trid" | wc -l)

           echo
   f_talk; echo "Total de linhas encontradas: $v_count"
}

function f_neofetch {
   # Same as neofetch

   clear

   # Var de espacamento
      e="     "

   trid_gmn=$(git config --get user.name)
   v_ed=$(cat $trid_editor_file)

   f_talk; echo    "Running on      : $trid_OS"
           echo "$e Git name        : $trid_gmn"
           echo "$e Editor texto    : $v_ed"
           echo "$e Package manager : $pkgm"
           echo

   # Apresentar apenas o icon ASCII do `neofetch`
      neofetch -L 2>/dev/null
}

function f_help {
   # Como na versão atual de Bash não da para exportar arrays, será usado um metodo mais arcaico
   echo "Este ficheiro é:"
   echo "> \$trid_script"  # Esta variavel foi criada e exportada em 'source-all-drya-files'
   echo 
   echo "Elemento [0] do array arcaico:"
   echo " > Cujo 'Key' + 'Pair' estao separados por '::'"
   echo " >> \$trid_0"   # esta variavel foi criada e exportada em 'source-all-drya-file'
   echo 
   echo "DRYa: traitsID: Source Location:"
   echo " > $trid_source"
   echo 
   echo "DRYa: traitsID: Main Script Location:"
   echo " > $trid_script"
   echo 
   echo "DRYa: traitsID: Output file Location:"
   echo " > $trid_output"
   echo 
}

function f_fetch {
   #echo " === Debug === $trid_output"; read
   f_trid_0_1_2   # Procurar "source","script", "output"
   f_trid_3       # Procurar "git name"
   f_trid_4       # Procurar "Package Manager"
   f_trid_5       # Procurar "Termux"
   f_trid_6       # Procurar "OS"
   f_trid_7       # Definir ficheiro para guardar o nome do editor de texto pre-definido
   f_trid_8       # Procurar dentro do ficheor "editor de texto" qual o nome do editor a usar
   #f_detectOS_2

   f_actions 
}





# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------





if [ -z $1 ];then
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Saving '; Lz2='trid'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L2='2. h'                                      
      L1='1. Cancel'

      Lh=""
      L0="traitsID: SELECT 1: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --pointer=">" --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[ $v_list =~ $Lz3  ]] && echo "Acede ao historico com \`D ..\`"
      [[ $v_list =~ "2. " ]] && f_help
      [[ $v_list =~ "1. " ]] && echo "Canceled" 
      unset v_list

elif [ $1 == "h" ]; then
   # uDev: This file is re-loaded every terminal startup and all variables are reloaded. So, another file is also needed where variables no not chang for the actuall machine. so, traitsID_rc should also be there (like .dryarc) The file .dryarc may even be a better option
   f_help

elif [ $1 == "." ]; then
   vim $trid_script

elif [ $1 == "o" ]; then
   less $trid_output

elif [ $1 == "fetch" ] || [ $1 == "f" ]; then
   # Start a new search of all variables and store them in a file
   f_fetch

elif [ $1 == "startup-message" ] || [ $1 == "s" ]; then
   f_startup

elif [ $1 == "neofetch" ] || [ $1 == "S" ]; then
   f_neofetch

elif [ $1 == "printenv" ] || [ $1 == "env" ] || [ $1 == "e" ]; then

   function f_printenv_recursive {
      # se houver mais args para alem de `e` em $1, entao vai buscar cada um ao `printenv` com `grep`

      # Copiar todos os arg para uma variavel
         var="$@"

      # Transforma a string em um array
         arr=($var)

      # Remove o primeiro elemento (simulando shift)
         arr=("${arr[@]:1}")

      # Ver resultado
         echo "${arr[@]}"
   }

   f_printenv

elif [ $1 == "editor" ] || [ $1 == "E" ]; then
  f_trid_7 

elif [ $1 == "print" ] || [ $1 == "p" ]; then
   # Print all variables

   if [ -z $2 ]; then
      f_trid_print_all

   elif [ $2 == "greet" ] || [ $2 == "g" ]; then
      figlet traitsID
      f_trid_print_all

   elif [ $2 == "nice" ] || [ $2 == "n" ]; then
      # Do not simply dump all vars, nstead, print them in a nice order

      # Declaring a variable with blank spaces
         B="     "

      f_talk
       
      # Verbose $trid_source 
         v=$(basename $(echo $trid_source)) && echo "trid_source : .../$v"

      # Verbose $trid_script 
         v=$(basename $(echo $trid_script)) && echo "$B trid_script : .../$v"

      # Verbose $trid_output 
         v=$(basename $(echo $trid_output)) && echo "$B trid_output : .../$v"

      # Verbose $trid_termux 
         echo "$B trid_termux : $trid_termux"

      # Verbose $trid_gmn 
        echo "$B trid_gmn    : $trid_gmn"

      # Verbose $trid_OS]
        echo "$B trid_OS     : $trid_OS"
   fi
fi
