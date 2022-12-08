#!/bin/bash

PS3=" Menu to decide things to do to your emacs instalation > "
select i in emacs-install emcas-uninstall emacs-dot-files-backup emacs-dot-files-apply install-doom "exit"
do
   case $i in 
      emacs-install)
         echo 
      ;;
      exit)
         break 
      ;;
   esac
done
