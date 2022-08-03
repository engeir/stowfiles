local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local servers = {
    "bashls",
    "cssls",
    "gopls",
    "html",
    "jsonls",
    "ltex",
    "prosemd_lsp",
    "pyright",
    "rust_analyzer",
    "sourcery",
    "sumneko_lua",
    "taplo",
    "tsserver",
    "vuels",
    "yamlls",
    -- TODO: Need to figure out how to prevent format on save...
    -- "texlab",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("engeir.lsp.handlers").on_attach,
        capabilities = require("engeir.lsp.handlers").capabilities,
    }

    if server == "sumneko_lua" then
        local sumneko_opts = require("engeir.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require("engeir.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if EXECUTABLE("pass") and server == "sourcery" then
        local sourcery_opts = require("engeir.lsp.settings.sourcery")
        opts = vim.tbl_deep_extend("force", sourcery_opts, opts)
    end

    if server == "ltex" then
        local ltex_opts = require("engeir.lsp.settings.ltex")
        local ltex_opts_cmd = require("engeir.lsp.settings.ltex_cmd")
        opts = vim.tbl_deep_extend("force", ltex_opts_cmd, opts)
        opts = vim.tbl_deep_extend("force", ltex_opts, opts)
    end

    lspconfig[server].setup(opts)
end
