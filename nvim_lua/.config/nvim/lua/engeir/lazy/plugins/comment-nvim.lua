return {
    "numToStr/Comment.nvim",
    enabled = true,
    config = function()
        require("Comment").setup()

        local ft = require("Comment.ft")
        ft.set("ncl", ";%s")
        ft.set("sent", "#%s")
        ft.set("jsonc", "//%s")
        ft.set("mplstyle", "#%s")
        ft.set("nu", "#%s")
    end,
}
