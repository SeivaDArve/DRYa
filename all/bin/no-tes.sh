#/bin/bash
# Title: Helper to write notes

function f_create_file_and_name {
   v_date=$(date +'%Y-%m-%d---%H-%M-%S')
   v_date="Data-Hora---$v_date)"

   v_tmp_dir=~/.tmp
   v_tmp_file="note-rn-$v_date"

   v_tmp=$v_tmp_dir/$v_tmp_file

   mkdir -p $v_tmp_dir
   touch $v_tmp
   ls $v_tmp_dir
}

function f_edit_with_heteronimos {
   
   # udev: Se repo omni-log nao existir, perguntar se quer download

   v_place=${v_REPOS_CENTER}/omni-log/all/ex-pressa 
   echo "Editar notas em .../omni-log/all/ex-pressa" 

   cd $v_place
   vim .
}

function f_edit_random_note_no_title {
   v_file=${v_REPOS_CENTER}/omni-log/all/ex-pressa/rn

   f_create_file_and_name

   echo -ne "$v_date { \n" >> $v_tmp  
   vim $v_tmp

   echo          >> $v_file \
   && cat $v_tmp >> $v_file \
   && echo "}"      >> $v_file \
   && echo "DRYa: no-tes: note added to 'rn'"  \
   && echo " > uDev: sync omni-log automatically"
}

function f_main_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D note'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      #L80= Share Trascrypt from termux (copy paste entire termux output)
      L6='6. ToDo | Lista de tarefas | `todo`'
      L5='5. Nota | com heteronimos  | `no H`' 

      L4='4. Nota | sync COM titulo  | `no ++`';  # Sync 1 file with ezGIT --trigger (only 1 person can edit at a time)

      L3='3. Nota | Nova COM titulo  | `no +`';  L3c="no +"  # uDev: command not ready
      L2='2. Nota | Nova SEM titulo  | `no -`';  L2c="no -"  # uDev: command not ready
      L1='1. Cancel'

      L0="SELECIONE 1 do menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n\n$L5 \n$L6\n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "6. " ]] && echo "uDev: 6"
      [[ $v_list =~ "5. " ]] && f_edit_with_heteronimos
      [[ $v_list =~ "4. " ]] && echo "uDev: 4"
      [[ $v_list =~ "3. " ]] && echo "uDev: 3"
      [[ $v_list =~ "2. " ]] && f_edit_random_note_no_title
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}





if [ -z $1 ]; then
   f_main_menu
 
elif [ $1 == "-" ]; then
   f_edit_random_note_no_title
      
elif [ $1 == "H" ]; then
   f_edit_with_heteronimos

else
   echo 'Option not recognized. Tey `no`'
fi

