" plugins
call plug#begin()
" motions/commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'
" language-specific
Plug 'rust-lang/rust.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'lervag/vimtex'
Plug 'vim-scripts/a.vim'
" appearance
Plug 'chriskempson/base16-vim'
" autocompletion
Plug 'tpope/vim-endwise'
Plug 'KeyboardFire/vim-minisnip'
Plug 'KeyboardFire/vim-xsami'
" integration
Plug 'tpope/vim-fugitive'
call plug#end()

syntax on
filetype plugin indent on
let mapleader=' '
let maplocalleader=' '
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
" lilypond
au! BufNewFile,BufRead *.ly,*.ily set ft=lilypond

" base16 colors
set background=dark
colorscheme base16-default-dark

" indentation
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent shiftround

" show more information
set showmode showcmd ruler relativenumber scrolloff=3

" better searching
set ignorecase smartcase incsearch hlsearch
nnoremap <C-l> :noh<cr><C-l>

" wrapping
set wrap display=lastline colorcolumn=80
highlight ColorColumn ctermbg=8
nnoremap j  gj
nnoremap gj j
nnoremap k  gk
nnoremap gk k
xnoremap <expr> j  mode() ==# 'v' ? 'gj' : 'j'
xnoremap <expr> gj mode() ==# 'v' ? 'j'  : 'gj'
xnoremap <expr> k  mode() ==# 'v' ? 'gk' : 'k'
xnoremap <expr> gk mode() ==# 'v' ? 'k'  : 'gk'

" easier buffer navigation
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <bs> :b#<cr>
if has('nvim') | tnoremap <Esc> <C-\><C-n> | endif

" show invisible chars
set list listchars=tab:▸…,eol:¬,trail:•

" fix bad default behavior
nnoremap Y y$
set hidden          " allow navigating away from modified buffers
set wildignorecase  " case-insensitive pathname tab completion
set nojoinspaces    " don't double-space after punctuation
set undofile        " persistent undo
set nostartofline   " non-stupid behavior for e.g. <C-v>G

" leader mappings
nnoremap <Leader>a :A<cr><C-g>
nnoremap <Leader>m :make<cr>
nnoremap <Leader>s :w<cr>
nnoremap <Leader>y :%y+<cr>
nnoremap <Leader>z :up<cr><C-z>

" title (urxvt/gvim)
set title
if has('gui_running')
    set titlestring=gvim\ [%F]
else
    set titlestring=]2;vim\ [%F]
endif

" annoyances
if exists("&esckeys") | set noesckeys | endif
set shortmess+=I
let g:netrw_dirhistmax=0

" disable annoying gvim stuff, in the unusual event that I might use it
if has('gui_running') | set toolbar= guioptions= | endif
