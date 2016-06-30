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

syntax on
filetype plugin indent on
let mapleader=' '
set mouse=
set encoding=utf-8

" plugins
" Vim-LaTeX
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='gv 2>/dev/null'
" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap gA ga

" language-specific
" HTML
let g:html_indent_inctags = "html,body,head,tbody"
" C++
set cinoptions=l1

" base16 colors
set background=dark
colorscheme base16-default-dark

" indentation
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent

" show more information
set showmode showcmd ruler relativenumber scrolloff=3

" better searching
set ignorecase smartcase incsearch showmatch hlsearch
nnoremap <C-l> :noh<cr><C-l>

" wrapping
set wrap display=lastline colorcolumn=80
highlight ColorColumn ctermbg=1
nnoremap j gj
vnoremap j gj
nnoremap gj j
vnoremap gj j
nnoremap k gk
vnoremap k gk
nnoremap gk k
vnoremap gk k

" easier buffer navigation
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <bs> :b#<cr>
if has('nvim')
    tnoremap <Nul> <C-\><C-n>
endif

" show invisible chars
set list listchars=tab:▸…,eol:¬,trail:•

" fix brain-damaged default behavior
set hidden
nnoremap Y y$

" case-insensitive pathname tab completion
set wildignorecase

" persistent undo
set undofile

" leader mappings
nnoremap <Leader>a :A<cr><C-g>
nnoremap <Leader>m :make<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>z :w<cr><C-z>

" title (urxvt)
set title titlestring=]2;vim\ [%F]

" annoyances
imap <Nul> <Esc><Leader>
set noesckeys
