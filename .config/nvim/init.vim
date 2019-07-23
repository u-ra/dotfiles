set colorcolumn=100		" not that anyone gives a shit
set cursorline			" highlight current line
set hidden			" don't fucking whine about unsaved buffers
set ignorecase			" case insensitive search
set inccommand=nosplit		" live preview
set list lcs=trail:·,tab:»·	" show whitespace
set mouse=a			" always enable mouse
set nowrap			" don't word wrap lines
set number			" show line numbers
set signcolumn=yes		" always draw signcolumn
set termguicolors		" use truecolor in terminal
set title			" update terminal window title
set nobackup			" no backups
set nowritebackup		" no backups
set updatetime=300		" shorter update time for CursorHold and CursorHoldI
set shortmess+=c		" don't give ins-completion-menu messages
set wildmode=longest:full,full	" sane completion behaviour
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

" vim-plug
call plug#begin('~/.local/share/nvim/plugins')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'u-ra/vim-two-firewatch'
Plug 'vim-airline/vim-airline'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'edkolev/promptline.vim'
call plug#end()

" colorscheme
let g:two_firewatch_italics = 1
set background=dark
colorscheme two-firewatch
let g:airline_theme = 'twofirewatch'

" ctrlp
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = ''
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_height = 30
let g:ctrlp_max_files = 0

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#warning_symbol = '🤔'
let g:airline#extensions#coc#error_symbol = '🤬'
let g:airline#extensions#whitespace#enabled = 0
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''


" lsp-cxx-highlight
"let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
"let g:lsp_cxx_hl_verbose_log = 1
hi default link LspCxxHlGroupEnumConstant Constant
hi default link LspCxxHlGroupNamespace Keyword
hi default link LspCxxHlGroupMemberVariable Identifier
hi default link LspCxxHlSymParameter Structure
hi default link LspCxxHlSymUnknownVariableExtern String
hi default link LspCxxHlSymFunction PreCondit
hi default link LspCxxHlSymUnknownVariableStatic Exception

" tagbar
let g:tagbar_width = 80
noremap <Leader>tt :TagbarToggle<CR>

" CoC
let g:coc_status_error_icon = '🤬'
let g:coc_status_warning_icon = '🤔'
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> <leader>jd <Plug>(coc-declaration)
nmap <silent> <leader>ji <Plug>(coc-definition)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>jc <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

" Remap for rename current word
nmap <leader>rw <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" misc key bindings
nnoremap <leader>x :bd<CR>
tnoremap <Esc> <C-\><C-n>

" project specific
autocmd BufNewFile,BufRead /home/jura/src/harman/* set nowrap tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.h set filetype=c
