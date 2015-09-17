"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'aceofall/gtags.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'bling/vim-airline'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
call vundle#end()

syntax on
set t_Co=256
set background=dark
colorscheme primary
set fileencodings=utf8,cp936,gb18030,big5
set autoindent
filetype plugin indent on
set hlsearch
set wrapscan
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set smarttab
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

"Gtags
set cscopetag
set cscopeprg='gtags-cscope'
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
autocmd CompleteDone * pclose
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType haskell setlocal expandtab softtabstop=4 shiftwidth=4 shiftround

"NerdTree
map <C-n> :NERDTreeToggle<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

"airline
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
