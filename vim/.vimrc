""" Load plugged
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdcommenter'
  Plug 'crusoexia/vim-monokai'
  Plug 'fratajczak/one-monokai-vim'
  Plug 'peterhoeg/vim-qml'
  Plug 'junegunn/vim-easy-align'
  Plug 'vim-airline/vim-airline'
  Plug 'neoclide/coc.nvim'
  Plug 'preservim/nerdtree'
  Plug 'baskerville/vim-sxhkdrc'
call plug#end()

""" Options
"filetype indent plugin on
"syntax on
"set modeline
"set number
"set nocompatible
"set showmode
"set showcmd
"set ruler
"set cursorline
"set expandtab
"set noshiftround
"set lazyredraw
"set magic
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase
"set encoding=utf-8
"set formatoptions=tqn1
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4
"set cmdheight=1
"set laststatus=2
"set backspace=indent,eol,start
"set list
"set listchars=tab:\│\
"set matchpairs+=<:>
"set statusline=%1*\ file\ %3*\ %f\ %4*\
"set statusline+=%=\
"set statusline+=%3*\ %l\ of\ %L\ %2*\ line\

"set clipboard=unnamedplus

" language
set encoding=UTF-8
set spelllang=en

" word wrapping
set textwidth=0
set wrapmargin=0
set nowrap

" indentation
set tabstop=2
set shiftwidth=2
set expandtab

" visual
"if has("termguicolors")
  "set termguicolors
  "set t_Co=256
"endif
set noshowmode
set nospell
set hlsearch
set hidden
set fillchars=vert:│,fold:\ ,stl:-,stlnc:-
set nocursorline
set wildmenu
set laststatus=2
syntax on
set foldmethod=syntax
set foldlevel=1
set foldlevelstart=99
set guifont=monospace:h18
set shortmess+=c
set cmdheight=2
set number

if has("patch-8.1.1564")
  " merge signcolumn and number column
  set signcolumn=number
else
  set signcolumn=yes
endif

" swap file
set nobackup
set nowritebackup
set updatetime=300

" case sensitivity
set ignorecase
set smartcase


" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

map <C-n> :NERDTreeToggle<CR>


" =============================================================================
"                     / ____/ __ \/ /   / __ \/ __ \/ ___/
"                    / /   / / / / /   / / / / /_/ /\__ \
"                   / /___/ /_/ / /___/ /_/ / _, _/___/ /
"                   \____/\____/_____/\____/_/ |_|/____/
" colors ======================================================================
if has('nvim')
  colo desert_v2
endif

hi StatusLine      cterm=bold,italic    gui=bold,italic
hi StatusLineNC    cterm=none           gui=none
hi VertSplit       cterm=none           gui=none
hi PmenuSel        cterm=reverse        gui=reverse
hi Visual          cterm=reverse        gui=reverse

" airline options
let g:airline_powerline_fonts = 1


" Open NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if the only window left open is a NERDTree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e
