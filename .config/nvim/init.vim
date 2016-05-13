if v:progname =~? "evim"
	finish
endif

set nocompatible		" drop vi compatibility
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set nobackup			" do not keep a backup file, use versions instead
set history=50			" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching
set nowrap			" don't word wrap lines
set hidden			" don't fucking whine about unsaved buffers
set list lcs=trail:·,tab:»·	" show whitespace
set shiftwidth=8		" XXX: gotta RTFM
set tabstop=8			" number of visual spaces per TAB
set ignorecase			" case insensitive search
set nu				" show line numbers
set laststatus=2		" always show status line
set mouse=a			" enable mouse for all modes
set updatetime=1000		" write swap file after a second spent idling
set omnifunc=ccomplete#Complete	" we use C god damnit
set completeopt=menuone		" fuck off, preview window
set cursorline			" highlight current line
set colorcolumn=100		" not that anyone gives a shit

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

" man pages
source $VIMRUNTIME/ftplugin/man.vim
nnoremap <leader>m :Man <cword><CR>

" C-] is not really accessible on hr keyboard
nnoremap <leader>ji :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>jc :cs find c <C-R>=expand("<cword>")<CR><CR>

" let pathogen do its thing
call pathogen#interpose('bundle/{}')
call pathogen#helptags()

" colorscheme
set background=dark
let base16colorspace=256
colorscheme base16-monokai

" Ctrl-P default are, indeed, retarded
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = ''
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_height = 30
let g:ctrlp_max_files = 0

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = '▓'
let g:airline_left_alt_sep = '░'
let g:airline_right_sep = '▓'
let g:airline_right_alt_sep = '░'

" gtags
if filereadable("GTAGS")
	source /usr/share/gtags/gtags-cscope.vim
	set cscopetag
	:GtagsCscope
endif
