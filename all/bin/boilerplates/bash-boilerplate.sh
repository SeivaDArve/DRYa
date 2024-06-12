#!/bin/bash

# f_greet
   # uDev

# Functions for text colors
   # Copied from ezGIT
   function f_cor1 {	
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput setaf 5 
   }
   function f_cor2 { 
      tput setaf 2 
   }
   function f_cor3 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput setaf 3
   }
   function f_cor5 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Similar to Bold
      # f_talk
      tput setaf 6
   }
   function f_cor4 { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Similar to Bold
      # f_talk
      tput setaf 4
   }
   function f_resetCor { 
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      tput sgr0
   }
   function f_talk {
      # Vindo de .../bin/boilerplates/bash-boilerplate.sh
      # Copied from: ezGIT
      echo
      f_cor4; echo -n "DRYa: "
      f_resetCor
   }

# Menu dizer sim/nao
   echo "Do you want to continue? [Y/n]"
   # Todas as teclas diferentes de Enter e 'y' e 'Y', dizer 'Abort'
   
# Date variables
   v_date=$(date +'%Y-%m-%d %H:%M:%S')
   v_date="Data/Hora: $v_date"

# Horizontal line variables
   # uDev

# Ficheiro tmp em pasta tmp
