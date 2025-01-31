#/bin/bash
# Title: Colors Boilerplate
# Description: One file that saves all colors
# Use: `source` this file to avoid repeating the same color functions on your scripts



#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Sourcing library with: Colors, f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
#        source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
#           v_greet="DRYa"
#           v_talk="DRYa: "
#           v_txt="<text-used-at-f_prsK-fx>"
#           #v_Hl (uDev)
#  
#


# uDev: add fx for `date` command
# uDev: with ANSI, move cursor up one line

# uDev: f_clear_current_line, (Apagar texto da linha atual ate ao fundo com ANSI)
#       f_count_var_size,     (saber quantas letrar tem `echo ${#variavel}`)
#       f_create_tmp_file     (dar um nome e saber que esse ficheiro tmp foi criado)





function f_c1 {	
   # Fx for color 1

   # This function is to be used when something is SEARCHED
   tput setaf 5 
}

function f_c2 { 
   # Fx for color 2

   tput setaf 12
}

function f_c3 { 
   # Fx for color 3

   # Mentioning user input or valiable input
   # This function is to be used when something is DECLAIRED
   tput setaf 3
}

function f_c4 { 
   # Fx for color 4

   # Similar to Bold. Used in: f_talk
   # This function is to be used when something is ASKED
   tput setaf 4
}

function f_c5 { 
   # Fx for color 5

   # Similar to Bold
   tput setaf 6
}

function f_c6 { 
   # Fx for color 6

   # Used for ASCII Drya Logo, centered to the screen
   tput setaf 28
   tput bold
}

function f_c7 {
   # Fx for ANSI green color

   GREEN='\033[0;32m'
   echo -en "$GREEN"
}

function f_c8 {
   # Fx for ANSI red color

   RED='\033[0;31m'
   echo -en "$RED"
}

function f_rc { 
   # Fx for color reset

   # This function is to be used when styles are to be CLEARED
   tput sgr0
}

function f_colors_without_tput {
   # Text Colors before discovering '$ tput setaf'
      RESTORE=$(echo -en '\001\033[0m\002')
          RED=$(echo -en '\001\033[00;31m\002')

   # Example of Text formating before discovering '$ tput'
   # > `echo ${RED}To do something, specify an argument like \"G 2\"${RESTORE}`
}  

function f_cON {
   # Fx for make cursor visible

   tput cnorm
}

function f_cOFF {
   # Fx for make cursor invisible

	tput civis
}

function f_greet {
   # Presents a nice visual ascii name/logo if figlet is installed
   # Presents a text massage with name/logo if figlet is NOT installed

   # uDev: Confirmar se no futuro pode haver problemas com a font: Enviar para omni-log

   # If previously the variable $v_greet was not set by any script, then assign a <Placeholder> to it.
      [[ -z $v_greet ]] && v_greet="< v_greet >"

   # Creting an alternative message in case figlet is not installed
      v_basename=$(basename $0)
      v_2nd_option="<< $v_greet >>\n\n > Running: $v_basename\n > Missing: \`figlet\` \n"

   clear
   f_c2
   figlet $v_greet 2>/dev/null || echo -e "$v_2nd_option"
   f_rc
}

function f_Greet {
   # Same as f_greet, but for Text that uses all the ascii space like "g" in "Yoga". This fx only adds another empty line below the ascii "g"
   f_greet
   echo
}

function f_greet2 {
   # Prints a more verbose output of the ascii text "DRYa" then f_greet

   bash ${v_REPOS_CENTER}/DRYa/all/bin/drya-presentation.sh 2>/dev/null \
      || echo -e "DRYa: app available \n > (For a pretty logo, install figlet)"  # In case figlet or tput are not installed, echo only "DRYa" instead
}

function f_talk {
   # Colorfull text to preceed any text of any important text line

   # If previously no script gave the variable $v_talk, then, assign "DRYa-lib-1" to it
      [[ -z $v_talk ]] && v_talk="< v_talk > "

   f_c2; echo -n "$v_talk"
   f_rc
}

function f_suc1 {
   # Fx number 1 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after f_prsK fx

   # EXAMPLE: 
   #     echo "Did this message work?" && echo "Success!"
   #     echo "Did this message work?" && f_suc1 || f_suc2

           echo -n " > "
     f_c7; echo       "Success!"
     f_rc
}

function f_suc2 {
   # Fx number 2 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after f_prsK fx

   # EXAMPLE: 
   #     echo "Did this message work?" && echo "Success!"
   #     echo "Did this message work?" && f_suc1 || f_suc2

           echo -n " > "
     f_c8; echo       "Failed!"
     f_rc
}

function f_done {
   # Use this after all precesses are finished

   f_talk; echo "Done!"
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

   # uDev: istead of "_" add a variable to it to be used as a library
   #       variable: $v_Hl
  
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

#  function f_nr_test {
#     # Testa se a Var fornecida é numero ou nao
#     # v_nr
#     
#     case $v_nr in
#        1 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0)
#           v_nr=true
#           ;;
#     esac
#  }
