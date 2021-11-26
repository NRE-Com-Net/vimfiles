"--------------------------------------------------------------------------------------------------
" Search:
"

" Ignore the case of normal letters.
set ignorecase

" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch

" Don't highlight search result.
set hlsearch

" Searches wrap around the end of the file.
set wrapscan

"---------------------------------------------------------------------------
" Edit:
"

" Smart insert tab setting.
set smarttab
" Don't exchange tab to spaces.
set expandtab
" Substitute <Tab> with blanks.
set tabstop=2
" Spaces instead <Tab>.
set softtabstop=2
" Autoindent width.
set shiftwidth=2
" Round indent by shiftwidth.
set shiftround

set autoindent smartindent
"wrapping
set wrap        "wrap lines
set linebreak   "wrap lines at convenient points
" Enable modeline.
set modeline
set modelines=5
"show linenumbers
set number

" Use clipboard register.
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
    if has('unnamedplus')
        set clipboard& clipboard+=unnamedplus
    else
        set clipboard& clipboard+=unnamed
    endif
endif

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch
" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=3
" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
set hidden

" Ignore case on insert completion.
set infercase

" Search home directory path on cd.
" But can't complete.
" set cdpath+=~

" Enable folding.
set nofoldenable
" set foldmethod=expr
set foldmethod=syntax
" Show folding level.
if has('nvim')
  set foldcolumn=auto:1
else
  set foldcolumn=1
endif
set fillchars=vert:\|

if exists('*FoldCCtext')
    " Use FoldCCtext().
    set foldtext=FoldCCtext()
endif

" Use vimgrep.
"set grepprg=internal
" Use grep.
set grepprg=grep\ -inH

" Exclude = from isfilename.
set isfname-==

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=100

" Set swap directory.
if !isdirectory(expand($CACHE . '/swapfiles'))
    call mkdir(expand($CACHE . '/swapfiles'), 'p')
endif
set directory=$CACHE/swapfiles

set undofile
if !isdirectory(expand($CACHE . '/undofiles'))
    call mkdir(expand($CACHE . '/undofiles'), 'p')
endif
set undodir=$CACHE/undofiles
set undolevels=1000
set undoreload=10000
if has('nvim')
    set shada=!,'500,<500,@100,/50,:100,f1,h,n$CACHE/nviminfo
else
    set viminfo=!,'500,<500,@100,/50,:100,f1,h,n$CACHE/viminfo
endif

if !isdirectory(expand($CACHE . '/backupfiles'))
    call mkdir(expand($CACHE . '/backupfiles'), 'p')
endif
set backupdir=$CACHE/backupfiles
set colorcolumn=100

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help.
set keywordprg=:help

" Check timestamp more for 'autoread'.
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
        \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
        \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/

autocmd MyAutoCmd BufWritePre *
            \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force)
    if !isdirectory(a:dir) && &l:buftype == '' &&
                \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
                \              a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

" Use autofmt.
set formatexpr=autofmt#compat#formatexpr()


"---------------------------------------------------------------------------
" View:
"

" Anywhere SID.
function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Show <TAB> and <CR>
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
" Do not wrap long line.
set nowrap
" Wrap conditions.
set whichwrap+=h,l,<,>,[,],b,s,~
set breakindent
" Always display statusline.
set laststatus=2

set linebreak
set showbreak=>\
set breakat=\ \	;:,!?

set cursorline

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" TMUX fix {{{
" tell vim that the term has 256 colors
if &term =~ '256color'
	set t_ut=
endif
" allows cursor change in tmux mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"}}}

" Disable bell.
set t_vb=
set novisualbell

" Display candidate supplement.
if has('nvim')
  " Display candidates by popup menu.
  set wildmenu
  set wildmode=full
  set wildoptions+=pum
else
  " Display candidates by list.
  set nowildmenu
  set wildmode=list:longest,full
endif

set wildignore=*.o,*.obj,*.pyc.,*.dll "stuff to ignore when tab completing
" Increase history amount.
set history=1000
" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag
" Can supplement a tag in a command-line.
set wildoptions+=tagfile

" Disable menu
let g:did_install_default_menus = 1

if !&verbose
	" Enable spell check.
	set spelllang=en_us
	" Enable de_de support.
	"set spelllang+=de_de
endif

" Completion setting.
set completeopt=menuone
" Don't complete from other buffer.
"set complete=.
set complete=.,w,b,i,t
" Set popup menu max height.
set pumheight=20

" Report changes.
set report=0

" Maintain a current line at the time of movement as much as possible.
set nostartofline

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
" set winheight=20
set winheight=1
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways

" Adjust window size of preview and help.
set previewheight=25
set helpheight=25

" Don't redraw while macro executing.
set lazyredraw
set ttyfast

" When a line is long, do not omit it in @.
set display=lastline
" Display an invisible letter with hex format.
"set display+=uhex

" View setting.
set viewdir=$CACHE/vim_view viewoptions-=options viewoptions+=slash,unix

function! s:strwidthpart(str, width) "{{{
	if a:width <= 0
		return ''
	endif
	let ret = a:str
	let width = s:wcswidth(a:str)
	while width > a:width
		let char = matchstr(ret, '.$')
		let ret = ret[: -1 - len(char)]
		let width -= s:wcswidth(char)
	endwhile

	return ret
endfunction"}}}

if v:version >= 703 || has('nvim')
	" For conceal.
	set conceallevel=2 concealcursor=iv

	set colorcolumn=100

	" Use builtin function.
	function! s:wcswidth(str)
		return strwidth(a:str)
	endfunction
	finish
endif

function! s:wcswidth(str)
	if a:str =~# '^[\x00-\x7f]*$'
		return strlen(a:str)
	end

	let mx_first = '^\(.\)'
	let str = a:str
	let width = 0
	while 1
		let ucs = char2nr(substitute(str, mx_first, '\1', ''))
		if ucs == 0
			break
		endif
		let width += s:_wcwidth(ucs)
		let str = substitute(str, mx_first, '', '')
	endwhile
	return width
endfunction

" UTF-8 only.
function! s:_wcwidth(ucs)
	let ucs = a:ucs
	if (ucs >= 0x1100
				\  && (ucs <= 0x115f
				\  || ucs == 0x2329
				\  || ucs == 0x232a
				\  || (ucs >= 0x2e80 && ucs <= 0xa4cf && ucs != 0x303f)
				\  || (ucs >= 0xac00 && ucs <= 0xd7a3)
				\  || (ucs >= 0xf900 && ucs <= 0xfaff)
				\  || (ucs >= 0xfe30 && ucs <= 0xfe6f)
				\  || (ucs >= 0xff00 && ucs <= 0xff60)
				\  || (ucs >= 0xffe0 && ucs <= 0xffe6)
				\  || (ucs >= 0x20000 && ucs <= 0x2fffd)
				\  || (ucs >= 0x30000 && ucs <= 0x3fffd)
				\  ))
		return 2
	endif
	return 1
endfunction
"}}}

" View logfiles as ft messages
autocmd BufNewFile,BufReadPost *.log :set filetype=messages
autocmd BufNewFile,BufReadPost /var/log/* :set filetype=messages


"--------------------------------------------------------------------------------------------------
" Others:
"

" If true Vim master, use English help file.
set helplang& helplang=en

" Default home directory.
let t:cwd = getcwd()
