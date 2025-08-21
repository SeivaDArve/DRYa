#/bin/bash
# Title: no-tes.sh
# Description: Helper to write notes


# Sourcing DRYa Lib 1: Color schemes, f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
   source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   v_greet="DRYa"
   v_talk="DRYa: no-tes: "



# Sourcing DRYa Lib 2: Create temporary files
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || read -s -n 1 -p "Error: drya-lib-2 does not exist"

   # Example: f_create_tmp_file will create a temporary file stored at $v_tmp (with abs path, at ~/.tmp/...)



# Sourcing DRYa Lib 4: Ensure package, updates, downloads, uploads
   v_lib4=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-dependencies-packages-git.sh
   [[ -f $v_lib4 ]] && source $v_lib4 || (read -s -n 1 -p "DRYa: error: drya-lib-4 does not exist " && echo)

   # Examples: v_ensure="<example-name-of-repo-to-ensure-existence>" && f_lib4_ensure_repo_existence
   #           f_stroken
  





function f_define_files_as_vars {

   # Default Storage Repository (for log files)
      v_df_repo="omni-log"
      v_df_repo_pwd=${v_REPOS_CENTER}/$v_df_repo

   # Default text editor (Using traitsID.sh to define the default text editor)
      v_default_editor=vim  

   # Directory of all Heteronimos
      v_dir_expressa=$v_df_repo_pwd/all/ex-pressa

   # File 'random' = 'rn'
      v_file_rn=$v_dir_expressa/rn

   # File 'ToDo'
      v_file_td=${v_REPOS_CENTER}/omni-log/all/ex-pressa/td
   

}

function f_create_tmp_file_with_date_as_name {
   # Get current day and hour; Create a tmp file with it
   # udev: drya-lib-2 already has a similar fx, this one could be removed

   # Get date values
      v_date=$(date +'%Y-%m-%d---%H-%M-%S')

      # To date values, add Prefix
         v_date="note-rn-Data-Hora---$v_date)"

   # Defining a dir to save many files like this
      v_dir=~/.tmp
      mkdir -p $v_dir

   # Defining final file (already mentioning dir)
      v_tmp=$v_dir/$v_date

   touch $v_tmp
}
   
function f_edit_with_heteronimos {
   
   # Menu that allows user to choose an Heteronimo file to edit
      v_file=$(ls $v_dir_expressa | fzf --prompt="no-tes: Edit 1 file with Heteronimo: ")

   # If any file was choosen, edit such file
      [[ -n $v_file ]] && vim $v_dir_expressa/$v_file
}

function f_edit_temporary_file {
   # If drya-lib-4 returns green light that repo existence is fixed, proceed

   echo -ne "$v_date { \n" >> $v_tmp  
   vim $v_tmp

   echo          >> $v_file_rn \
   && cat $v_tmp >> $v_file_rn \
   && echo "}"   >> $v_file_rn \
   && f_talk                \
   && echo "note added to file 'rn'"  \
   && echo " > uDev: sync omni-log automatically"
}

function f_edit_random_note_no_title {
   # Creating new random note as tmp file, then sending to omni-log
   # File to use: $v_file_rn

   # Ensuring omni-log is installed (using drya-lib-4)
      f_ensure_omni_log

   # Create temporary file at ~/.tmp/<date-as-name>
      f_create_tmp_file_with_date_as_name

   # If drya-lib-4 returns green light that repo existence is fixed, proceed
      [[ $v_green_light == 0 ]] && f_edit_temporary_file
      [[ $v_green_light == 1 ]] && echo "Could not proceed, no green light from drya-lib-4"
      
   # uDev: After sync the repo with new info, ask if user wants to delete repo again
}

function f_one_file_bau {
   # Edita e sincroniza notas em um repo especifico à parte

   v_repo=oneFile-bau
   v_file1=nota_1/nota  # Dentro da repo, existe 1 pasta para cada ficheiro
   v_file2=nota_2/nota  # Dentro da repo, existe 1 pasta para cada ficheiro
   v_file3=nota_3/nota  # Dentro da repo, existe 1 pasta para cada ficheiro

   # Test repo existence
      if [[ ! -d $v_REPOS_CENTER/$v_repo ]]; then
         echo "Sync ono-file-bau: repo does not exist" \
            && v_err=1

         bash ${v_REPOS_CENTER}/DRYa/drya.sh clone try $v_repo \
            && v_err=0
      fi

      if [[ -d $v_REPOS_CENTER/$v_repo ]]; then
         echo "Sync ono-file-bau: repo exists"
         v_err=0
      fi

      [[ $v_err == "1" ]] && exit 1

   # A variavel $v_err vai ser igual a zero caso a repi ja exista ou caso a repo seja clonada, apos isso, o ficheiro pode ser usado
      if [[ $v_err == 0 ]]; then
         echo "esta pronto para editar"
      fi
}

function f_run_notify_script {
   # Runs/Executes external script 'notify.sh'
   bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh
}

function f_main_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D note'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      #L80= Share Trascrypt from termux (copy paste entire termux output)

      #L7='7. Edit   | drya::wam (wordly abreviated messages) | `no wam`  # Ficheiro de texto (do estilo dicionario) que guarda um par de "key, value" cujo conteudo sao frases. No mundo real, podem ser encontradas frases com  texto "drya::wam:01" que corresponde ao "key". O valor dessa expressao "value" é guardada so online, e informa o que essa expressao abreviada quer dizer.  # uDev: mencionar e permitir que na repo "3sab" exista este software na repo DRYa que guarda texto na repo omni-log
      #L7='7. Script | Upload to omni-log | `no ^`

      L9='9. script | notify.sh         | `no f` or `notify`' 

      L8='8. Info   | com het. random   | `no x <txt no terminal>`' 
      L7='7. Nota   | com heteronimos   | `no H`' 

      L6='6. ToDo   | Lista de tarefas  | `no td e`'
      L5='5. ToDo   | Lista de tarefas  | `no td`'

      L4='4. Nota   | sync one-file-bau | `no ++ <nr>`';  # Sync 1 file with ezGIT --trigger (only 1 person can edit at a time)

      L3='3. Nota   | Nova COM titulo   | `no +`';  L3c="no +"  # uDev: command not ready
      L2='2. Nota   | Nova SEM titulo   | `no -`';  L2c="no -"  # uDev: command not ready
      L1='1. Cancel'

      L0="DRYa: no-tes: main menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n\n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$L9 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "9. " ]] && f_run_notify_script 
      [[ $v_list =~ "8. " ]] && f_talk && echo 'You may use text directly on the terminal that goes directly to 'rn' notes using the command `no x <text here>`'
      [[ $v_list =~ "7. " ]] && f_edit_with_heteronimos
      [[ $v_list =~ "6. " ]] && f_ensure_omni_log && emacs ${v_REPOS_CENTER}/omni-log/all/ex-pressa/td
      [[ $v_list =~ "5. " ]] && f_ensure_omni_log && vim   ${v_REPOS_CENTER}/omni-log/all/ex-pressa/td
      [[ $v_list =~ "4. " ]] && f_one_file_bau
      [[ $v_list =~ "3. " ]] && echo
      [[ $v_list =~ "2. " ]] && f_edit_random_note_no_title
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}




f_define_files_as_vars
f_greet 

if [ -z $1 ]; then
   f_talk; echo "Opening main menu"
           echo

   f_main_menu
 
elif [ $1 == "H" ]; then
   # Notas de cada Heteronimo

   f_talk; echo "Opening Heteronimos"
           echo

   # Using drya-lib-4 to ensure omni-log exists and is updated
      f_ensure_omni_log

   # Verbose notification
      f_talk; echo "Notas em: .../omni-log/all/ex-pressa/" 

   if [ -z $2 ]; then
      # Usar `vim` como menu para escolher qual ficheiro editar
      f_edit_with_heteronimos

   elif [ $2 == "dr" ]; then
      # Editar heteronimo Darve
      vim $v_dir_expressa/dr
   else
      shift  # Serve para remover o primeiro arg `H` e manter todos os restantes
      echo
      f_talk; echo "Esses heteronimos nao existem: $*"
   fi

elif [ $1 == "-" ]; then
   if [ -z $2 ]; then
      f_edit_random_note_no_title

   elif [ $2 == "." ]; then
      # Edit file 'rn' with vim

      # Ensuring omni-log is installed (using drya-lib-4)
         # uDev: para o verbose output falta: mencionar que vem do script: `no - .`
         f_ensure_omni_log
         f_lib4_git_pull
         vim $v_file_rn
         f_lib4_git_add_all
         f_lib4_git_commit
         f_lib4_git_push
   fi
      
elif [ $1 == "td" ] || [ $1 == "t" ]; then
   # Edit file: "To Do list"
   # --- File to be edited: $v_file_td (variable set at the top of this script)
   # --- Alias also defined as `td` in 'source-all-drya-files'

   # uDev: join "toDo" from: moedaz (alias on source-all-drya-files), omni-log.org (inside file itself), td, from no-tes.sh (that writes on Heteronimos, inside omni-log)

   
   # Ensuring omni-log with drya-lib-4
      # uDev: para o verbose output falta: mencionar que vem do script: `no - .`
      v_ensure="$v_df_repo" && f_lib4_download_compact

   if [ -z $2 ]; then
      # If no arg are given

      # Choose either DEFAULT text editor (usually vim) or the text editor choosen by `e` 
         #eval "$v_default_editor $v_file_td" 
         bash e $v_file_td 

   elif [ $2 == "emacs" ] || [ $2 == "e" ]; then
      emacs $v_file_td

   elif [ $2 == "vim" ] || [ $2 == "v" ]; then
      emacs $v_file_td
   fi
      
   f_lib4_upload_compact

elif [ $1 == "unique-nt" ] || [ $1 == "u" ]; then
   # Cria uma nota nova em um ficheiro novo (na pasta .../omni-log/all/ex-pressa/unique-nt/<nota-nova>
   echo "uDev: Buscar a drya-lib que cria ficheiros temporarios e usar escrver a nota nova, no fim, guardar"

elif [ $1 == "x" ]; then
   # Save all arguments as the note itself, directly from the terminal and without any text editor

   # Exclude argument 1
      shift

   v_text=$*
   f_talk; echo "Text sent to file 'rn':"
   echo "$v_text"

elif [ $1 == "^" ]; then
   echo "uDev: Upload to omni-log"

elif [ $1 == "rn" ]; then
   vim ${v_REPOS_CENTER}/omni-log/all/ex-pressa/rn

elif [ $1 == "notify" ] || [ $1 == "f" ]; then
   # Runs/Executes external script 'notify.sh'
   f_run_notify_script 

else
   f_talk; echo 'Option not recognized. try `no`'
fi

