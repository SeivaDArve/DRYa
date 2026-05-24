#!/bin/bash
# Title:       | drya-eGrep (drya extended grep)
# Description: | feed this script with a file name, and A grep search, it will tell the line number
#              | or, feed a .org file name and a header name, this script will print the entire header






# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && source $v_lib1 || (read -s -n 1 -p "DRYa: error: drya-lib-1 does not exist " && echo)

   v_greet="DRYa"
   v_talk="DRYa: eGrep: "

   # Examples: `db` (an fx to use during debug)
   #           f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]



# Sourcing DRYa Lib 2: Creating temporary files for support on scripts
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || (read -s -n 1 -p "DRYa: error: drya-lib-2 does not exist " && echo)

   # Examples: `f_create_tmp_file` (will give a $v_tmp with a new file with abs path)



# Sourcing DRYa Lib 8: Reading/Parsing argumentes from the CLI prompt, then testing if they are valid
   v_lib8=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-8-getopts-parse-n-validate.sh
   [[ -f $v_lib8 ]] && source $v_lib8 || (read -s -n 1 -p "DRYa: error: drya-lib-8 does not exist " && echo)

   # Examples: `D opts -i inFile.txt` and the script will test the input file if it exist or not






# uDev:
#      [ -z $2     ]  # Print todas estas opcoes/help
#
#      [ $2 == g   ]  # Usa `grep` e as pesquisas apresentam o nunero da linha
#                       grep -n <pesquisa> <ficheiro>
#
#      [ $2 == n   ]  # Imprime so a linha numero X correspondente
#                       exemplo: linha 1:
#                       sed -n '1p' <nome-do-ficheiro>
#
#      [ $2 == ^   ]  # Imprime so a linha numero X para cima
#                       sed -n '1,76p' <nome-do-ficheiro>
#
#      [ $2 == v   ]  # Imprime so a linha numero X para baixo
#                       exemplo: linha 5 ate 11:
#                       sed -n '5,$p' <nome-do-ficheiro>
#
#      [ $2 == "nn 5 11" ]  # Imprime desde a linha X a Y
#                             exemplo: linha 5 ate 11:
#                             sed -n '5,11p' <nome-do-ficheiro>
#
#      [ $2 == "gg <pesquisa> <pesquisa> " ]  # Imprime da linha X a Y, mas em vez de alimentar o numero da linha, alimenta 2 pesquisas de texto
#
#      [ $2 == "org <grep-ogr-header>" ]      # Para Emacs, imprime apenas o Header correspondente a pesquisa `grep` dada no arg seguinte 
#
#      [ $2 == "org" "-z $3" ]                # Para Emacs, imprime apenas o Header correspondente a pesquisa `grep` dada no arg seguinte 
#                                               exemplo, pesquisar TODOS os headers:
#                                               grep -n "^\*" <nome-do-ficheiro>
#


    









function f_output_org_mode_header_filtered_by_fzf {

   f_greet
   [[ -z $2 ]] && echo "Esta fx precisa do Arg 2 (ficheiro de entrada)" && exit 1

   v_headr=$(grep "^*" $2 | fzf --tac --cycle)

   [[ -n $v_headr ]] && echo $v_headr || echo "No line was selected"
   unset  v_headr
}

function f_fzf_menu {
   # Para ler partes de documentos (com fzf)

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='D grep'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

     #L19= Ver se 2 ficheiros sao diferentes em alguma parte do texto `diff`
      L18='Arg |   CMD  |  Method   |    Input      |     Task                             |  Output       |'
      L17='----|--------|-----------|---------------|--------------------------------------|---------------|'
      L16='16. | D grep | bash      | `ls | fzf`    | ( corrigir endereco `pwd` do dir   ) | tmp file      |'
     #L15='15. | D grep | bash      | file1 + file2 | ( select random line from file     ) | file1 + file2 |'
      L15='15. | D grep | bash      |  file         | ( select random line from file     ) | tmp file      |'
      L14='14. | D grep | bash      |  file         | ( intervalo de 2 pesquisas   | grep) | tmp file      |'
      L13='13. | D grep | bash      |  file         | ( intervalo de nr linhas     | grep) | tmp file      |'
      L12='12. | D grep | bash      |  file         | ( antes de:    pesquisa      | grep) | tmp file      |'
      L11='11. | D grep | bash      |  file         | ( depois de:   pesquisa      | grep) | tmp file      |'
      L10='10. | D grep | bash      |  file         | ( antes de:    nr linha      | grep) | tmp file      |'
       L9='9.  | D grep | bash      |  file         | ( depois de:   nr linha      | grep) | tmp file      |'
       L8='8.  | D grep | bash      |  file.org     | ( `org-mode headers | fzf`   | grep) | tmp file      |'                                      
       L7='7.  | D grep | bash      |  file.org     | ( org-mode header + menu     | grep) | tmp file      |'                                      
       L6='6.  | D grep | bash      |  file         | ( texto                      | grep) | tmp file      |'
       L5='5.  | D grep | bash      |  file         | ( nr linha                   | grep) | tmp file      |'
       L4='4.  | D grep | vimscript |  file.sh      | ( bash fx                    | grep) | tmp file      |'                                      

      L3='3. Manipular/Selecionar ficheiro de entrada'  # Toggle: Entrada vs. Saida'  # Pode ter uma lista de ficheiros fav;  # Opc: same input file as output and input    
      L2='2. Manipular/Selecionar ficheiro de saida'    # Toggle: Entrada vs. Saida'  # Pode ter uma lista de ficheiros fav;  # Opc: same input file as output and input    
      L1='1. Cancel'

      Lhc1=$1
      Lhc2=$2
      Lh=$(echo -e "\nFicheiro de entrada:\n > $v_input \n\nFicheiro de saida: ( concat:yes ):\n > exemplo 2\n ")
      L0="DRYa-eGrep: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n$L16 \n$L17 \n$L18  \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "3. " ]] && echo "uDev" 
      [[    $v_list =~ "3. " ]] && echo "uDev" 
      [[    $v_list =~ "8. " ]] && f_output_org_mode_header_filtered_by_fzf $*
      [[    $v_list =~ "2. " ]] && f_partial_file_reader_choose_file 
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list
}
























































# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------







f_parse_args "$@"

v_talk="DRYa: eGrep: "
__name__=drya-eGrep
f_talk; read -sn1 -p "[Enter = Menu fzf ] ... "
        echo

f_fzf_menu 
