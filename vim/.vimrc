""" Load plugged
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdcommenter'
    Plug 'crusoexia/vim-monokai'
    Plug 'fratajczak/one-monokai-vim'
    Plug 'peterhoeg/vim-qml'
    "Plug 'ycm-core/YouCompleteMe'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ajh17/VimCompletesMe'
    Plug 'junegunn/vim-easy-align'
call plug#end()

""" Options
filetype indent plugin on
syntax on
set modeline
set number
"set termguicolors
set nocompatible
set showmode
set showcmd
set ruler
set cursorline
set expandtab
set noshiftround
set lazyredraw
set magic
set hlsearch
set incsearch
set ignorecase
set smartcase
set encoding=utf-8
set formatoptions=tqn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cmdheight=1
set laststatus=2
set backspace=indent,eol,start
set list
set listchars=tab:\│\
set matchpairs+=<:>
set statusline=%1*\ file\ %3*\ %f\ %4*\
set statusline+=%=\
set statusline+=%3*\ %l\ of\ %L\ %2*\ line\

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" Colors
"colorscheme one-monokai
