return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "zbirenbaum/neodim",
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },
    { "ThePrimeagen/refactoring.nvim",   cond = IS_KNOWN },
    { "ziontee113/syntax-tree-surfer",   cond = IS_KNOWN },
}
