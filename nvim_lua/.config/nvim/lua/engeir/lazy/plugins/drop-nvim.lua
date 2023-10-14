return {
    "folke/drop.nvim",
    enabled = false,
    event = "VimEnter",
    config = function()
        require("drop").setup()
    end,
}
