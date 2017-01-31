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

"set transparency=30

" set line number
set number

" enable folding by fold markers
set foldmethod=marker 

" autoclose folds, when moving out of them
set foldclose=all

" use Vim defaults (much better!) -- not compataible with transparency
"set nocompatible        

" allow backspacing over everything in insert mode
set bs=2                

" always set autoindenting on
set ai                 

" keep a backup file
"set backup             

" read/write a .viminfo file, don't store more than 50 lines of registers
set viminfo='20,\"50    

" keep 50 lines of command line history
set history=50          

" show the cursor position all the time
set ruler               

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

" jump 5 lines when running out of the screen
set scrolljump=5

" indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" repair wired terminal/vim settings
set backspace=start,eol,indent

" allow file inline modelines to provide settings
set modeline


" tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" enable syntax highlighting
syntax on             

" enable filetype detection
filetype on           

" enable filetype-specific indenting
filetype indent on    

" enable filetype-specific plugins
filetype plugin on    

" colors!
colorscheme no_quarter
colorscheme fruity
set transparency=40
if has('gui_running')
  set guifont=Anonymous_Pro:h16
endif
set linespace=2
set lines=42


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


