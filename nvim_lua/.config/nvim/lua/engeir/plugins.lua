-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()

    -- Packer can manage itself
    use("wbthomason/packer.nvim")

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

    -- Colorscheme
    use 'sainnhe/gruvbox-material'
    use("tjdevries/colorbuddy.vim")
    use 'tjdevries/gruvbuddy.nvim'

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use 'nvim-telescope/telescope-bibtex.nvim'
    -- TJ

    use 'nvim-lualine/lualine.nvim'
end)
