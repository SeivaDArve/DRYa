#/bin/bash
# Title: Helper to write notes

# Sourcing f_greet, f_greet2, f_talk, f_done, f_prsK, f_Hline, f_horizlina, f_verticline
   v_greet="DRYa"
   v_talk="DRYa: no-tes: "
      source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh

   
# Sourcing f_ensure_repo_existence
      source ${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-4-test-dependencies-1st.sh
   
function f_create_file_and_name {
   v_date=$(date +'%Y-%m-%d---%H-%M-%S')
   v_date="Data-Hora---$v_date)"

   v_tmp_dir=~/.tmp
   v_tmp_file="note-rn-$v_date"

   v_tmp=$v_tmp_dir/$v_tmp_file

   mkdir -p $v_tmp_dir
   touch $v_tmp
   #ls $v_tmp_dir
}

function f_edit_with_heteronimos {
   
   # udev: Se repo omni-log nao existir, perguntar se quer download

   v_place=${v_REPOS_CENTER}/omni-log/all/ex-pressa
   v_file=$(ls ${v_REPOS_CENTER}/omni-log/all/ex-pressa | fzf)
   f_talk; echo "Notas em: .../omni-log/all/ex-pressa" 

   [[ -n $v_file ]] && vim $v_place/$v_file
}

function f_edit_ToDo_note_no_title {
   # Edit ToDo list
   vim ${v_REPOS_CENTER}/omni-log/all/ex-pressa/td
}

function f_vars_edit_random_note_no_title {
   v_repo_name="omni-log"
   v_repo=${v_REPOS_CENTER}/$v_repo_name
   v_file=$v_repo/all/ex-pressa/rn
}

function f_edit_random_note_no_title {
   # Creating new random note as tmp file, then sending to omni-log

   # Defining what file to use
      f_vars_edit_random_note_no_title

   # Ensuring omni-log is installed (using drya-lib-4)
      unset v_green_light  # var given after drya-lib-4 that tells this main script either to proceed or not
      v_ensure="omni-log"
      f_ensure_repo_existence

   f_create_file_and_name

   function f_edit_temporary_file {
      # If drya-lib-4 returns green light that repo existence is fixed, proceed

      echo -ne "$v_date { \n" >> $v_tmp  
      vim $v_tmp

      echo          >> $v_file \
      && cat $v_tmp >> $v_file \
      && echo "}"   >> $v_file \
      && f_talk                \
      && echo "note added to file 'rn'"  \
      && echo " > uDev: sync omni-log automatically"
   }

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

function f_main_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D note'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      #L80= Share Trascrypt from termux (copy paste entire termux output)

      #L7='7. Script | Upload to omni-log | `no ^`

      L8='8. script | notify.sh         | `notify`' 

      L7='7. Info   | com het. random   | `no x <txt no terminal>`' 
      L6='6. Nota   | com heteronimos   | `no H`' 

      L5='5. ToDo   | Lista de tarefas  | `no td`'
      L4='4. Nota   | sync one-file-bau | `no ++ <nr>`';  # Sync 1 file with ezGIT --trigger (only 1 person can edit at a time)

      L3='3. Nota   | Nova COM titulo   | `no +`';  L3c="no +"  # uDev: command not ready
      L2='2. Nota   | Nova SEM titulo   | `no -`';  L2c="no -"  # uDev: command not ready
      L1='1. Cancel'

      L0="SELECIONE 1 do menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n\n$L6 \n$L7 \n\n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "8. " ]] && bash ${v_REPOS_CENTER}/DRYa/all/bin/notify.sh
      [[ $v_list =~ "7. " ]] && f_talk && echo 'You may use text directly on the terminal that goes directly to 'rn' notes using the command `no x <text here>`'
      [[ $v_list =~ "6. " ]] && f_edit_with_heteronimos
      [[ $v_list =~ "5. " ]] && f_edit_ToDo_note_no_title
      [[ $v_list =~ "4. " ]] && f_one_file_bau
      [[ $v_list =~ "3. " ]] && echo
      [[ $v_list =~ "2. " ]] && f_edit_random_note_no_title
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}





if [ -z $1 ]; then
   f_main_menu
 
elif [ $1 == "-" ]; then
   if [ -z $2 ]; then
      f_edit_random_note_no_title

   elif [ $2 == "." ]; then
      # Getting file name
         f_vars_edit_random_note_no_title

      # Ensuring omni-log is installed (using drya-lib-4)
         v_ensure="omni-log"
         f_ensure_repo_existence
         vim $v_file
   fi
      
elif [ $1 == "a" ]; then
   # Create notes with terminal arguments
   echo "uDev"
   shift # Remove 1st argument from the arguments list
   echo $*

elif [ $1 == "H" ]; then
   f_edit_with_heteronimos

elif [ $1 == "td" ] || [ $1 == "t" ]; then
   # Edit ToDo list
   f_edit_ToDo_note_no_title

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
else
   echo 'Option not recognized. Tey `no`'
fi

