syntax on
set t_Co=256
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

autocmd CompleteDone * pclose

" ColorColumn
call matchadd('ColorColumn', '\%81v', 100)

" tab/spaces
set listchars=tab:\ \ ,trail:·
set list

" colon commands
nnoremap  ;  :
nnoremap  :  ;

" visual mode
nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

nnoremap H ^
nnoremap L $

inoremap kj <esc>
