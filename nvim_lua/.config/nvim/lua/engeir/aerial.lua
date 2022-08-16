local ok, aerial = pcall(require, "aerial")
if not ok then
    return
end

-- See https://github.com/stevearc/aerial.nvim#options
aerial.setup({
    layout = {
        max_width = { 100, 0.2 },
        min_width = 40,
    },

    -- Call this function when aerial attaches to a buffer.
    -- Useful for setting keymaps. Takes a single `bufnr` argument.
    on_attach = function(bufnr)
        -- Toggle the aerial window with <leader>a
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>at", "<cmd>AerialToggle<CR>", {})
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
