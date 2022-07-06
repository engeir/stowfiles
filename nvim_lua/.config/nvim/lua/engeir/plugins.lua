local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function()
	-- Packer can manage itself --------------------------------------------------------
	use("wbthomason/packer.nvim")

	-- General text manipulation and fonts ---------------------------------------------
	use("numToStr/Comment.nvim")
	use("tpope/vim-surround")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("monaqa/dial.nvim")
	use({
		"yamatsum/nvim-nonicons",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("zbirenbaum/neodim")
	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	})

	-- cmp / completions ---------------------------------------------------------------
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets ------------------------------------------------------------------------
	use({ "L3MON4D3/LuaSnip" })

	-- Post-install/update hook with neovim command ------------------------------------
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- LSP -----------------------------------------------------------------------------
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate")
	use("tami5/lspsaga.nvim")
	use("ray-x/lsp_signature.nvim")

	-- Git some shit done --------------------------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use("mbbill/undotree")

	-- Style and colorschemes ----------------------------------------------------------
	use("nvim-lualine/lualine.nvim")
	use("sainnhe/gruvbox-material")
	use("tjdevries/colorbuddy.vim")
	use("tjdevries/gruvbuddy.nvim")
	use("marko-cerovac/material.nvim")

	-- Telescope -----------------------------------------------------------------------
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-bibtex.nvim")
	use({
		"AckslD/nvim-neoclip.lua",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
			require("telescope").load_extension("neoclip")
		end,
	})
	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
			require("telescope").load_extension("file_browser")
		end,
	})

	-- Miscellaneous -------------------------------------------------------------------
	use({
		"akinsho/toggleterm.nvim",
		tag = "v1.*",
		config = function()
			require("toggleterm").setup({ shade_terminals = false })
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
