#!/bin/bash
# Title: DRYa: sshfs-wrapper

# Sourcing library with: Colors, f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
      v_greet=DRYa-SSH
      v_talk="DRYa: ssh: "
      #v_txt="<text-used-at-f_prsK-fx>"

      # Usar f_c3 para SERVIDOR
      # Usar f_c4 para CLIENTE


# Para Debug:
   # Este script nao reconhecia os arg $1 $2 $3 porque este script era chamado apartir de outro script (nomeadamente 'drya.sh'). Portanto, no script inicial, as variaveis $1, $2, $3 foram exportadas como ARG1, ARG2, ARG3
   #echo $0, $ARG1, $ARG2, $ARG3...
   #read

function f_declare_variables {
   # Se nao existir $USER no env, entao usar o comando `whoami` para o redefinir
      [[ -z $USER ]] && USER=$(whoami) && export USER
      v_current_username=$USER

      #v_debug=$v_current_username; f_debug

   # Definir neste array, qual o conjunto de diretorios que queremos como pre-definidas para os nossos 'mounting point'
      v_parent_dir=~/sshfs

 
   # Variaveis que guardam a localização da chave publica SSH
      v_public_key=~/.ssh/id_rsa.pub

      v_verbose_line_repo=${v_REPOS_CENTER}/verbose-lines
      v_verbose_line_file=$v_verbose_line_repo/all/ssh.txt

      v_temporary_file=~/.config/h.h/drya/ssh-tmp-file.txt  # Para quem nao tem a repo 'verbose-lines' é usada a alternativa deste ficheiro temporario que guarda o ultimo 'set-up' de cliente ou servidor 
      
   # Arrays de Maquina local + Maquina Remota
      # Par de arrays. o Index 1 de um array (array A) corresponde ao Index 1 do outro array (array B)
         v_array_A_remote_dir=("remote-sv-Rasp-miau" "remote-sv-Lenovo-Dv" "remote-sv-MSI-dv_msi" "remote-sv-ASUS-indratena" "remote-sv-A6-termux-Dv" "remote-sv-public-device-id-35780065215")
         v_array_B_this_machine=("local-Raspberry-Miau" "local-Lenovo-Dv" "local-MSI-dv_msi" "local-ASUS-indratena" "local-A6-termux-Dv" "local-public-device-id-35780065215")

      # Ao longo do script, pode ser necessario usar `fzf` para detetar uma das opcoes contidas no array
         #v_list=$(for i in ${v_array_A_remote_dir[@]}; do echo $i; done | fzf --prompt "INDIQUE a que maquina remota se quer ligar")
         #v_list=$(for i in ${v_array_B_this_machine[@]}; do echo $i; done | fzf --prompt "INDIQUE qual o nome desta maquina local")

      # uDev: find a solution on traitsID to identify public devices like WORK phones

      # Print the entire array
         #echo "Array elements: ${v_array_A_remote_dir[@]}"
}

function f_corresponder_local_com_remota {

   unset $v_current_local
   contador=0
   L0="QUAL o nome desta maquina SERVIDOR (para facilitar no aparelho do CLIENTE): "

   v_current_local=$(for i in ${v_array_B_this_machine[@]}; do 
                        echo "$contador. $i"; 
                        ((contador++)); 
                     done  | fzf --prompt "$L0")
   
   echo "Maquina atual: $v_current_local"
   echo

   
   [[ $v_current_local =~ "0." ]] && v_local=${v_array_A_remote_dir[0]} && echo "Info a dar ao clinte: $v_local"
   [[ $v_current_local =~ "1." ]] && v_local=${v_array_A_remote_dir[1]} && echo "Info a dar ao clinte: $v_local" 
   [[ $v_current_local =~ "2." ]] && v_local=${v_array_A_remote_dir[2]} && echo "Info a dar ao clinte: $v_local" 
   [[ $v_current_local =~ "3." ]] && v_local=${v_array_A_remote_dir[3]} && echo "Info a dar ao clinte: $v_local" 
   [[ $v_current_local =~ "4." ]] && v_local=${v_array_A_remote_dir[4]} && echo "Info a dar ao clinte: $v_local" 
   [[ $v_current_local =~ "5." ]] && v_local=${v_array_A_remote_dir[5]} && echo "Info a dar ao clinte: $v_local" 
   [[ $v_current_local =~ "6." ]] && v_local=${v_array_A_remote_dir[6]} && echo "Info a dar ao clinte: $v_local" 

   echo
   v_dir_to_mount=$v_parent_dir/$v_local/
   #echo "Ou seja: $v_dir_to_mount"
   mkdir -p $v_dir_to_mount
   f_prsK
}

function f_check_current_user {
   # Get the current username
         echo -n " > Username: "
   f_c1; echo    "$v_current_username"
   f_rc
}

function f_is_rooted {
   # Verificar se estamos no termux. Se estivermos no termux, sera verificado se temos permissoes root

   # No termux, a variavel $PREFIX nao vem vazia. Costuma conter "/data/data/com.termux/files/usr"
      if  [ $traits_termux == "true" ]; then 
   
         # Verificar se o comando 'su' está disponível
            if command -v su > /dev/null 2>&1; then
                #echo "O comando 'su' está disponível. Verificando permissões de root..."

                # Tentar obter permissões de root
                if su -c "echo 'Permissões de root verificadas com sucesso'" > /dev/null 2>&1; then
                    #echo "Você tem permissões de root."
                    v_rooted="true"
                else
                    #echo "Você não tem permissões de root ou não foi possível obter acesso root."
                    v_rooted="false"
                fi
            else
               #echo "O comando 'su' não está disponível. Você não tem permissões de root."
               v_rooted="false"
            fi
      fi

}

function f_is_rooted_verbose {
   # Depois de verificado que sim que estamos no termux e verificado se temos root, agora verbalizamos

   if [[ -z $v_rooted ]]; then
            echo -n " > Esta no termux: "
      f_c8; echo    "Nao!"
      f_rc

   elif [[ $v_rooted == "true" ]]; then
            echo -n " > Tem permissoes root: "
      f_c7; echo    "Sim"
      f_rc

   elif [[ $v_rooted == "false" ]]; then
            echo -n " > Tem permissoes root: "
      f_c8; echo    "Nao"
      f_rc
   fi
}

function f_menu_para_ver_resumo {
      # Apos decidir todas as configurações para ser Servidor, apresentar um menu para ler tudo o que foi definido
         echo "Press [ENTER] para opções"; read -s
         while true
         do
            v_menu=$(echo -e "1. Ver com \`less\` o ficheiro verboso (na repo Verbose-lines) \n2. Ver com \`less\` o ficheiro da chave publica) \n3. Sair" | fzf --prompt "SELECIONE ")

            [[ $v_menu =~ "1." ]] && less $v_verbose_line_file   && break
            [[ $v_menu =~ "2." ]] && less $v_temporary_file && break
            [[ $v_menu =~ "3." ]] && break
            unset v_menu
         done
}

function f_install_ssh_key {
   echo "Criar uma chave SSH publica e uma privada:"
   ssh-keygen -t rsa
}

#  function f_install_ssh {
#     # Installing ssh
#     # "$traits_pkgm"  # Variavel que carrega a info do package manager atual. Detetado pela DRYa
#  
#  
#     if [ -n "$TERMUX_VERSION" ]; then
#        #echo "Este terminal é o Termux. Versão: $TERMUX_VERSION"
#        pkg install openssh-clients
#        pkg install openssh-server
#     else
#        #echo "Este terminal não é o Termux."
#  
#        # Se nao estivermos no Termux, perguntar qual é o package manager no dispositivo atual
#           echo "Qual é o package manager da maquina atual? (pkg, apt, dnf, ...)"
#           echo " > Se deixar em branco, será usado: apt"
#           read -p " > " v_across
#  
#        if [ -z $v_across ]; then
#           # Se o utilizador deixar em vazio, instala com o mais comum (apt)
#           echo "Installing with 'apt'..."
#           sudo apt install openssh-clients
#           sudo apt install openssh-server
#        else 
#           sudo $v_across install ssh
#           sudo $across install openssh-server
#           sudo $across install openssh-server
#        fi
#     fi
#  
#  }

function f_install_ssh {
   # Overwrite a fx anterior

   if [ -n "$TERMUX_VERSION" ]; then
      # termux detetado, o comando não precisa de sudo
         pkg install openssh-clients
         pkg install openssh-server

   else
      # Usar traitsID para detetar o package manager na variavel $traits_pkgm e aplicar
         eval "sudo $traits_pkgm install openssh-clients"
         eval "sudo $traits_pkgm install openssh-server"
   fi
  
}

function f_install_sshfs {
   # Installing sshfs


   if [ -n "$TERMUX_VERSION" ]; then
      #echo "Este terminal é o Termux. Versão: $TERMUX_VERSION"
      pkg install sshfs
   else
      #echo "Este terminal não é o Termux."

      # Se nao estivermos no Termux, perguntar qual é o package manager no dispositivo atual
         echo "Qual é o package manager da maquina atual? (pkg, apt, dnf, ...)"
         echo " > Se deixar em branco, será usado: apt"
         read -p " > " v_across

      if [ -z $v_across ]; then
         echo "Installing with 'apt'..."
         sudo apt install sshfs
      else 
         sudo $v_across install sshfs
      fi
   fi

   # Se o utilizador deixar em vazio, instala com o mais comum (apt)
}

function f_uninstall_sshfs {
   # Installing sshfs

   echo "Uninstalling with 'apt'..."
   sudo apt remove sshfs
}

function f_concat_IP { 
   # Concatenar TUDO
      f_talk; echo "Na maquina que quer aceder ao servidor, escreva o comando:"
      v_com_IP_publico="IP publico: 'sshfs $USER@$v_ip:$v_r_dir $v_dir_to_mount'"
      echo " > $v_com_IP_publico"
      echo
      v_com_IP_local="IP local: 'sshfs $USER@$v_loc_ip:$v_r_dir $v_dir_to_mount'" 
      echo " > $v_com_IP_local" 
}


function f_send_public_key_to_verbose_line_repo {
   # Send text to a specific repo for verbose outputs through github

      # Data (Exemplo: "Data/Hora: 2024-06-07 04:21:26")
         v_data=$(date +'%Y-%m-%d %H:%M:%S')
         v_data="Data: $v_data"

      # Texto que descreve qual a nossa chave publica
         v_public="Public key para SSH (user: $USER)(at ~/.sshid_rsa.pub)"

      # Mostrar nome de utilizador
         v_user="Utilizador desta maquina (servidor): $USER"
   
      # texto que informa sobre a maquina atual
         v_texto_mq_atual="Maquina atual (servidor): $v_current_local"

      # Texto que indica ao cliente, em qual pasta montar os ficheiros do servidor
         v_mont="Pasta onde montar (cliente): $v_dir_to_mount"

      # Comando que o cliente vai introduzir
         v_comando="Comando a ser introduzido no terminal (cliente)"

      echo                          > $v_verbose_line_file
      echo "$v_data"               >> $v_verbose_line_file
      echo                         >> $v_verbose_line_file
      echo "$v_public "            >> $v_verbose_line_file
      cat $v_public_key            >> $v_verbose_line_file  # Despeja a chave publica no nosso ficheiro verboso
      echo                         >> $v_verbose_line_file
      echo "$v_user"               >> $v_verbose_line_file
      echo                         >> $v_verbose_line_file
      echo "IP publico: $v_ip"     >> $v_verbose_line_file
      echo "IP local:   $v_loc_ip" >> $v_verbose_line_file
      echo                         >> $v_verbose_line_file
      echo "$v_texto_mq_atual"     >> $v_verbose_line_file
      echo                         >> $v_verbose_line_file
      echo "$v_mont"               >> $v_verbose_line_file 
      echo                         >> $v_verbose_line_file
      echo "$v_comando"            >> $v_verbose_line_file 
      echo "   $v_com_IP_local  "  >> $v_verbose_line_file 
      echo "   $v_com_IP_publico"  >> $v_verbose_line_file

      # Enviar o mesmo tempo para um ficheiro tmp (para quem nao tem a repo 'verbose-lines' 
         cat $v_public_key > $v_temporary_file  ## Foi definido no inicio deste script
}

function f_check_installed_ssh_key {
   # Check if ssh key is available (WITHOUT VERBOSE OUTPUT)

   # variaveis definidas no inicio do fucheiro: v_public_key, v_verbose_line_file

   # Se existir chave public, envia tambem para a repo: verbose-line
   if [ -f $v_public_key ]; then
      v_ssh_installed_key="true"

   else
      v_ssh_installed_key="false"
   fi
}

function f_check_installed_ssh_key_verbose {
   # Check if ssh command is available (WITH VERBOSE OUTPUT)

   if [[ $v_ssh_installed_key == "true" ]]; then
            echo -n " > SSH key: "
      f_c7; echo    "installed."
      f_rc; echo 

   elif [[ $v_ssh_installed_key == "false" ]]; then
            echo -n " > SSH key: "
      f_c8; echo    "not installed."
      f_rc; echo 
   
   else
      echo "O software nao conseguiu detetar se está ou nao está instalado SSH key devido a um erro"
      exit 1
   fi
}

function f_check_installed_ssh {
   # Check if ssh command is available (WITHOUT VERBOSE OUTPUT)
   ssh -V &>/dev/null
   if [ $? == 0 ]; then
      v_ssh_installed="true"
   else
      v_ssh_installed="false"
   fi
}

function f_check_installed_ssh_verbose {
   # Check if ssh command is available (WITH VERBOSE OUTPUT)

   if [[ $v_ssh_installed == "true" ]]; then
            echo -n " > SSH is:  "
      f_c7; echo    "installed."
      f_rc

   elif [[ $v_ssh_installed == "false" ]]; then
            echo -n " > SSH is:  "
      f_c8; echo    "not installed."
      f_rc
   
   else
      echo "O software nao conseguiu detetar se está ou nao está instalado SSH devido a um erro"
      exit 1
   fi
}


function f_check_installed_sshfs {
   # Check if sshfs command is available (WITHOUT VERBOSE OUTPUT)
   if command -v sshfs &>/dev/null; then
      v_sshfs_installed="true"
   else
      v_sshfs_installed="false"
   fi
}

function f_check_installed_sshfs_verbose {
   # Check if sshfs command is available (WITH VERBOSE OUTPUT)

   v_termux=$TERMUX_VERSION
   v_info="   (Para termux precisa: root)"
   v_erro="Erro: O software nao conseguiu detetar se está ou nao está instalado SSHFS"

   if [[ $v_sshfs_installed == "true" ]]; then

            echo -n " > SSHFS: "
      f_rc; echo
      f_rc

      if [ -n "$v_termux" ]; then echo "$v_info"; fi


   elif [[ $v_sshfs_installed == "false" ]]; then

            echo -n " > SSHFS: "
      f_c8; echo    "is not installed."
      f_rc 

      if [ -n "$v_termux" ]; then echo "$v_info"; fi
   

   else
      echo -e "$v_erro \n"
      exit 1

   fi

   echo
}

function f_check_if_user_is_on_fuse_group {
   # Verifica se o utilizador faz parte do grupo fuse (WITHOUT VERBOSE OUTPUT)
      v_group="fuse"

   # Get the groups the current user is a member of
   user_groups=$(groups $USER)

   # Check if the FUSE group is in the list of groups
   if [[ $user_groups =~ (^|[[:space:]])"$v_group"($|[[:space:]]) ]]; then
      v_ison_fuse="true"
   else
      v_ison_fuse="false"
   fi
}

function f_check_if_user_is_on_fuse_group_verbose {
   # Verifica se o utilizador faz parte do grupo fuse (WITH VERBOSE OUTPUT)

   if [ $v_ison_fuse == "true" ]; then
       echo " > The current user is a member of the $v_group group."

   elif [ $v_ison_fuse == "false" ]; then
       echo " > The current user is not a member of the $v_group group."

   else
      echo "O software nao conseguiu detetar se está ou nao está no grupo fuse devido a um erro"
   fi
}

function f_check_ssh_daemon_is_on {
   # Verificar se o Daemon do ssh estao ON ou OFF

   f_talk; echo "Verificado o Status do Daemon:"
   
   if [ $traits_pkgm == "pkg" ]; then 
      # Termux encontrado, verifica-se o estado do `ssh` se existir um processo ativo chamado `sshd` verificavel apartir do comando `top`
      v_started=$(top -o PID,USER,ARGS -n 1 | grep ssh | grep -v "data" | grep -v "grep" )

   elif [ $traits_pkgm == "apt" ]; then 
      if [ $traits_OS == "Windows" ]; then
         echo " > Detetado windows" 

      else
         echo " > Detetado que não é windows"
         # para quando o daemos de chama `ssh`
         v_started=$(sudo systemctl status ssh | grep Active) 
      fi 

   elif [ $traits_pkgm == "dnf" ]; then 
      echo " > Detetado Fedora" 
      # para quando o daemos de chama `sshd`
      v_started=$(sudo systemctl status sshd.service | grep Active)
   
   fi

   # Debug
      #echo "$v_started"    # Print do estado, independentemente de como se chama o Daemon
      #echo "hit"; read  # Debug

   
   if [[ -z $v_started ]]; then
      # Se a variavel $v_started estiver vazia, nenhum processo ou Daemon foi encontrado, logo, está desligado
      echo " > Servico nao iniciado"
   
   else
      echo "$v_started"    # Print do estado, independentemente de como se chama o Daemon
   fi

}

function f_ver_as_pastas_pre_definidas {
   # Verbose: Pastas pre-definidas para mounting points
      f_greet
      f_talk; echo "Escolheu a opcao:"
              echo " > Listar pastas pre-definidas"
              echo
              echo "Instrucao:"
              echo " > No interior do script, pode alterar:"
              echo " >> o array de pastas (mounting point para cada servidor)"
              echo " >> o 'parent directory' onde residem todas essas"
              echo 

      f_check_mounting_point_array
}

function f_check_ssh_daemon_is_on_verbose {
   echo
   if [[ $v_started =~ "No superuser binary detected" ]]; then
      echo " > You are on termux, not sure if ssh Daemon is on"
   fi
}

function f_cat_this_public_key {
   # Mostra ao utilizador o ssh key publica desta maquina
      f_send_public_key_to_verbose_line_repo
      #tail -n 4 $v_verbose_line_file  # Esta linha n é precisa porque ja existe um menu fzf que faz isto
}


function f_add_user_to_fuse_group {
   sudo usermod -aG fuse $v_current_username
}

function f_create_fuse_group {
   # Define the FUSE group name
   fuse_group="fuse"

   # Check if the FUSE group exists
   if grep -q "^$fuse_group:" /etc/group; then
       echo "The FUSE group already exists."
   else
       # Create the FUSE group
       sudo groupadd $fuse_group
       if [ $? -eq 0 ]; then
           echo "The FUSE group has been created."
       else
           echo "Failed to create the FUSE group."
       fi
   fi
}

function f_remove_user_from_fuse_group {
   # Define the username you want to remove from the FUSE group
   username=$v_current_username

   # Remove the user from the FUSE group
   sudo gpasswd -d $username fuse

   # Check if the user was successfully removed from the FUSE group
   if [ $? -eq 0 ]; then
       echo "User $username has been removed from the FUSE group."
   else
       echo "Failed to remove user $username from the FUSE group."
   fi
}

function f_check_if_fuse_exists {
   grep -q "^fuse:" /etc/group &>/dev/null

   if [ $? -eq 0 ]; then
      v_group="true"
   else
      v_group="false"
   fi
}

function f_check_if_fuse_exists_verbose {
   # Check if sshfs command is available (WITH VERBOSE OUTPUT)

   if [[ $v_group == "true" ]]; then
      echo " > Group fuse exists."

   elif [[ $v_group == "false" ]]; then
      echo " > Group fuse does not exist."
   
   else
      echo "O software nao conseguiu detetar se existe ou nao um grupo FUSE devido a um erro"
      exit 1
   fi

   echo
}

function f_check_mounting_point_parent {
   # check if Default mounting point for DRYa exists
      # For raspberry: .../remote-miau
      # For MSI laptop: .../remote-MSI
   
   ls $v_parent_dir &>/dev/null

   if [ $? -eq 0 ]; then
       echo " > Default mounting point exists:"
       echo "   $v_parent_dir"
   else
       echo " > Default mounting point: "
       echo "   $v_parent_dir"
       echo "   does not exist."
   fi

   echo
}

function f_check_port_22_open {
   f_talk; echo "Listing open ports (default for ssh: 22)"
   sudo firewall-cmd --list-all | grep "ports: "
}
      
function f_verbose_check {
      f_greet
      f_talk; echo "Current status of SSHFS: "

      f_check_current_user

      f_is_rooted
      f_is_rooted_verbose

      f_check_installed_ssh
      f_check_installed_ssh_verbose

      f_check_installed_ssh_key
      f_check_installed_ssh_key_verbose

      f_check_ssh_daemon_is_on
      f_check_ssh_daemon_is_on_verbose

      f_check_installed_sshfs
      f_check_installed_sshfs_verbose

      f_check_if_fuse_exists
      f_check_if_fuse_exists_verbose

      f_check_if_user_is_on_fuse_group
      f_check_if_user_is_on_fuse_group_verbose

      f_check_mounting_point_parent
      f_check_port_22_open
}

function f_iniciar_daemon_ssh {
   # Iniciar o servico (Daemon) do ssh
      if [ $traits_pkgm == "pkg" ]; then 
         sshd

      elif [ $traits_pkgm == "apt" ] || [ $traits_pkgm == "pacman" ]; then 
         sudo service ssh start
         echo " > Daemon iniciado,mas é preciso confirmar"

      elif [ $traits_pkgm == "dnf" ]; then
         sudo systemctl start sshd
         sudo systemctl enable sshd  # Para iniciar automaticamente no boot
      fi
}

function f_check_mounting_point_array {
   # Visualizar o array de pastas 
      echo "Array definido (em: $v_parent_dir)"

      for i in ${v_array_A_remote_dir[@]};
      do
         echo " > $i"
      done
      echo

   # Visualizar as pastas criadas atualemte:
      echo "Visualizar as pastas que estao criadas neste momento:"
      for i in $(ls $v_parent_dir);
      do
         echo " > $v_parent_dir/$i"
      done
}

function f_delete_DRYa_mounting_points {
   # Apagar todas as pastas pre-definidas

   rmdir $v_parent_dir/*
}

function f_create_DRYa_mounting_points {
   #echo "Array elements: ${v_array_A_remote_dir[@]}"
   #echo 
   #echo "Demonstração de cada pasta:"

   # Criacao de cada pasta (caso nao exista)
   for i in ${v_array_A_remote_dir[@]};
   do
      v_temp="${v_parent_dir}/$i"

      # Debug: echo " > $v_temp"
      mkdir -p $v_temp

   done

   #v_parent_dir=~/sshfs/
   #echo "First element: ${my_array[0]}"
}

function f_ser_servidor {
   # Perguntar ao servidor, a que pasta quer deixar aceder o cliente

   f_talk; echo "Quero ser: Servidor"

   
   # Lista de opcoes
      Lz="DRYa: sshfs-wrapper.sh"

      L4="4. Dar acesso a: .  (pasta atual)"
      L3="3. Dar acesso a: /  (raiz do sistema)"
      L2="2. Dar aceeso a: ~  (documentos do utilizador)"
      L1="1. Calcelar"

      L0="Para SERVIDOR: A que pasta quer dar acesso?"

      v_menu=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz" | fzf --prompt "$L0")

   # Executar escolhas
      [[ $v_menu =~ "4." ]] && echo " > Quer deixar aceder a: . "   && v_r_dir=.
      [[ $v_menu =~ "3." ]] && echo " > Quer deixar aceder a: / "   && v_r_dir=/
      [[ $v_menu =~ "2." ]] && echo " > Quer deixar aceder a: ~ "   && v_r_dir=~
      [[ $v_menu =~ "1." ]] && echo "Canceled: sshfs-wrapper.sh" && exit 0
      #unset v_menu
      cd $v_r_dir

      v_r=$(pwd)
      f_talk; echo "Directory path \`pwd\`: $v_r"

      f_talk; echo 'Directory content `ls`:'
              ls -p

      f_prsK

   # Mostrar se o servidor SSH está ativo e a escutar conexões:
      f_check_ssh_daemon_is_on; f_check_ssh_daemon_is_on_verbose; echo

   # De acordo com o OS atual, iniciar o Daemon
      f_iniciar_daemon_ssh

   # Mostrar se o servidor SSH está ativo e a escutar conexões (novamente)
      f_check_ssh_daemon_is_on; f_check_ssh_daemon_is_on_verbose; echo

   # Mostrar nome de utilizador (Ja esta a ser enviado para o ficheiro verboso)
      #echo "Utilizador: $USER"
      #echo
   
   # Verificar ambos os IP e mencionar no ecra
      # Verificar o IP publico
         v_ip=$(curl -s ifconfig.me)

      # Verificar o IP local
         v_loc_ip=$(ifconfig | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}')

      # Mencionar ambos no ecr (Ja esta a ser enviado para o ficheiro verboso)a
         #echo "IP publico: $v_ip"
         #echo "IP local:   $v_loc_ip"
         #echo
         
   # Denunciar qual é a maquina atual: 
      f_corresponder_local_com_remota

   # Mostrar texto concatenado sobre IP
      f_concat_IP 

   # Mostrar a chave publica da maquina atual no ecra
      f_cat_this_public_key  

   f_menu_para_ver_resumo
}

function f_ser_cliente {
   # Perguntar: Qual maquina remota quer aceder?

   f_greet

   f_talk; echo "Quero ser: Cliente"
           echo

   f_talk; echo "Qual o nome da maquina remota a que quer aceder?"
           echo " > (para assegurar criar pasta pre-definida nesta maquina)"
           echo

   # Visualizar as pastas criadas atualemte:
      echo "Visualizar as pastas pre-definidas guardadas em array neste momento:"
      
      # iterador contador do 'for' loop
         e=1

      for i in ${v_array_A_remote_dir[@]};
      do
         echo "   $e = $i"
         e=$((e+1))
      done
      read -sn 1 -p " > " v_mach
      echo -e "\r\r\r > $v_mach"
      echo
      
      let "v_o = v_mach - 1"
      v_client_mount_point=${v_array_A_remote_dir[$v_o]}

      f_talk; echo -n "Escolheu assegurar que existe a pasta "
        f_c3; echo -n "$v_mach "
        f_rc; echo    "nesta maquina:"
      echo " > $v_parent_dir$v_client_mount_point"
      mkdir -p $v_parent_dir$v_client_mount_point && f_suc1 || f_suc2
      echo
      
      f_talk; echo "Por fim, configure 'Ser Servidor' na outra maquina. Passos:"
      echo " > 1. La, Ative 'Ser Servidor' na outra maquina"
      echo " > 2. La, vai acumular todos os dados de acesso em {repo}/verbose-lines"
      echo " > 3. La, esses dados da {repo} pode ser sincronizada com o github"
      echo "          ou Disponibilizados em imagens QR code"
      echo " > 4. Ca, introduza OU as credenciais manualmente no terminal"
      echo "                    OU cole o conteudo do QR code no terminal"
      echo "                    OU sincronize a {repo} neste dispositivo para usar as credenciais"
      echo " > 5. Ca, é suposto que o aparelho do servidor esteja montado"
      echo "          diretorio: $v_parent_dir$v_client_mount_point"
      echo
      f_done
}

function f_enable_everything {
   # Instalar SSHFS (verificando primeiro se ja está instalado)

      # Verificar se ja está instalado:
         f_check_installed_ssh  # Vai traser a variavel $v_sshfs_installed "true" ou "false"
         f_check_installed_ssh_key  # Vai traser a variavel $v_sshfs_installed "true" ou "false"
         f_check_installed_sshfs  # Vai traser a variavel $v_sshfs_installed "true" ou "false"
      
      # se nao estiver instalada ssh, vai instalar
         if [[ $v_ssh_installed == "false" ]]; then 
            # confirmar com o user se quer instalar:
               echo "(y)es para instalar ssh"
               read -sn 1 -p " > " v_ans
               echo $v_ans
               echo 

               if [[ $v_ans == "y" ]] || [[ $v_ans == "y" ]]; then 
                  f_install_ssh
               else
                  exit 0
               fi
         fi

      # se nao estiver instalada ssh key, vai instalar
         if [[ $v_ssh_installed_key == "false" ]]; then 
            # confirmar com o user se quer instalar:
               echo "(y)es para instalar ssh key" 
               read -sn 1 -p " > " v_ans
               echo $v_ans
               echo 

               if [[ $v_ans == "y" ]] || [[ $v_ans == "y" ]]; then 
                  f_install_ssh_key
               else
                  exit 0
               fi
         fi


      # Se estiver no termux e nao tiver root, tambem nao vale a pena tentar. A proxima fx faz o bipass à tentativa de instalar sshfs
         if [[ $v_rooted == "true" ]]; then
            # Se nao estiver instalada SSHFS, vai instalar
               #if [[ $v_sshfs_installed == "true" ]]; then 
               #   # A proxima fx ja tem output verbose que menciona que não está instalado. É usada para não haver varias frase verbose diferentes
               #   #f_check_installed_verbose 
                  
               if [[ $v_sshfs_installed == "false" ]]; then 
                  # Confirmar com o user se quer instalar:
                     echo "(Y)es para Instalar SSHFS" 
                     read -sn 1 -p " > " v_ans
                     echo $v_ans
                     echo 

                     if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then 
                        f_install_sshfs
                     else
                        exit 0
                     fi
               fi
         fi
      
   ##########################################################################
   # Criar FUSE group

      # Verificar se ja está existe esse grupo:
         f_check_if_fuse_exists
   
      # Se estiver no termux e nao tiver root, tambem nao vale a pena tentar. A proxima fx faz o bipass à tentativa de instalar sshfs
         if [[ $v_rooted == "true" ]]; then
            
            # Se nao existir, vai criar:
               if [[ $v_group == "false" ]]; then 
                  # Confirmar com o user se quer instalar:
                     echo "(Y)es para Criar grupo FUSE"
                     read -n 1 -p " > " v_ans
                     echo

                     if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then 
                        f_create_fuse_group
                     else
                        exit 0
                     fi
               fi
         fi
      


   ##########################################################################
   # Adicionar Utilizador ao grupo fuse

      # Verificar se o utilizador ja está adicionado ao grupo:
         f_check_if_user_is_on_fuse_group

      # Se estiver no termux e nao tiver root, tambem nao vale a pena tentar. A proxima fx faz o bipass à tentativa de instalar sshfs
         if [[ $v_rooted == "true" ]]; then
            # Se nao estiver adicionado, vai adicionar:
               if [[ $v_ison_fuse == "false" ]]; then 
                  # Confirmar com o user se quer instalar:
                     echo "(Y)es para adicionar utilizador ao grupo FUSE"
                     read -n 1 -p " > " v_ans
                     echo

                     if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then 
                        f_add_user_to_fuse_group
                     else
                        exit 0
                     fi
               fi
         fi


   ##########################################################################
   # Criar as pastas onde podem sermontados os  file systems

      # uDev: Verificar se existe neste momento algum sshfs montado, caso nao haja, apagar todas as subpastas do mounting point
      
      f_delete_DRYa_mounting_points
      f_create_DRYa_mounting_points

      # Questionar qual mounting point o utilizador quer (e de acordo com esse mounting point, ligar à maquina correspondente)
   

   ##########################################################################
   # Perguntar: Cliente ou Servidor?
         Lz="DRYa: sshfs-wrapper.sh"

         L3="3. Quero ser CLIENTE"
         L2="2. Quero ser SERVIDOR"
         L1="1. Cancelar"

         L0="SELECIONE 1 para ligar o servico (ON)"

         v_menu=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz" | fzf --prompt "$L0")

         [[ $v_menu =~ "3." ]] && f_ser_cliente  
         [[ $v_menu =~ "2." ]] && f_ser_servidor 
         [[ $v_menu =~ "1." ]] && echo "Canceled: sshfs-wrapper.sh"
         unset v_menu

   ##########################################################################
   echo "fim..."



}



function f_confirmar_turn_ssh_offline {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='Tornar SSH Offline'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L3='3. Sim | Tenho a certeza, parar o servico'
      L2='2. Nao | Nao fazer nada'
      L1='1. Cancel'

      L0="SELECT 1 do menu 'Go offline': "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "3. " ]] && f_confirmado_tornar_ssh_offline
      [[ $v_list =~ "2. " ]] && echo "Not turning off the ssh service"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}



function f_confirmado_tornar_ssh_offline {
   echo "uDev: desligar-se a si proprio de ser servidor"

   # Ver o estado atual do serviço antes de fazer alterações:
      f_check_ssh_daemon_is_on
      f_check_ssh_daemon_is_on_verbose

   # Parar o serviço

      # Parar no termux
      if [ $traits_pkgm == "pkg" ]; then 

         # Detetar qual é o PID do `sshd` 
            v_proc=$(top -o PID,USER,ARGS -n 1 | grep ssh | grep -v "bash" | grep -v "grep" | awk '{ print $1 }')

         # Terminar esse processo
            kill $v_proc
      fi 

      # Parar noutros OS
      if [ $traits_pkgm == "apt" ] || [ $traits_pkgm == "dnf" ] || [ $traits_pkgm == "pacman" ]; then sudo service ssh stop; fi
      


   # Ver o estado atual do serviço apos fazer alterações:
      f_check_ssh_daemon_is_on
      f_check_ssh_daemon_is_on_verbose
}

function f_confirmar_desinstalacao_ssh {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='Uninstall ssh'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L3='3. Sim | Tenho a certeza, quero desinstalar tudo'
      L2='2. Nao | Tenho a certeza, cancelar desinstalacao'
      L1='1. Cancel'

      L0="SELECT 1 do menu 'Disable': "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "3. " ]] && f_uninstall_sshfs
      [[ $v_list =~ "2. " ]] && echo "Canceled: Uninstalation of ssh"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}

function f_disable_ev_1st_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='SSH Disable'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L3='3. Menu Desinstalar'
      L2='2. Desligar (colocar Offline)'                                      
      L1='1. Cancel'

      L0="SELECIONE 1 do menu 'Disable': "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "3. " ]] && f_confirmar_desinstalacao_ssh
      [[ $v_list =~ "2. " ]] && f_confirmar_turn_ssh_offline
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}

function f_disable_everything {

   f_disable_ev_1st_menu

   # remove: f_create_fuse_group
   #f_remove_user_from_fuse_group
   # Delete dir

   # Perguntar: 
   #  > Quer que este dispositivo desconecte do servidor remotamento?
   #  > Quer que este dispositivo bloqueie os seus servicos de servidor e bloqueie visitas?
}



function f_help {
   f_greet
   f_talk; echo "Help and instructions:"
           echo 
           echo "When the USER wants to be a CLIENT ans acess another SERVER"
           echo " > uses ~/ssfhs/default-dir as mounting point"
           echo 
           echo "When the USER wants to a SERVE and allow other machine as CLIENT"
           echo " > Writes credentials at:"
           echo "   - Verbose-lines (repository, if exists)"
           echo "   - ~/.config     (if repo does not exist)"
           echo "   - Creates a QR code for the CLIENT to acess easily"
}






function f_main_menu {
   # Main menu for this entire script
   
   if [ -z $1 ]; then
      # If no arguments are given, present the main menu

      # List of menu options
         Lz="DRYa: sshfs-wrapper.sh"

         L7="7. Help"
         L6="6. Lista    | Mounting Points pre-definidos"
         L5="5. Ver      | Consult Output file"

         L4="4. Desligar | Servico SSH ou SSHFS"
         L3="3. Ligar    | Servico SSH ou SSHFS"

         L2="2. Ver      | Estado atual do sistema"
         L1="1. Cancelar" 

         L0="DRYa: Menu para os servicos SSH"

         v_menu=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n\n$Lz" | fzf --prompt "$L0")

      # Executar de acordo com o resultado
         [[ $v_menu =~ "7." ]] && f_help
         [[ $v_menu =~ "6." ]] && f_ver_as_pastas_pre_definidas
         [[ $v_menu =~ "5." ]] && less $v_verbose_line_file
         [[ $v_menu =~ "4." ]] && f_disable_everything
         [[ $v_menu =~ "3." ]] && f_enable_everything
         [[ $v_menu =~ "2." ]] && f_verbose_check
         [[ $v_menu =~ "1." ]] && echo "Canceled: sshfs-wrapper.sh"
         unset v_menu

   elif [ $1 == "." ]; then
      # See the current state
      f_verbose_check
      
   elif [ $1 == "on" ]; then
      # Go directly to the ON option
      f_enable_everything

   elif [ $1 == "off" ]; then
      # Go directly to the OFF option
      f_disable_everything

   elif [ $1 == ".." ]; then
      # See last output file
      less $v_verbose_line_file

   elif [ $1 == "dir" ]; then
      # See default Seiva directories as mounting points
      f_ver_as_pastas_pre_definidas

   fi
}



function f_exec {

   f_declare_variables
   f_main_menu

   # Status (each fx separate, for debug)
      #f_check_current_user
      #f_is_rooted
      #f_is_rooted_verbose
      #
      #f_check_installed_ssh
      #f_check_installed_ssh_verbose
      #
      #f_check_installed_ssh_key
      #f_check_installed_ssh_key_verbose
      #
      #f_check_installed_sshfs
      #f_check_installed_sshfs_verbose
      #
      #f_check_if_fuse_exists
      #f_check_if_fuse_exists_verbose
      #
      #f_check_if_user_is_on_fuse_group
      #f_check_if_user_is_on_fuse_group_verbose
      #
      #f_check_mounting_point_parent
      #f_check_mounting_point_array
      #
      #f_check_ssh_daemon_is_on
      #f_check_ssh_daemon_is_on_verbose
      #
      #uDev: check if repo exists: verbose-line

   # Function for $2 when it is on|off
      #f_enable_everything
      #f_disable_everything

   # Installing/Uninstalling SSHFS
      #f_install_ssh
      #f_install_sshfs
      #f_uninstall_sshfs

   # About ssh keys
      #f_install_ssh_key
      #f_send_public_key_to_verbose_line_repo

   # Create/Remove Fuse Group
      #f_create_fuse_group
      # remove: f_create_fuse_group
   
   # Include/Exclude current user from Fuse Group
      #f_add_user_to_fuse_group
      #f_remove_user_from_fuse_group

   # Create/Remove mounting point
      #f_create_DRYa_mounting_points
      #f_delete_DRYa_mounting_points

   # Dados de connexao
      #f_ser_servidor
      #f_ser_cliente
   # Instructions and wizzard to Uninstall everything
}
f_exec
