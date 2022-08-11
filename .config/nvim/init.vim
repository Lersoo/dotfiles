set number                                " Display line numbers
syntax on
filetype plugin indent on
filetype on
filetype indent on

nnoremap <SPACE> <Nop>
let &showbreak=' '

let mapleader="\<Space>"
set backspace=indent,eol,start
set breakindent
set clipboard=unnamed
set guifont="RobotoMono Nerd Font Mono"
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

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-dispatch'
Plug 'mileszs/ack.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'thoughtbot/vim-rspec'

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
\   'javascript': ['standard'],
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

" vim-rspec
"
let g:rspec_runner="os_x_iterm"

""""""""""""""""""""""""""""""""""""""""""
" Custom commands
""""""""""""""""""""""""""""""""""""""""""
map @ :NERDTreeToggle<CR>
map <Leader>h <C-w>h
map <Leader>l <C-w>l
map <Leader>j :bn!<CR>
map <Leader>k :bN!<CR>
nnoremap <C-x> :bd<CR>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
nmap <F8> :TagbarToggle<CR>
nmap ,w :b#<bar>bd#<CR>
nmap <C-S-n> :tabnew<CR>
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>

autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

if has('nvim')
  autocmd TermOpen * :set nonumber
  hi Normal guibg=none ctermbg=none
  hi LineNr guibg=none ctermbg=none
  hi Folded guibg=none ctermbg=none
  hi NonText guibg=none ctermbg=none
  hi SpecialKey guibg=none ctermbg=none
  hi VertSplit guibg=none ctermbg=none
  hi SignColumn guibg=none ctermbg=none
  hi EndOfBuffer guibg=none ctermbg=none
endif
