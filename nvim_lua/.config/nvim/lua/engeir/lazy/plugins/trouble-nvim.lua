return {
    "folke/trouble.nvim",
    denpendencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("trouble").setup({
            auto_close = true,
        })
    end,
}
