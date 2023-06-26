return {
    "rcarriga/nvim-notify",
    enabled = IS_KNOWN,
    config = function()
        require("notify").setup({
            background_colour = "#282828",
        })
    end,
}
