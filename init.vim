" vim: foldmethod=marker sw=2 ts=2 sts=2 expandtab

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'pbrisbin/vim-syntax-shakespeare', { 'for' : ['haskell', 'hamlet', 'julius', 'lucius'] }
Plug 'bitc/vim-hdevtools', { 'for' : 'haskell' }
Plug 'urso/haskell_syntax.vim', { 'for' : 'haskell' }
Plug 'benekastah/neomake'
Plug 'atweiden/vim-dragvisuals'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
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
Plug 'manicmaniac/coconut.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
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
let s:theme = 'Dracula'
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

" reset cursor to last location {{{
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
"}}}

" some auto commands {{{
augroup neomake_enable
	autocmd! BufWritePost * Neomake
augroup end

autocmd CompleteDone * pclose

augroup filetype_web
	autocmd Filetype html,xhtml,javascript,css,vue  setlocal sw=2 ts=2 expandtab sts=2 shiftround
	autocmd Filetype html,xhtml,css nnoremap <buffer> <localleader>ft Vatzf
augroup end

augroup filetye_vim
	autocmd FileType vim setlocal shiftwidth=4 tabstop=4
augroup end

augroup filetye_python
	autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
	autocmd FileType coconut setlocal shiftwidth=4 tabstop=4 expandtab
augroup end

augroup filetype_haskell
	autocmd FileType haskell,lhaskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround
	autocmd FileType cabal setlocal ts=2 sw=2 sts=2 expandtab
	autocmd FileType hamlet setlocal expandtab softtabstop=2 shiftwidth=2 shiftround
augroup end

augroup filetype_markdown
	autocmd FileType markdown setlocal tabstop=4 expandtab softtabstop=4 shiftwidth=4 shiftround
augroup end

augroup filetype_yaml
	autocmd FileType yaml setlocal tabstop=8 softtabstop=2 shiftwidth=2 shiftround
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
	autocmd FileType php setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
augroup end

augroup filetype_fix
  autocmd FileType plaintex set ft=tex
augroup end

augroup md_report_pdf
	autocmd BufWritePost \d\d\d\d-\d\d-\d\d.md call jobstart('pandoc_beamer ' . expand('%') . ' -o ' . expand('%:t:s?md$?pdf?'))
augroup end

"}}}

" vimtex {{{
"}}}

" neco-ghc {{{
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc " this seems unnecessary
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

" dragvisual
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
"vmap  <expr>  D        DVB_Duplicate()
"}}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

inoremap <silent><expr> <Tab>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
	endfunction
"}}}

augroup deoplete_special
	au FileType haskell let g:deoplete#disable_auto_complete = 0
	au FileType python let g:deoplete#disable_auto_complete = 0
	au FileType c,cpp let g:deoplete#disable_auto_complete = 0
augroup end
"}}}

" ghc-mod {{{
noremap <leader>tw :GhcModTypeInsert<CR>
noremap <leader>ts :GhcModSplitFunCase<CR>
noremap <leader>tq :GhcModType<CR>
noremap <leader>te :GhcModTypeClear<CR>
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

" LanguageClient-neovim {{{
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'c': ['/bin/cquery', '--log-file=/tmp/cq_c.log'],
    \ 'cpp': ['/bin/cquery', '--log-file=/tmp/cq.log'],
    \ 'haskell': ['stack', 'exec', '--', 'hie-wrapper', '--lsp'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls', '--log-file=/tmp/pyls.log']
    \ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/adv_zxy/.config/nvim/settings.json'

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nn <silent> <M-.> :call LanguageClient_textDocument_definition()<cr>
" nn <silent> <M-,> :call LanguageClient_textDocument_references()<cr>
" nn <f2> :call LanguageClient_textDocument_rename()<cr>
" nn <leader>ji :Denite documentSymbol<cr>
" nn <leader>jI :Denite workspaceSymbol<cr>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" augroup LanguageClient_config
  " au!
  " au BufEnter * let b:Plugin_LanguageClient_started = 0
  " au User LanguageClientStarted setl signcolumn=yes
  " au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
  " au User LanguageClientStopped setl signcolumn=auto
  " au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
  " au CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
" augroup END

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
nnoremap <silent> <leader>ag :Ag<CR>
nnoremap <silent> <leader>rg :Rg<CR>

" }}}

" neomake {{{
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clangcheck']
let g:neomake_tex_enabled_makers = ['chktex']
let g:neomake_cpp_clang_args = neomake#makers#ft#cpp#clang()['args']
    \ + ["-std=c++1z"]
let g:neomake_haskell_enabled_makers = ['hlint']
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint()['args']
    \ + ['-d', 'missing-docstring,invalid-name,maybe-no-member']
" let g:neomake_open_list = 2
let g:clang_diagsopt = ''
" }}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'coconut': { 'left': '#' } }
vmap <M-/> <plug>NERDCommenterToggle
nmap <M-/> <plug>NERDCommenterToggle
" }}}

" Some other stuffs {{{

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
