" Pathogen
let g:pathogen_disabled = ['syntastic']
execute pathogen#infect()

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

" Syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall'
let g:syntastic_cpp_check_header = 1

" ctrlp plugin
let g:ctrlp_map = '<Leader>p'

" NERDTree plugin
nnoremap <Leader>n :NERDTreeToggle<cr>

" YouCompleteMe plugin
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf_cpp.py'
let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_register_as_syntastic_checker = 0

" A plugin
nnoremap <Leader>a :A<cr><C-g>

" UltiSnips plugin
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsListSnippets="<C-S-j>"

" HTML editing
let g:html_indent_inctags = "html,body,head,tbody"

" Generic global config
set nocompatible
set modelines=0
set term=screen-256color
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
set linebreak
set display=lastline
highlight ColorColumn ctermbg=1
set colorcolumn=80
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" Easier navigation
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <C-m> :b#<cr>

" Invisible chars no more!
set list
set listchars=tab:▸…,eol:¬,trail:•

" Fix Vim's brain-damaged buffer handling system
set hidden

" Convenience
runtime macros/justify.vim
unmap ,gq
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :wq<cr>
nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>z :w<cr><C-z>
nnoremap <Leader>m :make<cr>
cnoremap w!! w !sudo tee %
