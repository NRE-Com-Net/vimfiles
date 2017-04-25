"---------------------------------------------------------------------------
" vimfiler.vim
"
scriptencoding utf-8

let g:vimfiler_as_default_explorer = get(g:, 'vimfiler_as_default_explorer', 1)
let g:vimfiler_time_format = get(g:, 'vimfiler_time_format', '%d/%m/%y %H:%M')

let g:vimfiler_tree_indentation = get(g:, 'vimfiler_tree_indentation', 1)
let g:vimfiler_tree_leaf_icon = get(g:, 'vimfiler_tree_leaf_icon', '├')
let g:vimfiler_tree_opened_icon = get(g:, 'vimfiler_tree_opened_icon', '┐')
let g:vimfiler_tree_closed_icon = get(g:, 'vimfiler_tree_closed_icon', '─')
let g:vimfiler_file_icon = get(g:, 'vimfiler_file_icon', '┄')
let g:vimfiler_readonly_file_icon = get(g:, 'vimfiler_readonly_file_icon', '✗')
let g:vimfiler_marked_file_icon = get(g:, 'vimfiler_marked_file_icon', '✓')

let g:vimfiler_ignore_pattern = get(g:, 'vimfiler_ignore_pattern', [
			\ '^\.git$',
			\ '^\.DS_Store$',
			\ '^\.init\.vim-rplugin\~$',
			\ '^\.netrwhist$',
			\ '\.class$'
			\])

call vimfiler#custom#profile('default', 'context', {
			\ 'explorer' : 1,
			\ 'winwidth' : 50,
			\ 'toggle' : 1,
			\ 'auto_expand': 1,
			\ 'direction' : 'topleft',
			\ 'columns' : 'devicons::size:time',
			\ 'explorer_columns' : 'devicons:size:time',
			\ 'parent': 0,
			\ 'status' : 1,
			\ 'safe' : 0,
			\ 'split' : 1,
			\ 'hidden': 1,
			\ 'no_quit' : 1,
			\ 'force_hide' : 0,
			\ })

augroup vfinit
  au!
  autocmd FileType vimfiler call s:vimfilerinit()
  autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') |
        \ q | endif
augroup END
function! s:vimfilerinit()
  set nonumber
  set norelativenumber
endf
