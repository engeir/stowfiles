return {
    "icholy/lsplinks.nvim",
    enabled = true,
    setup = function()
        local lsplinks = require("lsplinks")
        lsplinks.setup()
        vim.keymap.set("n", "gx", lsplinks.gx)
    end,
}
