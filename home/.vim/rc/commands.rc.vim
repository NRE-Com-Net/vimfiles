"jump to last cursor position when opening a file, dont do it when writing a commit log entry
fun! AutojumpLastPosition()
	if ! exists('b:autojumped_init')
		let b:autojumped_init = 1
		if &ft != 'gitcommit' && &ft != 'diff' && ! &diff && line("'\"") <= line("$") && line("'\"") > 0
			" NOTE: `zv` is ignored with foldlevel in modeline.
			exe 'normal! g`"zv'
		endif
	endif
endfun
au BufReadPost * call AutojumpLastPosition()"

function! FullyRedraw()
	nohls
	syntax sync fromstart
endfunction

function! CopyModeToggle()
	if &foldcolumn
		setlocal nolist
		setlocal nonumber
		setlocal foldcolumn=0
		if neobundle#is_sourced('vim-signify')
			call sy#stop(b:sy.buffer)
		endif
		if neobundle#is_sourced('vim-gitgutter')
			GitGutterSignsDisable
		endif
	else
		setlocal foldcolumn=1
		setlocal list
		setlocal number
		if neobundle#is_sourced('vim-signify')
			call sy#start()
		endif
		if neobundle#is_sourced('vim-gitgutter')
			GitGutterSignsEnable
		endif
	endif
endfunction

" autocommands for fugitive {{{2
" Source: http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
au User fugitive
			\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)' |
			\   nnoremap <buffer> .. :edit %:h<CR> |
			\ endif
au BufReadPost fugitive://* set bufhidden=delete

if neobundle#is_sourced('neosnippet.vim') "{{{
	autocmd InsertLeave * NeoSnippetClearMarkers
endif "}}}
