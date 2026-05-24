#!/bin/bash
# Title:       | drya-lib-8-getopts-parse-n-validate.sh
# Description: | This lib, when sourced, collects all CLI prompt arguments, tests if they are valid and then feeds then
#              | into the script that used it as a lib


#     
#     How to instal
#
#     # Sourcing DRYa Lib 8: Reading/Parsing argumentes from the CLI prompt, then testing if they are valid
#        v_lib8=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-8-getopts-parse-n-validate.sh
#        [[ -f $v_lib8 ]] && source $v_lib8 || (read -s -n 1 -p "DRYa: error: drya-lib-8 does not exist " && echo)
#     
#        # Examples: `D opts -i inFile.txt` and the script will test the input file if it exist or not
#     
#     


# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && source $v_lib1 || (read -s -n 1 -p "DRYa: error: drya-lib-1 does not exist " && echo)

   v_greet="DRYa"
   v_talk="DRYa-getopts: "

   # Examples: `db` (an fx to use during debug)
   #           f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]



# Sourcing DRYa Lib 2: Creating temporary files for support on scripts
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || (read -s -n 1 -p "DRYa: error: drya-lib-2 does not exist " && echo)

   # Examples: `f_create_tmp_file` (will give a $v_tmp with a new file with abs path)



__name__=drya-lib-8-getopts-parse-n-validade.sh





   
# Variables

   # Internal variable. Some fx will read this var, and decide weather or not to act (run the fx or not)  
      unset v_act  


function f_help__print_usage {

   # Define the variables in an array so that they can be explained in order
      v_arg_help="Mostra esta ajuda (tem de ser arg 1)"  # There are 3 args with this same text

      declare -A HELP
      HELP["h"]=" $v_arg_help"
      HELP["-v"]="desativa modo verbose"
      HELP["-f"]="força operação"
      HELP["-i"]="ficheiro de input"
      HELP["-o"]="ficheiro de output"
      HELP["-h"]="$v_arg_help"
      HELP["--help"]="$v_arg_help"



   f_talk; echo "CLI usage:"

   v_base=$(basename $0)

   echo " > $v_base [-v] [-f] [-i ficheiro] [-o ficheiro] [-h] [--]"
   echo


   for opt in "${!HELP[@]}"; do

      # ------------------------------------------------------------
      # Formatação de output com printf (estilo tabela)
      #
      # Exemplo:
      #   printf "  %-4s  %s\n" "$opt" "${HELP[$opt]}"
      #
      # SIGNIFICADO DO FORMATO:
      #
      #   "  "        -> dois espaços iniciais (indentação visual)
      #
      #   %-4s        -> imprime uma string com largura mínima de 4 caracteres
      #                  e alinhada à esquerda:
      #                  - "%"  = início do format specifier
      #                  - "s"  = string
      #                  - "4"  = largura mínima
      #                  - "-"  = alinhado à esquerda (padding à direita)
      #
      #                  Exemplo:
      #                    "-v"  -> "-v  " (preenche com espaços)
      #
      #   %s          -> segunda string (descrição da opção)
      #
      #   \n          -> nova linha
      #
      # RESULTADO:
      #
      #   -v    alternar modo verbose (default TRUE)
      #   -i    ficheiro de input
      #   -o    ficheiro de output
      #
      # BENEFÍCIO:
      #   - mantém colunas alinhadas
      #   - melhora legibilidade
      #   - estilo típico de CLIs (git, kubectl, etc.)
      # ------------------------------------------------------------
      
      printf "  %-4s  %s\n" "$opt" "${HELP[$opt]}"
   done

   echo
}

function f_special_cases {

   # nenhum argumento
   if [[ $# -eq 0 ]]; then

      f_talk; echo "$__name__"
      echo ' > nenhum argumento fornecido. usa `-h` para instrucoes'
      echo

      v_act=false
      return 1
   fi

   # help
   if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "h" ]]; then

      f_help__print_usage

      v_act=false
      return 1
   fi

   return 0
}



function f_long_arguments {

   v_shift=0

   # FLAGS

   if [[ "$1" == "--verbose" ]]; then
      verbose=false
      v_shift=1
      return 0
   fi

   if [[ "$1" == "--force" ]]; then
      force=true
      v_shift=1
      return 0
   fi

   # INLINE

   if [[ "$1" == --input=* ]]; then
      v_input="${1#*=}"
      v_shift=1
      return 0
   fi

   if [[ "$1" == --output=* ]]; then
      output="${1#*=}"
      v_shift=1
      return 0
   fi

   # SEPARADO

   if [[ "$1" == "--input" ]]; then

      if [[ -z "$2" ]]; then
         echo "erro: --input requer ficheiro"
         return 1
      fi

      v_input="$2"
      v_shift=2
      return 0
   fi

   if [[ "$1" == "--output" ]]; then

      if [[ -z "$2" ]]; then
         echo "erro: --output requer ficheiro"
         return 1
      fi

      output="$2"
      v_shift=2
      return 0
   fi

   return 1
}



function f_short_arguments {

   v_shift=0

   # excluir long options
   [[ "$1" != -* || "$1" == --* ]] && return 1

   local short="${1#-}"

   while [[ -n "$short" ]]; do

      local opt="${short:0:1}"
      short="${short:1}"

      # FLAGS

      if [[ "$opt" == "v" ]]; then
         verbose=false

      elif [[ "$opt" == "f" ]]; then
         force=true

      # INPUT

      elif [[ "$opt" == "i" ]]; then

         if [[ -n "$short" ]]; then

            v_input="$short"
            short=""

         else

            if [[ -z "$2" ]]; then
               echo "erro: -i requer ficheiro"
               return 1
            fi

            v_input="$2"
            v_shift=2
            return 0
         fi

      # OUTPUT

      elif [[ "$opt" == "o" ]]; then

         if [[ -n "$short" ]]; then

            output="$short"
            short=""

         else

            if [[ -z "$2" ]]; then
               echo "erro: -o requer ficheiro"
               return 1
            fi

            output="$2"
            v_shift=2
            return 0
         fi

      else
         echo "erro: opção inválida -$opt"
         return 1
      fi
   done

   # apenas o argumento atual foi consumido
   [[ "$v_shift" -eq 0 ]] && v_shift=1

   return 0
}

function f_parser_output {

   # uDev: Verbose and Concat will be 2 Args to manipute:
   #        - Terminal verbose Output
   #        - Temporary file replacement or concatenation 

   f_talk; echo "parse CLI arguments"
           echo
           echo "initial_argc = $initial_argc"
           echo "posicionais  = ${positional[*]}"
           echo
           echo "verbose      = $verbose"
           echo "force        = $force"
           echo "input file   = $v_input"
           echo "output file  = $output"
           echo
}



function f_parse_args {

   # ============================================================
   # DEFAULTS
   # ============================================================

   verbose=true
   force=false
   v_input=""
   output=""
   positional=()

   # ============================================================
   # SPECIAL CASES
   # ============================================================

   f_special_cases "$@" || return

   local initial_argc=$#

   # ============================================================
   # MAIN LOOP
   # ============================================================

   while [[ $# -gt 0 ]]; do

      # LONG OPTIONS
      f_long_arguments "$@" && {
         shift "$v_shift"
         continue
      }

      # SHORT OPTIONS
      f_short_arguments "$@" && {
         shift "$v_shift"
         continue
      }

      # END OF OPTIONS
      if [[ "$1" == "--" ]]; then
         # Exemplos uteis: `mkdir -- --teste`
         #                 `cd -- --teste`

         shift
         break
      fi

      # POSITIONAL
      positional+=("$1")
      shift

   done

   # ============================================================
   # OUTPUT
   # ============================================================

   [[ $verbose == "true" ]] && f_parser_output 
}










function f_validar_args {

   # This fx should only run if actually there were any arguments
      [[ $v_act && "true" ]] && return 0

   f_talk; echo "json-like output"

   echo "{"

   # ==========================================
   # FLAGS BOOLEAN (JSON-like)
   # ==========================================

   echo "  \"verbose\": ${ARGS[verbose]},"
   echo "  \"force\": ${ARGS[force]},"

   # ==========================================
   # STRINGS
   # ==========================================

   if [[ -n "${ARGS[v_input]}" ]]; then
      echo "  \"input\": \"${ARGS[v_input]}\","
   else
      echo "  \"input\": null,"
   fi

   if [[ -n "${ARGS[output]}" ]]; then
      echo "  \"output\": \"${ARGS[output]}\","
   else
      echo "  \"output\": null,"
   fi

   # ==========================================
   # POSITIONAL ARRAY (JSON-like list)
   # ==========================================

   echo "  \"positionals\": ["

   if [[ ${#POSITIONAL[@]} -eq 0 ]]; then
      echo "  ]"

   else
      local i
      for i in "${!POSITIONAL[@]}"; do

         # última vírgula handling simples
         if [[ $i -lt $((${#POSITIONAL[@]} - 1)) ]]; then
            echo "    \"${POSITIONAL[$i]}\","
         else
            echo "    \"${POSITIONAL[$i]}\""
         fi
      done

      echo "  ]"
   fi

   echo "}"
}




echo Fim















# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------


# Depois, os scripts externos tem de executar: 
#     f_greet
#     f_talk; echo "(extended grep)"
#     f_parse_args "$@" 
#     f_validar_args 
