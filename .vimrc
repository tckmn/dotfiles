" plugins
call plug#begin()
" motions/commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'
" language-specific
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'vim-scripts/a.vim'
" appearance
Plug 'chriskempson/base16-vim'
" autocompletion
Plug 'tpope/vim-endwise'
Plug 'KeyboardFire/vim-minisnip'
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

" base16 colors
set background=dark
colorscheme base16-default-dark

" indentation
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent

" show more information
set showmode showcmd ruler relativenumber scrolloff=3

" better searching
set ignorecase smartcase incsearch hlsearch
nnoremap <C-l> :noh<cr><C-l>

" helpful for recording recursive macros
let g:recording = 0
function! BigQ()
    let g:recording = !g:recording
    if g:recording
        nnoremap q <nop>
        return "qqqqq"
    else
        nunmap q
        call feedkeys("q:let @q=@q[:-2].'@q'|echo\<cr>@q", "t")
    endif
endfunction
nnoremap <expr> Q BigQ()

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
nnoremap <cr> :e <cfile><cr>
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
nnoremap <Leader>s :w<cr>
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>z :w<cr><C-z>

" title (urxvt)
set title titlestring=]2;vim\ [%F]

" annoyances
imap <Nul> <Esc><Leader>
set noesckeys
set shortmess+=I
let g:netrw_dirhistmax=0
