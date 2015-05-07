" NemesisRE's .vimrc (shameless taken from https://github.com/Shougo/shougo-s-github)
"--------------------------------------------------------------------------------------------------

"--------------------------------------------------------------------------------------------------
" Initialize:
"
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
	set nocompatible
endif

if has('nvim')
	runtime! plugin/python_setup.vim
	set unnamedclip
endif

function! g:Source_rc(path)
	execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER != '' && $USER !=# $SUDO_USER
			\ && $HOME !=# expand('~'.$USER)
			\ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
	return s:is_windows
endfunction

function! IsMac()
	return !s:is_windows && !s:is_cygwin
				\ && (has('mac') || has('macunix') || has('gui_macvim') ||
				\   (!executable('xdg-open') &&
				\     system('uname') =~? '^darwin'))
endfunction

call g:Source_rc('init.rc.vim')

call neobundle#begin(expand('$CACHE/neobundle'))

" Use NeoBundleCache
if neobundle#load_cache(g:Source_rc('neobundle.rc.vim'))
	NeoBundleFetch 'Shougo/neobundle.vim'

	NeoBundle 'Shougo/vimproc.vim', {
				\ 'build' : {
				\     'windows' : 'tools\\update-dll-mingw',
				\     'cygwin' : 'make -f make_cygwin.mak',
				\     'mac' : 'make -f make_mac.mak',
				\     'unix' : 'make -f make_unix.mak',
				\    }
				\ }

	"call neobundle#load_toml(
	"	\ '~/.vim/rc/neobundle.toml', {'lazy' : 1})
	call g:Source_rc('neobundle.rc.vim')
	NeoBundleSaveCache
	NeoBundleClean
endif

if isdirectory(expand('~/.vim/localbundle'))
	NeoBundleLocal expand(~/.vim/localbundle)
endif

call neobundle#end()

"load ftplugins and indent files
filetype plugin indent on
"turn on syntax highlighting
syntax on

" Installation check.
if !has('vim_starting')
	NeoBundleCheck
endif

"--------------------------------------------------------------------------------------------------
" Encoding:
"

call g:Source_rc('encoding.rc.vim')

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

"--------------------------------------------------------------------------------------------------
" Edit:
"

call g:Source_rc('edit.rc.vim')

"--------------------------------------------------------------------------------------------------
" View:
"

call g:Source_rc('view.rc.vim')

"--------------------------------------------------------------------------------------------------
" FileType:
"

call g:Source_rc('filetype.rc.vim')

"--------------------------------------------------------------------------------------------------
" Plugin:
"

call g:Source_rc('plugins.rc.vim')

"--------------------------------------------------------------------------------------------------
" Mappings:
"

call g:Source_rc('mappings.rc.vim')

"--------------------------------------------------------------------------------------------------
" Platform:
"

if s:is_windows
	call g:Source_rc('windows.rc.vim')
else
	call g:Source_rc('unix.rc.vim')
endif

" Using the mouse on a terminal.
if has('mouse')
	set mouse=a
	if has('mouse_sgr') || v:version > 703 ||
				\ v:version == 703 && has('patch632')
		set ttymouse=sgr
	else
		set ttymouse=xterm2
	endif

	" Paste.
	nnoremap <RightMouse> "+p
	xnoremap <RightMouse> "+p
	inoremap <RightMouse> <C-r><C-o>+
	cnoremap <RightMouse> <C-r>+
endif
"}

"--------------------------------------------------------------------------------------------------
" Commands:
"
call g:Source_rc('commands.rc.vim')

"--------------------------------------------------------------------------------------------------
" GUI:
"

if has('gui_running')
	call g:Source_rc('gui.rc.vim')
endif

"--------------------------------------------------------------------------------------------------
" Others:
"

" If true Vim master, use English help file.
set helplang& helplang=en

" Default home directory.
let t:cwd = getcwd()

call neobundle#call_hook('on_source')

set secure

" vim: foldmethod=marker
