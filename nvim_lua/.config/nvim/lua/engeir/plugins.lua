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

    -- Performance ================================================================== --
    use("lewis6991/impatient.nvim")

    -- Syntax and other good stuff ================================================== --
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-context")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("stevearc/aerial.nvim")
    use("RRethy/vim-illuminate")
    use("zbirenbaum/neodim")
    use({
        "danymat/neogen",
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    })
    if IS_KNOWN then
        use("ThePrimeagen/refactoring.nvim")
        use("ziontee113/syntax-tree-surfer")
    end

    -- LSP ========================================================================== --
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- Extra
            { "jose-elias-alvarez/null-ls.nvim" },
        },
    })

    -- Telescope ==================================================================== --
    use("nvim-telescope/telescope.nvim")
    use({ "axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim" })
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
    if IS_KNOWN then
        use("nat-418/boole.nvim")
        use("junegunn/vim-easy-align")
    end
    use({
        "gaoDean/autolist.nvim",
        config = function()
            require("autolist").setup()
        end,
    })
    use({
        "asiryk/auto-hlsearch.nvim",
        tag = "1.0.0",
        config = function()
            require("auto-hlsearch").setup()
        end,
    })

    -- Git some shit done =========================================================== --
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    -- TODO: understand how to ackshually use this
    use("mbbill/undotree")
    use("sindrets/diffview.nvim")
    if IS_KNOWN then
        use("TimUntersberger/neogit") -- To commit quickly and view
        use("rhysd/committia.vim")
        use({ "kdheepak/lazygit.nvim", cond = EXECUTABLE("lazygit") })
    end
    use({
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup()
        end,
    }) -- Quickly get a permalink to lines of code

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
    if IS_KNOWN then
        use("anufrievroman/vim-angry-reviewer")
    end

    -- TODO: set up dap

    -- Miscellaneous ================================================================ --
    use({
        -- "vigoux/notifier.nvim",
        "j-hui/fidget.nvim",
        config = function()
            -- require("notifier").setup({
            require("fidget").setup({
                -- You configuration here
            })
        end,
    })
    use("voldikss/vim-floaterm")
    use("airblade/vim-rooter")
    use("ThePrimeagen/harpoon")
    use({ "ellisonleao/glow.nvim", branch = "main" })
    use("goolord/alpha-nvim")
    use("folke/zen-mode.nvim")
    -- Latex
    use("lervag/vimtex")
    -- My plugins
    use("engeir/githistory-browse.nvim")

    -- Graveyard (plugins I've used but that I don't think I have use for)
    -- use({ "ibhagwan/smartyank.nvim" })
    -- use({
    --     "AckslD/nvim-FeMaco.lua",
    --     config = 'require("femaco").setup()',
    -- })
    -- use("nvim-neorg/neorg")
    -- use("nvim-orgmode/orgmode")
    -- use("brymer-meneses/grammar-guard.nvim")
    -- if IS_KNOWN then
    --     use({ "akinsho/toggleterm.nvim", tag = "v1.*" })
    -- end
    -- if IS_KNOWN and IS_LINUX then
    --     use({ "dccsillag/magma-nvim", run = ":UpdateRemotePlugins" })
    --     use("goerz/jupytext.vim")
    -- end
    -- use("AckslD/swenv.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
