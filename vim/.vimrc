filetype plugin on

set number
syntax on
syntax enable

set clipboard+=unnamed
set hlsearch

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'

call plug#end()
