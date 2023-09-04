return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = { auto_close = true },
    keys = {
        { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "[T]rouble[T]oggle" },
    },
}
