#/bin/bash
# Title: Helper to write notes

function f_edit_with_heteronimos {
   
   # udev: Se repo omni-log nao existir, perguntar se quer download
   echo "Editar notas em omni-log/all/ex-pressa" 
   cd ${v_REPOS_CENTER}/omni-log/all/ex-pressa 
   vim .
}

function f_edit_random_note_no_title {
   v_file=${v_REPOS_CENTER}/omni-log/all/ex-pressa/rn

   v_date=$(date +'%Y-%m-%d %H:%M:%S')
   v_date="Data/Hora $v_date"

   echo                 >> $v_file  # Send one empty line to $v_file
   echo -n "$v_date { " >> $v_file  # Send Date to $v_file
   echo -e "\n\n} "            >> $v_file  # Send one empty line to $v_file

   vim $v_file
}

function f_main_menu {
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='D note'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L5='5. ToDo | Lista de tarefas | `todo`'
      L4='4. Nota | com heteronimos  | `no H`' 

      L3='3. Nota | Nova COM titulo  | `no +`';  L3c="no +"  # uDev: command not ready
      L2='2. Nota | Nova SEM titulo  | `no -`';  L2c="no -"  # uDev: command not ready
      L1='1. Cancel'

      L0="SELECIONE 1 do menu (exemplo): "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "5. " ]] && echo "uDev: 5"
      [[ $v_list =~ "4. " ]] && f_edit_with_heteronimos
      [[ $v_list =~ "3. " ]] && echo "uDev: 3"
      [[ $v_list =~ "2. " ]] && f_edit_random_note_no_title
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}





if [ -z $1 ]; then
   f_main_menu
 
elif [ $1 == "-" ]; then
   f_edit_random_note_no_title
      
else
   echo 'Option not recognized. Tey `no`'
fi

