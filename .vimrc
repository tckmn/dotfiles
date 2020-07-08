" ugh, this has to be up here for vimtex
au! FileType tex imap [[ \( | imap ] <plug>(vimtex-delim-close)

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
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'vim-scripts/a.vim'
Plug 'tounaishouta/coq.vim'
" appearance
Plug 'chriskempson/base16-vim'
" autocompletion
Plug 'tpope/vim-endwise'
Plug 'tckmn/vim-minisnip'
Plug 'tckmn/vim-xsami'
" integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
call plug#end()


syntax on
filetype plugin indent on
let mapleader=' '
let maplocalleader=' '
set mouse=
set encoding=utf-8
set background=dark
let base16colorspace=256
colorscheme base16-default-dark

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap gA ga

" language specific
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:html_indent_inctags='html,body,head,tbody'
set cinoptions=l1
au! FileType scheme inoremap <buffer> <C-\> λ
au! FileType coq nnoremap <silent> <cr> :CoqRunToCursor<cr> | let b:commentary_format='(*%s*)'
au! BufRead all-packages.nix setl fdm=expr fde=getline(v:lnum)!~'###'

" display
set showmode showcmd ruler relativenumber scrolloff=3
set list listchars=tab:▸…,eol:¬,trail:•
set title
if has('gui_running')
    set titlestring=gvim\ [%F]
else
    set titlestring=]2;vim\ [%F]
endif
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

" search
set ignorecase smartcase incsearch hlsearch
nnoremap <C-l> :noh<cr><C-l>
if has('nvim') | set inccommand=nosplit | endif

" behavior
nnoremap Y y$
set hidden              " allow navigating away from modified buffers
set wildignorecase      " case-insensitive pathname tab completion
set nojoinspaces        " don't double-space after punctuation
set undofile            " persistent undo
set nostartofline       " reasonable behavior for e.g. <C-v>G
set nrformats=bin,hex   " not octal, so <C-a> on 07 isn't 010
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent

" mappings
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <bs> :b#<cr>
nnoremap <Leader>a :A<cr><C-g>
nnoremap <Leader>m :make<cr>
nnoremap <Leader>s :w<cr>
nnoremap <Leader>y :%y+<cr>
nnoremap <Leader>z :up<cr><C-z>
if has('nvim') | tnoremap <Esc> <C-\><C-n> | endif

" more complex mappings
function! DTS()
    let l:v = winsaveview()
    keeppatterns %s/\s*$
    call winrestview(l:v)
endfunction
nnoremap <silent> <Leader>d :call DTS()<cr>

function! Col()
    exe '%!column -c'.winwidth(0)
    " irritatingly, we can't pipe to expand(1) because it breaks on unicode
    let l:t=&l:ts
    setl ts=8
    retab
    let &l:ts=l:t
endfunction
nnoremap <silent> col :call Col()<cr>

function! ToggleAlpha()
    if &nrformats =~ "alpha"
        set nrformats-=alpha
    else
        set nrformats+=alpha
    endif
endfunction
nnoremap <silent> yoa :call ToggleAlpha()<cr>

" annoyances
if has('gui_running') | set toolbar= guioptions= | endif
if exists("&esckeys") | set noesckeys | endif
let g:netrw_dirhistmax=0
set shortmess+=I
