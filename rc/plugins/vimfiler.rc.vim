"---------------------------------------------------------------------------
" vimfiler.vim
"
scriptencoding utf-8
let g:vimfiler_as_default_explorer = get(g:, 'vimfiler_as_default_explorer', 1)
"let g:vimfiler_restore_alternate_file = get(g:, 'vimfiler_restore_alternate_file', 1)
let g:vimfiler_tree_indentation = get(g:, 'vimfiler_tree_indentation', 1)
let g:vimfiler_tree_leaf_icon = get(g:, 'vimfiler_tree_leaf_icon', '')
let g:vimfiler_tree_opened_icon = get(g:, 'vimfiler_tree_opened_icon', '▼')
let g:vimfiler_tree_closed_icon = get(g:, 'vimfiler_tree_closed_icon', '▷')
let g:vimfiler_file_icon = get(g:, 'vimfiler_file_icon', '')
let g:vimfiler_readonly_file_icon = get(g:, 'vimfiler_readonly_file_icon', '*')
let g:vimfiler_marked_file_icon = get(g:, 'vimfiler_marked_file_icon', '√')
let g:vimfiler_preview_action = 'auto_preview'
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
      \ 'winminwidth' : 30,
      \ 'toggle' : 1,
      \ 'auto_expand': 1,
      \ 'direction' : 'topleft',
      \ 'parent': 0,
      \ 'status' : 1,
      \ 'safe' : 0,
      \ 'split' : 1,
      \ 'hidden': 1,
      \ 'no_quit' : 1,
      \ 'force_hide' : 0,
      \ })

