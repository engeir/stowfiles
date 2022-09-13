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

return packer.startup(function(use)
    -- Packer can manage itself ===================================================== --
    use("wbthomason/packer.nvim")

    -- Syntax and other good stuff ================================================== --
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("ThePrimeagen/refactoring.nvim")
    use("nvim-treesitter/nvim-treesitter-context")
    use("ziontee113/syntax-tree-surfer")
    use("stevearc/aerial.nvim")

    -- LSP ========================================================================== --
    use("neovim/nvim-lspconfig") -- enable LSP
    use("williamboman/nvim-lsp-installer") -- simple to use language server installer
    use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
    use("RRethy/vim-illuminate")
    use("tami5/lspsaga.nvim")
    use("ray-x/lsp_signature.nvim")
    -- if IS_KNOWN then
    --     use({
    --         "zbirenbaum/copilot.lua",
    --         event = { "VimEnter" },
    --         config = function()
    --             vim.defer_fn(function()
    --                 require("copilot").setup()
    --             end, 100)
    --         end,
    --     })
    --     use({
    --         "zbirenbaum/copilot-cmp",
    --         module = "copilot_cmp",
    --     })
    -- end

    -- Telescope ==================================================================== --
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-bibtex.nvim")
    use({
        "AckslD/nvim-neoclip.lua",
        requires = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("neoclip").setup({ default_register = { '"', "+", "*" } })
            require("telescope").load_extension("neoclip")
        end,
    })
    use({
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    })
    use("nvim-telescope/telescope-symbols.nvim")
    if IS_KNOWN and IS_LINUX then
        use({ "nvim-telescope/telescope-media-files.nvim", requires = { "nvim-lua/popup.nvim" } })
    end
    use("samodostal/image.nvim")

    -- General text manipulation and fonts ========================================== --
    use("numToStr/Comment.nvim")
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use("monaqa/dial.nvim")
    use("zbirenbaum/neodim")
    use("junegunn/vim-easy-align")
    use({
        "AckslD/nvim-FeMaco.lua",
        config = 'require("femaco").setup()',
    })
    if IS_KNOWN then
        -- use("nvim-neorg/neorg")
        use("nvim-orgmode/orgmode")
    end
    use({
        "gaoDean/autolist.nvim",
        config = function()
            require("autolist").setup()
        end,
    })

    -- cmp / completions ============================================================ --
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-buffer") -- Buffer completions
    use("hrsh7th/cmp-path") -- Path completions
    use("saadparwaiz1/cmp_luasnip") -- Snippet completions
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")

    -- snippets ===================================================================== --
    use({ "L3MON4D3/LuaSnip" })

    -- Git some shit done =========================================================== --
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    -- TODO: understand how to ackshually use this
    use("mbbill/undotree")
    use("sindrets/diffview.nvim")
    use("TimUntersberger/neogit") -- To commit quickly and view
    use({
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup()
        end,
    }) -- Quickly get a permalink to lines of code
    use("rhysd/committia.vim")
    use({ "kdheepak/lazygit.nvim", cond = EXECUTABLE("lazygit") })

    -- Style and colour schemes ===================================================== --
    use("nvim-lualine/lualine.nvim")
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })
    use("sainnhe/gruvbox-material")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("tjdevries/colorbuddy.vim")
    use("tjdevries/gruvbuddy.nvim")
    use("marko-cerovac/material.nvim")
    use("p00f/nvim-ts-rainbow") -- Different colour for nested parenthesis
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use("ziontee113/color-picker.nvim")
    use("folke/todo-comments.nvim")
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })
    use("mechatroner/rainbow_csv")

    -- Correct spelling and fix grammar ============================================= --
    use({
        "lewis6991/spellsitter.nvim",
        config = function()
            require("spellsitter").setup()
        end,
    })
    if IS_KNOWN then
        use("brymer-meneses/grammar-guard.nvim")
        use("anufrievroman/vim-angry-reviewer")
    end

    -- TODO: set up dap

    -- Miscellaneous ================================================================ --
    use({ "akinsho/toggleterm.nvim", tag = "v1.*" })
    use("voldikss/vim-floaterm")
    use("airblade/vim-rooter")
    use("ThePrimeagen/harpoon")
    use({ "ellisonleao/glow.nvim", branch = "main" })
    use("goolord/alpha-nvim")
    -- Jupyter notebooks
    if IS_KNOWN and IS_LINUX then
        use({ "dccsillag/magma-nvim", run = ":UpdateRemotePlugins" })
        use("goerz/jupytext.vim")
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
