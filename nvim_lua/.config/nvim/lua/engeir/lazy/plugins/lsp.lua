return {
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
}
