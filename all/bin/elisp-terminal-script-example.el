#!/usr/bin/emacs --script
;; TITLE: Example script to run with emacs in the temrinal
;; Description:
;;    This is a one line of comment
;; 
;;    In order to run this script from the terminal, type:
;;    emacs --script <name-of-file-containing-elisp>
;;
;;    You can also create an alias to "emacs --script", for example:
;;     > alias ems="emacs --script"
;;
;;    You can also put an emacs script in a directory mentioned by the variable $PATH like /bin and change its mode to executable `chmod +x <emacs-script-name>`
;;    Then, call it direclty (with autocompletion, due to $PATH being set) on the prompt with:
;;     > `emacs-script-name` 


(message "Hello World")
