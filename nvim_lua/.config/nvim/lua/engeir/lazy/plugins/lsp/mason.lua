return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconf = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- local signs = {
        --     { name = "DiagnosticSignError", text = "" },
        --     { name = "DiagnosticSignWarn", text = "▲" },
        --     { name = "DiagnosticSignHint", text = "" },
        --     { name = "DiagnosticSignInfo", text = "" },
        -- }
        -- local config = {
        --     virtual_text = false, -- disable virtual text
        --     signs = {
        --         active = signs,   -- show signs
        --     },
        --     update_in_insert = true,
        --     underline = true,
        --     severity_sort = true,
        --     float = {
        --         focusable = true,
        --         style = "minimal",
        --         -- border = "rounded",
        --         source = "always",
        --         -- header = "",
        --         -- prefix = "",
        --     },
        --     automatic_installation = true,
        -- }
        -- mason_lspconfig.setup(config)
        mason_lspconf.setup({
            -- virtual_text = false, -- disable virtual text
            -- signs = {
            --     active = signs,   -- show signs
            -- },
            -- update_in_insert = true,
            -- underline = true,
            -- severity_sort = true,
            -- float = {
            --     focusable = true,
            --     style = "minimal",
            --     -- border = "rounded",
            --     source = "always",
            --     -- header = "",
            --     -- prefix = "",
            -- },
            ensure_installed = {},
            automatic_installation = true,
        })
    end,
}
