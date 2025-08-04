" Title: Copy entire bash fx to a temporary file, using vimscript
" Description: Ficheiros com a extensao exemplo.vim sao normalmente escritos para serem executados pelo vim
"              Podem ser executados no terminal com "vim headless mode"

" Use: no teminal: `vim -Es -S remove_trailing.vim arquivo.txt`
"      -E        significa: entrar no ficheiro em "ex mode"
"      -s        significa: silent mode
"      -S {file} significa: source 'file' com o vimscript la dentro, para ser usado no ficheiro do arg seguinte 

" Abre o arquivo bash-texto.sh com `:e ficheiro.sh` e nao precisa ser usado caso o nome desse ficheiro ja seja mencionado no argumento seguinte  
   "e bash-texto.sh


" Encontra a linha que contém 'function algoritmo_dois {' e vai até a chave de fechamento '}'
   let start_line = search('function f_busca_exemplo')
   normal! ma  " mark place in the 'a' variable. Then we can navigate there again with `'a`

   if  start_line == 0
       echo "DRYa: vimscript: Texto inicial não encontrado!"
       quit
   endif

" A partir dessa linha, busca a chave de fechamento '}'
   "let end_line = search('}', 'w', start_line)
   normal! $%
   normal! mb  " mark place in the 'b' variable. Then we can navigate there again with `'b`

" Copia o conteúdo entre as linhas encontradas (sem incluir as chaves)
   normal! 'aV'by

" Cria o arquivo destino e cria as subpastas pelo caminho se elas nao existirem, tal como `mkdir -p`
   let destino = expand('~/.tmp/vimscript-1-output.txt')

" Grava o conteúdo copiado no arquivo
   execute 'e ' . destino
   "call writefile([getreg('"')], destino)

" Encodicacao do ficheoiro
   execute 'set fileencoding=utf-8'
   normal! p
   execute 'wq'

" Exibe uma mensagem de sucesso
   echo "DRYa: vimscript: texto copiado para " . destino
   "quit
