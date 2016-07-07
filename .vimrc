" plugins
call plug#begin()
" motions/commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
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
Plug 'vimwiki/vimwiki'
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
" vimwiki
let g:vimwiki_list = [
\   {
\       'path': '~/documents/vimwiki/',
\       'auto_export': 1,
\       'auto_toc': 1
\   }
\]
let g:vimwiki_folding='list'

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

" wrapping
set wrap display=lastline colorcolumn=80
highlight ColorColumn ctermbg=8
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
nnoremap <Leader>s :w<cr>
nnoremap <Leader>y mygg"+yG`y
nnoremap <Leader>z :w<cr><C-z>

" title (urxvt)
set title titlestring=]2;vim\ [%F]

" annoyances
imap <Nul> <Esc><Leader>
set noesckeys
