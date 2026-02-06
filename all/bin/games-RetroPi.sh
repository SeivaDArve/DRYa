#/bin/bash
# Title: games-RetroPi.sh
# Description: 
# Use:



# Usefull variables:
   __name__="games-RetroPi.sh"                     # Used to describe the name of current file with extention. Example: .exe .jpg .mp3
   __repo__="${v_REPOS_CENTER}/DRYa"  # Used to describe the name of current repo, the repository that contains __name__
   v_ftf_talk="games-RetroPi.sh: "                 # Used to better present text at `fzf` menus in the prompt area




###############
#
# Info
#
# tty default username + password:
#  > pi:raspberry
#
# Repositories sources file (path):
#  > /etc/apt/sources.list
#
# Verificar o OS atual:
#  > cat /etc/os-release
#
#
#
#
#
#
#
#
#
#
#
#
#
###############













if [ -z "$*" ]; then
   echo "D game    : Print this message"
   echo "D game h  : Print help message + info "
   echo "D game .  : edit 'retroPi-games.sh "
   echo "D game go : Start RetroPi emulation station"

elif [ $1 == "help" ] || [ $1 == "h" ] || [ $1 == "?" ] || [ $1 == "--help" ] || [ $1 == "-h" ] || [ $1 == "-?" ] || [ $1 == "rtfm" ]; then
   echo "Resret all retroPi configs: "
   echo " > "

elif [ $1 == "." ]; then
   # Edit self (this script)
   bash e $__repo__/all/bin/$__name__

elif [ $1 == "rom" ]; then
   # Print ROMs location
   echo "By default, ROMs      location: ~/RetroPie/roms"
   echo "By default, USB stick location: /media"

elif [ $1 == "net" ]; then
   # Testar se ha net com `ping` 
   ping -c 3 google.com

elif [ $1 == "sources" ]; then
   # Debugging the repositories sources file
   sudo vim /etc/apt/sources.list

elif [ $1 == "tty" ]; then
   # Alterar o tamanho da letra/fonte no tty
   echo 'Info `D tty`     para saber user:passwords pre-definidas de tty'
   echo 'Info `D kbd tty` para saber alterar a letra do tty'

elif [[ $1 == "install" ]] || [ $1 == "install-retropi-on-raspberryOS" ]; then
   # If we have RaspberyOS and don't want to flash a different SD card with RetroPi, this is to install on same card

   clear 
   echo "Installing RetroPi"
   echo

   # Step 1  (cloning RetroPi for RaspberryOS)
      echo "---- Step 1: cloning ----"

      v_repo=https://github.com/RetroPie/RetroPie-Setup.git
      v_destination=~/Downloads/RetroPie-Setup
      
      [[   -d $v_destination ]] && echo " > Ja existe"
      [[ ! -d $v_destination ]] && git clone --depth=1 $v_repo $v_destination

      echo

   # Step 2  (Installing RetroPi on RaspberryOS)
      echo "---- Step 2: Installing ----"
      echo
      echo "To install:"
      echo " > \`bash $v_destination/retropie_setup.sh\`"
      echo

      sudo bash $v_destination/retropie_setup.sh

   # Step 3  (Installing X11 replacing wayland)
      echo "---- Step 3: Installing X11 ----"
      echo
      echo "RetroPie does not use wayland, it uses X11"
      echo " > If it mentions 'wayland not available', it means you must switch"
      echo
      echo ' > 1 `sudo raspi-config`'
      echo ' > 2 `6. Advanced Options`'
      echo ' > 3 `A7. Wayland (switch between both)`'
    
elif [ $1 == "go" ]; then
   # Inicia o emulador do RetroPie
   emulationstation  
fi
