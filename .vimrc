"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'vim-latex/vim-latex'
Plugin 'Valloric/YouCompleteMe'
Plugin 'eagletmt/neco-ghc'
Plugin 'rdnetto/YCM-Generator'
Plugin 'atweiden/vim-dragvisuals'
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

autocmd CompleteDone * pclose
autocmd FileType html setlocal shiftwidth=2 tabstop=2
"autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround

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

"vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='tex'
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat='pdf'

"YouCompleteMe
let g:ycm_key_invoke_completion = '<C-o>'
let g:ycm_global_ycm_extra_conf = '/home/adv_zxy/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

noremap <leader>gg :YcmCompleter GoTo<CR>
noremap <leader>gc :YcmCompleter GoToDeclaration<CR>
noremap <leader>gf :YcmCompleter GoToDefinition<CR>
noremap <leader>gt :YcmCompleter GetType<CR>
noremap <leader>gd :YcmCompleter GetDoc<CR>
noremap <leader>ff :YcmCompleter FixIt<CR>

"neco-ghc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

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

" dragvisual
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
"let g:DVB_TrimWS = 1
