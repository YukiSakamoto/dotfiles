"========================================
"	Basic Settings
"========================================
set number
set ruler
set showcmd
set showmode
set incsearch
set background=dark
set nocompatible
set cursorline
set nostartofline
set ignorecase
set smartcase
set laststatus=2
set visualbell t_vb=
set tabstop=4
set wildmenu

" When using vim build on mac, Delete key does not work.
set backspace=2

imap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>

"========================================
"	Key Mapping
"========================================
:nmap <Space> <PageDown>
:nmap <S-Space> <PageUp>
:nmap ; :

"========================================
"	Gtags
"========================================
map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

"========================================
"	Explorer(Filer ?)
"========================================
nmap <Leader>e :e .<CR>
let g:netrw_liststyle=3

"========================================
"	Japanese
"========================================
"set termencoding=euc-jp
"set encoding=japan
"set fenc=euc-jp
"set enc=euc-jp

"========================================
"	syntax and indent
"========================================
syntax on
set autoindent
set smartindent
filetype on
filetype indent on
filetype plugin on

:nnoremap <ESC><ESC> :nohlsearch<CR>
highlight PreProc ctermfg=lightgreen

"========================================
"	QuickFix etc... 
"========================================
augroup greopen
	autocmd!
	autocmd QuickfixCmdPost vimgrep cw
augroup END

au QuickfixCmdPost make,grep,grepadd,vimgrep copen

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

map <Leader>c :cclose<cr>:SCCompile<cr>
map <Leader>r :cclose<cr>:SCCompileRun<cr>

"========================================
" 	C and C++ Source Code
"========================================
function! Set_C_CPP_Common()
	setl cindent
	set path=.,/usr/local/include,/usr/include
	setl tabstop=8 expandtab shiftwidth=4 softtabstop=4  
	"map <Leader>r <Esc>:!./a.out<CR>
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

"========================================
"	Lisp
"========================================
function! SetLispSettings()
	map <Leader>l <Esc>:!clisp -i %<CR>
endfunction

autocmd FileType lisp call SetLispSettings()

"========================================
"	Python 
"========================================
function! SetPythonSettings()
	setl autoindent
	setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
	setl tabstop=8 expandtab shiftwidth=4 softtabstop=4                          
	"map <Leader>p <Esc>:!python %<CR>
endfunction

autocmd FileType python	call SetPythonSettings()
autocmd FileType pyrex	call SetPythonSettings()

"========================================
"	Ruby
"========================================
function! SetRubySettings()
	"map <Leader>r <Esc>:!ruby %<CR>
endfunction

autocmd FileType ruby	call SetRubySettings()



