vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.listchars = "eol:↵,trail:·,tab:┊ "
vim.o.mouse="a"
vim.o.shortmess = vim.o.shortmess .. "s"
vim.o.termguicolors = true
vim.o.title = true
vim.o.updatetime = 300
vim.o.wildignore="*.o,*.obj,~*"
vim.o.wildmode = "longest:full,full"

vim.wo.colorcolumn = "100"
vim.wo.cursorline = true
vim.wo.list = true
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

--vim.opt.fillchars:append { eob = " " }

local fn = vim.fn
local cmd = vim.api.nvim_command

-- jump to last known position in file
cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]])

-- Auto install packer.nvim if not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	cmd("!git clone https://github.com/wbthomason/packer.nvim ".. install_path)
end

require("packer").init {
	display = {
		open_cmd = 'vnew \\[packer\\]'
	}
}

require('plugins')

-- update packer when saving config
cmd([[au! BufWritePost plugins.lua execute 'luafile %' | lua require('packer').compile()]])

-- colorscheme
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_style = "atlantis"
vim.g.sonokai_diagnostic_text_highlight = 1
cmd([[colorscheme sonokai]])

require("lualine").setup {
	options = {
		theme = "sonokai",
		section_separators = {left = '', right = ''},
		component_separators = {left = '', right = ''}
	},

	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch'},
		lualine_c = {{'filename', path = 1},

			{
				'diagnostics',
				-- table of diagnostic sources, available sources:
				-- nvim_lsp, coc, ale, vim_lsp
				sources =  {'coc'},
				-- displays diagnostics from defined severity
				sections = {'error', 'warn', 'info', 'hint'},
				-- all colors are in format #rrggbb
				color_error = nil, -- changes diagnostic's error foreground color
				color_warn = nil, -- changes diagnostic's warn foreground color
				color_info = nil, -- Changes diagnostic's info foreground color
				color_hint = nil, -- Changes diagnostic's hint foreground color
				symbols = {error = '🤬', warn = '🤔', info = 'I', hint = 'H'}
			}
		},
		lualine_x = {'encoding'},
		lualine_y = {'filetype'},
		lualine_z = {'progress', 'location'}
	}
}

require("bufferline").setup {
	options = {
		separator_style = "thick",
		numbers = "ordinal",
		always_show_bufferline = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
	highlights = {
		fill = {
			guibg = {
				attribute = "bg",
				highlight = "StatusLine"
			}
		},
	}
}

cmd([[nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>]])
cmd([[nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>]])
cmd([[nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>]])
cmd([[nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>]])
cmd([[nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>]])
cmd([[nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>]])
cmd([[nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>]])
cmd([[nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>]])
cmd([[nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>]])

require("nvim-treesitter.configs").setup {
	highlight = {
		enable = true,
	},
}

require("telescope").setup {
	defaults = {
		file_ignore_patterns = {"%.o", "%.obj", "%.dwo", "%.dtb"}
	}
}
require('telescope').load_extension('coc')

cmd("nnoremap <c-p> <cmd>Telescope find_files<cr>")
cmd("nnoremap <leader>tt <cmd>Telescope coc document_symbols<cr>")

vim.g.coc_status_error_icon = '🤬'
vim.g.coc_status_warning_icon = '🤔'

-- Use tab for trigger completion with characters ahead and navigate.
-- Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
cmd([[
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
]])
cmd([[inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"]])

cmd([[
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

cmd([[inoremap <silent><expr> <C-Space> coc#refresh()]])
cmd([[inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"]])
cmd([[inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"]])
cmd([[inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]])

-- Remap keys for gotos
cmd([[nmap <silent> <leader>jd <Plug>(coc-declaration)]])
cmd([[nmap <silent> <leader>ji <Plug>(coc-definition)]])
cmd([[nmap <silent> <leader>jt <Plug>(coc-type-definition)]])
cmd([[nmap <silent> <leader>jc <Plug>(coc-references)]])

-- Use K for show documentation in preview window
cmd([[nnoremap <silent> K :call <SID>show_documentation()<CR>]])

cmd([[
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
]])

-- Highlight symbol under cursor on CursorHold
cmd([[autocmd CursorHold * silent call CocActionAsync('highlight')]])
cmd([[autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')]])

-- Remap for rename current word
cmd([[nmap <leader>rw <Plug>(coc-rename)]])

-- Remap for format selected region
cmd([[vmap <leader>f  <Plug>(coc-format-selected)]])
cmd([[nmap <leader>f  <Plug>(coc-format-selected)]])

-- Using CocList
-- Show all diagnostics
cmd([[nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>]])
-- Show commands
cmd([[nnoremap <silent> <space>c  :<C-u>CocList commands<cr>]])
-- Find symbol of current document
cmd([[nnoremap <silent> <space>o  :<C-u>CocList outline<cr>]])
-- Search workspace symbols
cmd([[nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>]])
-- Do default action for next item.
cmd([[nnoremap <silent> <space>j  :<C-u>CocNext<CR>]])
-- Do default action for previous item.
cmd([[nnoremap <silent> <space>k  :<C-u>CocPrev<CR>]])
-- Resume latest coc list
cmd([[nnoremap <silent> <space>p  :<C-u>CocListResume<CR>]])

-- misc key bindings
cmd([[nnoremap <leader>x :bd<CR>]])
cmd([[tnoremap <Esc> <C-\><C-n>]])
cmd([[vmap <LeftRelease> "+ygv]])

-- project specific
cmd([[autocmd BufRead,BufNewFile *.h set filetype=c]])
