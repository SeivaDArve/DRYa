#/bin/bash
# Title: drya-zip-unzip
# Description: wrapper for zip commands (with drya syntax)
# Use:

# Usefull variables:
   __name__="drya-zip-unzip.sh"                     # Used to describe the name of current file with extention. Example: .exe .jpg .mp3
   __repo__="${v_REPOS_CENTER}/DRYa"  # Used to describe the name of current repo, the repository that contains __name__
   v_ftf_talk="drya-zp: "                 # Used to better present text at `fzf` menus in the prompt area


# Sourcing DRYa Lib 1: Color schemes
   __name__="example-to-change"  # Change to the name of the script. Example: DRYa.sh, ezGIT.sh, Patuscas.sh (Set this variable at the head of the file, next to title)
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/libs/drya-lib-1-colors-greets.sh
   source $v_lib1 2>/dev/null || (read -s -n 1 -p "DRYa libs: $__name__: drya-lib-1 does not exist (error)" && echo )

   # Examples: f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]
      v_greet="DRYa"
      v_talk="DRYa-zp: "


# uDev: aprender bruteforce para unzip: https://www.instagram.com/reel/DJfFjNpuvwW/?igsh=YTA3eDVuYTc2cmFt
#                                       https://www.instagram.com/reel/DHzW9hboyfH/?igsh=dWgyMnRnZWE4bGJo




function f_help {
   echo '
Argumentos `tar` (compactar + descompactar)
   -x (eXtract) é para extrair os dados do arquivo .tar.gz (usado apenas para descompactar).
   -c (Create) é para criar um arquivo tar (usado apenas para compactar).
   -z (gZip) é para manipular o arquivo .tar.gz em GZip.
   -v (Verbose) é para mostrar os arquivos conforme o tar os manipula. Quando estiver em uma conexão SSH lenta, você pode retirar este comando para não receber a lista completa de arquivos que foram compactados/descompactados.
   -f (File) é para definir que estamos trabalhando com arquivos, e não com uma fita ou outro dispositivo.

   Compactar:    `tar -czvf <novo-arquivo-de-saida.tar.gz> <pasta-de-entrada>`
   Descompactar: `tar -xzvf <arquivo-a-extrair.tar.gz>`

   `tar` so arquiva; 
   -z `gz`    compactar em .gz
   -j `bzip2` compactar em 
   -J `xz`    compactar em 







Comandos linux para pesquisar texto dentro de ficheiros compactados

   Tipo de ficheiro	| Comando correspondente
   ------------------|------------------------
   .gz	            | zgrep
   .bz2	            | bzgrep
   .xz	            | xzgrep
   .lzma	            | lzgrep
   .zst	            | zstdgrep
   .zip	            | zipgrep




Para descompactar .rar
   Tem de se intalar `unrar`
   `unrar x <arquivo-a-descompactar.rar> `
   `unrar x <arquivo-a-descompactar.rar> /caminho/de/destino/especifico`
   '
}

function f_about_possible_compression_dependencies {
   f_greet
   echo '
   Lista de pacotes disponiveis para compactar e descompactar ficheiros







   1. TAR, GZIP, BZIP2, XZ (nativos do Linux). Esses geralmente já vêm instalados por padrão.

   Se precisar garantir:
      sudo apt install tar gzip bzip2 xz-utils

   | .tar     | empacotador (não comprime)
   | .tar.gz  | usa gzip
   | .tar.bz2 | usa bzip2
   | .tar.xz  | usa xz






   2. ZIP (Dois pacotes a instalar, Ambos são open-source e amplamente compatíveis com Windows/macOS.)

   Se precisar garantir:
      sudo apt install zip unzip

   | zip   | cria arquivos .zip
   | unzip | extrai .zip







   3. RAR (Dois pacotes, um nao é FOSS. O outro que é FOSS so vai ate a versao 5)
   Se precisar garantir:
      sudo apt install unrar

   ou, se quiser uma alternativa livre:
      sudo apt install unar


   | unrar | extrai .rar (proprietário, leitura apenas)
   | rar   | cria .rar (também proprietário, pode baixar do site da RARLAB)
   | unar  | leitura livre, suporta RAR5+








   4. 7-Zip (.7z) Altamente recomendado no Linux: taxa de compressão excelente e software livre.

   Se precisar garantir:
      sudo apt install p7zip-full

   | 7z | cria e extrai .7z, .zip, .tar, etc.









   5. DAR (.dar) Pouco usado, mas poderoso para backups.

   Se precisar garantir:
      sudo apt install dar

   | dar | cria/extrai .dar









   6. Outros formatos úteis
      | Formato           | Pacote              | Comando
      ---------------------------------------------------------
      | .xz	              | xz-utils            | xz, unxz
      | .bz2              | bzip2               | bzip2, bunzip2
      | .lzma             | lzma                | lzma, unlzma
      | .zst  (Zstandard) | zstd                | zstd, unzstd
      | .iso	           | p7zip-full ou mount | 7z x arquivo.iso ou mount -o loop
   '
}

function f_test_existent_compression_dependencies {



   # uDev: passar isto para DRYa pre-requisitos

   # ===========================================
   # 🧩 Verificador de ferramentas de compactação e criptografia
   # ===========================================

   # Lista de comandos a verificar
   comandos=(
     tar
     gzip
     bzip2
     xz
     zip
     unzip
     rar
     unrar
     7z
     #dar
     gpg
     #unar
     #atool
     #zstd
   )

   f_talk; echo "Verificando comandos instalados no sistema..."
           echo "            (Compactacao e Criptografia)"
           echo 

   # Loop pelos comandos
      n=0  # Variavel que conta o numero de loops

      for cmd in "${comandos[@]}"
      do
         ((n++))           # Adiciona +1 a variavel n   # Opcao alternativa: `((n += 1))`
         #echo -n "(${n}) "  # Adiciona no Verbose/Output o numero do loop sem quebra de linha. Este numero fica in-line com o `if then else` que se segue

         if command -v "$cmd" &> /dev/null; then
            echo "✅ ($n) $cmd    encontrado em: $(command -v "$cmd")"
         else
            echo "❌ ($n) $cmd    não encontrado — instale com: sudo apt install $cmd"
         fi
      done


}

function f_ls {
   # Usa simplesmente o comando `ls` para facilitar o autocomplete nos momentos em que algum menu pede um nome de um ficheiro de entrada

   f_hzl
   f_talk; echo "Comando \`ls\` para facilitar:" 
   echo
   ls -pA
   f_hzl
}

function f_zip {
   # tar é o nome do pacote a instalar

   #tar -czf arquivo.tar.gz nome_da_pasta/
   #     `-c` create  (cria um novo arquivo tar)
   #     `-z` gzip    (comprime usando gzip, gerando .tar.gz)
   #     `-f` file    (indica o nome do arquivo de saída)
   #     `-v` verbose (mostra cada ficheiro extraido)

   f_greet
   f_talk; echo "uDev: zip"   
   f_hzl
   f_test_existent_compression_dependencies 

   # Escolha do formato
      f_hzl
      f_talk; echo "Escolha qual formato para 'Compactar'"
              echo "            (dependencias serao instaladas)"
              echo "            (default: \`5\` \`zip\`)"

      read -p " > " v_formt
      v_formt=${v_formt:-"zip"}  # Se nada for introduzido no `read`, pre-definir a a variavel com um valor fixo

      echo " > Selecionado: $v_formt"
      echo " > Sera usado : 'zip' (outros formatos: uDev)"


   # Testar se 'zip' existe no sistema
      f_hzl
              echo
      f_talk; echo "Testar se 'zip' existe"

      if [[ -n $(command -v zip) ]]; then
         echo " > zip existe no sistema"
      else
         echo " > zip nao existe no sistema" 
         echo
         v_txt="Instalar 'zip'"
         f_anyK && pk + zip
      fi

   f_ls
   f_talk; echo "Escolha uma pasta para compactar"   
   read -ep " > " v_dir

   [[ -d $v_dir ]] && echo " > Confirmado, é pasta" || echo " > Rejeitado, Nao é pasta"

   echo
   echo 'uDev: Compactar: `tar -czvf <novo-arquivo-de-saida.tar.gz> <pasta-de-entrada>`'
}


function f_unzip {
   # tar é o nome do pacote a instalar

   # Ver conteudo sem extrair
   #     tar -tzf arquivo.tar.gz
   #
   # Extrair
   #     tar -xzf arquivo.tar.gz

   f_greet
   f_talk; echo "uDev: unzip"   

   # Testar quais as dependencias de descompacatmento que existem instaladas
      f_hzl
      f_test_existent_compression_dependencies 

   # Escolher o formato para descompactar
      f_hzl
      f_talk; echo "Escolha qual formato para 'descompactar' (default: \`6\` \`unzip\`)"
              echo "         (dependencias serao instaladas, uDev)"
              #echo "         (default: \`6\` \`unzip\`)"

              read -p " > " v_formt
      v_formt=${v_formt:-"unzip"}  # Se nada for introduzido no `read`, pre-definir a a variavel com um valor fixo
      echo " > Escolhido: $v_formt (outros formatos: uDev)"


   # Listar `ls` os ficheiros a introduzir para descompactar
      f_ls

   echo
   echo 'uDev: Descompactar: `tar -xzvf <arquivo-a-extrair.tar.gz>`'
}






# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------









if [ -z $* ]; then
   f_talk; echo "uDev: Menu"

elif [ $1 == "." ] || [ $1 == "edit-self" ]; then
   bash e ${v_REPOS_CENTER}/DRYa/all/bin/drya-zip-unzip.sh

elif [ $1 == "h" ] || [ $1 == "help" ]; then
   f_help
      
elif [ $1 == "compression-help" ] || [ $1 == "zip-info" ]; then
   f_about_possible_compression_dependencies

elif [ $1 == "zip" ]; then
   f_zip

elif [ $1 == "unzip" ]; then
   f_unzip

else
   echo "Argument not recognized"
fi
