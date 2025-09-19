









# [fzf menu exemplo 1]
   # Menu Simples
   
   # Note: Variable $v_fzf_talk for script name. Is a varible that should be set on the beginning of any script that wants to run this fzf boilerplate. This helps a lot when developing, because in any working script, when adding a new menu, it already brings the Script Name in $v_fzf_talk and prevents dev repetition
   # Note: `--layout=reverse-list` : ...
   # Note: `--reverse`             : ...
   # Note: `--cycle`               : ...
   # Note: `--pointer=">" -m`      : combinar 2 comandos. Sempre que o menu for de escolha multipla, usa o caractere ">" cmoo ponteiro.
   # Note: `--no-info`             : significa ocultar a info de quantos resultados encontrou. (Exemplo: "14/200" quando encontra 200 itens e o cursor esta na linha 14)
   # Note: `--header="Text here" 
   # Note: `--tac" 
   # Note: `--wrap"                : Para quando as linhas sao demasiado longas e nao cabem no ecra

   # uDev: testar --history=HISTORY_FILE
   # uDev: fx/lib para o  ---Invert Selection---'
   # uDev: criar em drya-lib-2:      "Tracking: `command`  [ENTER = Previous menu]"

   # uDev: criar opcoes de cor ANSI. 
   #       Exemplo do GPT: `echo -e "normal\n\033[31mvermelho\033[0m" | fzf --ansi`
   #
   #       Exemplo de backspace 1: `echo -e "Texto \bArvore"` output: "TextoArvore"
   #
   #       Exemplo de backspace 2: v_backspace=$'\b'
   #                               v="Texto ${v_backspace}Arvore"
   #                               echo -e "$v"
   #                               Output: "TextoArvore"
   #

   # Opcional: Buscar valores externos para usar variaveis neste menu
   #    f_example_busca_L6b; echo "$Lb6"

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6="6. Opcao com variavel externa | $L6b" # Variable L6b may be set and may be empty to give more info to the user
      L5='5. Opcao com Pin'                                       
      L5='5. Opcao com fx history (na fx)'                                       
      L3='3. Opcao com fx history (no proprio menu)';  L3c='<fx-terminal-command>'  # L3c: terminal command to send to history file
      L2='2. Opcao simples'                                      
     #L2='2. ---Invert Selection---'
      L1='1. Cancel'

      Lh=$(echo -e "\nInstrucoes multi texto:\n -Aqui\n ")
      L0="$v_fzf_talk: SELECT 1: Menu X: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --header="$Lh" --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atualizar historico fzf (texto em cada fx)
   #
   #  funtion f_example { 
   #     # Atualizar historico fzf (inserir esta fx):
   #        echo "D command" >> $Lz4  # Segundo a opcao 4
   #        echo "$L3c" >> $Lz4       # Segundo a opcao 3 
   #  }

   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "6. " ]] && echo "uDev: $L6" 
      [[    $v_list =~ "5. " ]] && f_pin && echo "uDev"
      [[    $v_list =~ "4. " ]] && f_example
      [[    $v_list =~ "3. " ]] && echo "$L3c" >> $Lz4 && echo "uDev" 
      [[    $v_list =~ "2. " ]] && echo "uDev: $L2" 
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list








