call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin on

set number
syntax on
syntax enable

colorscheme gruvbox
set background=dark

set clipboard+=unnamed
set hlsearch

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

