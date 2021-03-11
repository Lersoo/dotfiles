set number                                " Display line numbers
syntax on
filetype plugin indent on
filetype on
filetype indent on
set backspace=indent,eol,start
set breakindent
set clipboard=unnamed
set guifont="RobotoMono Nerd Font Mono"
let &showbreak=' '
set incsearch
set ruler
set wildmenu
set wildmode=longest:full,full
set autoread                              " Automatically reload changed files
set scrolloff=20
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set noswapfile
set nobackup
set nowb
set tabstop=2 shiftwidth=2 expandtab

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

""""""""""""""""""""""""""""""""""""""""""
" Install junegunn/plug if not present
""""""""""""""""""""""""""""""""""""""""""
" For Neovim
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

" For Vim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'matze/vim-move'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-dispatch'
Plug 'voldikss/vim-floaterm'
Plug 'cweagans/vim-taskpaper'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""
" Deoplete settings
""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""""""""""
" Goyo & Limelight settings
""""""""""""""""""""""""""""""""""""""""""
let g:goyo_linenr=1
let g:goyo_width=90
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""""""""""""""""""""""""""""""""""""""""""
" OneDark Theme settings
""""""""""""""""""""""""""""""""""""""""""
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
colorscheme onedark
set termguicolors
set noshowmode

""""""""""""""""""""""""""""""""""""""""""
" Lightline settings
""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

""""""""""""""""""""""""""""""""""""""""""
" Ale settings (lint/syntax)
""""""""""""""""""""""""""""""""""""""""""
" let g:ale_open_list = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'ruby': ['standardrb'],
\}
let g:ale_linters= {
\   'ruby': ['standardrb'],
\}
let g:ale_completion_enabled = 1

""""""""""""""""""""""""""""""""""""""""""
" NERDTree settings
""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeGitStatusUseNerdFonts = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

""""""""""""""""""""""""""""""""""""""""""
" CtrlP settings
""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*

""""""""""""""""""""""""""""""""""""""""""
" Floaterm settings
""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_position = 'top'
let g:floaterm_height = 0.9

""""""""""""""""""""""""""""""""""""""""""
" Custom commands
""""""""""""""""""""""""""""""""""""""""""
map ² :NERDTreeToggle<CR> "
map <T-t> :terminal<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <M-l> :bn!<CR>
map <M-h> :bN!<CR>
nnoremap <C-x> :bd<CR>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
nmap <F8> :TagbarToggle<CR>
nmap ,w :b#<bar>bd#<CR>
map <F10> :FloatermToggle<CR>
:tnoremap <Esc> <C-\><C-n>:FloatermToggle<CR>
nmap <C-S-n> :tabnew<CR>
autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

if has('nvim')
  autocmd TermOpen * :set nonumber
endif
