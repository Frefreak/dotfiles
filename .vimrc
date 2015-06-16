syntax on
set background=dark
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
set cscopetag
set cscopeprg='gtags-cscope'
autocmd CompleteDone * pclose
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType haskell setlocal expandtab softtabstop=4 shiftwidth=4 shiftround

map <C-n> :NERDTreeToggle<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

"let Gtags_Auto_Map = 1

