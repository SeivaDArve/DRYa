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









   
# Variables

   # Internal variable. Some fx will read this var, and decide weather or not to act (run the fx or not)  
      unset v_act  


function f_help__print_usage {

   # Define the variables in an array so that they can be explained in order
      v_arg_help="Mostra esta ajuda (tem de ser arg 1)"  # There are 3 args with this same text

      declare -A HELP
      HELP["h"]=" $v_arg_help"
      HELP["-v"]="ativa modo verbose"
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
      #   -v    modo verbose
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





function f_parse_args {
   # Esta fx apenas lê e filtra todos os argumentos do prompt (um a um) e coloca nas suas variaveis. Nao confirma por exemplo se nomes de ficheiros de entrada existe e se esta correto (porque isso será na fx seguinte)

   echo  # Espacamento inicial, apoio ao f_talk
   
   local verbose=false
   local force=false
   local v_input=""
   local output=""
   local positional=()



   if [[ $# -eq 0 ]]; then
      # Testar ausencia de argumento
     
      echo ' > nenhum argumento fornecido. usa `-h` para instrucoes'
      echo 
      v_act=false

      return 0  # Este 'return' termina TODA a função e devolve sucesso (exit code 0). Ou seja, o proximo 'while' loop nao sera executado
   fi



   if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "h" ]]; then
      # Deteta que foi pedido 'help' e vai imprimir 'usage' 

      f_help__print_usage
      v_act=false

      return 0
   fi



   local initial_argc=$#  # Contar (e guardar) o numero inicial de argumentos

   while [[ $# -gt 0 ]]; do
      # Percorre argumento a argumento

      # ============================================================
      # LONG OPTIONS SUPORTADAS
      #
      # ESTE PARSER ACEITA:
      #
      #   1. FLAGS SIMPLES:
      #      --verbose
      #      --force
      #
      #   2. ARGUMENTO EM PRÓXIMO TOKEN:
      #      --input file.txt
      #      --output file.txt
      #
      #   3. ARGUMENTO INLINE (GNU STYLE):
      #      --input=file.txt
      #      --output=file.txt
      #
      #   4. uDev
      #      --in file.txt
      #      --out file.txt
      #
      #      --in=file.txt
      #      --out=file.txt
      #
      # ============================================================

      if [[ "$1" == "--verbose" ]]; then
         verbose=true
         shift

      elif [[ "$1" == "--force" ]]; then
         force=true
         shift



      # LONG OPTION INLINE ( --input=file.txt )

      elif [[ "$1" == --input=* ]]; then
         # Exemplo: --input=file.txt
         v_input="${1#*=}"
         shift

      elif [[ "$1" == --output=* ]]; then
         # Exemplo: --output=file.txt
         output="${1#*=}"
         shift


      # LONG OPTION SEPARADO

      elif [[ "$1" == "--input" ]]; then
         # Exemplo: --input file.txt
         v_input="$2"
         shift 2

      elif [[ "$1" == "--output" ]]; then
         # Exemplo: --output file.txt
         output="$2"
         shift 2

      #  # ============================================================
      #  # SHORT OPTIONS
      #  #
      #  # ESTE BLOCO DETETA:
      #  #
      #  #   - FLAGS:
      #  #       -v
      #  #       -f
      #  #
      #  #   - AGRUPAMENTO:
      #  #       -vf
      #  #       -vfofile.txt
      #  #
      #  #   - ARGUMENTOS INLINE:
      #  #       -iinput.txt
      #  #       -ooutput.txt
      #  #
      #  #   - ARGUMENTOS SEPARADOS:
      #  #       -i input.txt
      #  #       -o output.txt
      #  #
      #  # REGEX:
      #  #
      #  #   -[!-]?*
      #  #
      #  # SIGNIFICADO:
      #  #
      #  #   -       → começa com hífen
      #  #   [!-]    → segundo char não pode ser "-"
      #  #   ?*      → pelo menos mais um char
      #  #
      #  # EXCLUI:
      #  #   --long-options (evita conflito)
      #  #
      #  # ============================================================
      #
      #  elif [[ "$1" == -[!-]?* ]]; then


      elif [[ "$1" == -* ]] && [[ "$1" != --* ]]; then

         # remove o "-"
         # "-vfofile" → "vfofile"
         short="${1#-}"

         while [[ -n "$short" ]]; do
            # Percorre caractere a caractere

            opt="${short:0:1}"
            short="${short:1}"

            # ------------------------------------------
            # FLAGS SIMPLES
            # ------------------------------------------

            if [[ "$opt" == "v" ]]; then
               verbose=true

            elif [[ "$opt" == "f" ]]; then
               force=true

            # ------------------------------------------
            # INPUT
            #
            # FORMAS ACEITES:
            #
            #   -i input.txt
            #   -iinput.txt
            #
            # ------------------------------------------

            elif [[ "$opt" == "i" ]]; then

               if [[ -n "$short" ]]; then
                  v_input="$short"
                  short=""
               else
                  shift

                  if [[ -z "$1" ]]; then
                     echo "erro: -i requer nome de ficheiro (nem que seja invalido)"
                     return 1
                  fi

                  v_input="$1"
               fi

            # ------------------------------------------
            # OUTPUT
            #
            # FORMAS ACEITES:
            #
            #   -o output.txt
            #   -ooutput.txt
            #
            # ------------------------------------------

            elif [[ "$opt" == "o" ]]; then

               if [[ -n "$short" ]]; then
                  output="$short"
                  short=""
               else
                  shift

                  if [[ -z "$1" ]]; then
                     echo "erro: -o requer nome de ficheiro (nem que seja invalido)"
                     return 1
                  fi

                  output="$1"
               fi

            else
               echo "erro: opção inválida -$opt"
               return 1
            fi
         done

         shift

      # ============================================================
      # FIM DE PARSING com Args
      # ============================================================

      elif [[ "$1" == "--" ]]; then
         shift
         break

         # ============================================================
         # ARGUMENTOS POSICIONAIS
         #
         # SUPORTA:
         #   .
         #   ./ficheiro
         #   qualquer string não-option
         #
         # ============================================================

      else
         positional+=("$1")
         shift
      fi

   done

   # OUTPUT final (sem confirmar se os argumentos sao validos)
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



















# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------


# Depois, os scripts externos tem de executar: 
#     f_greet
#     f_talk; echo "(extended grep)"
#     f_parse_args "$@" 
#     f_validar_args 
