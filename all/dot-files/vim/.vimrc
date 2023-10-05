" Title: .vimrc
" Description: file that stores all settings to vim app

"This is a comment
set number
set relativenumber
set nowrap
syntax on

"Adjust tab size to 3 spaces
set tabstop=3
set shiftwidth=3
set expandtab

"uDev: add macro to inserv Shebang '#!/bin/bash'

"Enable Mouse scrolling and selecting
set mouse=a

"Display indentation
":set noexpandtab | retab! 4

"Set syntax highlighting
filetype plugin on
syntax on

"Making .sh thr defaulf filetype for bash
let g:is_bash=1

"With the vim open, type this to know wich syntax is the one found to
"highlight
":windo echo b:current_syntax

"Return to last cursor position when opening files you edited and closed before
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
