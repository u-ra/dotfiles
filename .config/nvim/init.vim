if v:progname =~? "evim"
	finish
endif

set showcmd			" display incomplete commands
set nowrap			" don't word wrap lines
set hidden			" don't fucking whine about unsaved buffers
set list lcs=trail:·,tab:»·	" show whitespace
set ignorecase			" case insensitive search
set number			" show line numbers
set completeopt=menuone		" fuck off, preview window
set cursorline			" highlight current line
set colorcolumn=100		" not that anyone gives a shit
set title			" update terminal window title
set termguicolors		" use truecolor in terminal
set inccommand=nosplit		" live preview

filetype plugin indent on

" For all text files set 'textwidth' to 100 characters.
autocmd FileType text setlocal textwidth=100

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal g`\"" |
			\ endif

" man pages
nnoremap <leader>m :Man <cword><CR>

" C-] is not really accessible on hr keyboard
nnoremap <leader>ji :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>jc :cs find c <C-R>=expand("<cword>")<CR><CR>

" let pathogen do its thing
call pathogen#interpose('bundle/{}')
call pathogen#helptags()

" colorscheme
set background=dark
colorscheme OceanicNext

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

" Chromatica
let g:chromatica#libclang_path='/usr/lib'
let g:chromatica#responsive_mode=1
let g:chromatica#enable_at_startup=1

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'oceanicnext'

" gtags
if filereadable("GTAGS")
	source /usr/share/vim/vimfiles/plugin/gtags-cscope.vim
	set cscopetag
	:GtagsCscope
endif

autocmd BufNewFile,BufRead /home/jura/harman/* set nowrap tabstop=4 shiftwidth=4 expandtab
autocmd BufNewFile,BufRead /home/jura/harman/* TagbarOpen
