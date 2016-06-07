" plugins
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
Plug 'vim-scripts/a.vim'
Plug 'chriskempson/base16-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'junegunn/vim-easy-align'
call plug#end()

" auto-indent, syntax highlighting, leader
" (these are needed for plugin config)
syntax on
filetype plugin indent on
let mapleader=" "

" Vim-LaTeX plugin
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='mimeopen'

" A plugin
nnoremap <Leader>a :A<cr><C-g>

" easy-align plugin
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Ruby syntax highlighting is super slow without this
autocmd FileType ruby setlocal re=1 nornu nu

" HTML editing
let g:html_indent_inctags = "html,body,head,tbody"

" C++
set cinoptions=l1

" generic global config
set modelines=0
set mouse=
set background=dark
colorscheme base16-default
set encoding=utf-8

" indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" show more information
set showmode
set showcmd
set ruler
set relativenumber
set scrolloff=3

" better searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" wrapping
set wrap
set display=lastline
highlight ColorColumn ctermbg=1
set colorcolumn=80
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" easier navigation
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <C-m> :b#<cr>
if has('nvim')
    tnoremap <Nul> <C-\><C-n>
endif

" show invisible chars
set list
set listchars=tab:▸…,eol:¬,trail:•

" fix Vim's brain-damaged buffer handling system
set hidden

" fix Vim's brain-damaged Y-handling behavior
nnoremap Y y$

" convenience
runtime macros/justify.vim
unmap ,gq
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>w :w<cr>
" nnoremap <Leader>q :wq<cr>
" nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>z :w<cr><C-z>
nnoremap <Leader>m :make<cr>
cnoremap w!! w !sudo tee %

" title
set title titlestring=]2;vim\ [%F]

" annoyances
imap <Nul> <Esc><Leader>
set noesckeys
