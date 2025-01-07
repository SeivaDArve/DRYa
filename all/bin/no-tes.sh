#/bin/bash
# Title: Helper to write notes

function f_edit_with_heteronimos {
   
   # udev: Se repo omni-log nao existir, perguntar se quer download
   echo "Editar notas em omni-log/all/ex-pressa" 
   cd ${v_REPOS_CENTER}/omni-log/all/ex-pressa 
   vim .
}

# Lista de opcoes para o menu `fzf`
   Lz1='Save '; Lz2='D note'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

   L4='4. Usar heteronimos' 

   L3='3. Nova Nota (com titulo)'                                      
   L2='2. Nova Nota (sem titulo)'                                      
   L1='1. Cancel'

   L0="SELECIONE 1 do menu (exemplo): "
   
   v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   #echo "comando" >> ~/.bash_history && history -n
   #history -s "echo 'Olá, mundo!'"

# Perceber qual foi a escolha da lista
   [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
   [[ $v_list =~ "4. " ]] && f_edit_with_heteronimos
   [[ $v_list =~ "3. " ]] && echo "uDev: 3"
   [[ $v_list =~ "2. " ]] && echo "uDev: 2"
   [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
   unset v_list
 
