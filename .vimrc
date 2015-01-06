" Pathogen
execute pathogen#infect()

" Auto-indent and syntax highlighting
syntax on
filetype plugin indent on

" Vim-LaTeX plugin
let g:tex_flavor='latex'
let g:html_indent_inctags = "html,body,head,tbody"

" Generic global config
set nocompatible
set modelines=0
set background=dark
let mapleader=" "
set encoding=utf-8

" Tab/indentation settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" Show me more stuffs!
set showmode
set showcmd
set ruler
set relativenumber
set scrolloff=3

" Better searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" Wrapping
set wrap
set linebreak
set nolist
set colorcolumn=80
nnoremap j gj
nnoremap k gk

" Easier navigation
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>

" Invisible chars no more!
set list
set listchars=tab:▸…,eol:¬,trail:•

" Fix Vim's brain-damaged buffer handling system
set hidden

" Convenience
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :wq<cr>
nnoremap <Leader>z :w<cr><C-z>
