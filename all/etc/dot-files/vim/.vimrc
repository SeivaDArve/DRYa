" Title: .vimrc (dot-files by Seiva D'Arve)
" Description: file that stores all settings for vim CLI app

"This is an example of a line of comment 


" uDev: See what CTRL-o and CTRL-O do. If it is useless, replace for 'o' and 'O' (creating new lines below and above, but without entering insert mode)


"Define a GLOBAL variable (across all buffers) the variable of DRYa's Repository center
" (When DRYa installs this file .vimrc at $HOME, DRYa has to use `sed` to replace the variable's content)
let g:dryaREPOS = '<DRYa-variable-for-Repository-Center>'

" Instructuons: Usefull tools to know:
"    Escape: <Esc>
"    CTRL-L: <C-L>
"    Enter:  <Cr>


"uDev: add macro to insert Shebang '#!/bin/bash'
"uDev: add macro to insert New Line + echo




"Define a GLOBAL variable (across all buffers) the variable of DRYa's Repository center
" --- When DRYa installs this file .vimrc at $HOME, DRYa has to use `sed` to replace the variable's content
   let g:dryaREPOS = '/home/dv_msi/Repositories' 

"Set the side ruler, allowing to read better which is the current line
   set number
   set relativenumber
   set nowrap
   syntax on

"Adjust tab size to 3 spaces
   set tabstop=3
   set shiftwidth=3
   set expandtab

"Enable Mouse scrolling and selecting
   set mouse=a

"Highlight columns and lines where the cursor stands
   set cursorcolumn
   set cursorline

   "Definir o mesmo estilo de cursor para horizontal e vertical (Para terminal (cterm) e GUI (gui))
      "ctermbg    : cor de fundo no terminal.
      "guibg      : cor de fundo no GVim/Neovim GUI.
      "cterm=NONE : remove o sublinhado.

      hi CursorLine   ctermbg=236 guibg=#3a3a3a cterm=NONE gui=NONE
      hi CursorColumn ctermbg=236 guibg=#3a3a3a cterm=NONE gui=NONE

" Dentro do vim, pesquisar texto com insensibilidade a letras maiusculas e minusculas quando pesquisamos com a vim keybing: /
   set ignorecase

"Display indentation
   ":set noexpandtab | retab! 4

"Set syntax highlighting
   filetype plugin on
   syntax on

"Making .sh thr defaulf filetype for bash
   let g:is_bash=1

"With the vim open, type this to know which syntax is the one found to highlight
   ":windo echo b:current_syntax

"When opening a file, return to last cursor position where you were the last time you opened and closed the file.
   autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

" F7 to close vim from normal mode (equivalent to zz)
   nnoremap <F7> <Esc>ZZ

" F8 to scroll Horizontaly to the left
   nnoremap <F8> zhzhzhzhzhzhzhzh

" F9 to scroll Horizontaly to the right
   nnoremap <F9> zlzlzlzlzlzlzlzl

" Não manter sublinhado a pesquisa de palavras anterior. Esse mapeamento faz com que, quando pressiona Enter no modo normal, o Vim execute o comando :nohlsearch antes de inserir uma nova linha. que apaga o highlight da pesquisa
   nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Mapear uma tecla de atalho ZX para imitar ':q!' e sair do documento discartando as alteracoes (tal como ZZ faz ao guardar)
   nnoremap ZX :q!<CR>
   " (O `vim` ja tem uma tecla de atalho para esta fx: `ZQ`, mas esta continua a ser util)

" Inserir texto que equivale a variavel: ${v_REPOS_CENTER}
   nnoremap ZR i ${v_REPOS_CENTER}/<Esc>

" Inserir o texto que estiver no ficheiro 'drya-date-now'
   nnoremap ZD :r <C-r>='~/.config/h.h/drya/drya-date-now'<CR>

" Inserir o texto que estiver no ficheiro 'drya-autocomplete-if-then-else-fi
   nnoremap ZAI :r <C-r>=g:dryaREPOS . '/DRYa/all/etc/autocomplete/drya/drya-autocomplete-if-then-else-fi.txt'<CR>

" Mapeamento da combinaçao de teclas ZF para copiar e colar conteúdo de um ficheiro externo (menu fzf exemplo 1)
" --- usa a variavel global 'g:dryaREPOS'
   nnoremap ZF :r <C-r>=g:dryaREPOS . '/DRYa/all/bin/boilerplates/bash-fzf-1-boilerplate.sh'<CR>

" uDev: bug fix para esta fx. Introduzir no local do ponteiro, o texto equivalente a data e hora
   nnoremap ZH :r!date +"%Y-%m-%d"<CR>          
   "nnoremap ZH :put =strftime("%Y-%m-%d")<CR>

" Mapear `CTRL-o` e `CTRL-O` para que abram novas linhas de texto (abaixo do cursor e acima do cursor, respetivamente) sem entrar em INSERT mode
   " uDev

" Config para que o nome do ficheiro se mantenha visivel
   " Help command (in vim): `:help laststatus` or `:help statusline`
   set laststatus=2
   "set statusline+=%F  "Para ver o caminho inteiro


