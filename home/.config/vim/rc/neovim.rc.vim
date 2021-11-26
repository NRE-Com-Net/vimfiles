"---------------------------------------------------------------------------
" For neovim:
"

if has('vim_starting') && empty(argv())
  syntax off
endif

tnoremap   <ESC><ESC>   <C-\><C-n>

" Share the histories
" augroup MyAutoCmd
"   autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
" augroup END

" Use cursor shape feature
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
