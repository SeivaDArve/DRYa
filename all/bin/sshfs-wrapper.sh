#!/bin/bash

v_ssh_on="false"  # If true, sshfs might get installed by an fx

function f_check_current_user {
   # Get the current username
   v_current_username=$USER
   echo " > Your current username is: $v_current_username"
}

function f_install_sshfs {
   # Installing sshfs

   echo "Installing with 'apt'..."
   sudo apt install sshfs
}

function f_uninstall_sshfs {
   # Installing sshfs

   echo "Uninstalling with 'apt'..."
   sudo apt remove sshfs
}

function f_check_installed {
   # Check if sshfs command is available
   if command -v sshfs &>/dev/null; then
       echo " > SSHFS is installed."
   else
      echo " > SSHFS is not installed."
      
      # If the enabler script wants to run and install sshfs, the variable $v_ssh_on comes as 'true'
      # After installing, this fx turns that variable back 'false'
         if [ $v_ssh_on == "true" ]; then
            echo "SSHFS is now going to be installed"
         fi
      
      # Turn variable back 'false'
         v_ssh_on="false"
   fi
}



function f_check_if_user_is_on_fuse_group {
   # Define the FUSE group
   fuse_group="fuse"

   # Get the groups the current user is a member of
   user_groups=$(groups)

   # Check if the FUSE group is in the list of groups
   if [[ $user_groups =~ (^|[[:space:]])"$fuse_group"($|[[:space:]]) ]]; then
       echo " > The current user is a member of the $fuse_group group."
   else
       echo " > The current user is not a member of the $fuse_group group."
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
   grep -q "^fuse:" /etc/group

   if [ $? -eq 0 ]; then
       echo " > Group fuse exists."
   else
       echo " > Group fuse does not exist."
   fi
}

function f_check_mounting_point {
   # check if Default mounting point for DRYa exists
   v_mount_dir=~/sshfs-mp/
      # For raspberry: .../remote-miau
      # For MSI laptop: .../remote-MSI
   
   ls $v_mount_dir &>/dev/null

   if [ $? -eq 0 ]; then
       echo " > Default mounting point exists."
   else
       echo " > Default mounting point does not exist."
   fi

}

function f_verbose_check {
      echo "Current status of SSHFS: "
      f_check_current_user
      f_check_installed
      f_check_if_fuse_exists
      f_check_if_user_is_on_fuse_group
      f_check_mounting_point
      echo
      echo "Options:"
      echo " > 'on'  to enable everything'"
      echo " > 'off' to disable everything'"
      echo " > 'no option' for instructions (uDev)"
      echo
      echo "Example: "
      echo " > '$ bash sshfs-wrapper.sh on'"
}
      
function f_create_DRYa_mounting_points {
   echo "Confirme no script, as pastas que vao ser criadas"
   read
   read
   read
   read
   mkdir -p ~/sshfs/remote-Rasp-miau
   mkdir -p ~/sshfs/remote-Lenovo-Dv
   mkdir -p ~/sshfs/remote-MSI-dv_msi
   mkdir -p ~/sshfs/remote-ASUS-indratena
   mkdir -p ~/sshfs/remote-A6-termux-Dv
}

#function f_check_overall_status {
   
   clear
   figlet SSHFS

   if [[ -z $1 ]]; then
      echo "DRYa: SSHFS-wrapper: A verificar o estado atual..."
      echo
      f_verbose_check

   elif [[ $1 == "on" ]]; then
      # Verbose output do instalador
         echo "Escolheu a opcao: on"
         echo " > Tem a certeza que quer ativar todas as fx para poder usar sshfs?"
         echo

      # Perguntar: Cliente ou Servidor?
         echo 
         echo "Pretende ser (C)liente ou (S)ervidor?"
         read -p " > " v_side

      # Instalar SSHFS
         # Verificar primeiro se SSHFS esta instalado (se nao estiver, perguntar se quer instalar):
         read -p "(Y)es para Instalar SSHFS" v_ans
         if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then f_install_sshfs; fi
         
      #f_create_fuse_group
      #f_add_user_to_fuse_group
      #f_create_DRYa_mounting_points
      # Create dir
      
      # Perguntar: 
      #  > Quer que este dispositivo aceda a um servido remotamento?
      #  > Quer que este dispositivo seja um servidor que permita visitas?

   elif [[ $1 == "off" ]]; then
      # Verbose output do desinstalador
         echo "Escolheu a opcao: off"
         echo " > Tem a certeza que quer desativar todas as fx e deixar de usar sshfs?"

      # Perguntar: Quer so desligar o Servico ou Desinstalar tudo?
         echo 
         echo "Pretende tornar-se (O)ffline ou (D)esinstalar tudinho?"
         read -p " > " v_off

      # Desinstalar SSHFS (Se escolheu desinstalar)
         read -p "(Y)es para Desinstalar SSHFS" v_ans
         if [[ $v_ans == "y" ]] || [[ $v_ans == "Y" ]]; then f_uninstall_sshfs; fi

      # remove: f_create_fuse_group
      #f_remove_user_from_fuse_group
      # Delete dir

      # Perguntar: 
      #  > Quer que este dispositivo desconecte do servidor remotamento?
      #  > Quer que este dispositivo bloqueie os seus servicos de servidor e bloqueie visitas?

   else
      echo "SSHFS-wrapper: comando nao encontrado"
   fi
#}

function f_enable_everything {
   echo
   
}

#function f_exec {

 # f_check_overall_status

   # Status (each fx separate, for debug)
      #f_check_current_user
      #f_check_installed
      #f_check_if_fuse_exists
      #f_check_if_user_is_on_fuse_group
      #f_check_mounting_point

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
      # Delete dir

   # Instructions and wizzard to Uninstall everything

#}
#f_exec
