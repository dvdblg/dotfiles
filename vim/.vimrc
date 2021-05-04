""" Load plugged

 "Plug 'vim-airline/vim-airline'
 "Plug 'vim-airline/vim-airline-themes'
  

call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdcommenter'
  
  Plug 'junegunn/vim-easy-align'
  
  Plug 'itchyny/lightline.vim'
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
  
  "Plug 'neoclide/coc.nvim'
  
  Plug 'preservim/nerdtree'
    " Open NERDTree automatically when vim starts up if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  

  Plug 'arcticicestudio/nord-vim'
  
  "Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='evince'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'


  Plug 'vim-pandoc/vim-pandoc'
  
  Plug 'vim-pandoc/vim-pandoc-syntax'
  
  Plug 'vim-pandoc/vim-pandoc-after'
    "let g:pandoc#after#modules#enabled = ["nrrwrgn", "ultisnips"]
  
  Plug 'conornewton/vim-pandoc-markdown-preview'
    let g:md_pdf_viewer="evince"

  Plug 'dhruvasagar/vim-table-mode'
call plug#end()

""" Options
"set clipboard=unnamedplus
set noshowmode
set hlsearch
"set hidden
"set fillchars=vert:│,fold:\ ,stl:-,stlnc:-
set nocursorline
"set wildmenu
set laststatus=2
syntax on
"set foldmethod=syntax
set foldlevel=1
set foldlevelstart=99
"set guifont=monospace:h18
"set shortmess+=c
"set cmdheight=2
set number


" language
set encoding=UTF-8
set spelllang=en,it
"setlocal spell


" word wrapping
"set textwidth=0
"set wrapmargin=0
"set nowrap

" indentation
set tabstop=4
set shiftwidth=4
set expandtab

" visual
if has("termguicolors")
  set termguicolors
  set t_Co=256
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

" makrdown preview
nnoremap <Leader>mp :StartMdPreview<cr>

" =============================================================================
"                     / ____/ __ \/ /   / __ \/ __ \/ ___/
"                    / /   / / / / /   / / / / /_/ /\__ \
"                   / /___/ /_/ / /___/ /_/ / _, _/___/ /
"                   \____/\____/_____/\____/_/ |_|/____/
" colors ======================================================================

colorscheme nord
hi! clear Conceal
set background=dark


"hi PmenuSel        ctermfg=5 ctermbg=8
"hi StatusLine      cterm=bold,italic    gui=bold,italic
"hi StatusLineNC    cterm=none           gui=none
"hi VertSplit       cterm=none           gui=none
"hi PmenuSel        cterm=reverse        gui=reverse
"hi Visual          cterm=reverse        gui=reverse

" remove trailing spaces on save
"autocmd BufWritePre * :%s/\s\+$//e


" Abbreviations

" indented right arrow in pandoc md
iabbrev --> &nbsp;<Return>: $\rightarrow$
