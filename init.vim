" vim: foldmethod=marker sw=2 ts=2 sts=2 expandtab

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'pbrisbin/vim-syntax-shakespeare', { 'for' : ['haskell', 'hamlet', 'julius', 'lucius'] }
Plug 'bitc/vim-hdevtools', { 'for' : 'haskell' }
Plug 'urso/haskell_syntax.vim', { 'for' : 'haskell' }
" Plug 'benekastah/neomake'
Plug 'atweiden/vim-dragvisuals'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jpalardy/vim-slime'
Plug 'aceofall/gtags.vim'
Plug 'KabbAmine/zeavim.vim'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim', { 'for' : ['html', 'javascript', 'php', 'css', 'vue', 'xml'] }
Plug 'tmux-plugins/vim-tmux'
Plug 'roxma/vim-tmux-clipboard'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'idris-hackers/idris-vim', { 'for': ['idr'] }
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
Plug 'ianding1/leetcode.vim'
Plug 'mesonbuild/meson', {'rtp': 'data/syntax-highlighting/vim'}
call plug#end()
"}}}

" display related {{{
set background=dark
set termguicolors
color dracula
syntax enable
"}}}

" general settings {{{
set rtp+=~/.local/share/nvim
set mouse=
set fileencodings=utf8,cp936,gb18030,big5
filetype plugin indent on
set tabstop=8
set softtabstop=8
set shiftwidth=8
set cursorline
set inccommand=split
"}}}

" lightline {{{
set noshowmode
let s:theme = 'dracula'
let g:lightline = {
	\ 'colorscheme': s:theme,
	\ 'active': {
	\	'left': [ ['mode', 'paste'],
	\			  ['fugitive', 'filename', 'modified'] ],
	\ },
	\ 'component_function': {
	\   'fugitive': 'LightlineFugitive',
	\	'readonly': 'LightlineReadonly',
	\   'filename': 'LightlineFilename'
	\ },
	\ 'component': {
	\ 	'lineinfo': ' %3l:%-2v',
	\   'modified': '%#ModifiedColor#%{LightlineModified()}',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
	\ }

function! LightlineModified()
  let map = { 'V': 'v', "\<C-v>": 'v', 's': 'n', 'v': 'n', "\<C-s>": 'n',
        \ 'c': 'n', 'R': 'n'}
  let mode = get(map, mode()[0], mode()[0])
  let bgcolor = {'n': [236, '#44475a'], 'i': [236, '#44475a'],
        \ 'v': [236, '#44475a']}
  let color = get(bgcolor, mode, bgcolor.n)
  exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
    \ color[0], color[1])
  return &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return ""
    else
        return ""
    endif
endfunction

function! LightlineFugitive()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
		 \ ('' != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction
"}}}

" coc.nvim {{{
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap FMT <Plug>(coc-format)
nmap FMT <Plug>(coc-format)

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}

" reset cursor to last location {{{
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
"}}}

" some auto commands {{{
" augroup neomake_enable
	" autocmd! BufWritePost * Neomake
" augroup end

autocmd CompleteDone * pclose

augroup filetype_web
	autocmd Filetype html,xhtml,javascript,css,typescript,vue  setlocal sw=2 ts=2 expandtab sts=2 shiftround
augroup end

augroup filetye_vim
	autocmd FileType vim setlocal shiftwidth=4 tabstop=4
  autocmd FileType vimwiki setlocal shiftwidth=4 tabstop=4 expandtab
augroup end

augroup filetye_dev
	autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
	autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab
augroup end

augroup filetype_haskell
	autocmd FileType haskell,lhaskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround
	autocmd FileType cabal setlocal ts=2 sw=2 sts=2 expandtab
	autocmd FileType hamlet setlocal expandtab softtabstop=2 shiftwidth=2 shiftround
augroup end

augroup filetype_cmake
	autocmd FileType cmake setlocal tabstop=4 expandtab softtabstop=4 shiftwidth=4 shiftround
augroup end

augroup filetype_markdown
	autocmd FileType markdown setlocal tabstop=4 expandtab softtabstop=4 shiftwidth=4 shiftround
augroup end

augroup filetype_config
	autocmd FileType yaml setlocal tabstop=8 softtabstop=2 shiftwidth=2 shiftround
	autocmd FileType json setlocal tabstop=8 softtabstop=2 shiftwidth=2 shiftround
augroup end

augroup filetype_vim
	autocmd FileType vim setlocal foldmethod=marker
augroup end

augroup filetype_html
	autocmd FileType html setlocal foldmethod=syntax
augroup end

augroup filetype_script
	autocmd FileType zsh setlocal foldmethod=marker ts=2 sw=2 sts=2 expandtab
	autocmd FileType tex setlocal foldmethod=marker ts=2 sw=2 sts=2 expandtab
	autocmd FileType lua setlocal foldmethod=marker ts=2 sw=2 sts=2 expandtab
  autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 expandtab
	autocmd FileType groovy setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
	autocmd FileType php setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
augroup end

augroup filetype_fix
  autocmd FileType plaintex set ft=tex
augroup end

augroup md_report_pdf
	autocmd BufWritePost \d\d\d\d-\d\d-\d\d.md call jobstart('pandoc_beamer ' . expand('%') . ' -o ' . expand('%:t:s?md$?pdf?'))
augroup end

"}}}

" from Damian Conway, More Instantly Better Vim - OSCON 2013 {{{
" ColorColumn
call matchadd('ColorColumn', '\%81v', 100)
autocmd Filetype xhtml,html,php call clearmatches() " html is special

" jump to next
nnoremap <silent> n   n:call HLNext(0.01)<cr>
nnoremap <silent> N   N:call HLNext(0.01)<cr>

highlight BlinkHighlight guibg=#000000 guifg=#ffffff
function! _HLNext (blinktime)
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#\%('.@/.'\)'
	let ring = matchadd('BlinkHighlight', target_pat, 101)
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

nnoremap <Down> 5j
nnoremap <Up>   5k
nnoremap <Left> 5h
nnoremap <Right> 5l

" dragvisual
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
"vmap  <expr>  D        DVB_Duplicate()
"}}}

" vim-hdevtools {{{
augroup filetype_haskell
	au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
	au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
	au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
augroup end
"}}}

" Ultisnips {{{
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir='~/.local/share/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsListSnippets="<C-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"}}}

" vim-slime {{{
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
nnoremap <leader>r :SlimeSend1 :r<CR>
"}}}

" gtags {{{
set cscopetag
set cscopeprg='gtags-cscope'

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
"}}}

" enable this to start writing nvim-hs plugin for nvim {{{
let g:nvimhsmode = 0
if nvimhsmode
    call rpcrequest(jobstart(expand('$HOME/bin/nvim-hs-devel.sh'), {'rpc': v:true}), "PingNvimhs")
    augroup nvim-hs
	au!
    augroup end
endif
"}}}

" learn vimscript the hard way {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H ^
nnoremap L $

inoremap kj <esc>
cnoremap kj <C-c>

"}}}

" Key mapping {{{
vnoremap ty "+y
nnoremap tp "+p
nnoremap a9 v<esc>ea(<esc>A)<esc>gv<esc>
cmap w!! w !sudo tee % > /dev/null
nnoremap cp :e %:h<enter>
" }}}

" fzf {{{
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <leader>f :FZF -m<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <leader>ag :Ag<CR>
nnoremap <silent> <leader>rg :Rg<CR>

" }}}

" neomake {{{
" let g:neomake_c_enabled_makers = ['clang']
" let g:neomake_cpp_enabled_makers = ['clangcheck']
" let g:neomake_tex_enabled_makers = ['chktex']
" let g:neomake_python_enabled_makers = ['pylint']
" let g:neomake_cpp_clang_args = neomake#makers#ft#cpp#clang()['args']
    " \ + ["-std=c++1z"]
" let g:neomake_haskell_enabled_makers = ['hlint']
" let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint()['args']
    " \ + ['-d', 'missing-docstring,invalid-name,maybe-no-member']
" let g:neomake_open_list = 2
" let g:clang_diagsopt = ''
" let g:neomake_warning_sign = {
   " \   'text': '❗',
   " \   'texthl': 'NeomakeWarningSign',
   " \ }
"}}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'coconut': { 'left': '#' } }
vmap <M-/> <plug>NERDCommenterToggle
nmap <M-/> <plug>NERDCommenterToggle
" }}}

" netrw {{{
" let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"}}}

" Some other stuffs {{{

command! SSS :syntax sync fromstart
" Markdown preview using github api, markdownPreview is an external executable
command! MarkdownPreview :call MarkdownPreview()
"augroup filetype_markdown
"	au BufWritePost *.md :MarkdownPreview
"augroup end

function! MarkdownPreview()
	:silent :execute "!markdownPreview %"
	:echom fnamemodify(@%, ':s?md?html?') . " saved"
endfunction

function! RepeatLastCommand()
	if !exists("b:tmux_target_pane")
		let b:tmux_target_pane = input("tmux target pane: ", 1)
	end
	call system("tmux send-keys -t " . shellescape(b:tmux_target_pane) . " Up")
	call system("tmux send-keys -t " . shellescape(b:tmux_target_pane) . " Enter")
endfunction
nnoremap <leader>p :call RepeatLastCommand()<CR>

function! ChangeTmuxTargetPane()
	let b:tmux_target_pane = input("tmux target pane: ", b:tmux_target_pane)
endfunction

inoremap `l λ
set timeoutlen=500
"}}}

" LeetCode {{{
let g:leetcode_solution_filetype = 'scala'
let g:leetcode_username = 'frefreak.zxy@gmail.com'

"}}}
