-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()

    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- General text manipulation
    use("numToStr/Comment.nvim")
    use("tpope/vim-surround")
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use("monaqa/dial.nvim")

    -- Post-install/update hook with neovim command
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Use dependency and run lua function after load
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    })

    -- Git some shit done
    use("mbbill/undotree")

    -- Style and colorschemes
    use 'nvim-lualine/lualine.nvim'
    use 'sainnhe/gruvbox-material'
    use("tjdevries/colorbuddy.vim")
    use 'tjdevries/gruvbuddy.nvim'
    use 'marko-cerovac/material.nvim'

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use 'nvim-telescope/telescope-bibtex.nvim'
    -- TJ

end)
