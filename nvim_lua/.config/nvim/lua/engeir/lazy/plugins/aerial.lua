return {
    "stevearc/aerial.nvim",
    dependencies = "nvim-tree/nvim-web-devicons", -- optional, for file icons
    config = function()
        require("aerial").setup({
            layout = {
                max_width = { 100, 0.2 },
                min_width = 40,
            },
            -- Call this function when aerial attaches to a buffer.
            -- Useful for setting keymaps. Takes a single `bufnr` argument.
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ap", "<cmd>AerialPrev<CR>", {})
                vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>an", "<cmd>AerialNext<CR>", {})
                -- -- Jump up the tree with '[[' or ']]'
                -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
                -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
            end,
            -- When true, aerial will automatically close after jumping to a symbol
            close_on_select = true,
            -- Show box drawing characters for the tree hierarchy
            show_guides = true,
        })
        require("telescope").load_extension("aerial")
    end,
    keys = {
        { "<leader>at", "<cmd>AerialToggle<CR>", desc = "Aerial Toggle (list of TS objects)" },
    },
}
