" dein configurations.

let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, [expand('<sfile>')]
      \ + split(glob($RC_PATH . '/*.toml'), '\n'))

call dein#load_toml(expand($RC_PATH . '/dein.toml'), {'lazy': 0})
call dein#load_toml(expand($RC_PATH . '/deinlazy.toml'), {'lazy' : 1})
if has('nvim')
  call dein#load_toml(expand($RC_PATH . '/deineo.toml'), {})
endif
call dein#load_toml(expand($RC_PATH . '/deinft.toml'))

let s:vimrc_local = findfile('vimrc_local.vim', '.;')
if s:vimrc_local !=# ''
  " Load develop version plugins.
  call dein#local(fnamemodify(s:vimrc_local, ':h'),
        \ {'frozen': 1, 'merged': 0},
        \ ['vim*', 'unite-*', 'neco-*', '*.vim'])
  if has('nvim')
    call dein#local(fnamemodify(s:vimrc_local, ':h'),
          \ {'frozen': 1, 'merged': 0},
          \ ['deoplete-*', '*.nvim'])
  endif
endif

call dein#disable('neobundle.vim')
call dein#disable('neopairs.vim')

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif
