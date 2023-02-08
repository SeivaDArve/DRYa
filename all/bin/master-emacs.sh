#!/bin/bash

PS3=" Menu to decide things to do to your emacs instalation > "
select i in vanilla-emacs-install vanilla-emacs-uninstall \
            emacs-dot-files-backup emacs-dot-files-apply \
            install-doom-emacs "exit"
do
   case $i in 
      vanilla-emacs-install)
         echo 
      ;;
      exit)
         break 
      ;;
   esac
done
