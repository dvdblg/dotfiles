call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
<<<<<<< HEAD
Plug 'arcticicestudio/nord-vim'
=======
"Plug 'morhetz/gruvbox'
>>>>>>> d216eebcc55dec7d4d6cd9f8e639a3cf3c1afc7d

call plug#end()

filetype plugin on

set number
syntax on
syntax enable

<<<<<<< HEAD
colorscheme nord
=======
"colorscheme gruvbox
>>>>>>> d216eebcc55dec7d4d6cd9f8e639a3cf3c1afc7d
set background=dark

"set clipboard+=unnamed
set clipboard=unnamedplus
set hlsearch

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

