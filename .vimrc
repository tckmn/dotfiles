" plugin stuff that needs to be run before loading plugins
let g:coqtail_nomap = 1
let g:gutentags_define_advanced_commands = 1
augroup preplug
    au! FileType tex imap [[ \( | imap ] <plug>(vimtex-delim-close)
    au! ColorScheme * hi def CoqtailChecked guibg=#113311 | hi def CoqtailSent guibg=#007630
augroup end

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
Plug 'whonore/Coqtail'
" appearance
Plug 'chriskempson/base16-vim'
" autocompletion
Plug 'tpope/vim-endwise'
Plug 'tckmn/vim-minisnip'
Plug 'tckmn/vim-xsami'
" integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()


syntax on
filetype plugin indent on
let mapleader=' '
let maplocalleader=' '
set mouse=
set encoding=utf-8
set background=dark
let base16colorspace=256
if filereadable($HOME.'/.cache/cocyc/vim.vim') | source $HOME/.cache/cocyc/vim.vim | else | colorscheme base16-default-dark | endif

" highlighting should look around more
augroup highlighting
  au! Syntax * syntax sync minlines=1000
augroup end

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap gA ga

" language specific
let g:tex_flavor='latex'
let g:vimtex_compiler_method='tectonic'
let g:vimtex_view_method='zathura'
let g:vimtex_view_forward_search_on_start=0
let g:html_indent_inctags='html,body,head,tbody'
set cinoptions=l1
augroup langs
  au! FileType scheme inoremap <buffer> <C-\> λ
  au! FileType coq nnoremap <silent> <cr> :CoqToLine<cr>| let b:commentary_format='(*%s*)'
  au! BufRead all-packages.nix setl fdm=expr fde=getline(v:lnum)!~'###'
augroup end

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
set grepprg=rg\ -n\ $*
nnoremap <C-l> :noh<cr><C-l>
if has('nvim') | set inccommand=nosplit | endif

" behavior
nnoremap Y y$
set wildignorecase      " case-insensitive pathname tab completion
set path=.,**,,         " for various path-aware commands, e.g. :find
set hidden              " allow navigating away from modified buffers
set nojoinspaces        " don't double-space after punctuation
set undofile            " persistent undo
set nostartofline       " reasonable behavior for e.g. <C-v>G
set nrformats=bin,hex   " not octal, so <C-a> on 07 isn't 010
set noautoread          " nvim has this on by default, which is dangerous
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent

" mappings
set wildcharm=<C-z>
nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap <bs> :b#<cr>
nnoremap <Leader>a :A<cr><C-g>
nnoremap <Leader>e :e **/*<C-z><S-Tab>
nnoremap <Leader>f :find *
nnoremap <Leader>g :grep 
nnoremap <Leader>m :make<cr>
nnoremap <Leader>s :up<cr>
nnoremap <Leader>t :ltag /\c
nnoremap <Leader>y :%y+<cr>
nnoremap <Leader>z :up<cr><C-z>
noremap <silent> g{ :<C-u>call cursor(line("'{")+empty(getline(line("'{"))), col('.'))<cr>
noremap <silent> g} :<C-u>call cursor(line("'}")-empty(getline(line("'}"))), col('.'))<cr>
vnoremap <silent> g{ :<C-u>call cursor(line("'{")+empty(getline(line("'{"))), col('.'))<cr>`<1v``
vnoremap <silent> g} :<C-u>call cursor(line("'}")-empty(getline(line("'}"))), col('.'))<cr>`>1v``
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
nnoremap <silent> [oa :set nrformats+=alpha<cr>
nnoremap <silent> ]oa :set nrformats-=alpha<cr>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif
endfunction
function! ToggleLocation()
    if empty(filter(getwininfo(), 'v:val.loclist')) | lopen | else | lclose | endif
endfunction
nnoremap <silent> <Leader>c :call ToggleQuickFix()<cr>
nnoremap <silent> <Leader>l :call ToggleLocation()<cr>

" annoyances
if has('gui_running') | set toolbar= guioptions= | endif
if exists("&esckeys") | set noesckeys | endif
let g:netrw_dirhistmax=0
set shortmess+=I

" local project-specific settings (path, different shiftwidth, etc)
if filereadable($HOME.'/.vim/local.vim') | source $HOME/.vim/local.vim | endif

let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
func! RandColors()
    return g:colors[rand() % len(g:colors)]
endfunc
nnoremap <A-n> :exe "colo " .. NextColors()<bar>colo<CR>
nnoremap <A-p> :exe "colo " .. PrevColors()<bar>colo<CR>
nnoremap <A-r> :exe "colo " .. RandColors()<bar>colo<CR>
