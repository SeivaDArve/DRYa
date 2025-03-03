" Title: .vimrc (dot-files by Seiva D'Arve)
" Description: file that stores all settings for vim CLI app

"This is an example of a line of comment 

"Define a GLOBAL variable (across all buffers) the variable of DRYa's Repository center
" (When DRYa installs this file .vimrc at $HOME, DRYa has to use `sed` to replace the variable's content)
let g:dryaREPOS = '<DRYa-variable-for-Repository-Center>'

"Set the side ruler, allowing to read better which is the current line
set number
set relativenumber
set nowrap
syntax on

"Adjust tab size to 3 spaces
set tabstop=3
set shiftwidth=3
set expandtab

"uDev: add macro to insert Shebang '#!/bin/bash'
"uDev: add macro to insert New Line + echo

"Enable Mouse scrolling and selecting
set mouse=a

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

" Não manter sublinhado a pesquisa de palavras anterio. Esse mapeamento faz com que, quando pressiona Enter no modo normal, o Vim execute o comando :nohlsearch antes de inserir uma nova linha. que apaga o highlight da pesquisa
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Mapear uma tecla de atalho ZX para imitar ':q!' e sair do documento discartando as alteracoes (tal como ZZ faz ao guardar)
nnoremap ZX :q!<CR>

" Inserir texto que equivale a variavel: ${v_REPOS_CENTER}
nnoremap ZD i${v_REPOS_CENTER}/<Esc>

" Mapeamento da combinaçao de teclas ZF para copiar e colar conteúdo de um ficheiro externo (menu fzf exemplo 1)
" (usa a variavel global 'g:dryaREPOS')
nnoremap ZF :r <C-r>=g:dryaREPOS . '/DRYa/all/bin/boilerplates/bash-fzf-1-boilerplate.sh'<CR>
