" =============================================================================
" Plastic's Vim config - 01/2015
" ==============================================================================
"
"	A. BASIC CONFIG
"		1. Interface
"		2. Colors
"		3. Indentation
"		4. Search
"		6. Key mapping
"		7. Misc
"		8. Yankless paste
"
"	B. PERSISTENCE
"		1. Backups
"		2. Swap files
"		2. Restore session
"		4. Save buffers
"		5. Undo history
"
"	C. PLUGINS
"		1. Vundle
"		2. Tomorrow-night
"		3. Syntastic
"		4. Gundo
"		5. YouCompleteMe
"		6. EasyMotion
"		7. Airline
"		8. Template
"		9. Rainbow Parentheses
"		10. UltiSnips
"
" ==============================================================================


" =========================
" A. BASIC CONFIG
" =========================

"1" Interface :
"--------------------
set title						" Display filename in title bar
set ttyfast						" More reactive displaying
set number						" Show line number
set mousehide					" Hide mouse cursor when typing
set showcmd						" Show incomplete command
set wildmenu					" Display command auto-completion with tab
set splitbelow					" New horizontal split appears below
set splitright					" New vertical split appears on right
"--------------------

"2" Colors :
"--------------------
set t_Co=256					" Enable 256 colors mode
syntax on						" Syntax coloration
"--------------------

"3" Indentation :
"--------------------
set noexpandtab					" Disable tab to spaces
set tabstop=4					" 4 column by tab"
set autoindent					" Same indent as previous lines
set smartindent					" Auto-indentation in while, if, etc...
set backspace=indent,eol,start	" Restore normal backspace comportement
set shiftwidth=4				" Auto-indent with 4 columns"
"--------------------

"4" Search :
"--------------------
set history=500					" 500 command line history
set ignorecase					" Ignore case in search
set smartcase					" Don't ignore case when capitale is typed
set incsearch					" Highlight typed word during typing
set hlsearch					" Highlight typed word
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
" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Check norm
map <F4> :!norminette **/*.{c,h} <CR>
" Switch tab
nnoremap { :tabprevious <CR>
nnoremap } :tabnext <CR>
"--------------------

"7" Misc :
"-------------------- 
set nocompatible				" Disable vi compatibility
set autoread					" Refresh current file when modified by another editor
set undolevels=500				" 500 undo history
set showmatch					" Show matching bracket
set matchtime=10				" Show matching bracket for 1 second
set scrolloff=5					" Display minimum five lines around the cursor
set sidescrolloff=15			" Display minimum five columns around the cursor
set cursorline					" Display horizontal line on the cursor position
set nowrap						" Don't wrap text on multiple lines
"--------------------

"8" Yankless paste :
"--------------------
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Repl()
"--------------------


" =========================
" B. PERSISTENCE
" =========================

"1" Backups :
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

"2" Swap files :
"--------------------
if isdirectory($HOME . '/.vim/swap') == 0
	:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=~/.vim/swap//
set directory+=.
"--------------------

"3" Restore session :
"--------------------
set viminfo+=n~/.vim/viminfo
"--------------------

"4" Save buffers :
"--------------------
map <F5> :mksession! .mysession.vim<CR>
"--------------------

"5" Undo history :
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
" C. PLUGINS
" =========================

"1" Vundle :
"--------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'					"Vundle
Plugin 'scrooloose/syntastic.git'			"Syntastic
Plugin 'sjl/gundo.vim'						"Gundo
Plugin 'Lokaltog/vim-easymotion.git'		"EasyMotion
Plugin 'bling/vim-airline.git'				"Airline
Plugin 'tpope/vim-commentary.git'			"Commentary plugin
Plugin 'aperezdc/vim-template.git'			"Template
Plugin 'Valloric/YouCompleteMe.git'			"YouCompleteMe
Plugin 'Raimondi/delimitMate.git'			"delimitMate
Plugin 'luochen1990/rainbow'				"Rainbow Parentheses
Plugin 'vim-scripts/matchit.zip.git'		"MatchIt
Plugin 'tpope/vim-repeat.git'				"RepeatVim
Plugin 'sirver/ultisnips'					"Ultisnips
Plugin 'kien/ctrlp.vim.git'					"CtrlP
Plugin 'Plastic-1/tomorrow-theme.git'		"Colorscheme tomorrow-night
Plugin 'Plastic-1/Templates-snippets.git'	"Custom templates/snippets
Plugin 'Plastic-1/Stdheader'				"Stdheader

call vundle#end()
filetype plugin indent on
"--------------------

"2" Tomorrow-night :
"--------------------
silent! colorscheme Tomorrow-Night			"Enable theme with silent! to avoid error on first launch
"--------------------

"3" Syntastic :
"--------------------
let g:syntastic_c_compiler_options = '-Werror -Wextra -Wall -pedantic'
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-Werror -Wextra -Wall -pedantic'
let g:syntastic_cpp_compiler = 'g++'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"--------------------

"4" Gundo :
"--------------------
nnoremap U :GundoToggle<CR>
"--------------------

"5" YouCompleteMe :
"--------------------
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/Templates-snippets/ycm_conf/ycm_c++_conf.py"
let g:ycm_confirm_extra_conf = 1			"Disable confimation message
let g:ycm_register_as_syntastic_checker = 0	"Don't overide Syntastic plugin
try
	set shortmess+=c						"Disable "Pattern not found" message
catch /E539: Illegal character/
endtry
let g:ycm_use_ultisnips_completer = 1		"Display available snippets
"--------------------

"6" EasyMotion :
"--------------------
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"--------------------

"7" Airline :
"--------------------
set laststatus=2							"Always show airline
let g:airline_powerline_fonts = 1			"Enable patched fonts
let g:airline_theme = 'tomorrow'
set noshowmode
"--------------------

"8" Template :
"--------------------
let g:templates_directory = '~/.vim/bundle/Templates-snippets/templates'
"--------------------

"9" Rainbow Parentheses :
"--------------------
let g:rainbow_active = 0
nnoremap <leader><leader>( :RainbowToggle<CR>
"--------------------

"10" UltiSnips
"--------------------
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-S-e>"
let g:UltiSnipsJumpBackwardTrigger="<C-w>"
"--------------------
