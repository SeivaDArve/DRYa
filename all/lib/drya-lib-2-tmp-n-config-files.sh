#!/bin/bash
# Title: drya-lib-2-tmp-n-config-files.sh
# Description: Creates and manages temporary and config files to avoid repetition

# uDev: 
#    History files for:
#
#     ~/.confif/h.h/drya
#
#     `V`
#     `S`
#     bash history
#     drya-messages
#     `notify` output messages  # Placed on repo: omni-log
#     ~/DRYa-IO                 # This lib will attemp to output every verbose to omni-log, but if internet or github is not available, drya-IO will work as a mailbox. Whenever Internet is available, it will be uploaded and the dir is deleted
#     file: un-exported-variables-list.txt   # File of outputs that may be used by other terminal commands as variables (without wlexporting them to the env). Examples: ezGIT.sh sais that if it cannot webscrape github.com correctly, it gives the link "https://github.com/SeivaDArve" so that the browser can go there. But, if the user does not want to use the clipboard to copy the link and past in the browser, then this file comes in handy... the browser can fzf the file and pick one line to navigate to... ANOTHER EXAMPLE: a Qr code is generated via curl and exported to this file. Another apps can pick up
#     test existence of files, directories
#  
#

function f_tmp_file {
   # Creates a temporary file and returns a variable with it's path $v_tmp_file

   # Use: 1. At the first lines of your scripts, source this library file entirely
   #      2. In the middle of your scripts when you want a tmp file, just invoke `f_tmp_file`
   #      3. In the next code line, the varibale v_tmp_file will be a path to a new temporary file 
   #      4. If you want to save multiple tmp files, you can,in another variable names like $var1 $var2 after each f_tmp_file call

   # Reset as variaveis que possam vir de outros scripts
      unset v_dir v_tmp_file

   # Criar pasta oculta com o nome .tmp  (O ficheiro .bash_logout editado por DRYa apaga essa pasta ao encerrar o terminal)
      v_dir=~/.tmp
      mkdir -p $v_dir
   
   # O nome do ficheiro temporario será a data/hora atual
      v_tmp_file=$(bash ${v_REPOS_CENTER}/DRYa/all/bin/data.sh v)
      v_tmp_file="$v_tmp_file.txt"

      #echo "$v_tmp_file"  # Debug

   # Criar o ficheiro temporario
      v_tmp_file="$v_dir/$v_tmp_file"

      touch $v_tmp_file
}
f_tmp_file
