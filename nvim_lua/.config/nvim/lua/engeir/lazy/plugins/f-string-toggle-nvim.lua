return {
    "roobert/f-string-toggle.nvim",
    config = true,
    keys = {
        {
            "<C-f>",
            function()
                require("f-string-toggle").toggle_fstring()
            end,
            desc = "Toggle f-string",
            mode = "i",
        },
    },
}
