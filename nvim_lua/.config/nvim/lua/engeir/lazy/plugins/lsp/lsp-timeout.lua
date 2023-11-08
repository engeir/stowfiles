return {
    "hinell/lsp-timeout.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "neovim/nvim-lspconfig" },
    init = function()
        vim.g.lspTimeoutConfig = {
            -- see config below
        }
    end,
}
