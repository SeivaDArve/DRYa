#/bin/bash
# Title: Colors Boilerplate
# Description: One file that saves all colors
# Use: `source` this file to avoid repeating the same color functions on your scripts
# Use for libraries: In this file, copy the normal functions and variables to the bottom of the page and use capital letters instead
#                    f_talk is F_talk  (for example in drya-lib-4)
#                    v_txt  is V_txt   (for example in drya-lib-4)



#
#
#  INSTRUCTIONS: 
#     At the top of every script file in which this script needed, place these lines below:
#
#
#     # Sourcing DRYa Lib 1: Color schemes
#        __name__="example-to-change"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)
#        v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
#        source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )
#
#        # Examples: f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
#           v_greet="DRYa"
#           v_talk="DRYa: "
#           v_txt="<text-used-at-f_anyK-fx>"
#           v_hzl  # (uDev: variable that decides what is the char that is written in the horizontal line)
#  
#



# uDev: fix dependencies bugs (in case DRYa is running on a fresh install of some new OS)
# uDev: Center text Horizontally + vertically
# uDev: add fx to test if a given variable is number, letter or others
# uDev: fx to read text like chat gpt, one character at a time, slow dump of text, like pokemon on gameboy, like in between each letter of text there is a command `sleep 0.1`. Text is not dumpt at once, it is slowly diumped
# uDev: create fx that catches prompt arguments: $1 $2 $3 = $v_1 $v_2 $v_3
# uDev: create fx to increment a var: i=(($i + 1))
# uDev: add fx for `date` command
# uDev: with ANSI, move cursor up one line
# uDev: f_clear_current_line, (Apagar texto da linha atual ate ao fundo com ANSI)
#       f_count_var_size,     (saber quantas letrar tem `echo ${#variavel}`)
#       f_create_tmp_file     (dar um nome e saber que esse ficheiro tmp foi criado)
# uDev: fx com tput para apagar linha anterior inteira e comecar a escrever a partir de la
#       vatias fx para usar tput, manipular tput facilmente
# uDev: Para os repos que queiram ser independentes das bibliotecas, pode-se adicionar nos seus __repo__/all/libs-from-drya uma copia das libs originais, e depois colocar nos seus __main__ o codigo [[ -z $v_lib ]] && source $__repo__/all/libs-from-drya/copy-x



function f_test_dependencie_tput {
   # Testar a existencia de ncurses-utils

   #echo "uDev"

   v_status=1
   v_status=0
}


function f_c1 {	
   # Text Color 1
   # This function is to be used:
   #  - Output of `git` when something is being cloned, pulled, pushed

   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 5  #   2>/dev/null  || (or, use ANSI colors) 
}

function f_c2 { 
   # Fx for color 2

   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 12
}

function f_c3 { 
   # Fx for color 3

   # Mentioning user input or valiable input
   # This function is to be used when something is DECLAIRED

   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 3
}

function f_c4 { 
   # Fx for color 4

   # Similar to Bold. Used in: f_talk
   # This function is to be used when something is ASKED
   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 4
}

function f_c5 { 
   # Fx for color 5

   # Similar to Bold
   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 6
}

function f_c6 { 
   # Fx for color 6

   # Used for ASCII Drya Logo, centered to the screen
   f_test_dependencie_tput
   [[ $v_status == 0 ]] && tput setaf 28
   [[ $v_status == 0 ]] && tput bold
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
   [[ $v_status == 0 ]] && tput sgr0
}

function f_colors_without_tput {
   # Text Colors before discovering '$ tput setaf'
      RESTORE=$(echo -en '\001\033[0m\002')
          RED=$(echo -en '\001\033[00;31m\002')

   # Exemplo de backspace 1: `echo -e "Texto \bArvore"` output: "TextoArvore"
   #
   # Exemplo de backspace 2: v_backspace=$'\b'
   #                         v="Texto ${v_backspace}Arvore"
   #                         echo -e "$v"
   #                         Output: "TextoArvore"

   # uDev: Criar vars de cor ANSI que usam SEMPRE um Backspace (facilita aleitura)
   #       c_bks="\b"                           # Variavel de codigo ANSI para traser o cursor um caractere para a esquerda
   #       c_vrm="\001\033[00;31m\002"          # Variavel de cor v_vrm ou c_vrm para: Vermelho
   #       c_vrm="${c_bks}\001\033[00;31m\002"  # Variavel de cor v_vrm ou c_vrm para: Vermelho (com backspace)
   #       c_rst="\001\033[00;31m\002"          # Variavel de cor v_rst ou c_rst para: Restore (reset as cores e estilos)
   #
   #       Exemplo: `echo -e "Texto: ${c_vrm} A vermelho. ${c_rst} Agora a branco"


   # Example of Text formating before discovering '$ tput'
   # > `echo ${RED}To do something, specify an argument like \"G 2\"${RESTORE}`
}  

function f_cON {
   # Fx for make cursor visible

   [[ $v_status == 0 ]] && tput cnorm
}

function f_cOFF {
   # Fx for make cursor invisible

   [[ $v_status == 0 ]] && tput civis
}

function f_greet {
   # Presents a nice visual ascii name/logo if figlet is installed
   # Presents a text massage with name/logo if figlet is NOT installed

   # uDev: Confirmar se no futuro pode haver problemas com a font: Enviar para omni-log

   # If previously the variable $v_greet was not set by any script, then assign a <Placeholder> to it.
      [[ -z $v_greet ]] && v_greet="< v_greet >"
      [[ -n $1       ]] && v_greet="$1"           # If an argument was given to f_greet, it will overwrite $v_greet

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

# uDev: f_greet, f_Greet, f_greet2 ... change to f_g1, f_g2, f_g3 ...

function f_talk {
   # uDev: change to f_tk
   # Colorfull text to preceed any text of any important text line

   # If previously no script gave the variable $v_talk, then, assign "DRYa-lib-1" to it
      [[ -z $v_talk ]] && v_talk="< v_talk > "

   f_c2; echo -n "$v_talk"
   f_rc
}










#  Instructions of f_suc (success) options
#
#  | Name   | sucess | failed | green | red  | in-line | 2 lines |
#  | f_suc1 | x      |        | x     |      |         | x       |
#  | f_suc2 |        | x      |       | x    |         | x       |
#
#  | f_suc3 | x      |        | x     |      | x       |         |
#  | f_suc4 |        | x      |       | x    | x       |         |
#
#  | f_suc5 | x      |        |       | x    |         | x       | (uDev) 
#  | f_suc6 |        | x      | x     |      |         | x       | (uDev)
#
#  | f_suc7 | x      |        |       | x    | x       |         | (uDev)
#  | f_suc8 |        | x      | x     |      | x       |         | (uDev)

#  | f_suc  | `$1`   | `$2`   | `$3`  | `$4` | `$5`    | `$6`    | (uDev)


function f_suc {

   # uDev
   
   v_args_number=$#
   echo $v_args_number  # Debug

   # example: `f_suc [S|F] [G|R] [1|2]`         # Synopse  
   # example: `f_suc S G 2`                     # $1 is Success; $2 is Green; $3 is "2 lines"
   # example: `f_suc S R 1`                     # $1 is Success; $2 is Red  ; $3 is "1 line" 

   # example: `echo -n "text" && f_suc S R 1`   # $1 is Success; $2 is Red  ; $3 is "1 line" 

   if [[ $v_args_number == 3 ]]; then 
      echo "hit" 1>/dev/null

   else
      echo "drya-lib-1: f_suc: Minimum args 6 not reached (error) "

   fi
}

function f_suc1 {
   # Fx number 1 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after f_anyK fx

   # EXAMPLE: 
   #     echo "Did this message work?" && echo "Success!"
   #     echo "Did this message work?" && f_suc1 || f_suc2
   #     echo "Did this message work?" && f_suc1 || f_suc2 && exit 1

           echo -n " > "
     f_c7; echo       "Success!"
     f_rc

   # Set a variable to indicate exit status
      v_suc=0
}

function f_suc2 {
   # Fx number 2 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after f_anyK fx

   # EXAMPLE: 
   #     echo "Did this message work?" && echo "Success!"
   #     echo "Did this message work?" && f_suc1 || f_suc2
   #     echo "Did this message work?" && f_suc1 || f_suc2 && exit 1

           echo -n " > "
     f_c8; echo       "Failed!"
     f_rc

   # Set a variable to indicate exit status
      v_suc=1
}

function f_suc3 {
   # Fx number 1 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after text

   # EXAMPLE: 
   #     echo -n "Did this message work?" && echo "Success!"
   #     echo -n "Did this message work?" && f_suc3 || f_suc4

           echo -n " > "
     f_c7; echo       "Success!"
     f_rc

   # Set a variable to indicate exit status
      v_suc=0
}

function f_suc4 {
   # Fx number 2 of 2 
   # Use this to give confirmation the previous command has successfull
   # Use it after text

   # EXAMPLE: 
   #     echo -n "Did this message work?" && echo "Success!"
   #     echo -n "Did this message work?" && f_suc3 || f_suc4

           echo -n " > "
     f_c8; echo       "Failed!"
     f_rc

   # Set a variable to indicate exit status
      v_suc=1
}















function f_done {
   # Use this after all precesses are finished

   f_talk; echo "Done!"
   f_rc
}

function f_anyK {
   # Press Any key to continue
   # Or wait X seconds




   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
      # EXEMPLO:
      #
      # v_txt="Editado X"
      # f_anyK
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


function f_prsD {
   # Press key 'D' or 'd' to continue
   # Or wait X seconds




   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
      # EXEMPLO:
      #
      # v_txt="Editado X"
      # f_prsD
      #
      # EFEITO: 
      # DRYa: Are you sure: "Editar X"
      #  > Are you sure? (Press D to confirm) 



   # Set how many seconds to wait before automatically continue
      v_secs=5

   # Message
      v_msg=" ... (Continue: 'd' or 'D' | Cancel: Ctrl-C or Any Key) "

   # Set $v_txt to " ... " in case the user forgets to set it (must be unset before this fx finishes
      [[ -z $v_txt ]] && v_txt=" ... "

   # Text to print
         #echo
   f_talk; echo -n 'Are you sure? `'
     f_c5; echo -n "$v_txt"   # A variavel $v_txt tem de ser definida antes desta fx ser chamada
     f_rc; echo '`'
           echo -n "$v_msg"
           read -sn1 v_ans
           echo
     
     [[ -n $v_ans ]] && echo -e "\r\033[K > A Continuar..."

   # Removing variables before the fx finished
      unset v_txt
}

function f_hzl {
   # Prints an horizontal line according to the amount to line existent in the current terminal
   # This fx exists also at .../init-bin/horizontal-line.sh

   # If the script that used this library does not set the variable that fills the line, then the character is set as default here
      [[ -z $v_hzl ]] && v_hzl="-"
   
   # Allowing $1 to overwrite $v_hzl
      [[ -n $1 ]] && v_hzl=$1
      
   v_cols=$(tput cols)
   printf "%*s" $v_cols | tr " " "$v_hzl"

   unset v_hzl  # Obrigar a que as fx externas tenham sempre de configurar esta variavel para que ela saia do padrao default
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

function db {
   # Function for fast debugging
   # use: After sourcing this drya-lib-2, just add a line `db` to it
   read -s -p " ------> Debug <------ "
   echo
}

function f_debug {
   # Creating a pause in the middle of the script for debugging process
   
   # Var to print as debug message: v_debug (do not set this var if not needed)
   echo "Debuging... $v_debug"
   echo -n " > 3"
   read -sn1
   echo -n ", 2"
   read -sn1
   echo -n ", 1... "
   read -sn1
}

function f_pin {
   # Adicionar pin aos pedidos de certas fx
   # v_pin is defined at source-all-drya-files
   # v_pin=$(grep "v_pin" ${v_REPOS_CENTER}/DRYa/all/source-all-drya-file)
   v_pin=0000

   # Se no 'main' script o user definiu texto para apresentar no ecra, entao esse texto é apresentado
      [[ -n $v_pin_txt ]] && echo "$v_pin_txt" 

   read -sp " > Introduz um PIN: " v_ans

   [[ $v_ans != $v_pin ]] && f_suc2 && exit 1
   [[ $v_ans == $v_pin ]] && f_suc1

   unset v_pin_txt

}


# {----------------------------------------------------------------------
# Material do center text (vertically, horizontally) found in source-all-drya-files
#
#  # For the lines: 
#     # Count number of lines in the terminal:
#        v_tLines=$(stty size | cut -d ' ' -f 1)
#          #echo "current number of lines in the terminal is: $v_tLines"
#
#     # Dividing that number into 2
#        v_half_tLines=$(expr $v_tLines / 2)
#         #echo "Half of that is (rounded number): $v_half_tLines"
#
#     # And the into 2
#        v_half_half_tLines=$(expr $v_half_tLines / 2)
#        v_lines=$v_half_half_tLines
#
#
#
#
#
#  # For the Columns: 
#     # Count number of lines in the terminal:
#        v_tCols=$COLUMNS
#          #echo "current number of columns in the terminal is: $v_tCols"
#
#     # Removing the number of characters from the text variables:
#        v_tCols=$(expr $v_tCols - $v_char) 
#
#     # Dividing that number into 2
#        v_half_tCols=$(expr $v_tCols / 2)
#        #echo "Half of that is (rounded number): $v_half_tCols"
#
#     v_cols=$v_half_tCols
#
#
#
#  # Center Vertically 
#     for i in $(seq 1 $v_lines)
#     do
#        # Filling a file with empty lines
#        echo -e "\n" >> $v_preMSGS
#     done
#
#  # Center Horizontally
#     echo "${v_cols}$v_msg_1" >> $v_preMSGS
#     echo "${v_cols}$v_msg_2" >> $v_preMSGS
#
# }----------------------------------------------------------------------





# -----------------------------------------------------------------------------------------
# --+-- Above: functions for '__main__' scripts                                     --+--  
# -----------------------------------------------------------------------------------------
