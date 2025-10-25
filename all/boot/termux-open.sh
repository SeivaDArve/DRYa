#!/bin/bash
# Title: termux-open
# Description: grupo de funcoes facilitadoras ao termux-open
# Use: Para usar este script: faz source para o $ENV e no emacs (ou outros) podes terntar abrir qualquer imagem apartir do termux. Este script é necessario quando é preciso descobrir quel é o OS em vigor (WSL, Linux, Android) e apartir desse OS abrir a nossa imagem

   function f_attempt_WSL2 {
     wslview ${v_REPOS_CENTER}/moedaz/all/real-documents/cartoes-supermercado/$v_name 2>/dev/null
   }
   
   function f_attermpt_termux {
     termux-open ${v_REPOS_CENTER}/moedaz/all/real-documents/cartoes-supermercado/$v_name 2>/dev/null
   }
   
   function f_attempt_linux {
     xdg-open ${v_REPOS_CENTER}/moedaz/all/real-documents/cartoes-supermercado/$v_name 2>/dev/null
   }
   
   function f_op {
     # Find wich OS is running and run just that
     f_attempt_WSL2 || f_attempt_termux || f_attempt_linux
   }
   
   function f_sure_open_card {
     v_name_example="cartao.jpg"
     v_name_example="/tmp/"
     #v_name="<define-your-img-name-externally-first,it-will-replace-text-here>"
     #v_name_example="/tmp/"
     f_op
   }
