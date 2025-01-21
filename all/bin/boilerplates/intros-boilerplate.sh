#/!/bin/bash
# Title: intros-boilerplate.sh
# Description: A file that contains Ascii Text improvements for scripts

#
# At every script file in which this script is sourced, place these lines below:
#
#
#  # Sourcing f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline
#     v_greet="<repo-name>"
#     v_talk="<script-name>"
#     source ${v_REPOS_CENTER}/DRYa/all/bin/boilerplates/intros-boilerplate.sh
#  
#
#  EXAMPLE: 
#  # Sourcing f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline
#     v_greet="DRYa"
#     v_talk="DRYa: no-tes: "
#     source ${v_REPOS_CENTER}/DRYa/all/bin/boilerplates/intros-boilerplate.sh
#  
#


# uDev: f_clear_current_line, (Apagar texto da linha atual ate ao fundo com ANSI)
#       f_count_var_size,     (saber quantas letrar tem `echo ${#variavel}`)
#       f_create_tmp_file     (dar um nome e saber que esse ficheiro tmp foi criado)


function f_greet {
   # Presents a Nice visual ascii name/logo for this entire script

   # If figlet app is installed:     print an ascii version of the text "DRYa" to improve the appearence of the app
   # "     "    "  is not insfalled: print only a message

   # If figlet not installed, use this message instead
      v_basename=$(basename $0)
      v_2nd_option="( $v_greet ):\vrunning: $v_basename\v\`figlet\`  Not installed"

   # CORDN_5_10='\033[5;23H'
   # echo -e "$CORDN_5_10 Don't Repeat Yourself (app)"
   # 
   # uDev: Confirmar se no futuro pode haver problemas com a font

   clear
   figlet $v_greet 2>/dev/null || echo -e "$v_2nd_option"
}

function f_greet2 {
   # Prints a more verbose output of the ascii text "DRYa" then f_greet

   bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh 2>/dev/null \
      || echo -e "DRYa: app available \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
}

function f_talk {
   # Copied from: ezGIT
         echo
   f_c4; echo -n "$v_talk: "
   f_rc
}

function f_done {
   # Copied from: ezGIT
   f_c5; echo -n ": Done"
   f_rc
}

function f_prsK {
   # Press Any key to continue
   # Or wait X seconds




   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
      # EXEMPLO:
      #
      # v_txt="Editado X"
      # f_prsK
      #
      # EFEITO: 
      # DRYa: Are you sure: "Editar X"
      #  > Are you sure? (Press ANY key to confirm) 



   # Set how many seconds to wait before automatically continue
      v_secs=5

   # Message
      v_msg=" ... (Continue: ANY KEY | Cancel: Ctrl-C ) "

   # Set $v_txt to " ... " in case the user forgets to set it (must be unset before this fx finishes
      [[ -z $v_txt ]] && v_txt=" ... "

   # Text to print
         #echo
   f_talk; echo -n 'Are you sure? `'
     f_c5; echo -n "$v_txt"   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
     f_rc; echo '`'
           echo -n "$v_msg"
           read -sn1
     f_rc; echo -e "\r\033[K > A Continuar..."

   # Removing variables before the fx finished
      unset v_txt
}



function f_Hline {
   # Prints an horizontal line

   #echo $COLUMNS # Debug
   v_cols=$(tput cols)
   printf "%*s" $v_cols | tr " " "_"
}

function f_horizline {
   # Criar uma linha horizontal do tamanho correto do ecra

   # Buscar tamanho correto (precisa da dependencia `tput`)
      v_cols=$(tput cols)

   # Escrever uma linha no ecra
      for i in $(seq $v_cols); do
         echo -ne "-" 
      done
}

function f_verticline {
	v_lines=$(tput lines)
	for i in $(seq $v_lines); do
   	echo -ne "   |\n" 
	done
}
