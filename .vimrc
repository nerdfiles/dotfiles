if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

" nerdtree
let g:NERDTreeWinSize = 30
nmap <silent> <c-n> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree

" highlight current line in insert mode
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul 

" set line number
set number

" Enable folding by fold markers
set foldmethod=marker 

" Autoclose folds, when moving out of them
set foldclose=all

" stuff
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set laststatus=2

" backup to ~/.tmp
" set backup
" set backupdir=$HOME/.tmp
" set writebackup

" misc
set nohls
set hlsearch

" incremental search
set incsearch
set showcmd
set nowrap

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol,indent

" Allow file inline modelines to provide settings
set modeline


" tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

colorscheme desert


" {{{ Execute in shell 
" http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev

function! s:ExecuteInShell(command, bang)
	let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

	if (_ != '')
		let s:_ = _
		let bufnr = bufnr('%')
		let winnr = bufwinnr('^' . _ . '$')
		silent! execute  winnr < 0 ? 'new ' . fnameescape(_) : winnr . 'wincmd w'
		setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
		silent! :%d
		let message = 'Execute ' . _ . '...'
		call append(0, message)
		echo message
		silent! 2d | resize 1 | redraw
		silent! execute 'silent! %!'. _
		silent! execute 'resize ' . line('$')
		silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
		silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
	endif
endfunction

command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
command! -complete=file -nargs=* Git call s:ExecuteInShell('git '.<q-args>, '<bang>')
command! -complete=file -nargs=* Svn call s:ExecuteInShell('svn '.<q-args>, '<bang>')
command! -complete=file -nargs=* Open call s:ExecuteInShell('open '.<q-args>, '<bang>')
cabbrev shell Shell
cabbrev git Open
cabbrev git Git
cabbrev svn Svn

" }}}

