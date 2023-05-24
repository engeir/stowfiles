return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("trouble").setup({
            auto_close = true,
        })
    end,
    keys = {
        { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "[T]rouble[T]oggle" },
    },
}
