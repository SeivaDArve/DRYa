


# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Saving '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Opcao c/ Pin'                                       
      L3='3. Opcao c/ fx history';  L3c='<fx-terminal-command>'  # L3c: terminal command to send to history file
      L2='2. Opcao simples'                                      
     #L2='2. -- Invert Selection --'
      L1='1. Cancel'

      Lh=$(echo -e "\nInstrucoes multi texto:\n -Aqui")
      L0="SELECT 1: Menu X: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --pointer=">" --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente
      echo "$Lz2" >> $Lz4

   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[ $v_list =~ $Lz3  ]] && echo "Acede ao historico com \`D ...\`"
      [[ $v_list =~ "4. " ]] && f_pin && echo "uDev: $L4"
      [[ $v_list =~ "3. " ]] && echo "$L3c" >> $Lz4 && echo "uDev: $L3" 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2" 
      [[ $v_list =~ "1. " ]] && echo "Canceled" 
      unset v_list




