return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr)
                    return vim.startswith(name, ".git/")
                end,
            },
            float = {
                max_width = 150,
                max_height = 50,
                padding = 5,
            },
        })
        vim.keymap.set("n", "<leader>po", function()
            require("oil").open()
        end, { desc = "[P]ath explorer with [O]il" })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
