local opts = { noremap = true, silent = true }
return {
    -- Performance ================================================================== --
    "lewis6991/impatient.nvim",

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
    {
        "airblade/vim-rooter",
        init = function()
            vim.g.rooter_patterns = { ".git", "Makefile", "*.sln", "build/env.sh", "pyproject.toml" }
        end,
    },
    {
        "ThePrimeagen/harpoon",
        opts = {
            menu = {
                width = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
            },
        },
        keys = {
            { "<leader>hf", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts },
            { "<leader>hm", '<cmd>lua require("harpoon.mark").add_file()<CR>',        opts },
            { "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<CR>',          opts },
            { "<leader>hN", '<cmd>lua require("harpoon.ui").nav_prev()<CR>',          opts },
        },
    },
    { "ellisonleao/glow.nvim",            branch = "main" },
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
