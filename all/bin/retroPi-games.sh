#/bin/bash
# Title: retroPi-games.sh
# Description: 
# Use:

# Usefull variables:
   __name__="retroPi-games.sh"                     # Used to describe the name of current file with extention. Example: .exe .jpg .mp3
   __repo__="${v_REPOS_CENTER}/DRYa"  # Used to describe the name of current repo, the repository that contains __name__
   v_ftf_talk="retroPi-games.sh: "                 # Used to better present text at `fzf` menus in the prompt area


if [ -z "$*" ]; then
   echo "D game   : Print this message"
   echo "D game h : Print help message + info "

elif [ $1 == "help" ] || [ $1 == "h" ] || [ $1 == "?" ] || [ $1 == "--help" ] || [ $1 == "-h" ] || [ $1 == "-?" ] || [ $1 == "rtfm" ]; then
   echo "Resret all retroPi configs: "
   echo " > "

elif [ $1 == "." ]; then
   # Inicia o emulador do RetroPie
   emulationstation  
fi
