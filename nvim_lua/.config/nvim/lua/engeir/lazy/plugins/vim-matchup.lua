return {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        require("nvim-treesitter.configs").setup({
            matchup = {
                enable = true, -- mandatory, false will disable the whole extension
                disable = { "c", "ruby" }, -- optional, list of language that will be disabled
                -- [options]
            },
        })
    end,
}
