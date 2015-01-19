" ==============================================================================
" Plastic's Vim config - 09/2013
" ==============================================================================
"
"	A. BASIC CONFIG
"		1. Interface
"		2. Colors
"		3. Indentation
"		4. Search
"		6. Key mapping
"		7. Misc
"
"	B. 42 NORM C/C++
"		1. Space & Tab
"		2. Parenthesis
"		3. Line size limit
"		4. Auto header
"		5. Auto .h protect
"		6. Auto .sh env
"
"	C. PERSISTENCE
"		1. Backups
"		2. Swap files
"		2. Restore session
"		4. Save buffers
"		5. Undo history
"
"	D. PLUGINS
"		1. Pathogen
"		2. NERDTree
"		3. NERDCommenter
"
"	E. MISC
"		1. Skeletons
"
" ==============================================================================

" =========================
" A. BASIC CONFIG
" =========================
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'https://github.com/sickill/vim-monokai'	"Colorscheme monokai

call vundle#end()
filetype plugin indent on
colorscheme monokai		" Enable mustang theme

"1" Interface :
"--------------------
set title			" Display filename in title bar
set ttyfast			" More reactive displaying
set number			" Show line number
set mousehide			" Hide mouse cursor when typing
"set mouse=a			" Disable mouse support
"set showcmd			" Show incomplete command
"set wildmenu			" Display command auto-completion with tab
"--------------------

"2" Colors :
"--------------------
set t_Co=256			" Enable 256 colors mode
syntax on			" Syntax coloration
"--------------------

"3" Indentation :
"--------------------
set noexpandtab			" Disable tab to spaces
"set tabstop=4			" 4 column by tab
set autoindent			" Same indent as previous lines
set smartindent			" Auto-indentation in while, if, etc...
set shiftwidth=4		" Auto-indent with 4 columns
set backspace=indent,eol,start	" Restore normal backspace comportement
"--------------------

"4" Search :
"--------------------
set history=500			" 500 command line history
set ignorecase			" Ignore case in search
set smartcase			" Don't ignore case when capitale is typed
set incsearch			" Highlight typed word during typing
set hlsearch			" Highlight typed word
"--------------------

"6" Key mapping :
"--------------------
" Enable/Disable paste mode
map <F6> :set paste <CR>
map <S-F6> :set nopaste <CR>
" Replace escape key
imap ;j <Esc>
nmap ;j <Esc>
vmap ;j <Esc>
"--------------------

"7" Misc :
"-------------------- set nocompatible		" Disable vi compatibility set autoread			" Refresh current file when modified by another editor
set undolevels=500		" 500 undo history
set showmatch			" Show matching bracket
set matchtime=10		" Show matching bracket for 1 second
set scrolloff=5			" Display minimum five lines around the cursor
set sidescrolloff=15		" Display minimum five columns around the cursor
set cursorline			" Display horizontal line on the cursor position
set nowrap			" Don't wrap text on multiple lines
"--------------------

" =========================
" B. 42 NORM C/C++
" =========================

" Auto header
"--------------------
"autocmd BufNewFile *.{c,cpp,h,hpp} :Stdheader
"--------------------

"5" Auto .h protect
"--------------------
"function! s:insert_gates()
"let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
"	execute "normal! i#ifndef " . gatename
"	execute "normal! o# define " . gatename
"	execute "normal! o"
"	execute "normal! Go#endif /* !" . gatename . " */"
"	normal! kk
"endfunction
"autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
"autocmd BufNewFile *.{h,hpp} :3
"--------------------

"6" Auto .sh env
"--------------------
"function! s:insert_env()
"	execute "normal! i#!/bin/sh"
"	execute "normal! o"
"	normal kk
"endfunction
"autocmd BufNewFile *.sh call <SID>insert_env()
"autocmd BufNewFile *.sh :2
"--------------------

" =========================
" C. PERSISTENCE (By TWal)
" =========================

"1" Backups
"--------------------
if isdirectory($HOME . '/.vim/backup') == 0
	:silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backup
"--------------------

"2" Swap files
"--------------------
if isdirectory($HOME . '/.vim/swap') == 0
	:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=~/.vim/swap//
set directory+=.
"--------------------

"3" Restore session
"--------------------
set viminfo+=n~/.vim/viminfo
"--------------------

"4" Save buffers
"--------------------
map <F5> :mksession! .mysession.vim<CR>
"--------------------

"5" Undo history
"--------------------
if exists("+undofile")
	if isdirectory($HOME . '/.vim/undo') == 0
		:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
	endif
	set undodir=~/.vim/undo//
	set undodir=~/.vim/undo//
	set undofile
endif
"--------------------

" =========================
" D. PLUGINS
" =========================
" set the runtime path to include Vundle and initialize
