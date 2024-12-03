" Title: .vimrc (dot-files by Seiva D'Arve)
" Description: file that stores all settings for vim CLI app

"This is a comment
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

nnoremap <F8> zhzhzhzhzhzhzhzh
nnoremap <F9> zlzlzlzlzlzlzlzl

" Não manter sublinhado a pesquisa de palavras anterio. Esse mapeamento faz com que, quando pressiona Enter no modo normal, o Vim execute o comando :nohlsearch antes de inserir uma nova linha. que apaga o highlight da pesquisa
nnoremap <silent> <CR> :nohlsearch<CR><CR>
