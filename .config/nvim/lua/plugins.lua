require("packer").startup(function()

	use {"akinsho/nvim-bufferline.lua"}
	use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
	use {"kergoth/vim-bitbake"}
	use {"neoclide/coc.nvim", branch = "release"}
	use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}}
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use {"sainnhe/sonokai"}
	use {"tpope/vim-fugitive"}
	use {"wbthomason/packer.nvim"}
	use {"fannheyward/telescope-coc.nvim"}
end)
