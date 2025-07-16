#!/bin/bash
# Title: drya-lib-6-flash-buffer
# Description: Abrir temporariamente uma buffer com mensagens de DRYa (em buffer a parte, tal como o `vim` faz)

# uDev: Alternativa para buffers com `tput`: Iniciar o terminal sempre com `tmux` e usar os paineis como buffers. Existe sempre a opcao deles serem temporizados para se apagarem automaticamente

# Entra no buffer alternativo
   tput smcup

# Move para o canto superior esquerdo
   tput cup 0 0

v_talk="DRYa: buffer: "

# Apresentacao
   [[ -z $v_fig ]] && v_fig="INFO"
   
   figlet $v_fig

# Explicar ao user o que se passa
   echo "$v_talk Mensagem Temporaria (buffer) "

# Texto a apresentar
   [[ -z $v_txt ]] && v_txt="Qual é a info que quer apresentar?? "

   echo
   echo $v_txt
   echo 

# Aguarda 5 segundos
   #tput cr → move o cursor para o início da linha.
   #tput el → limpa da posição atual até o fim da linha.
   #tput cuu1 move o cursor 1 linha para cima
   #echo -n → imprime sem pular linha.

   tput cr #→ move o cursor para o início da linha.
   tput el #→ limpa da posição atual até o fim da linha.
   #echo -n    "$v_talk Pressione ENTER (.  )  "; read
   read -s -p    "$v_talk Pressione ENTER (.  )  " v_ans
   echo "$v_ans"
   read
   tput cuu1

   tput cr #→ move o cursor para o início da linha.
   tput el #→ limpa da posição atual até o fim da linha.
   #echo -n    "$v_talk Pressione ENTER (.. )  "; read
   read -s -p    "$v_talk Pressione ENTER (.. )  "
   tput cuu1

   tput cr #→ move o cursor para o início da linha.
   tput el #→ limpa da posição atual até o fim da linha.
   read -s -p    "$v_talk Pressione ENTER (...)  "
   tput cuu1

   # Opcional: move para a próxima linha depois
   echo


# Sai do buffer alternativo, restaurando a tela anterior
   tput rmcup
