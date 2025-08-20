#!/bin/bash
# Title: Partial file Reader
# Description: feed this script with a file name, and A grep search, it will tell the line number
#              or, feed a .org file name and a header name, this script will print the entire header


# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && source $v_lib1 || (read -s -n 1 -p "DRYa: error: drya-lib-1 does not exist " && echo)

   v_greet="DRYa"
   v_talk="DRYa: "

   # Examples: `db` (an fx to use during debug)
   #           f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]

# Sourcing DRYa Lib 2: Creating temporary files for support on scripts
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || (read -s -n 1 -p "DRYa: error: drya-lib-2 does not exist " && echo)

   # Examples: `f_create_tmp_file` (will give a $v_tmp with a new file with abs path)




function f_partial_file_reader_get_file_name {
   Lhc2=$(head -n 1 $v_tmp)

   [[ -z $Lhc2 ]] && Lhc2="[none]"

}

function f_partial_file_reader_choose_file {
   f_create_tmp_file 
}

function f_partial_file_reader {
   # Para ler partes de documentos (com fzf)

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


   # ------------------------------
    

   # Buscar variavel `Lhc` para usar em `Lh`
      f_partial_file_reader_choose_file 
      f_partial_file_reader_get_file_name 

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='D grep'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L18='    |   CMD  |   arg     |    input    |     task                             |  output  |'
      L17='----|--------|-----------|-------------|--------------------------------------|----------|'
      L16='16. | D grep | bash      | `ls | fzf`  | ( corrigir endereco `pwd` do dir   ) | tmp file |'
      L15='15. | D grep | bash      |  file       | ( select random line from file     ) | tmp file |'
      L14='14. | D grep | bash      |  file       | ( intervalo de 2 pesquisas   | grep) | tmp file |'
      L13='13. | D grep | bash      |  file       | ( intervalo de nr linhas     | grep) | tmp file |'
      L12='12. | D grep | bash      |  file       | ( antes de:    pesquisa      | grep) | tmp file |'
      L11='11. | D grep | bash      |  file       | ( depois de:   pesquisa      | grep) | tmp file |'
      L10='10. | D grep | bash      |  file       | ( antes de:    nr linha      | grep) | tmp file |'
       L9='9.  | D grep | bash      |  file       | ( depois de:   nr linha      | grep) | tmp file |'
       L8='8.  | D grep | bash      |  file.org   | ( `org-mode headers | fzf`   | grep) | tmp file |'                                      
       L7='7.  | D grep | bash      |  file.org   | ( org-mode header + menu     | grep) | tmp file |'                                      
       L6='6.  | D grep | bash      |  file       | ( texto                      | grep) | tmp file |'
       L5='5.  | D grep | bash      |  file       | ( nr linha                   | grep) | tmp file |'
       L4='4.  | D grep | vimscript |  file.sh    | ( bash fx                    | grep) | tmp file |'                                      

      L3='3. Manipular/Selecionar ficheiro de entrada'  # Toggle: Entrada vs. Saida'  # Pode ter uma lista de ficheiros fav; 
      L2='2. Manipular/Selecionar ficheiro de saida'    # Toggle: Entrada vs. Saida'  # Pode ter uma lista de ficheiros fav; 
      L1='1. Cancel'

      Lhc1=$1
      Lhc2=$2
     #Lhc1 existe na fx: ...  (para ficheiro de entrada)
     #Lhc2 existe na fx: ...  (para ficheiro de saida)
      Lh=$(echo -e "\nFicheiro de entrada:\n > $Lhc2\n\nFicheiro de saida: ( concat:yes ):\n > $Lhc1\n ")
      L0="DRYa: Menu grep: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n$L7 \n$L8 \n$L9 \n$L10 \n$L11 \n$L12 \n$L13 \n$L14 \n$L15 \n$L16 \n$L17 \n$L18  \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "3. " ]] && echo "uDev" 
      [[    $v_list =~ "3. " ]] && echo "uDev" 
      [[    $v_list =~ "8. " ]] && echo "hit: $1" && grep "^*" $1 | fzf
      [[    $v_list =~ "2. " ]] && f_partial_file_reader_choose_file 
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list
}

v_secs=10
echo "DRYa: partial-file-reader: (ENTER or wait $v_secs sec):"
echo " > All args: $@"
echo
echo " > Assuming: \$1: Input  File: $1"
echo " > Assuming: \$2: Output File: $2"
read -sn1 -t $v_secs

f_partial_file_reader "$@"

