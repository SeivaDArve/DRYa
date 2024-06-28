# Lista de opções para o menu `fzf` (com loop)
   while true
   do
      # Texto do menu
         v_list=$(echo -e "1. ca-lculator-reg.sh \n2. unit-converter.sh \n3. Cambios \n4. Sair" | fzf -m --prompt="SELECIONE 1 calculladora: ")
      

      # Quando o menu é de Escolha multipla tipo `for` loop
         [[ $v_list =~ "1." ]] && echo "Debug" && ${v_REPOS_CENTER}/DRYa/all/bin/calculadoras/ca-lculator-reg.sh
         [[ $v_list =~ "2." ]] && echo "Debug" && ${v_REPOS_CENTER}/DRYa/all/bin/calculadoras/unit-converter.sh
         [[ $v_list =~ "3." ]] && echo "Debug"
         [[ $v_list =~ "4." ]] && echo "Debug break" && break
         [[ $v_list =~ "5." ]] && echo "Debug"
         [[ $v_list =~ "6." ]] && echo "Debug"
         [[ $v_list =~ "7." ]] && echo "Debug"
         [[ $v_list =~ "8." ]] && echo "Debug"
         unset v_list             # Reset à Variavel

   done
