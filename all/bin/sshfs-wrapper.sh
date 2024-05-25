#!/bin/bash

function f_greet {
   clear
   figlet SSHFS
}

# Para Debug:
   # Escte script nao reconhecia os arg $1 $2 $3 porque este script era chamado apartir de outro script (nomeadamente 'drya.sh'). Portanto, no script inicial, as variaveis $1, $2, $3 foram exportadas como v_1, v_2, v_3
   #echo $0, $v_1, $v_2, $v_3...
   #read

# Verificar a env variable para o nome de utilizador atual
   v_current_username=$USER

# Definir neste array, qual o conjunto de diretorios que queremos como pre-definidas para os nossos 'mounting point'
   v_parent_dir=~/sshfs/
   v_array_remote_dir=("remote-Rasp-miau" "remote-Lenovo-Dv" "remote-MSI-dv_msi" "remote-ASUS-indratena" "remote-A6-termux-Dv")

   # Print the entire array
      #echo "Array elements: ${v_array_remote_dir[@]}"
 
function f_check_current_user {
   # Get the current username
   echo " > Your current username is: $v_current_username"
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

function f_check_installed_ssh {
   # Check if sshfs command is available (WITHOUT VERBOSE OUTPUT)
   if command -v ssh &>/dev/null; then
      v_ssh_installed="true"
   else
      v_ssh_installed="false"
   fi
}

function f_check_installed_ssh_verbose {
   # Check if sshfs command is available (WITH VERBOSE OUTPUT)

   if [[ $v_ssh_installed == "true" ]]; then
      echo " > SSH is installed."

   elif [[ $v_ssh_installed == "false" ]]; then
      echo " > SSH is not installed."
   
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

   if [[ $v_sshfs_installed == "true" ]]; then
      echo " > SSHFS is installed."

   elif [[ $v_sshfs_installed == "false" ]]; then
      echo " > SSHFS is not installed."
   
   else
      echo "O software nao conseguiu detetar se está ou nao está instalado SSHFS devido a um erro"
      exit 1
   fi
         

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
}

function f_check_mounting_point_parent {
   # check if Default mounting point for DRYa exists
   v_parent_dir=~/sshfs/
      # For raspberry: .../remote-miau
      # For MSI laptop: .../remote-MSI
   
   ls $v_parent_dir &>/dev/null

   if [ $? -eq 0 ]; then
       echo " > Default mounting point exists: $v_parent_dir"
   else
       echo " > Default mounting point '$v_parent_dir' does not exist."
   fi

}

function f_verbose_check {
      echo "Current status of SSHFS: "
      f_check_current_user

      f_check_installed_ssh
      f_check_installed_ssh_verbose

      f_check_installed_sshfs
      f_check_installed_sshfs_verbose

      f_check_if_fuse_exists
      f_check_if_fuse_exists_verbose

      f_check_if_user_is_on_fuse_group
      f_check_if_user_is_on_fuse_group_verbose

      f_check_mounting_point_parent
      echo
      echo "Options:"
      echo " > 'on'  to enable everything"
      echo " > 'off' to disable everything"
      echo " > 'dir' See all Default dir mounting points"
      echo " > 'no option' for instructions (uDev)"
      echo
      echo "Example: "
      echo " > '$ bash sshfs-wrapper.sh on'"
}
      
function f_check_mounting_point_array {
   # Visualizar o array de pastas 
      echo "Array definido (em: $v_parent_dir)"

      for i in ${v_array_remote_dir[@]};
      do
         echo " > $i"
      done
      echo

   # Visualizar as pastas criadas atualemte:
      echo "Visualizar as pastas que estao criadas neste momento:"
      for i in $(ls $v_parent_dir);
      do
         echo " > $i"
      done

}

function f_delete_DRYa_mounting_points {
   # Apagar todas as pastas pre-definidas

   rmdir $v_parent_dir/*
}

function f_create_DRYa_mounting_points {
   #echo "Array elements: ${v_array_remote_dir[@]}"
   #echo 
   #echo "Demonstração de cada pasta:"

   # Criacao de cada pasta (caso nao exista)
   for i in ${v_array_remote_dir[@]};
   do
      v_temp="${v_parent_dir}$i"

      # Debug: echo " > $v_temp"
      mkdir -p $v_temp

   done

   #v_parent_dir=~/sshfs/
   #echo "First element: ${my_array[0]}"
}

function f_ser_servidor {
   
   function f_ask {
      f_greet
      echo "Ser servidor"
   }

   f_ask
   echo " > na maquina remota, que acerder a qual pasta?"
   echo " >> A tudo?? '/'"
   echo " >> So aos Documentos 'Home' '~'?"
   echo -n " > "
   read v_r_dir
   
   f_ask
   echo " > Na pasta remota: $v_r_dir"
   echo

   echo "Utilizador: "
   echo " > $USER"
   echo
   
   v_ip=$(curl -s ifconfig.me)
   echo "IP publico:"
   echo " > $v_ip"
   echo
   
   # Concatenar TUDO
      echo "Na maquina que quer aceder ao servidor, escreva o comando:"
      echo " > sshfs $USER@$v_ip:$v_r_dir  (mais o mounting point do cliente)"
      echo "   Por exemplo: remote-MSI-dv_msi" 
}

function f_ser_cliente {
   # Perguntar: Qual maquina remota quer aceder?
      echo "A qual maquina remota quer aceder?"

      # Visualizar as pastas criadas atualemte:
         echo "Visualizar as pastas que estao criadas neste momento:"
         
         # iterador contador do 'for' loop
            e=1

         for i in ${v_array_remote_dir[@]};
         do
            echo " > $e.$i"
            e=$((e+1))
         done
         read -sn 1 -p " > " v_mach
         echo
         echo " > $v_mach"
         
         let "v_o = v_mach - 1"
         echo " >> $v_parent_dir${v_array_remote_dir[$v_o]}"

}

function f_enable_everything {
      ##########################################################################
      # Instalar SSHFS (verificando primeiro se ja está instalado)

         # Verificar se ja está instalado:
            f_check_installed_ssh  # Vai traser a variavel $v_sshfs_installed "true" ou "false"
            f_check_installed_sshfs  # Vai traser a variavel $v_sshfs_installed "true" ou "false"

         # Se nao estiver instalada, vai instalar
            #if [[ $v_sshfs_installed == "true" ]]; then 
            #   # A proxima fx ja tem output verbose que menciona que não está instalado. É usada para não haver varias frase verbose diferentes
            #   #f_check_installed_verbose 
               
            if [[ $v_sshfs_installed == "false" ]]; then 
               # Confirmar com o user se quer instalar:
                  echo "(Y)es para Instalar SSHFS" v_ans
                  read -sn 1 -p " > " v_ans
                  echo $v_ans
                  echo 

                  if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then 
                     f_install_sshfs
                  else
                     exit 0
                  fi
            fi
         
         
      ##########################################################################
      # Criar FUSE group

         # Verificar se ja está existe esse grupo:
            f_check_if_fuse_exists
      
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
         


      ##########################################################################
      # Adicionar Utilizador ao grupo fuse

         # Verificar se o utilizador ja está adicionado ao grupo:
            f_check_if_user_is_on_fuse_group

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



      ##########################################################################
      # Criar as pastas onde podem sermontados os  file systems

         # uDev: Verificar se existe neste momento algum sshfs montado, caso nao haja, apagar todas as subpastas do mounting point
         
         f_delete_DRYa_mounting_points
         f_create_DRYa_mounting_points

         # Questionar qual mounting point o utilizador quer (e de acordo com esse mounting point, ligar à maquina correspondente)
      

      ##########################################################################
      # Perguntar: Cliente ou Servidor?
         echo "Pretende ser (C)liente ou (S)ervidor?"
         read -n 1 -p " > " v_side

         if [[ $v_side == "c" ]] || [[ $v_side == "C" ]]; then
            # Se for Cliente: Perguntar a qual maquina quer aceder
            echo " > Client"
            f_ser_cliente
         fi

         if [[ $v_side == "s" ]] || [[ $v_side == "S" ]]; then 
            # Se for Servidor, dar os dados no ecra para o cliente no outro dispositivo poder aceder
            echo " > Server"
            f_ser_servidor
         fi
         echo


      ##########################################################################
      echo "Foi tudo verificado"
}

function f_disable_everything {
      # Perguntar: Quer so desligar o Servico ou Desinstalar tudo?
         echo "Pretende tornar-se (O)ffline ou (D)esinstalar tudinho?"
         read -p " > " v_off
         echo 

         # Desinstalar SSHFS (Se escolheu desinstalar)
            if [[ $v_ans == "d" ]] || [[ $v_ans == "D" ]]; then 
               echo "Tem a certeza que quer desativar todas as fx e deixar de usar sshfs?"
               read -p "(Y)es para Desinstalar SSHFS" v_ans
      
               if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then i
                  f_uninstall_sshfs
               fi
            fi

         # Tornar-se Offline
            if [[ $v_ans == "o" ]] || [[ $v_ans == "O" ]]; then 
               echo "Tem a certeza que quer cncelar o serviço de servidor sshfs nesta maquina?"
               read -p "(Y)es para desligar-se de servidor SSHFS" v_ans
      
               if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then 
                  echo "uDev: desligar-se a si proprio de ser servidor"
               fi
            fi
      # remove: f_create_fuse_group
      #f_remove_user_from_fuse_group
      # Delete dir

      # Perguntar: 
      #  > Quer que este dispositivo desconecte do servidor remotamento?
      #  > Quer que este dispositivo bloqueie os seus servicos de servidor e bloqueie visitas?
}










function f_check_overall_status {

   f_greet

   if [[ -z $v_2 ]]; then
      echo "DRYa: SSHFS-wrapper: A verificar o estado atual..."
      echo
      f_verbose_check

   elif [[ $v_2 == "on" ]]; then
      # Verbose output do instalador
         echo "Escolheu a opcao: on"
         echo 
         f_enable_everything

   elif [[ $v_2 == "off" ]]; then
      # Verbose output do desinstalador
         echo "Escolheu a opcao: off"
         echo 
         f_disable_everything

   elif [[ $v_2 == "dir" ]]; then
      # Verbose: Pastas pre-definidas para mounting points
         echo "Escolheu a opcao: dir"
         echo
         echo "Instrucao:"
         echo " > No interior do script, pode alterar:"
         echo " >> o array de pastas (mounting point para cada servidor)"
         echo " >> o 'parent directory' onde residem todas essas"
         echo 

         f_check_mounting_point_array
         exit 0

   else
      echo "SSHFS-wrapper: comando nao encontrado"
   fi
}



function f_exec {

  f_check_overall_status

   # Status (each fx separate, for debug)
      #f_check_current_user
      #
      #f_check_installed_ssh
      #f_check_installed_ssh_verbose
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

   # Function for $2 when it is on|off
      #f_enable_everything
      #f_disable_everything

   # Installing/Uninstalling SSHFS
      #f_install_sshfs
      #f_uninstall_sshfs

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
