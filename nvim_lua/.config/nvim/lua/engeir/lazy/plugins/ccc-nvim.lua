local opts = { noremap = true, silent = true }
return {
    "uga-rosa/ccc.nvim",
    keys = {
        { "<C-c>", "<cmd>CccPick<cr>", opts },
        { "<C-c>", "<cmd>CccPick<cr>", opts, mode = "i" },
    },
}
