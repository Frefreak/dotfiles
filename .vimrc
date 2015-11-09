"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'aceofall/gtags.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'vim-scripts/JavaDecompiler.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'eagletmt/neco-ghc'
Plugin 'Valloric/YouCompleteMe'
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
autocmd FileType verilog setlocal expandtab shiftwidth=8 tabstop=8
autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround

"Gtags
set cscopetag
set cscopeprg=gtags-cscope
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

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
let g:tex_flavor = 'xelatex'
let g:Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'

"neco-ghc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

"YouCompleteMe
let g:ycm_key_invoke_completion = '<C-o>'
let g:ycm_global_ycm_extra_conf = '/home/adv_zxy/.vim/.ycm_extra_conf.py'
noremap <leader>gg :YcmCompleter GoTo<CR>
noremap <leader>gc :YcmCompleter GoToDeclaration<CR>
noremap <leader>gf :YcmCompleter GoToDefinition<CR>
noremap <leader>gt :YcmCompleter GetType<CR>
noremap <leader>ff :YcmCompleter FixIt<CR>
"let g:ycm_filepath_completion_use_working_dir = 1
