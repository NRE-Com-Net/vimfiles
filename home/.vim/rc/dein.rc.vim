" dein configurations.

let g:dein#auto_recache = v:true
let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = v:true

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
	finish
endif

let s:dein_toml = expand($RC_PATH . '/dein.toml')
let s:dein_lazy_toml = expand($RC_PATH . '/deinlazy.toml')
let s:dein_ft_toml = expand($RC_PATH . '/deinft.toml')

call dein#begin(s:path, expand('<sfile>'))

call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
call dein#load_toml(s:dein_ft_toml)
call dein#load_toml(expand($RC_PATH . '/deineo.toml'), {})

let s:vimrc_local = findfile('vimrc_local.vim', '.;')
if s:vimrc_local !=# ''
	call dein#local(fnamemodify(s:vimrc_local, ':h'),
		\ {'frozen': 1, 'merged': 0},
		\ ['vim*', 'unite-*', 'neco-*', '*.vim'])
	call dein#local(fnamemodify(s:vimrc_local, ':h'),
		\ {'frozen': 1, 'merged': 0},
		\ ['deoplete-*', '*.nvim'])
endif

if dein#tap('deoplete.nvim') && has('nvim')
	call dein#disable('neocomplete.vim')
endif
call dein#disable('neobundle.vim')
call dein#disable('neopairs.vim')

call dein#end()

if !has('vim_starting') && dein#check_install()
	" Installation check.
	call dein#install()
endif
