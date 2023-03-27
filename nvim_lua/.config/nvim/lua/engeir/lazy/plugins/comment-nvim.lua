return {
    "numToStr/Comment.nvim",
    enabled = false,
    config = function()
        require("Comment").setup()

        local ft = require("Comment.ft")
        ft.set("ncl", ";%s")
        ft.set("sent", "#%s")
    end,
}
