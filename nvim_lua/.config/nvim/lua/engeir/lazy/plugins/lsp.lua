return {
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
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-calc" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- Extra
            { "jose-elias-alvarez/null-ls.nvim" },
            -- Additional lua configuration, makes nvim stuff amazing!
            { "folke/neodev.nvim" },
        },
        config = function()
            require("engeir.lazy.lsp")
            require("engeir.lazy.lsp.luasnip-settings")
        end,
    },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
        -- using treesitter.
        dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("luasnip-latex-snippets").setup({ use_treesitter = true })
        end,
        -- treesitter is required for markdown
        ft = { "tex", "markdown" },
    },
}
