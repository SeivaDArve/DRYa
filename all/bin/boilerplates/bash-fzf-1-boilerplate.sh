


# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. Opcao c/ Pin'                                       
      L3='3. Opcao c/ fx history';  L3c='<fx-terminal-command>'  # L3c: terminal command to send to history file
      L2='2. Opcao simples'                                      
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --pointer=">" --cycle --prompt="$L0")

   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "4. " ]] && f_pin && echo "uDev: $L4"
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3" && history -s "$L3c" 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2" && sleep 0.1 
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
      
   # uDev: Corrigir a atualizacao do ficheiro que guarda o historico de comandos executados pelo prompt
      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"


