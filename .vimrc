"	Vimrc 
"	Basic Settings	{{{ 1
set number
set ruler
set showcmd
set showmode
set incsearch
nnoremap <ESC><ESC> :nohlsearch<CR>
set background=dark
set nocompatible
set cursorline
set nostartofline
set ignorecase
set smartcase
set laststatus=2
set visualbell t_vb=
set wildmenu
set foldmethod=manual
set modeline
set modelines=3
set foldcolumn=3
" When using vim build on mac, Delete key does not work.
set backspace=2
set statusline=%f%m%=%y[%{&fileencoding}][%{&fileformat}]

set foldtext=MyFoldText()
function! MyFoldText()
	let line = getline(v:foldstart)
    let subline = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')	" }}} dummy
	let length = v:foldend - v:foldstart
	"return v:folddashes . subline . "[ " . length . " lines ]"
	return subline . "[ " . length . " lines ]"
endfunction

imap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>
" }}}

"	Syntax and Indent	{{{
syntax on
set autoindent
set smartindent

"	tab( reference: http://peacepipe.toshiville.com/2006/05/vimrc-vim.html )
set tabstop=4
set softtabstop=0
set shiftwidth=4

filetype on
filetype indent on
filetype plugin on
highlight PreProc ctermfg=lightgreen

"}}}

"	Key Mapping	{{{ 
:nmap <Space> <PageDown>
:nmap <S-Space> <PageUp>
:nmap ; :
" }}}

"	Gtags Related {{{ 
map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>
" }}}

"	Explorer(vim default implemented filer related)	{{{1
nmap <Leader>e :e .<CR>
let g:netrw_liststyle=3
" }}}

"	Japanese	{{{ 
"set termencoding=euc-jp
"set encoding=japan
"set fenc=euc-jp
"set enc=euc-jp
" }}}


"	QuickFix etc... 	{{{
augroup greopen
	autocmd!
	autocmd QuickfixCmdPost vimgrep cw
augroup END
au QuickfixCmdPost make,grep,grepadd,vimgrep copen

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
map <Leader>c :cclose<cr>:SCCompile<cr>
map <Leader>r :cclose<cr>:SCCompileRun<cr>
"	}}}

" Programs {{{1
"	C/C++	{{{2
function! Set_C_CPP_Common()
	setl cindent
	set path=.,/usr/local/include,/usr/include
	setl tabstop=8 expandtab shiftwidth=4 softtabstop=4  
	set foldmethod=syntax
	set foldnestmax=3
	"map <Leader>r <Esc>:!./a.out<CR>
	set foldmethod=syntax
	set foldlevel=0
	set foldnestmax=2
endfunction

function! Set_CPP_Settings()
	call Set_C_CPP_Common()
	"map <Leader>c <Esc>:!g++ %<CR>
	"map <Leader>C <Esc>:!clang++ %<CR>
	set path+=/usr/include/c++/4.2.1
endfunction

function! Set_C_Settings()
	"map <Leader>c <Esc>:!llvm-gcc %<CR>
	"map <Leader>C <Esc>:!clang %<CR>
	call Set_C_CPP_Common()
endfunction

autocmd FileType c	call Set_C_Settings()
autocmd FileType cpp	call Set_CPP_Settings()
" }}}

"	Lisp	{{{2
function! SetLispSettings()
	map <Leader>l <Esc>:!clisp -i %<CR>
endfunction

autocmd FileType lisp call SetLispSettings()
" }}}

"	Python	{{{2
function! SetPythonSettings()
	setl autoindent
	setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
	setl tabstop=8 expandtab shiftwidth=4 softtabstop=4                          
	"map <Leader>p <Esc>:!python %<CR>
endfunction

autocmd FileType python	call SetPythonSettings()
autocmd FileType pyrex	call SetPythonSettings()
" }}}

"	Ruby	{{{2
function! SetRubySettings()
	"map <Leader>r <Esc>:!ruby %<CR>
	"
	"Fold Related
	set foldmethod=indent
	set foldlevel=0
	set foldnestmax=2
endfunction

autocmd FileType ruby	call SetRubySettings()
" }}}

au BufRead,BufNewFile *.bngl set filetype=bngl
"
" 	BioNetGen {{{2
au BufRead,BufNewFile *.bngl set filetype=bngl
"
" }}}
"
" }}}

"	Tab Related	{{{
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

"always shows tabline
set showtabline=2 

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
map <silent> [Tag]l :tabs<CR>
" list tabs
" }}}
"
"

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
