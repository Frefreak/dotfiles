" vim: foldmethod=marker sw=2 ts=2 sts=2 expandtab

" lazy.nvim & LUA stuffs {{{
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local entry = require('entry')
require('lazy').setup(entry)
EOF

"}}}

" display related {{{
set background=dark
set termguicolors
color dracula
syntax enable
"}}}

" general settings {{{
set mouse=
set fileencodings=utf8,cp936,gb18030,big5
filetype plugin indent on
set tabstop=8
set softtabstop=8
set shiftwidth=8
set cursorline
set inccommand=split
"}}}

" reset cursor to last location {{{
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
"}}}

" auto commands {{{
augroup filetype_web
	autocmd Filetype html,xhtml,javascript,css,typescript,typescript.*,vue,wast  setlocal sw=2 ts=2 expandtab sts=2 shiftround
augroup end

augroup filetype_vim
	autocmd FileType vim setlocal shiftwidth=4 tabstop=4
  autocmd FileType vimwiki setlocal shiftwidth=4 tabstop=4 expandtab
augroup end

augroup filetype_dev
	autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
	autocmd FileType go setlocal shiftwidth=4 tabstop=4
	autocmd FileType gdscript,gdshader setlocal shiftwidth=4 tabstop=4
	"autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab
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
	autocmd FileType lua setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
  autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 expandtab
	autocmd FileType groovy setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
	autocmd FileType php setlocal foldmethod=marker ts=4 sw=4 sts=4 expandtab
augroup end

augroup filetype_fix
  autocmd FileType plaintex set ft=tex
augroup end

augroup filetype_nginx
	autocmd Filetype nginx  setlocal sw=4 ts=4 expandtab sts=4
augroup end
"}}}

" from Damian Conway, More Instantly Better Vim - OSCON 2013 {{{
" ColorColumn
call matchadd('ColorColumn', '\%81v', 100)
autocmd Filetype xhtml,html,php call clearmatches() " html is special

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
"}}}

" others {{{
set listchars=tab:\ \ ,trail:·
set list

nnoremap  ;  :
nnoremap  :  ;

nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

nnoremap <Down> 5j
nnoremap <Up>   5k
nnoremap <Left> 5h
nnoremap <Right> 5l

nnoremap H ^
nnoremap L $

inoremap kj <esc>
cnoremap kj <C-c>

vnoremap ty "+y
nnoremap tp "+p
nnoremap a9 v<esc>ea(<esc>A)<esc>gv<esc>
cmap w!! w !sudo tee % > /dev/null
nnoremap cp :e %:h<enter>

command! SSS :syntax sync formstart
let g:python3_host_prog = '/opt/homebrew/bin/python3'
"}}}

lua require('setup')
