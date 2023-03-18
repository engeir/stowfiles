return {
    -- Performance ================================================================== --
    "lewis6991/impatient.nvim",

    -- Syntax and other good stuff ================================================== --
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "stevearc/aerial.nvim",
    "zbirenbaum/neodim",
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },
    { "ThePrimeagen/refactoring.nvim",   cond = IS_KNOWN },
    { "ziontee113/syntax-tree-surfer",   cond = IS_KNOWN },

    -- LSP ========================================================================== --
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            -- TODO: replace with mini.completion?
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
    },

    -- Telescope ==================================================================== --
    "nvim-telescope/telescope.nvim",
    "axkirillov/easypick.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup({ default_register = { '"', "+", "*" } })
            require("telescope").load_extension("neoclip")
        end,
    },
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-lua/popup.nvim" },
        cond = IS_KNOWN and IS_LINUX,
    },

    -- mini.nvim
    -- Replaces:
    --    junegunn/vim-easy-align -> mini.align
    --    numToStr/Comment.nvim -> mini.comment
    --    RRethy/vim-illuminate -> mini.cursorword
    --    windwp/nvim-autopairs -> mini.pairs
    --    goolord/alpha-nvim -> mini.starter
    --    kylechui/nvim-surround -> mini.surround
    "echasnovski/mini.nvim",

    -- General text manipulation and fonts ========================================== --
    { "nat-418/boole.nvim",                       cond = IS_KNOWN },
    { "phaazon/mind.nvim",                        cond = IS_KNOWN },
    -- "gaoDean/autolist.nvim",
    {
        "asiryk/auto-hlsearch.nvim",
        version = "1.0.0",
        config = function()
            require("auto-hlsearch").setup()
        end,
    },

    -- Git some shit done =========================================================== --
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- TODO: understand how to ackshually use this
    "mbbill/undotree",
    "sindrets/diffview.nvim",
    { "TimUntersberger/neogit", cond = IS_KNOWN }, -- To commit quickly and view
    { "rhysd/committia.vim",    cond = IS_KNOWN },
    { "kdheepak/lazygit.nvim",  cond = IS_KNOWN and EXECUTABLE("lazygit") },
    {
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup()
        end,
    }, -- Quickly get a permalink to lines of code

    -- Style and colour schemes ===================================================== --
    -- TODO: replace with mini.statusline?
    "nvim-lualine/lualine.nvim",
    -- TODO: replace with mini.tabline?
    {
        "akinsho/bufferline.nvim",
        version = "v2.*",
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    "sainnhe/gruvbox-material",
    { "catppuccin/nvim",                  name = "catppuccin" },
    "tjdevries/colorbuddy.vim",
    "tjdevries/gruvbuddy.nvim",
    "marko-cerovac/material.nvim",
    -- nvim-ts-rainbow is archived, but nvim-ts-rainbow2 is ugly
    "p00f/nvim-ts-rainbow", -- Different colour for nested parenthesis
    -- "HiPhish/nvim-ts-rainbow2", -- Different colour for nested parenthesis
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    "ziontee113/color-picker.nvim",
    "folke/todo-comments.nvim",
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = "kyazdani42/nvim-web-devicons", -- optional, for file icons
        version = "nightly",                           -- optional, updated every week. (see issue #1193)
    },
    "mechatroner/rainbow_csv",

    -- Correct spelling and fix grammar ============================================= --
    { "anufrievroman/vim-angry-reviewer", cond = IS_KNOWN },

    -- TODO: set up dap

    -- Miscellaneous ================================================================ --
    "ThePrimeagen/vim-be-good",
    {
        -- "vigoux/notifier.nvim",
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                -- You configuration here
            })
        end,
    },
    "voldikss/vim-floaterm",
    "airblade/vim-rooter",
    "ThePrimeagen/harpoon",
    { "ellisonleao/glow.nvim", branch = "main" },
    "folke/zen-mode.nvim",
    -- Latex
    "lervag/vimtex",
    -- My plugins
    "engeir/githistory-browse.nvim",

    -- Graveyard (plugins I've used but that I don't think I have use for)
    -- "nvim-telescope/telescope-file-browser.nvim",
    -- "samodostal/image.nvim",
    -- { "ibhagwan/smartyank.nvim" },
    -- {
    --     "AckslD/nvim-FeMaco.lua",
    --     config = 'require("femaco").setup()',
    -- },
    -- "nvim-neorg/neorg",
    -- "nvim-orgmode/orgmode",
    -- "brymer-meneses/grammar-guard.nvim",
    -- { "akinsho/toggleterm.nvim", version = "v1.*",               cond = IS_KNOWN },
    -- { "dccsillag/magma-nvim",    build = ":UpdateRemotePlugins", cond = IS_KNOWN and IS_LINUX },
    -- { "goerz/jupytext.vim",      cond = IS_KNOWN and IS_LINUX },
    -- "AckslD/swenv.nvim",
}
