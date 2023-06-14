return {
    "johmsalas/text-case.nvim",
    enabled = IS_KNOWN,
    config = function()
        require("textcase").setup({})
        require("telescope").load_extension("textcase")
        vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
        vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
    keys = {
        { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", desc = "Telescope Text [C]ase [C]hange" },
        {
            "<leader>cc",
            "<cmd>TextCaseOpenTelescope<CR>",
            mode = "v",
            desc = "Telescope Text [C]ase [C]hange",
        },
    },
}
