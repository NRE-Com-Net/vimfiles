"---------------------------------------------------------------------------
" Plugin:
"

let g:inet_connection = system("ping -q -c 2 -W 1 google.com 2>&1 >/dev/null; echo ${?}")

if neobundle#tap('deoplete.nvim') && has('nvim') "{{{
	let g:deoplete#enable_at_startup = 1
	let neobundle#hooks.on_source =
				\ '~/.vim/rc/plugins/deoplete.rc.vim'

	call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') && has('lua') "{{{
	let g:neocomplete#enable_at_startup = 1
	let neobundle#hooks.on_source =
				\ '~/.vim/rc/plugins/neocomplete.rc.vim'

	call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplcache.vim') "{{{
	let g:neocomplcache_enable_at_startup = 0
	let neobundle#hooks.on_source =
				\ '~/.vim/rc/plugins/neocomplcache.rc.vim'

	call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/neosnippet.rc.vim'
	call neobundle#untap()
endif "}}}

if neobundle#tap('echodoc.vim') "{{{
	let g:echodoc_enable_at_startup = 1

	call neobundle#untap()
endif "}}}

if neobundle#tap('vimshell.vim') "{{{
	nmap <C-@>  <Plug>(vimshell_switch)
	nnoremap !  q:VimShellExecute<Space>
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/vimshell.rc.vim'
	call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
	nnoremap <silent> <F1> :<C-u>Unite -profile-name=menu menu:Main<CR>
	inoremap <silent> <F1> <C-o>:<C-u>Unite -profile-name=menu menu:Main<CR>
	nnoremap <silent> <F4> :<C-u>Unite buffer_tab -toggle -start-insert<CR>
	inoremap <silent> <F4> <C-o>:<C-u>Unite buffer_tab -toggle -start-insert<CR>
	nnoremap <silent> <F9> :<C-u>Unite tasklist -toggle -start-insert -vertical -winwidth=40<CR>
	inoremap <silent> <F9> <C-o>:<C-u>Unite tasklist -toggle -start-insert -vertical -winwidth=40<CR>
	nnoremap <silent> <C-P> :<C-u>Unite -buffer-name=files -toggle -start-insert neomru/file file_rec/async:!<CR>
	nnoremap <silent> <C-f> :<C-u>Unite grep:. -buffer-name=grep%".tabpagenr()." -toggle -auto-preview -no-split -no-empty<CR>
	inoremap <silent> <F10> <C-o>:<C-u>Unite -buffer-name=register -toggle register history/yank<CR>
	nnoremap <silent> <F10> :<C-u>Unite -buffer-name=register -toggle register history/yank<CR>
	" Execute help.
	nnoremap <silent> <C-h>  :<C-u>Unite -buffer-name=help help<CR>
	" Execute help by cursor keyword.
	nnoremap <silent> g<C-h>	:<C-u>UniteWithCursorWord help<CR>
	" Search.
	nnoremap <silent><expr> / ":\<C-u>Unite -buffer-name=search line:all -start-insert -no-quit\<CR>"
	nnoremap <expr> g/  <SID>smart_search_expr('g/',
				\ :<C-u>Unite -buffer-name=search -start-insert line_migemo<CR>)
	nnoremap <silent><expr> ? ":\<C-u>Unite -buffer-name=search%".bufnr('%')." -start-insert line:backward\<CR>"
	nnoremap <silent><expr> * ":\<C-u>UniteWithCursorWord -buffer-name=search%".bufnr('%')." line:forward:wrap\<CR>"
	cnoremap <expr><silent><C-g> (getcmdtype() == '/') ?
				\ "\<ESC>:Unite -buffer-name=search line:forward:wrap -input=".getcmdline()."\<CR>" : "\<C-g>"
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/unite.rc.vim'
	call neobundle#untap()
endif "}}}

if neobundle#tap('vimfiler.vim') "{{{
	nnoremap <silent> <F2> :<C-u>VimFilerExplorer -parent -explorer-columns=type:size:time -toggle -no-safe -winwidth=50<CR>
	:imap <silent> <F2> <C-o>:<C-u>VimFilerExplorer -parent -explorer-columns=type:size:time -toggle -no-safe -winwidth=50<CR>
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/vimfiler.rc.vim'
endif "}}}

if neobundle#tap('quickrun.vim') "{{{
	nmap <silent> <Leader>r <Plug>(quickrun)
endif "}}}

if neobundle#tap('python.vim') "{{{
	let python_highlight_all = 1
endif "}}}

if neobundle#tap('vim-ref') "{{{
	function! neobundle#hooks.on_source(bundle)
		let g:ref_cache_dir = expand('$CACHE/ref')
		let g:ref_use_vimproc = 1
		if IsWindows()
			let g:ref_refe_encoding = 'cp932'
		endif
		" ref-lynx.
		if IsWindows()
			let lynx = 'C:/lynx/lynx.exe'
			let cfg  = 'C:/lynx/lynx.cfg'
			let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
			let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
		endif
		let g:ref_lynx_use_cache = 1
		let g:ref_lynx_start_linenumber = 0 " Skip.
		let g:ref_lynx_hide_url_number = 0
		autocmd MyAutoCmd FileType ref call s:ref_my_settings()
		function! s:ref_my_settings() "{{{
			" Overwrite settings.
			nmap <buffer> [Tag]t	<Plug>(ref-keyword)
			nmap <buffer> [Tag]p	<Plug>(ref-back)
		endfunction"}}}
	endfunction
endif"}}}

if neobundle#tap('vim-surround') "{{{
	nmap <silent>sa <Plug>(operator-surround-append)
	nmap <silent>sd <Plug>(operator-surround-delete)
	nmap <silent>sr <Plug>(operator-surround-replace)
	call neobundle#untap()
endif "}}}

" Operator-replace.
nmap R <Plug>(operator-replace)
xmap R <Plug>(operator-replace)
xmap p <Plug>(operator-replace)

if neobundle#tap('tagbar') "{{{
	let g:tagbar_singleclick = 1
	let g:tagbar_sort = 0
	nnoremap <silent> <F3> :<C-u>TagbarToggle<CR>
	:imap <silent> <F3> <C-o>:<C-u>TagbarToggle<CR>
	call neobundle#untap()
endif "}}}

if neobundle#tap('undotree') "{{{
	nnoremap <silent> <F5> :UndotreeToggle<CR>
	:imap <F5> <C-o>:UndotreeToggle<CR>
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/undotree.rc.vim'
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-niceblock') "{{{
	xmap I <Plug>(niceblock-I)
	xmap A <Plug>(niceblock-A)
	call neobundle#untap()
endif "}}}

if neobundle#tap('matchit.zip') "{{{
	function! neobundle#hooks.on_post_source(bundle)
		silent! execute 'doautocmd Filetype' &filetype
	endfunction
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fugitive') "{{{
	autocmd BufReadPost fugitive://* set bufhidden=delete
	autocmd BufReadPost fugitive://*
				\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
				\   nnoremap <buffer> .. :edit %:h<CR> |
				\ endif
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-airline') "{{{
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_buffers = 0
	let g:airline_powerline_fonts = 1
	let g:airline_theme="powerlineish"
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-colors-solarized') "{{{
	let g:solarized_termcolors=256
	let g:solarized_termtrans=0
	set background=dark
	NeoBundleSource vim-colors-solarized
	call neobundle#untap()
endif "}}}

if neobundle#tap('PIV') "{{{
	let g:DisableAutoPHPFolding=1
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easytags') "{{{
	let g:easytags_dynamic_files = 1
	let g:easytags_autorecurse = 1
	let g:easytags_async = 1
	let g:easytags_auto_highlight = 0
	let g:easytags_updatetime_warn = 0
	call neobundle#untap()
endif "}}}

if neobundle#tap('auto-neobundle') && g:inet_connection == 0 "{{{
	NeoBundleSource auto_neobundle
	augroup AutoNeoBundle
		autocmd!
		autocmd VimEnter * call auto_neobundle#update_daily()
	augroup END
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-diffchanges') "{{{
	nnoremap <silent> <F12> :DiffChangesDiffToggle<CR>
	inoremap <silent> <F12> <C-o>:<C-u>DiffChangesDiffToggle<CR>
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-trailing-whitespace') "{{{
	let g:extra_whitespace_ignored_filetypes = ['unite', 'vimfiler', 'vimshell', 'Help', 'vimfiler:explorer', 'startify']
endif "}}}

if neobundle#tap('vim-startify') "{{{
	let neobundle#hooks.on_source = '~/.vim/rc/plugins/vim-startify.vim'
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-signify') "{{{
	let g:signify_vcs_list = [ 'svn', 'hg', 'bzr' ]
	let signify_update_on_focusgained = 1
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = '~_'
	call neobundle#untap()
endif "}}}

if neobundle#tap('vim-extradite') "{{{
	nnoremap <silent> <F6> :Extradite!<CR>
	:inoremap <F6> <C-o>:<C-u>Extradite!<CR>
	call neobundle#untap()
endif "}}}

if neobundle#tap('unite-tasklist') "{{{
	let g:unite_tasklist_ignorecase = 1
	call neobundle#untap()
endif "}}}
