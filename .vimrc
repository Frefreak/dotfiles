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

"from Damian Conway, More Instantly Better Vim - OSCON 2013

" ColorColumn
call matchadd('ColorColumn', '\%>81v', 100)

" jump to next
nnoremap <silent> n   n:call HLNext(0.01)<cr>
nnoremap <silent> N   N:call HLNext(0.01)<cr>

highlight WhiteOnBlack ctermbg=black ctermfg=white
function! _HLNext (blinktime)
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#\%('.@/.'\)'
	let ring = matchadd('WhiteOnBlack', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

function! HLNext (blinktime)
	call _HLNext(a:blinktime)
	call _HLNext(a:blinktime)
	call _HLNext(a:blinktime)
endfunction

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

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>ee
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>ee
vnoremap <leader>" viw<esc>`>a"<esc>`<i"<esc>`>2l
vnoremap <leader>( viw<esc>`>a)<esc>`<i(<esc>`>2l

nnoremap H 0
nnoremap L $

inoremap jk <esc>

onoremap in( :<c-u>normal! f(vi(<CR>
onoremap il( :<c-u>normal! F)vi)<CR>
onoremap an( :<c-u>normal! f(va(<CR>
onoremap al( :<c-u>normal! F)va)<CR>

onoremap in{ :<c-u>execute "normal! /{\r:noh\rvi{"<CR>
onoremap il{ :<c-u>execute "normal! ?}\r:noh\rvi}"<CR>
onoremap an{ :<c-u>execute "normal! /{\r:noh\rva{"<CR>
onoremap al{ :<c-u>execute "normal! ?}\r:noh\rva}"<CR>
