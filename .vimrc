" vim-plug
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'wting/rust.vim'
Plug 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
Plug 'vim-scripts/a.vim'
Plug 'altercation/vim-colors-solarized'
call plug#end()

" Weirdness
let g:netrw_ftpextracmd='passive'

" Auto-indent and syntax highlighting
syntax on
filetype plugin indent on

" Leader
let mapleader=" "

" Vim-LaTeX plugin
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='mimeopen'

" A plugin
nnoremap <Leader>a :A<cr><C-g>
"iunmap <Leader>ih
"iunmap <Leader>is
"iunmap <Leader>ihn

" UltiSnips plugin
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsListSnippets="<C-S-j>"

" Ruby syntax highlighting is super slow without this
autocmd FileType ruby setlocal re=1 nornu nu

" HTML editing
let g:html_indent_inctags = "html,body,head,tbody"

" C++
set cinoptions=l1

" Generic global config
set nocompatible
set modelines=0
set mouse=
set t_Co=16
set background=dark
colorscheme solarized
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
set display=lastline
highlight ColorColumn ctermbg=1
set colorcolumn=80
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" Easier navigation
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <C-m> :b#<cr>

" Invisible chars no more!
set list
set listchars=tab:▸…,eol:¬,trail:•

" Fix Vim's brain-damaged buffer handling system
set hidden

" Fix Vim's brain-damaged Y-handling behavior
nnoremap Y y$

" Convenience
runtime macros/justify.vim
unmap ,gq
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>w :w<cr>
" nnoremap <Leader>q :wq<cr>
nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>z :w<cr><C-z>
nnoremap <Leader>m :make<cr>
cnoremap w!! w !sudo tee %

" annoyances
imap <Nul> <Esc><Leader>
set noesckeys
